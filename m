From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] configure: fix help screen
Date: Fri, 28 Jun 2013 10:48:48 -0700
Message-ID: <7v8v1up1mn.fsf@alter.siamese.dyndns.org>
References: <39f9e29341ce7818d1b3ed67d108345c7159f01d.1372439910.git.stefano.lattarini@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 28 19:48:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uscn3-0004I7-59
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 19:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476Ab3F1Rsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 13:48:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46289 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751693Ab3F1Rsw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 13:48:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CF542C9DE;
	Fri, 28 Jun 2013 17:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KIHuiCq/fhtW2tfkxMUbqJYZmg0=; b=XS257X
	PZPhycLqfX+qy+szLopJ6KlBkBNOasyJUV4XGS5Spx+pwCiCNkJq3tv1i84LmE3R
	Qi5eLZD2cgtu8+9K833UXxbUXV95aDR3dfb8o+S5uw7xkkrdIlQpAPM+a8jIBlzS
	UtoXVORXcb8KKZw+xayN0/tjujE+J8MEuUjL0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m3WYPS44KDVMbP59aK6XKuR/adF6zyXM
	kJ6Ds1MkdRjMkxeYoPpWalM3FSSGBE1iWZnDqJXcVozpFroGY+NX64KZJVeqEmcG
	aOe1qNjTPCV/JZfMWIe7PgRs3kpxwAitrrokyZHy0BjxMIcvtPdGAhTjfYvoTpjH
	1IIT6yn3A2I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 009332C9DD;
	Fri, 28 Jun 2013 17:48:52 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 681622C9D7;
	Fri, 28 Jun 2013 17:48:50 +0000 (UTC)
In-Reply-To: <39f9e29341ce7818d1b3ed67d108345c7159f01d.1372439910.git.stefano.lattarini@gmail.com>
	(Stefano Lattarini's message of "Fri, 28 Jun 2013 19:19:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FDAEA182-E01A-11E2-A58A-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229222>

Stefano Lattarini <stefano.lattarini@gmail.com> writes:

> The configure option to disable threading is '--disable-pthreads',
> not '--without-pthreads'.
>
> Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
> ---

Thanks.

>  configure.ac | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configure.ac b/configure.ac
> index f3462d9..2f43393 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -193,7 +193,7 @@ AC_ARG_ENABLE([pthreads],
>    [FLAGS is the value to pass to the compiler to enable POSIX Threads.]
>    [The default if FLAGS is not specified is to try first -pthread]
>    [and then -lpthread.]
> -  [--without-pthreads will disable threading.])],
> +  [--disable-pthreads will disable threading.])],
>  [
>  if test "x$enableval" = "xyes"; then
>     AC_MSG_NOTICE([Will try -pthread then -lpthread to enable POSIX Threads])
