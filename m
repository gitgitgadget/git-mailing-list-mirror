From: John Hsing <tsyj2007@gmail.com>
Subject: Re: a bug when execute "git status" in git version 1.7.7.431.g89633
Date: Sun, 23 Oct 2011 16:35:07 +0800
Message-ID: <4EA3D1BB.2010802@gmail.com>
References: <4EA20C5B.3090808@gmail.com> <vpqfwiknmh3.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Oct 23 10:35:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHtWd-0007D5-Bl
	for gcvg-git-2@lo.gmane.org; Sun, 23 Oct 2011 10:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755142Ab1JWIfN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Oct 2011 04:35:13 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59016 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754715Ab1JWIfM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2011 04:35:12 -0400
Received: by iaby12 with SMTP id y12so50775iab.19
        for <git@vger.kernel.org>; Sun, 23 Oct 2011 01:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=c+Bl4lFzBchMGPows1lqSr9GLhlmTH48gjR+ag77F6c=;
        b=OVq6KslGlojsUEihgtgdmkm3kkC1uqnNl4gMW+zgM8DBkdFeD4C9uj1Aro/06yT6Nr
         bzaMGtTTAdecGvKlB9IhW8g7r3tQZObJmWhGmsZXOJASuM3WtRjb/XGSL2bimk8gcB3Q
         5Zkl9jaBoxdvzdzvxA9oJ17yrXp8pCKzvGaYw=
Received: by 10.42.180.138 with SMTP id bu10mr14227147icb.22.1319358911831;
        Sun, 23 Oct 2011 01:35:11 -0700 (PDT)
Received: from [10.13.157.146] ([112.2.254.147])
        by mx.google.com with ESMTPS id ge16sm49614791ibb.2.2011.10.23.01.35.09
        (version=SSLv3 cipher=OTHER);
        Sun, 23 Oct 2011 01:35:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:7.0.1) Gecko/20110930 Thunderbird/7.0.1
In-Reply-To: <vpqfwiknmh3.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184129>

ok,when i finish compiling git 1.7.7.431.g89633=EF=BC=8CI use it to che=
ck=20
Cyanogenod=EF=BC=88an Android mod source=EF=BC=89 by =E2=80=9Cgit statu=
s=E2=80=9D=EF=BC=8Cit happend this=20
error=EF=BC=81but when i reuse git v1.7.7=EF=BC=8Cit is OK=EF=BC=81so i=
 think it is a bug in=20
git 1.7.7.431.g89633=EF=BC=81My OS is Ubuntu Linux 10.10=EF=BC=8Csorry =
for my bad=20
english=EF=BC=81 If you want to reproduce this error,please excute "git=
 status"=20
in https://github.com/CyanogenMod/android_packages_apps_DSPManager.git=20
repo!

=E4=BA=8E2011=E5=B9=B410=E6=9C=8823=E6=97=A5 =E6=98=9F=E6=9C=9F=E6=97=A5=
 16=E6=97=B625=E5=88=8628=E7=A7=92,Matthieu Moy=E5=86=99=E5=88=B0:
> John Hsing <tsyj2007@gmail.com> writes:
>
>> the error:
>
> When does this error occur? is it reproducible on any repository? Whi=
ch
> OS?
>
>> git: malloc.c:3096: sYSMALLOc: Assertion `(old_top =3D=3D (((mbinptr=
)
>> (((char *) &((av)->bins[((1) - 1) * 2])) - __builtin_offsetof (struc=
t
>> malloc_chunk, fd)))) && old_size =3D=3D 0) || ((unsigned long) (old_=
size) >=3D
>> (unsigned long)((((__builtin_offsetof (struct malloc_chunk,
>> fd_nextsize))+((2 * (sizeof(size_t))) - 1)) & ~((2 * (sizeof(size_t)=
)) -
>> 1))) && ((old_top)->size & 0x1) && ((unsigned long)old_end & pagemas=
k)
>> =3D=3D 0)' failed.
>
> The assertion is violated outside the source code of Git itself, so
> either Git calls malloc incorrectly, or this is a bug in your libc.
>
