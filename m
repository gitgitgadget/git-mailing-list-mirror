From: =?UTF-8?B?VXNpZXZhxYJhZCDEjG9ybnk=?= <eratyk@tut.by>
Subject: =?UTF-8?B?UmU6IMWsxa0gbGV0dGVy?=
Date: Wed, 31 Oct 2012 18:08:51 +0300
Message-ID: <CAG+H+KT=TyJ2hwWRxYwfXut==1v+a0fpy_pZH1SCR4=VukPHbQ@mail.gmail.com>
References: <CAG+H+KTc9trmR9VBgGsdHfAUFW8VMwa218O3yM_nyNWtrySXyg@mail.gmail.com>
	<50913C58.2000200@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Oct 31 16:09:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTZur-0004DG-QO
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 16:09:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423103Ab2JaPIz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Oct 2012 11:08:55 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:36267 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423087Ab2JaPIw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Oct 2012 11:08:52 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so2179328iea.19
        for <git@vger.kernel.org>; Wed, 31 Oct 2012 08:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wQwJWYO9VN9PB3zZCsLmcoryxcC+I6OJpZxvIkyP3VM=;
        b=of0hC10V/X5eVWCr6byDaO9s6OgMoiEuEclGOaemydgcfRO4Z/H2kGax4ihJuegw5o
         RGNTAyHD7x0R7KHL/urPzZjOAb4/2nnDwPBzZi5PeOLu4Wwj807kiEF9zaUIP5xHhQII
         C3eCrL4s3mtYW3Bsmwk4R2/aWjYbZIWyVZ8/8i8cB+MT5bLoxO8sizz3hy2kXS1B+TGh
         +badZXE/rTc0WJJYe7jaMId+hREMjA8X3DgAMQ8ATayaAJGI2Xrdn9qqWUuBmesIo5UG
         Bs/Jv3aOjV4A5VWTH8T8/3kS/Fjd5Xdbmmt8Ehj3fNuYVZ73oU8B3NOdPiGv4pbwsfh9
         EZWg==
Received: by 10.50.187.194 with SMTP id fu2mr1837776igc.63.1351696131694; Wed,
 31 Oct 2012 08:08:51 -0700 (PDT)
Received: by 10.64.45.6 with HTTP; Wed, 31 Oct 2012 08:08:51 -0700 (PDT)
In-Reply-To: <50913C58.2000200@drmicha.warpmail.net>
X-Google-Sender-Auth: UqHqyn5EqUcIF5b5Ou4hK5RfN1Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208830>

Ok. I use Win7 sp1, syslang =E2=80=94 be_BY, git version 1.8.0.msysgit.=
0 (=E2=80=9Egit
version=E2=80=9C command).
Problem appears when I type this letter on keyboard; when I copy-paste
it everyrhing is ok.

On Wed, Oct 31, 2012 at 5:57 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Usieva=C5=82ad =C4=8Corny venit, vidit, dixit 31.10.2012 15:39:
>> Hello!
>>
>> When I type comment message in Git Gui (1.8.0 and previous), I can't
>> use =C5=AC=C5=AD letter (U+016C, U+016D) =E2=80=94 it just transform=
s into simple Uu.
>> Please fix it.
>
> Can you tell us more about your environment (LANG setting, OS)? I jus=
t
> made two commits (1 with git-gui, one with git-commit on command line=
),
> and both come out fine (LANG=3Dde_DE.UTF-8, git version 1.8.0.226.gba=
44ac5
> on Fedora 16):
>
> git log -2 -p
> commit 36de49231639eb9edccb1ebad595056d395141c7
> Author: Michael J Gruber <git@drmicha.warpmail.net>
> Date:   Wed Oct 31 15:54:04 2012 +0100
>
>     =C3=A4=C3=B6=C3=BC=C3=9F=C5=AC=C5=AD
>
> diff --git a/a b/a
> index 1074042..677c385 100644
> --- a/a
> +++ b/a
> @@ -1 +1,2 @@
>  =C3=A4=C3=B6=C3=BC=C3=9F=C5=AC=C5=AD
> +=C3=A4=C3=B6=C3=BC=C3=9F=C5=AC=C5=AD
>
> commit cfcf8f021a53c1bf5ae018a723fbcfad8649a02b
> Author: Michael J Gruber <git@drmicha.warpmail.net>
> Date:   Wed Oct 31 15:52:52 2012 +0100
>
>     =C3=A4=C3=B6=C3=BC=C3=9F=C5=AC=C5=AD
>
> diff --git a/a b/a
> new file mode 100644
> index 0000000..1074042
> --- /dev/null
> +++ b/a
> @@ -0,0 +1 @@
> +=C3=A4=C3=B6=C3=BC=C3=9F=C5=AC=C5=AD



--=20
Z pavahaj, Usieva=C5=82ad =C4=8Corny
