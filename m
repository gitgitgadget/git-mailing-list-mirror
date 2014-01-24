From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] implement @{publish} shorthand
Date: Fri, 24 Jan 2014 15:12:03 -0800
Message-ID: <xmqq61p9q8jg.fsf@gitster.dls.corp.google.com>
References: <20140108093338.GA15659@sigill.intra.peff.net>
	<20140108093716.GE15720@sigill.intra.peff.net>
	<xmqqob32s08p.fsf@gitster.dls.corp.google.com>
	<20140124213521.GA26602@sigill.intra.peff.net>
	<CALkWK0mgGyYaTmSTLL5BRpr6cOWgx7VJuQTtuqDnmjCMbXhgqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 25 00:12:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6pvE-0000qk-3s
	for gcvg-git-2@plane.gmane.org; Sat, 25 Jan 2014 00:12:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbaAXXMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 18:12:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56822 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751087AbaAXXMO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 18:12:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7314B642EC;
	Fri, 24 Jan 2014 18:12:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oPk+FyKb0CYUDEtpcUCFqUJ+fok=; b=l6u6RG
	lZn7Gdtd5q68cYHoL+UgQtu7ZqgkVg4ZYOAadxHVniqHnNWCIAfijD2JQPdmW9zt
	I6dm6kCpFCwCs2Lmbz8jgtDePBbpPKeH3XFDoZ961DGRBbAwkno1L0mFp3ezNim/
	vFv2alzgJocDOw+5zbgHZgIcO/u4BtqZEnuNU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FgfXS3/UDwWK8z4J2PRgKpssWtcigK0t
	pr3QPhhB20nOaiTLDBv/B8SSJDKFbmigN3iXCZbJFCL19sCdkiAwVCEPs7DtIrzR
	zJj6l3ZdXQ8VFC0ZmgWZqxa2plXOe8Zm2fP2Q2Gmyas3K1K8QzGzipK7X6kQ7rI8
	bP0d3WY6/+g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05E25642E8;
	Fri, 24 Jan 2014 18:12:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C7CEF642E3;
	Fri, 24 Jan 2014 18:12:07 -0500 (EST)
In-Reply-To: <CALkWK0mgGyYaTmSTLL5BRpr6cOWgx7VJuQTtuqDnmjCMbXhgqA@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 24 Jan 2014 17:05:35 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F22CE648-854C-11E3-B44F-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241051>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> On that note, can you hold off graduating
> jk/branch-at-publish-rebased, Junio? Hopefully, I'll come up with a
> replacement over the weekend.

Sure.

This close to the feature freeze, I'd rather see all contributors,
not limited to you, not rush on new and shiny things, but instead
spend time looking at bugs and fixes proposed for the upcoming
release in the codepaths they were involved.

The send-email SSL issue $gmane/240479 is one of the things I'd like
to see your sanity-checking ;-)
