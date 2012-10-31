From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: =?UTF-8?B?xazFrSBsZXR0ZXI=?=
Date: Wed, 31 Oct 2012 16:15:07 +0100
Message-ID: <5091407B.1080005@drmicha.warpmail.net>
References: <CAG+H+KTc9trmR9VBgGsdHfAUFW8VMwa218O3yM_nyNWtrySXyg@mail.gmail.com> <50913C58.2000200@drmicha.warpmail.net> <CAG+H+KT=TyJ2hwWRxYwfXut==1v+a0fpy_pZH1SCR4=VukPHbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?VXNpZXZhxYJhZCDEjG9ybnk=?= <eratyk@tut.by>
X-From: git-owner@vger.kernel.org Wed Oct 31 16:15:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTa0p-00048G-B7
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 16:15:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756715Ab2JaPPK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Oct 2012 11:15:10 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:55114 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753282Ab2JaPPJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Oct 2012 11:15:09 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id A65DC2077F;
	Wed, 31 Oct 2012 11:15:08 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Wed, 31 Oct 2012 11:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=ZG8o1SN76xhhO15b47uDhg
	CaL08=; b=AdvYC6+WvZkLIWU7BxVlXSEqonjuIQDp/q0ttalqnoGvSBsQ8V5Oor
	2ObAzt7G5mmsegVx3Btk3hgpxD5l6xjEdt61Px09MBDI6A33VsLhBxM+DI8K9nUc
	qdK+vaIvGPrW/Clai/r2bBjVTwmwL4LcDxQUMODaVrK5VqfkP0K5I=
X-Sasl-enc: EntJGjyiIDK/tgtwidsgkgI4v8JhwZH5kF64LXgSw4oh 1351696508
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 190814825DB;
	Wed, 31 Oct 2012 11:15:07 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
In-Reply-To: <CAG+H+KT=TyJ2hwWRxYwfXut==1v+a0fpy_pZH1SCR4=VukPHbQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208831>

Usieva=C5=82ad =C4=8Corny venit, vidit, dixit 31.10.2012 16:08:
> Ok. I use Win7 sp1, syslang =E2=80=94 be_BY, git version 1.8.0.msysgi=
t.0 (=E2=80=9Egit
> version=E2=80=9C command).
> Problem appears when I type this letter on keyboard; when I copy-past=
e
> it everyrhing is ok.

That is interesting. It means git-gui can make the commit properly, but
somehow the input method fails in the commit message form of the gui
window. Do those letters show correctly in the form (but fail to commit
correctly), or do they appear incorrectly already at the time you try t=
o
type them?

That info could help windows folks find the cause.

Michael

> On Wed, Oct 31, 2012 at 5:57 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Usieva=C5=82ad =C4=8Corny venit, vidit, dixit 31.10.2012 15:39:
>>> Hello!
>>>
>>> When I type comment message in Git Gui (1.8.0 and previous), I can'=
t
>>> use =C5=AC=C5=AD letter (U+016C, U+016D) =E2=80=94 it just transfor=
ms into simple Uu.
>>> Please fix it.
>>
>> Can you tell us more about your environment (LANG setting, OS)? I ju=
st
>> made two commits (1 with git-gui, one with git-commit on command lin=
e),
>> and both come out fine (LANG=3Dde_DE.UTF-8, git version 1.8.0.226.gb=
a44ac5
>> on Fedora 16):
>>
>> git log -2 -p
>> commit 36de49231639eb9edccb1ebad595056d395141c7
>> Author: Michael J Gruber <git@drmicha.warpmail.net>
>> Date:   Wed Oct 31 15:54:04 2012 +0100
>>
>>     =C3=A4=C3=B6=C3=BC=C3=9F=C5=AC=C5=AD
>>
>> diff --git a/a b/a
>> index 1074042..677c385 100644
>> --- a/a
>> +++ b/a
>> @@ -1 +1,2 @@
>>  =C3=A4=C3=B6=C3=BC=C3=9F=C5=AC=C5=AD
>> +=C3=A4=C3=B6=C3=BC=C3=9F=C5=AC=C5=AD
>>
>> commit cfcf8f021a53c1bf5ae018a723fbcfad8649a02b
>> Author: Michael J Gruber <git@drmicha.warpmail.net>
>> Date:   Wed Oct 31 15:52:52 2012 +0100
>>
>>     =C3=A4=C3=B6=C3=BC=C3=9F=C5=AC=C5=AD
>>
>> diff --git a/a b/a
>> new file mode 100644
>> index 0000000..1074042
>> --- /dev/null
>> +++ b/a
>> @@ -0,0 +1 @@
>> +=C3=A4=C3=B6=C3=BC=C3=9F=C5=AC=C5=AD
>=20
>=20
>=20
