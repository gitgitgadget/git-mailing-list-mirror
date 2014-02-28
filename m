From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] lifting upload-archive restrictions
Date: Fri, 28 Feb 2014 09:54:52 -0800
Message-ID: <xmqq61nzw2ab.fsf@gitster.dls.corp.google.com>
References: <20140227040504.GA2242@sigill.intra.peff.net>
	<xmqqtxbkz9jp.fsf@gitster.dls.corp.google.com>
	<20140228090709.GB11709@sigill.intra.peff.net>
	<20140228095619.GA11803@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Scott J. Goldman" <scottjg@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 28 18:55:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJReK-0002c0-P3
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 18:55:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080AbaB1Ry7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 12:54:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46352 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752494AbaB1Ry6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 12:54:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 376526E56A;
	Fri, 28 Feb 2014 12:54:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TYysFn06U6//NL+m91Y575k7Pzk=; b=Lws6yE
	VYGZ91XzDdL3eZaNGQ6QE+j0DitgeMlRo/7ivMzCAUNjwrwxKoNu9+B+m/OMhFXJ
	jpwYSt8sEBzzVjZR9too7cJd762G3kjnyIvWjqhR5EExue8Dwlwx1aSjBtMZHFCb
	hEOnq0kEmtOAmknxV7DvgGGYcinRNvxo2edOo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Uhn9biA/xlKlfACyfxrgt7LXVW0Rw/RR
	ekltgpC/qSUYW7s64+N1eOZMlWHBnhaUmahkOs6bt/RZdm4rZ5EsDzC7v6eLre4m
	b5iEBbFyHOfZ+PTiYn2eIKfrDWHGWloUSldtIvb4gNIZwx+FA2pkcWa6QfhX16AQ
	UJYTy/GqOp8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F12B6E569;
	Fri, 28 Feb 2014 12:54:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 075596E566;
	Fri, 28 Feb 2014 12:54:54 -0500 (EST)
In-Reply-To: <20140228095619.GA11803@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 28 Feb 2014 04:56:19 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6E34F892-A0A1-11E3-AD93-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242998>

Jeff King <peff@peff.net> writes:

> Here's a series to handle this; I think the end result is much nicer. I
> ended up calling the option "uploadarchive.allowUnreachable". By moving
> it there instead of under "archive", it is more clear that this is about
> the _serving_ end of the remote connection, and the word "remote"
> becomes redundant.

Yeah, the original was already good but I like this version much
better.  I'm glad I bikeshedded ;-)

Thanks.
