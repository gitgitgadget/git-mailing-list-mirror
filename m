From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-clean.txt: don't mention deletion of .git/modules/*
Date: Mon, 08 Feb 2016 14:22:01 -0800
Message-ID: <xmqqvb5y6dx2.fsf@gitster.mtv.corp.google.com>
References: <1454790889.23898.225.camel@mattmccutchen.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Matt McCutchen <matt@mattmccutchen.net>
To: Mikko Rapeli <mikko.rapeli@iki.fi>
X-From: git-owner@vger.kernel.org Mon Feb 08 23:22:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSuCA-0004SH-JF
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 23:22:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756374AbcBHWWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 17:22:06 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59391 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756340AbcBHWWE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 17:22:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 70B6F42071;
	Mon,  8 Feb 2016 17:22:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2+oxzcgNT24N+nVrW2wXmsBNWWQ=; b=DI5Dr5
	vHp3sysNNHz6AvtcntZjLhD/caOYrtPZqVRs+SLKgRi/uPNlk9KIZKRWdXWHOiFI
	fLuUtzipLp8VywK58wt8gIBWU+MUTtLVPVhInPsO9b9E73CBRqhzHXFlXhL6SMSC
	71ZiD8TP5wWyvvm+sTeunHf8od7avMLbKXY44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qLTazJuNhmIuP9HkTHBbIQek22vDvXcp
	ym6gmkP9dB+InBY6PY/QE6nVmjLBzjfKj/5SV/Yysyca1k9c/wl++zcUGGQ2R00G
	nuO+yXnZdKZnIcxceHbdjS4M29J3yxi7mhVJSC9Swvjf+TRErRHPCgbZr89GSfT0
	qO51lpKbTY0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 67E3742070;
	Mon,  8 Feb 2016 17:22:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D70054206F;
	Mon,  8 Feb 2016 17:22:02 -0500 (EST)
In-Reply-To: <1454790889.23898.225.camel@mattmccutchen.net> (Matt McCutchen's
	message of "Sat, 06 Feb 2016 15:34:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 60D82F8E-CEB2-11E5-93E0-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285816>

Matt McCutchen <matt@mattmccutchen.net> writes:

> I found no evidence of such behavior in the source code.
>
> Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
> ---

That was added last year at bcd57cb9 (Documentation/git-clean.txt:
document that -f may need to be given twice, 2015-02-26).  It would
be better to know what got changed since then--that is, was the
additional text unnecessary even back then, or we made changes to
the system since then and forgot to remove the added text.

Mikko, is this need to give -f twice still the case?

>
> This is based on the maint branch, a08595f.
>
>  Documentation/git-clean.txt | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
> index 641681f..51a7e26 100644
> --- a/Documentation/git-clean.txt
> +++ b/Documentation/git-clean.txt
> @@ -37,9 +37,7 @@ OPTIONS
>  	to false, 'git clean' will refuse to delete files or directories
>  	unless given -f, -n or -i. Git will refuse to delete directories
>  	with .git sub directory or file unless a second -f
> -	is given. This affects also git submodules where the storage area
> -	of the removed submodule under .git/modules/ is not removed until
> -	-f is given twice.
> +	is given.
>  
>  -i::
>  --interactive::
> -- 
> 2.5.0
