From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Move api-command.txt to the end of API list in
 api-index.txt
Date: Sun, 16 Dec 2012 12:01:25 -0800
Message-ID: <7vwqwhpy0a.fsf@alter.siamese.dyndns.org>
References: <1582223824.296627.1355560147565.JavaMail.ngmail@webmail08.arcor-online.net>
 <1479174763.154268.1350408444997.JavaMail.ngmail@webmail15.arcor-online.net>
 <1213313884.154031.1350407865830.JavaMail.ngmail@webmail15.arcor-online.net>
 <1702872710.62174.1355660592713.JavaMail.ngmail@webmail12.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Sun Dec 16 21:01:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkKPH-0008OO-6c
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 21:01:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155Ab2LPUBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 15:01:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54210 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752123Ab2LPUBc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 15:01:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88DEEA10F;
	Sun, 16 Dec 2012 15:01:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oydLK3orKAFHZE9yKHuWed2IVdA=; b=iYctyB
	1IoxU/a1HfWK0XtdfZG+ce4+wdPQOb/fz/lg6E3ryB0p5UCV4tJBi4mIuKgCJRqe
	Qk+4zDoEE/rxRi/C7tjBX99v/nSu2UhhO5t7+rHwm6szkH14Rd/qe5av1MSEt7JT
	8AYK7XdzQzincUBpwvNsU92bAQxCHklwoRMj0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qgmG7hLVK6T569thibdATV/mj5BQfC5z
	zyuDMTQnqlOKs4u70OL7r3xfoA65Dr/kEPcde8DJjw0w5b2n5RYuHL4XyqJB7Z9R
	ZbOg+qAQeOqsMfBDqTWqs7IykPHNK/BnKJPEU+XengphLeBUxah1hwQiiLDXo/gF
	TzcczrmOTi0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7569CA10E;
	Sun, 16 Dec 2012 15:01:32 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72F50A10A; Sun, 16 Dec 2012
 15:01:31 -0500 (EST)
In-Reply-To: <1702872710.62174.1355660592713.JavaMail.ngmail@webmail12.arcor-online.net>
 (Thomas Ackermann's message of "Sun, 16 Dec 2012 13:23:12 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 62B147D6-47BB-11E2-94F8-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211612>

Thomas Ackermann <th.acker@arcor.de> writes:

> - because it describes a different form of API than the other api-* documents

Drop that "- "; it is not like you are enumerating many reasons.

It makes me wonder if a more correct "fix" is to move this document
to the ../howto/ hierarchy.

>
> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---
>  Documentation/technical/api-index.sh | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/technical/api-index.sh b/Documentation/technical/api-index.sh
> index 9c3f413..c2c68ed 100755
> --- a/Documentation/technical/api-index.sh
> +++ b/Documentation/technical/api-index.sh
> @@ -10,12 +10,16 @@
>  	while read filename
>  	do
>  		case "$filename" in
> -		api-index-skel.txt | api-index.txt) continue ;;
> +		api-index-skel.txt | api-index.txt | api-command.txt) continue ;;
>  		esac
>  		title=$(sed -e 1q "$filename")
>  		html=${filename%.txt}.html
>  		echo "* link:$html[$title]"
>  	done
> +	filename=api-command.txt
> +	title=$(sed -e 1q "$filename")
> +	html=${filename%.txt}.html
> +	echo "* link:$html[$title]"
>  	echo "$c"
>  	sed -n -e '/^\/\/ table of contents end/,$p' "$skel"
>  ) >api-index.txt+
