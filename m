From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2010, #03; Wed, 24)
Date: Thu, 25 Nov 2010 16:22:02 +0100
Message-ID: <AANLkTi=KiZszM-oxVusNssA7YocqGAvN0rubyzsrTqTu@mail.gmail.com>
References: <7vk4k2rt2m.fsf@alter.siamese.dyndns.org> <AANLkTi=U=Km28W-xUM0vmRhhYCuhjSxxk5Fk_yhvjz8K@mail.gmail.com>
 <AANLkTinWtG8dp_CvoH+EWYz4d=D-N0QUiBSrCNwamROo@mail.gmail.com>
 <AANLkTim0hYKcPPaZjxjbpekhR4Ho_cOVaE=41HyJOrMZ@mail.gmail.com>
 <AANLkTi=N=-e+BYM+Bjp665pN=GxK5fWSKbJ34T8Qfh77@mail.gmail.com>
 <AANLkTind1tQ2bE3O-_dz+LOa4gW1X3J28uvRg1mP7aU=@mail.gmail.com> <AANLkTi=gg=cqTewgUfqctbd=MdYNcL=jECyCXJycwx_k@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 25 16:22:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLdeh-0005A3-BS
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 16:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490Ab0KYPWa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Nov 2010 10:22:30 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62119 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941Ab0KYPW3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Nov 2010 10:22:29 -0500
Received: by fxm13 with SMTP id 13so858981fxm.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 07:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=oM7irHpCAqwN3gTrZqQ1WVk3BqeFH1z/osNA2LrGdhw=;
        b=SIeMzBfuWqsD3FpeLzSKcfbBCoRwpWoTpHVaay5KFeUJLNx2sXnOBUOU92i9sk0mZC
         FDL+4pOiUaECSx/IzpRRlcVBwk3tZVyX/EiUQfIs9KIXRfesqd8dogp86pKQikb+WcBU
         nmgZA6Qij3z0x2cSAP4K7+AC+N61MwNp8e2Ag=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=eLZR1Rrb/1UEpjuDdwFcN3r2AY++IQgkvm1sb2RPEuJ7UaxkhIVghK8ATER/UhgEf6
         ZvZLNlzg17Rw6Bw7pF8SnZfqJHXNv8VXJ9nBZRIZrd63AcJ0niSdoTmLo4wmoTarqaoH
         APpRfwI4h2VLDkqHW1uytMLPh1f+25c6wywOg=
Received: by 10.223.107.16 with SMTP id z16mr902334fao.7.1290698543113; Thu,
 25 Nov 2010 07:22:23 -0800 (PST)
Received: by 10.223.72.206 with HTTP; Thu, 25 Nov 2010 07:22:02 -0800 (PST)
In-Reply-To: <AANLkTi=gg=cqTewgUfqctbd=MdYNcL=jECyCXJycwx_k@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162141>

On Thu, Nov 25, 2010 at 4:03 PM, Erik Faye-Lund <kusmabite@gmail.com> w=
rote:
> On Thu, Nov 25, 2010 at 3:54 PM, Erik Faye-Lund <kusmabite@gmail.com>=
 wrote:
>> On Thu, Nov 25, 2010 at 1:34 PM, Erik Faye-Lund <kusmabite@gmail.com=
> wrote:
>>> On Thu, Nov 25, 2010 at 1:00 PM, =C6var Arnfj=F6r=F0 Bjarmason
>>> <avarab@gmail.com> wrote:
>>>> On Thu, Nov 25, 2010 at 11:35, Erik Faye-Lund <kusmabite@gmail.com=
> wrote:
>>>>> On Thu, Nov 25, 2010 at 10:45 AM, =C6var Arnfj=F6r=F0 Bjarmason
>>>>> <avarab@gmail.com> wrote:
>>>>
>>>>>> Is there anything else than that (the builtin.h includes) that y=
ou
>>>>>> think needs work?
>>>>>
>>>>> There was an issue where setting NO_GETTEXT wasn't enough to disa=
ble
>>>>> internationalization. Has this been fixed?
>>>>
>>>> Do you mean the issue with eval_gettext in git-sh-i18n.sh? I fixed
>>>> that issue, but even under NO_GETTEXT=3DYesPlease we'll still pass
>>>> things through git-sh-i18n--envsubst. Since I can't just #define
>>>> things out under NO_GETTEXT=3DYes like I can in the C code.
>>>>
>>>> Maybe you mean something different that I'm forgetting. But IIRC t=
hat
>>>> was the only issue.
>>>>
>>>
>>> I'm talking about this:
>>>
>>> $ git diff
>>> diff --git a/Makefile b/Makefile
>>> index 8357106..0a49c2c 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -1124,6 +1124,7 @@ ifeq ($(uname_S),Windows)
>>> =A0 =A0 =A0 =A0NO_STRTOK_R =3D YesPlease
>>> =A0 =A0 =A0 =A0NO_FNMATCH =3D YesPlease
>>> =A0 =A0 =A0 =A0NO_MEMMEM =3D YesPlease
>>> + =A0 =A0 =A0 NO_GETTEXT =3D YesPlease
>>> =A0 =A0 =A0 =A0# NEEDS_LIBICONV =3D YesPlease
>>> =A0 =A0 =A0 =A0NO_ICONV =3D YesPlease
>>> =A0 =A0 =A0 =A0NO_C99_FORMAT =3D YesPlease
>>>
>>
>> Uhm, my bad. This was in the MINGW-section. Seems this issue has bee=
n
>> fixed now, thanks.
>>
>
> I'm really not thinking straight today: This was in the MSVC-section,
> and I tried to build with MinGW. If I move it to the MinGW section,
> then it's closer to working:
>
> $ make
> =A0 =A0CC alias.o
> =A0 =A0CC alloc.o
> <...>
> =A0 =A0CC gettext.o
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
> =A0# The default target of this Makefile is...
> =A0all::
> -
> =A0# Define V=3D1 to have a more verbose compile.
> =A0#
> =A0# Define SHELL_PATH to a POSIX shell if your /bin/sh is broken.
> @@ -628,9 +627,6 @@ LIB_OBJS +=3D entry.o
> =A0LIB_OBJS +=3D environment.o
> =A0LIB_OBJS +=3D exec_cmd.o
> =A0LIB_OBJS +=3D fsck.o
> -ifndef NO_GETTEXT
> -LIB_OBJS +=3D gettext.o
> -endif
> =A0LIB_OBJS +=3D graph.o
> =A0LIB_OBJS +=3D grep.o
> =A0LIB_OBJS +=3D hash.o
> @@ -1603,6 +1600,8 @@ endif
>
> =A0ifdef NO_GETTEXT
> =A0 =A0 =A0 =A0COMPAT_CFLAGS +=3D -DNO_GETTEXT
> +else
> + =A0 =A0 =A0 LIB_OBJS +=3D gettext.o
> =A0endif
>
> =A0ifdef NEEDS_LIBINTL
>

change that last hunk to:
@@ -1603,11 +1600,13 @@ endif

 ifdef NO_GETTEXT
        COMPAT_CFLAGS +=3D -DNO_GETTEXT
-endif
+else
+       LIB_OBJS +=3D gettext.o

 ifdef NEEDS_LIBINTL
        EXTLIBS +=3D -lintl
 endif
+endif

 ifdef GNU_GETTEXT
        MSGFMT +=3D --check

=2E..so we don't end up trying to link to -lintl.
