From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/3] completion: remove unused code
Date: Mon, 30 Jan 2012 05:30:49 +0200
Message-ID: <CAMP44s1bZeednbHfqXANZR5zVVvGwjRpuV5TFmnh212FD7E-Vg@mail.gmail.com>
References: <1327880479-25275-1-git-send-email-felipe.contreras@gmail.com>
	<1327880479-25275-4-git-send-email-felipe.contreras@gmail.com>
	<20120130025014.GA15944@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 04:30:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrhxH-0008Qb-RN
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 04:30:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754051Ab2A3Dav convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Jan 2012 22:30:51 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:52235 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753062Ab2A3Dav convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2012 22:30:51 -0500
Received: by lagu2 with SMTP id u2so1953240lag.19
        for <git@vger.kernel.org>; Sun, 29 Jan 2012 19:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=L0tSSZe8rxuFUMjVmRuPQ61DEDDSgvB44VTVINVSSMo=;
        b=rw/n/iYK6rzwTa+55P14LxWcIWzMWsIeid6gpMybLG/xko02gOfTjfKgMajPUJb/gI
         4/iK4H1vgLCInxQdFDHs5nv8pLhxPg7qTV12kNJW8NaPgQf9D4kn2HfcHCAzcxdATiQ0
         eskqi1iI6eOpbJ7IrMh29AdfZLekLA16zh2W8=
Received: by 10.112.48.65 with SMTP id j1mr4023627lbn.76.1327894249578; Sun,
 29 Jan 2012 19:30:49 -0800 (PST)
Received: by 10.112.10.169 with HTTP; Sun, 29 Jan 2012 19:30:49 -0800 (PST)
In-Reply-To: <20120130025014.GA15944@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189319>

On Mon, Jan 30, 2012 at 4:50 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Felipe Contreras wrote:
>
>> No need for thus rather complicated piece of code :)
> [...]
>> =C2=A0contrib/completion/git-completion.bash | =C2=A0 30 -----------=
-------------------
>> =C2=A01 files changed, 0 insertions(+), 30 deletions(-)
> [...]
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -2730,33 +2730,3 @@ if [ Cygwin =3D "$(uname -o 2>/dev/null)" ]; =
then
> [...]
>> -if [[ -n ${ZSH_VERSION-} ]]; then
>> - =C2=A0 =C2=A0 __git_shopt () {
> [...]
>> -else
>> - =C2=A0 =C2=A0 __git_shopt () {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 shopt "$@"
>> - =C2=A0 =C2=A0 }
>> -fi
>
> What codebase does this apply to? =C2=A0My copy of git-completion.bas=
h
> contains a number of calls to __git_shopt, which will fail after this
> change.

The latest and greatest of course:

http://git.kernel.org/?p=3Dgit/git.git;a=3Dblob;f=3Dcontrib/completion/=
git-completion.bash

It's only used in __git_remotes.

> By the way, is there any reason you did not cc this series to G=C3=A1=
bor or
> others who also know the completion code well? =C2=A0The patches are =
not
> marked with RFC/ so I assume they are intended for direct application=
,
> which seems somewhat odd to me.

No reason. I hope they read the mailing list, otherwise I'll resend
and CC them. A get_maintainers script, or something like that would
make things easier.

Cheers.

--=20
=46elipe Contreras
