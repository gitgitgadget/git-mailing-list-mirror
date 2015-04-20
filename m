From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-list-options.txt: complete sentence about notes matching
Date: Mon, 20 Apr 2015 14:59:15 -0700
Message-ID: <xmqqa8y2jwb0.fsf@gitster.dls.corp.google.com>
References: <2ff739260d94310b616eb4a0dd2bd8aac53fd762.1429280914.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Apr 20 23:59:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkJis-0000aB-OE
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 23:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754768AbbDTV7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 17:59:18 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58406 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754766AbbDTV7R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 17:59:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C82D54A3B8;
	Mon, 20 Apr 2015 17:59:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PHHTqcLzcbG3QrKjjJC8T+PIC7U=; b=cqXuuw
	VwDj/QwqMW6yEj5nVoEFgOg8194ZDXuBhwhrr8tcg2Bxu8DCzXxCtCmatRp0JHRB
	GyA9ybkR2IYOD8kumsOZgmPl88RxHLh9d3UPxHhGJZjqksumTf5xnrzI6egR6TVk
	JwJCKJnq4oQ7anLn3M08X/D+aq44cBGQCXsyk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p4a1T9/70QDC34iQlViraOczTIuYreKL
	xr+aNm2NzhjHGRFJfIh+ekavj07c7+0eJSscwJ7SkyxT5dBDLHSnjXF9GXGRlDzH
	T03I+6QR5xH88SDoteK29/i1ruAxTy7MwJ4VKR/Gz69xP3/dpRlHIqMVj2F8gBlq
	mxN52g20bNQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C110F4A3B6;
	Mon, 20 Apr 2015 17:59:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 384514A3B5;
	Mon, 20 Apr 2015 17:59:16 -0400 (EDT)
In-Reply-To: <2ff739260d94310b616eb4a0dd2bd8aac53fd762.1429280914.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Fri, 17 Apr 2015 16:28:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7CCF8990-E7A8-11E4-B883-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267504>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  Documentation/rev-list-options.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index f620ee4..77ac439 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -59,8 +59,8 @@ endif::git-rev-list[]
>  	matches any of the given patterns are chosen (but see
>  	`--all-match`).
>  +
> -When `--show-notes` is in effect, the message from the notes as
> -if it is part of the log message.
> +When `--show-notes` is in effect, the message from the notes is
> +matched as if it were part of the log message.
>  
>  --all-match::
>  	Limit the commits output to ones that match all given `--grep`,


Makes sense, thanks.
