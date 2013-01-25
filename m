From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] Update renamed file merge-file.h in Makefile
Date: Fri, 25 Jan 2013 12:59:42 +0800
Message-ID: <CANYiYbHWE+88DbSoA2EgcZjCh+9YTcHGQhumSUkx_ovXY6FSDQ@mail.gmail.com>
References: <1359083188-31866-1-git-send-email-worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 25 06:00:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TybOW-0003Em-W1
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 06:00:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754792Ab3AYE7o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2013 23:59:44 -0500
Received: from mail-wi0-f172.google.com ([209.85.212.172]:48307 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754324Ab3AYE7n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jan 2013 23:59:43 -0500
Received: by mail-wi0-f172.google.com with SMTP id o1so1087177wic.17
        for <git@vger.kernel.org>; Thu, 24 Jan 2013 20:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=y6Gk/pngfKD4dOn2idlkaa+MhcsxX7a0JeKQ88DvWGA=;
        b=M1Tsn3Sf8SdSD1MKKuihDEVnqUrnDJFGqsNI4+pChioPDp1efURmZuJztXDQwi6TC0
         C3NE7iAC6jvCFfDgIsTLrwrZ6/QGj0psgZjziJwfSfGifTyL5oNeyf4Dq9d3xYeuPjLW
         KSTywOtltefk6pxsEzQJs4T7CnSpsnnlJN8ElWR7pIrl8rpd95qqIqAYnwZBO+7JHN4K
         iqLhpeQwjexNP8VLE26KtdJvJuAlXbgRjfTkIqj6g0A7jFaO+QQLNBtb9872RoMQuaqS
         mZHEgGCWGT3sJJS27XLOJqsjuosfWhS8bjRF8s/L+d0z8EQ0wYeIGE44hd9v/muurfPP
         rSJw==
X-Received: by 10.194.238.226 with SMTP id vn2mr6666164wjc.23.1359089982109;
 Thu, 24 Jan 2013 20:59:42 -0800 (PST)
Received: by 10.216.106.65 with HTTP; Thu, 24 Jan 2013 20:59:42 -0800 (PST)
In-Reply-To: <1359083188-31866-1-git-send-email-worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214496>

Oops,  I find it is already fixed in commit
a60521bc6099ce89d05ef2160d2e3c30a106fda7.

commit a60521bc6099ce89d05ef2160d2e3c30a106fda7
Author: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Date:   Tue Jan 22 16:47:47 2013 +0000

    Makefile: Replace merge-file.h with merge-blobs.h in LIB_H

    Commit fa2364ec ("Which merge_file() function do you mean?", 06-12-=
2012)
    renamed the files merge-file.[ch] to merge-blobs.[ch], but forgot t=
o
    rename the header file in the definition of the LIB_H macro.

    Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

(kick back to the list)

2013/1/25 Jiang Xin <worldhello.net@gmail.com>:
> Commit v1.8.1-rc0-3-gfa2364e renamed merge-file.h to merge-blobs.h, b=
ut
> forgot to update the reference of merge-file.h in Makefile. This woul=
d
> break the build of "po/git.pot", which depends on $(LOCALIZED_C), the=
n
> fallback to the missing file "merge-file.h".
>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> ---
>  Makefile |    2 +-
>  1 =B8=F6=CE=C4=BC=FE=B1=BB=D0=DE=B8=C4=A3=AC=B2=E5=C8=EB 1 =D0=D0(+)=
=A3=AC=C9=BE=B3=FD 1 =D0=D0(-)
>
> diff --git a/Makefile b/Makefile
> index 1b30d7b..a786d4c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -649,7 +649,7 @@ LIB_H +=3D list-objects.h
>  LIB_H +=3D ll-merge.h
>  LIB_H +=3D log-tree.h
>  LIB_H +=3D mailmap.h
> -LIB_H +=3D merge-file.h
> +LIB_H +=3D merge-blobs.h
>  LIB_H +=3D merge-recursive.h
>  LIB_H +=3D mergesort.h
>  LIB_H +=3D notes-cache.h
> --
> 1.8.1.1
>
