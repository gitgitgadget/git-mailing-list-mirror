From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Makefile: don't include git version file on 'make clean'
Date: Sun, 25 Jul 2010 13:08:14 +0000
Message-ID: <AANLkTillxO38RTicjCw8ujzliFIhY3oHYHOCHAvUe7mB@mail.gmail.com>
References: <1279943627-11053-1-git-send-email-Lynn.Lin@emc.com>
	<AANLkTilYXdVI_fqG5ZvPEABTXt7fTps3ZbPiiWgVnDxS@mail.gmail.com>
	<4C4BFAA3.3050700@digium.com>
	<7F48A44C0E1FBF48B00D4DA49C85432E54F998@CORPUSMX100A.corp.emc.com>
	<AANLkTilHrEImfhl0YTqj0MgXFTzYmJMJrUTKkflGFwpp@mail.gmail.com>
	<7F48A44C0E1FBF48B00D4DA49C85432E54F99A@CORPUSMX100A.corp.emc.com>
	<AANLkTilhoF670uZ1WbosZP9TNbXect2A3gELRJL0ZZIn@mail.gmail.com>
	<m2d3ubojfr.fsf@igel.home>
	<AANLkTilK_8wVQG6s8pUrscwd7ZnvgGyjOjJP41uXYfEl@mail.gmail.com>
	<7F48A44C0E1FBF48B00D4DA49C85432E54F99D@CORPUSMX100A.corp.emc.com>
	<7F48A44C0E1FBF48B00D4DA49C85432E54F99F@CORPUSMX100A.corp.emc.com>
	<7F48A44C0E1FBF48B00D4DA49C85432E54F9A0@CORPUSMX100A.corp.emc.com>
	<AANLkTinjmUEHxnGI2kRBwN17689MEwRRX_1uOQx-ZaHY@mail.gmail.com>
	<7F48A44C0E1FBF48B00D4DA49C85432E54F9A1@CORPUSMX100A.corp.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: schwab@linux-m68k.org, kpfleming@digium.com, git@vger.kernel.org
To: lynn.lin@emc.com
X-From: git-owner@vger.kernel.org Sun Jul 25 15:08:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od0wR-0005R4-Pz
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 15:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392Ab0GYNIQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 09:08:16 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56709 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150Ab0GYNIP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jul 2010 09:08:15 -0400
Received: by iwn7 with SMTP id 7so1896294iwn.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 06:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RJgtYh8h3TfS3w4W/3MFHAxL79ZzRJzIAhNqi3bfH0A=;
        b=xFQqK8fThNm9uhD9EE+MO2+jVgRhhlO9OZlsqXIi6yEUy0wVHUHIi22t+A2CxQU0WW
         KR+eIhFu8vckk87hSa2rX29e3M08zZ6jYfHFeBvRe2hq/2yH7v9bcY+Pf5bXLjqTeoDo
         ZlCYOA1ubQorx/R3owrrtpVUzQ1jE+OwYb4pg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JiNokELJbMfV1CopF0gQrW3BECID4JFQ13BFOtTXGbjNdLXua6QpohVaMSRwcAbMwr
         rKrgvIQ6AyGG6rnygAZ2UhLDCLs4leVvZXeOq1YSm8v7TwUWLTwfm5ZJtIh7IZyWT8AJ
         JeXN+GyW/dKBzAx24VyStpxPSziad7/wqK444=
Received: by 10.231.146.196 with SMTP id i4mr6348224ibv.110.1280063294925; 
	Sun, 25 Jul 2010 06:08:14 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Sun, 25 Jul 2010 06:08:14 -0700 (PDT)
In-Reply-To: <7F48A44C0E1FBF48B00D4DA49C85432E54F9A1@CORPUSMX100A.corp.emc.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151740>

On Sun, Jul 25, 2010 at 12:37,  <lynn.lin@emc.com> wrote:
>
>
> -----Original Message-----
> From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason [mailto:avarab@gmail.com=
]
> Sent: 2010=E5=B9=B47=E6=9C=8825=E6=97=A5 20:34
> To: Lin, Lynn
> Cc: schwab@linux-m68k.org; kpfleming@digium.com; git@vger.kernel.org
> Subject: Re: [PATCH] Makefile: don't include git version file on 'mak=
e clean'
>
> On Sun, Jul 25, 2010 at 12:29, =C2=A0<lynn.lin@emc.com> wrote:
>
>> My patch is to don't call GIT-VERSION-FILE target when you run 'make=
 clean'
>
> Yes, but as I demonstrated it gets called anyway. Presumably because
> of the $(MAKE) -C ... clean rules. But I haven't looked into it.
>
>
> If we don't specify special goals, when we run any target ,it will ca=
ll GIT-VERSIONF-FILE target as it include this target
>
> Example from GNU make manual:
> http://www.gnu.org/software/autoconf/manual/make/Goals.html
>
>
> An example of appropriate use is to avoid including .d files during c=
lean rules (see Automatic Prerequisites), so make won't create them onl=
y to immediately remove them again:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sources =3D foo.c bar.c
>
> =C2=A0 =C2=A0 ifneq ($(MAKECMDGOALS),clean)
> =C2=A0 =C2=A0 include $(sources:.c=3D.d)
> =C2=A0 =C2=A0 endif

Yes, I know (now) how include directives work. What I'm saying is that
your patch doesn't work because the main Makefile clean directive
calls *other* makefiles, which in turn include the version file:

    $ rm GIT-VERSION-FILE ; make -C gitweb clean; cat GIT-VERSION-FILE
    make: Entering directory `/home/avar/g/git/gitweb'
    make[1]: Entering directory `/home/avar/g/git'
    GIT_VERSION =3D 1.7.2.6.g65a0d3
    make[1]: Leaving directory `/home/avar/g/git'
    make[1]: Entering directory `/home/avar/g/git'
    make[1]: `GIT-VERSION-FILE' is up to date.
    make[1]: Leaving directory `/home/avar/g/git'
    make: Leaving directory `/home/avar/g/git/gitweb'
    make: Entering directory `/home/avar/g/git/gitweb'
    make[1]: Entering directory `/home/avar/g/git'
    make[1]: `GIT-VERSION-FILE' is up to date.
    make[1]: Leaving directory `/home/avar/g/git'
    rm -f gitweb.cgi static/gitweb.min.js static/gitweb.min.css
GITWEB-BUILD-OPTIONS
    make: Leaving directory `/home/avar/g/git/gitweb'
    GIT_VERSION =3D 1.7.2.6.g65a0d3

So just removing the inclusion in the main Makefile doesn't do
anything at all.

To get it to work you need to patch the */Makefile files too, and
patch other clean targets like distclean.

But personally I think this whole thing is a bit silly, but others may
disagree. I've said my bit.

Thanks for contributing to Git anyway, your help is appreciated.
