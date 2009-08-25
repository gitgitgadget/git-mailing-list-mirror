From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add option -b/--branch to clone for select a new HEAD
Date: Mon, 24 Aug 2009 19:13:23 -0700
Message-ID: <7vfxbgvdx8.fsf@alter.siamese.dyndns.org>
References: <1251146568-25248-1-git-send-email-catap@catap.ru>
 <20090825015726.GB7655@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kirill A. Korinskiy" <catap@catap.ru>, gitster@pobox.com,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 25 04:13:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MflXc-0005Ld-CC
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 04:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754157AbZHYCNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 22:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754147AbZHYCNf
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 22:13:35 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45576 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093AbZHYCNe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 22:13:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E9D9C365B9;
	Mon, 24 Aug 2009 22:13:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JqEOdrDzmgt8MjxMBnYyxii0AKE=; b=f/vooh
	lfawR8mw7Hjl2WKj5E1+zo+MD4a5e4PyK3CQ6KCmldbi7Xl46tunIychmtUZVwFC
	DHn1mXq4rwI026GCE3wSEnVh4c+GJueGxuRUdJcZIreIfE3OkmxB7Cj/vjeZuJ33
	5aLPjpiQdpj9Mr68mim3HFtX+eJYBLAN+ii/A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BEFIxO8Z+bbRzSkh+zxDDw2ydIlhBTnU
	uBpQSqBC02QRnMtDx95oIr5PLSCXCTiRIEKSWmH7xumNDQj2axQ4OULtk90jsVXY
	SYjrr/c9sjmW8GJt4UQ4XW6pmUn5cPs5l6f7E31ONkTjh3RB6cwwHaVUulq64q+E
	XqRiCH+Trv8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C7A93365B8;
	Mon, 24 Aug 2009 22:13:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 24CF0365B7; Mon, 24 Aug 2009
 22:13:25 -0400 (EDT)
In-Reply-To: <20090825015726.GB7655@coredump.intra.peff.net> (Jeff King's
 message of "Mon\, 24 Aug 2009 21\:57\:26 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E2C7D75E-911C-11DE-AF31-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126991>

Jeff King <peff@peff.net> writes:

> On Tue, Aug 25, 2009 at 12:42:48AM +0400, Kirill A. Korinskiy wrote:
>
>> Sometimes (especially on production systems) we need to use only one
>> remote branch for building software. It really annoying to clone
>> origin and then swith branch by hand everytime. So this patch provide
>> functionality to clone remote branch with one command without using
>> checkout after clone.
>
> If you are doing this a lot, it is probably a sign that you should
> repoint the "HEAD" of the parent repository.
>
> That being said, you may want one branch half the time, and another
> branch the other half. So I think this is a good feature.
>
> A few comments:

Very good review snipped, as I agree with everything you said (except that
you did not point out the lack of sign-off).
