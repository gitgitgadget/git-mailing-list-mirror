From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git(1) man page has link to out-of-date googlecode site
Date: Tue, 09 Feb 2016 12:48:59 -0800
Message-ID: <xmqqvb5x38zo.fsf@gitster.mtv.corp.google.com>
References: <1455049098.2511.203.camel@mattmccutchen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Matt McCutchen <matt@mattmccutchen.net>
X-From: git-owner@vger.kernel.org Tue Feb 09 21:49:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTFDh-0004T6-MH
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 21:49:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932691AbcBIUtF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Feb 2016 15:49:05 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53079 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932641AbcBIUtC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Feb 2016 15:49:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3D76942B6B;
	Tue,  9 Feb 2016 15:49:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Fm4cfe4szEsK
	UfO4EMl1Ch27XzQ=; b=vpHk6EPqfP0uHz0l1Kk96E/mxYFx2bMYXCwf4nj7X9D6
	ntExd16KbljFMqZum+Q5Lvys2JDXfcqsskY+gAjoRNG53ZDPvlPkZ6UOpWfS0QYC
	xn+JY0Zn+9FHNqQxYMestZMQTHtmXjXt1q+thL55jRbZkS9ktii798N1KhRGJr0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Xl6zC2
	y/VkqiO5LuFfF4WW6uRgKM3z6gd++/dKAa5lYf01/qQPijdigyZyT9UbPqxsrec9
	PxEYwiQMgivdGt/Psi5YQxs2LaaUC+1m0P9vHh2mvLCnD/ROxbZKl03es9xaXB04
	oTqmmGw9QPa6kpfArx6lPPcf4cA8U+Axv2AjY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 34A0C42B6A;
	Tue,  9 Feb 2016 15:49:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9ADA642B69;
	Tue,  9 Feb 2016 15:49:01 -0500 (EST)
In-Reply-To: <1455049098.2511.203.camel@mattmccutchen.net> (Matt McCutchen's
	message of "Tue, 09 Feb 2016 15:18:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8C935ED4-CF6E-11E5-9BEF-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285857>

Matt McCutchen <matt@mattmccutchen.net> writes:

> I noticed that near the top of the git(1) man page, there is a link t=
o
> http://git-htmldocs.googlecode.com/git/git.html, which apparently has
> not been updated since August 2015

Thanks for noticing.  Yes, that should be corrected.

> Should this link just be removed, or replaced with
> http://git-scm.com/docs=C2=A0(which lists a subset of the pages) or p=
erhaps
> http://git-scm.com/docs/git?=C2=A0 I will be happy to write the patch=
=2E

The former URL adds GitHub's own Value-Add like pretty icons and
categorization, which may be more appropriate than the latter URL.
Both are a bit more than just "formatted and hyperlinked version" so
the phrasing may want to be also changed.

	An online documentation based on a recent version of Git can
	be viewed at ...

perhaps?

Thanks.
