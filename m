From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2010, #03; Wed, 24)
Date: Thu, 25 Nov 2010 17:33:11 +0100
Message-ID: <AANLkTikcZ1-7+ATH1mB+ycQiL7-WRtjwBZ8rkue_-Vom@mail.gmail.com>
References: <7vk4k2rt2m.fsf@alter.siamese.dyndns.org>
	<AANLkTi=U=Km28W-xUM0vmRhhYCuhjSxxk5Fk_yhvjz8K@mail.gmail.com>
	<AANLkTinWtG8dp_CvoH+EWYz4d=D-N0QUiBSrCNwamROo@mail.gmail.com>
	<AANLkTim0hYKcPPaZjxjbpekhR4Ho_cOVaE=41HyJOrMZ@mail.gmail.com>
	<AANLkTi=N=-e+BYM+Bjp665pN=GxK5fWSKbJ34T8Qfh77@mail.gmail.com>
	<AANLkTind1tQ2bE3O-_dz+LOa4gW1X3J28uvRg1mP7aU=@mail.gmail.com>
	<AANLkTi=gg=cqTewgUfqctbd=MdYNcL=jECyCXJycwx_k@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Nov 25 17:33:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLel4-0007Qk-4R
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 17:33:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754102Ab0KYQdN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Nov 2010 11:33:13 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58668 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754075Ab0KYQdM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Nov 2010 11:33:12 -0500
Received: by fxm15 with SMTP id 15so28373fxm.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 08:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=72aDtHTTrLTrFC/Yh6dCrGTg70IlLzbcQPKTgMLrXo4=;
        b=lk7hkEcy2AWCqyur/ef1sErye5mHLrBAwDRrW7eDoViqTu7G1POKjt4AyF8QFEtQYB
         SeSfd2Km319LdvPez/AjZP0N94DId7kBpF3PAvT8cdBHnDY98OiyMzg35DQZ+OiWLz6O
         60To3Y9GIx4qSbnRG6ypfvhX2rlYSge0Fh5sI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xySdtOzS2L7EBn6U0oyaRSIje7J/oj1r/NYPffwuDmfIY/kMs1hm3efbxAsszckaiI
         ZDZ+tWcdOzhlRNIM+wVWy2GmSy2pnmTIHhIOhJB9D45V9FsaJx4BHyr/3iwh0NZIFE1G
         ky3+vTBTJaU2zmXewUKIbal2lpTiyN8NkOAdA=
Received: by 10.223.118.132 with SMTP id v4mr968834faq.87.1290702791190; Thu,
 25 Nov 2010 08:33:11 -0800 (PST)
Received: by 10.223.86.134 with HTTP; Thu, 25 Nov 2010 08:33:11 -0800 (PST)
In-Reply-To: <AANLkTi=gg=cqTewgUfqctbd=MdYNcL=jECyCXJycwx_k@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162146>

On Thu, Nov 25, 2010 at 16:03, Erik Faye-Lund <kusmabite@gmail.com> wro=
te:
> I'm really not thinking straight today: This was in the MSVC-section,
> and I tried to build with MinGW. If I move it to the MinGW section,
> then it's closer to working:
>
> $ make
> =C2=A0 =C2=A0CC alias.o
> =C2=A0 =C2=A0CC alloc.o
> <...>
> =C2=A0 =C2=A0CC gettext.o
> gettext.c:3:21: error: libintl.h: No such file or directory
> gettext.c:7:22: error: langinfo.h: No such file or directory
> gettext.c: In function 'git_setup_gettext':
> gettext.c:17: warning: implicit declaration of function 'bindtextdoma=
in'
> gettext.c:25: error: 'LC_MESSAGES' undeclared (first use in this func=
tion)
> gettext.c:25: error: (Each undeclared identifier is reported only onc=
e
> gettext.c:25: error: for each function it appears in.)
> gettext.c:30: warning: implicit declaration of function 'nl_langinfo'
> gettext.c:30: error: 'CODESET' undeclared (first use in this function=
)
> gettext.c:30: warning: assignment makes pointer from integer without =
a cast
> gettext.c:32: warning: implicit declaration of function 'bind_textdom=
ain_codeset
> '
> gettext.c:34: warning: implicit declaration of function 'textdomain'
> make: *** [gettext.o] Error 1
>
> So this seems to be the same issue as what Hannes is talking about;
> gettext.o being included into LIB_OBJS before we know if it should or
> not.
>
> Moving it down to the rest of the NO_GETTEXT-magic fixes the problem =
for me:
>
>
> diff --git a/Makefile b/Makefile
> index 8357106..a858708 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,6 +1,5 @@
> =C2=A0# The default target of this Makefile is...
> =C2=A0all::
> -
> =C2=A0# Define V=3D1 to have a more verbose compile.
> =C2=A0#
> =C2=A0# Define SHELL_PATH to a POSIX shell if your /bin/sh is broken.
> @@ -628,9 +627,6 @@ LIB_OBJS +=3D entry.o
> =C2=A0LIB_OBJS +=3D environment.o
> =C2=A0LIB_OBJS +=3D exec_cmd.o
> =C2=A0LIB_OBJS +=3D fsck.o
> -ifndef NO_GETTEXT
> -LIB_OBJS +=3D gettext.o
> -endif
> =C2=A0LIB_OBJS +=3D graph.o
> =C2=A0LIB_OBJS +=3D grep.o
> =C2=A0LIB_OBJS +=3D hash.o
> @@ -1603,6 +1600,8 @@ endif
>
> =C2=A0ifdef NO_GETTEXT
> =C2=A0 =C2=A0 =C2=A0 =C2=A0COMPAT_CFLAGS +=3D -DNO_GETTEXT
> +else
> + =C2=A0 =C2=A0 =C2=A0 LIB_OBJS +=3D gettext.o
> =C2=A0endif
>
> =C2=A0ifdef NEEDS_LIBINTL

Doesn't it also work for you to just add:

    NO_GETTEXT =3D YesPlease
    NEEDS_LIBINTL =3D

To the MinGW specific section in the Makefile? That's why I did the
"Makefile: move "Platform specific tweaks" above LIB_{H,OBJS}"
patch. I just hadn't submitted another patch to disable it on MinGW. I
think I asked someone to look into that (e.g. I know that you're
working on MinGW + gettext, so maybe we don't want to disable it
anymore). But I can't find that posting now, and maybe I didn't send it=
=2E

Anyway, if that works it's a cleaner way to disable it.
