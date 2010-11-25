From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2010, #03; Wed, 24)
Date: Thu, 25 Nov 2010 18:55:44 +0100
Message-ID: <AANLkTin-kF_+DKDAu=gt12WfOcEVJaED-Qny8sFQ=oKP@mail.gmail.com>
References: <7vk4k2rt2m.fsf@alter.siamese.dyndns.org> <AANLkTi=U=Km28W-xUM0vmRhhYCuhjSxxk5Fk_yhvjz8K@mail.gmail.com>
 <AANLkTinWtG8dp_CvoH+EWYz4d=D-N0QUiBSrCNwamROo@mail.gmail.com>
 <AANLkTim0hYKcPPaZjxjbpekhR4Ho_cOVaE=41HyJOrMZ@mail.gmail.com>
 <AANLkTi=N=-e+BYM+Bjp665pN=GxK5fWSKbJ34T8Qfh77@mail.gmail.com>
 <AANLkTind1tQ2bE3O-_dz+LOa4gW1X3J28uvRg1mP7aU=@mail.gmail.com>
 <AANLkTi=gg=cqTewgUfqctbd=MdYNcL=jECyCXJycwx_k@mail.gmail.com> <AANLkTikcZ1-7+ATH1mB+ycQiL7-WRtjwBZ8rkue_-Vom@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 25 18:56:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLg3J-0005zf-14
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 18:56:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473Ab0KYR4I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Nov 2010 12:56:08 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64180 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266Ab0KYR4H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Nov 2010 12:56:07 -0500
Received: by fxm15 with SMTP id 15so93842fxm.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 09:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=eBSmtCoakwdfvV1GjLkQY1mc5HYnyWiVb0VhGp4Pnfo=;
        b=fgoLQptBAanIZl/ySeoGgdx1MQIuVP+EZqRzuQAiDJh8QrZhMlagLrbdHewIesh9gz
         DxX2yxqPIRY32ZHTENzopPy/NMWFWy2sV2LSsGJUKGWpW77TTVvRzj0wa5WpsghhUKJl
         OlocsBBXXrNFfkLEzmszRR2zL/lWrwiEYtlF0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=n0x9XdOTqs84b7uShXuAnR8fJHl17HPE6ax4SNMQMvae5I9S8Fn9iPxeRANN3HY+nA
         x19paCc/iFZ+ps9MeH/QknYwDyhZSZ49lSEt1NmdxGAP5jL+Z3wjoMSOLAce2B8eZVz+
         Ot6hdXqueuH5Y7ShC/JQ/sYDKVekOLZA7hHXY=
Received: by 10.223.100.15 with SMTP id w15mr1060467fan.121.1290707764542;
 Thu, 25 Nov 2010 09:56:04 -0800 (PST)
Received: by 10.223.72.206 with HTTP; Thu, 25 Nov 2010 09:55:44 -0800 (PST)
In-Reply-To: <AANLkTikcZ1-7+ATH1mB+ycQiL7-WRtjwBZ8rkue_-Vom@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162148>

On Thu, Nov 25, 2010 at 5:33 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Thu, Nov 25, 2010 at 16:03, Erik Faye-Lund <kusmabite@gmail.com> w=
rote:
>> I'm really not thinking straight today: This was in the MSVC-section=
,
>> and I tried to build with MinGW. If I move it to the MinGW section,
>> then it's closer to working:
>>
>> $ make
>> =A0 =A0CC alias.o
>> =A0 =A0CC alloc.o
>> <...>
>> =A0 =A0CC gettext.o
>> gettext.c:3:21: error: libintl.h: No such file or directory
>> gettext.c:7:22: error: langinfo.h: No such file or directory
>> gettext.c: In function 'git_setup_gettext':
>> gettext.c:17: warning: implicit declaration of function 'bindtextdom=
ain'
>> gettext.c:25: error: 'LC_MESSAGES' undeclared (first use in this fun=
ction)
>> gettext.c:25: error: (Each undeclared identifier is reported only on=
ce
>> gettext.c:25: error: for each function it appears in.)
>> gettext.c:30: warning: implicit declaration of function 'nl_langinfo=
'
>> gettext.c:30: error: 'CODESET' undeclared (first use in this functio=
n)
>> gettext.c:30: warning: assignment makes pointer from integer without=
 a cast
>> gettext.c:32: warning: implicit declaration of function 'bind_textdo=
main_codeset
>> '
>> gettext.c:34: warning: implicit declaration of function 'textdomain'
>> make: *** [gettext.o] Error 1
>>
>> So this seems to be the same issue as what Hannes is talking about;
>> gettext.o being included into LIB_OBJS before we know if it should o=
r
>> not.
>>
>> Moving it down to the rest of the NO_GETTEXT-magic fixes the problem=
 for me:
>>
>>
>> diff --git a/Makefile b/Makefile
>> index 8357106..a858708 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1,6 +1,5 @@
>> =A0# The default target of this Makefile is...
>> =A0all::
>> -
>> =A0# Define V=3D1 to have a more verbose compile.
>> =A0#
>> =A0# Define SHELL_PATH to a POSIX shell if your /bin/sh is broken.
>> @@ -628,9 +627,6 @@ LIB_OBJS +=3D entry.o
>> =A0LIB_OBJS +=3D environment.o
>> =A0LIB_OBJS +=3D exec_cmd.o
>> =A0LIB_OBJS +=3D fsck.o
>> -ifndef NO_GETTEXT
>> -LIB_OBJS +=3D gettext.o
>> -endif
>> =A0LIB_OBJS +=3D graph.o
>> =A0LIB_OBJS +=3D grep.o
>> =A0LIB_OBJS +=3D hash.o
>> @@ -1603,6 +1600,8 @@ endif
>>
>> =A0ifdef NO_GETTEXT
>> =A0 =A0 =A0 =A0COMPAT_CFLAGS +=3D -DNO_GETTEXT
>> +else
>> + =A0 =A0 =A0 LIB_OBJS +=3D gettext.o
>> =A0endif
>>
>> =A0ifdef NEEDS_LIBINTL
>
> Doesn't it also work for you to just add:
>
> =A0 =A0NO_GETTEXT =3D YesPlease
> =A0 =A0NEEDS_LIBINTL =3D
>
> To the MinGW specific section in the Makefile? That's why I did the
> "Makefile: move "Platform specific tweaks" above LIB_{H,OBJS}"
> patch. I just hadn't submitted another patch to disable it on MinGW. =
I
> think I asked someone to look into that (e.g. I know that you're
> working on MinGW + gettext, so maybe we don't want to disable it
> anymore). But I can't find that posting now, and maybe I didn't send =
it.
>
> Anyway, if that works it's a cleaner way to disable it.
>

Yes, that works. But that is a work-around, not a solution. I already
told the make system not to translate git, why should I have to
anything else? In fact, I did exactly what the documentation at the
top of the makefile told me to do. It says to set NO_GETTEXT, nothing
about clearing NEEDS_LIBINTL.
