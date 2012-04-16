From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] completion: add new git_complete helper
Date: Tue, 17 Apr 2012 02:04:00 +0300
Message-ID: <CAMP44s0cdSaiCoMLk7oTHE4dies5-G0C7-RczK5OFEK=pYUW_A@mail.gmail.com>
References: <20120415213718.GB5813@burratino>
	<CAMP44s0PWAV=nD1xnAFMx8OPby88W2jKwDGtiUFY4LA93D-gAw@mail.gmail.com>
	<7vaa2by8nj.fsf@alter.siamese.dyndns.org>
	<20120416160729.GM5813@burratino>
	<CAMP44s2_VYNFeBi9GPa9CeqT=oRmSq1J1XaSP+aKgC6bJ55Lfg@mail.gmail.com>
	<20120416200941.GD12613@burratino>
	<CAMP44s0CVsmHw4jQqHvZMi342V8-Yh2zYYcAE_5EHu5OAiktcw@mail.gmail.com>
	<20120416203320.GF12613@burratino>
	<7v7gxftn78.fsf@alter.siamese.dyndns.org>
	<CAMP44s1TkE=rd8AxbBnR4a8FwY+H9MHxYOhcks9fsnuK1iL_oA@mail.gmail.com>
	<20120416224411.GU12613@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 01:04:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJuxw-0002qF-0A
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 01:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755649Ab2DPXED convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 19:04:03 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42378 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755614Ab2DPXEB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2012 19:04:01 -0400
Received: by eaaq12 with SMTP id q12so1417461eaa.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 16:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=P7mWTzpfCEUZzGUgFNqwmg2iDj6RIdpLurMKG3dyn4U=;
        b=mPkeWX22U26S2Zi8D2WbOU4QkYg/WSLJviHXMq2FdniWwf0n3JlE2bWBz9Nb1YSD7d
         gEVv1sTkSAmEjQ9bfTDEY6JyB3Xs5eaPD4wuurSb7xYnJZ1f/8QN7mmNjVCE9XeVjqeM
         Q/B0fBtETIVNPjfitEJlac25PLHvUUw+OSzLfS2jbgJU2f+YienFfJr5qB1P5SsqVboC
         CEYXSq9GjMY0ps6kvcKJvOINRy3GSbR3uJYjlSscoy6qC5/PhMVqT1pBPVsLBoKaXzP3
         DQqXhM2I94AA53dtTEoy7Q/mUTAPBcFQ1rmT6iLQPOlucV0h+HO3Aii9S92sFpGmMRKd
         5WAA==
Received: by 10.14.187.4 with SMTP id x4mr1975010eem.14.1334617440324; Mon, 16
 Apr 2012 16:04:00 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Mon, 16 Apr 2012 16:04:00 -0700 (PDT)
In-Reply-To: <20120416224411.GU12613@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195720>

On Tue, Apr 17, 2012 at 1:44 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Felipe Contreras wrote:
>
>> Even more, I just added a foobar() function in my profile, and I als=
o
>> added a foobar() function in /etc/bash_completion.d/git. I don't see
>> my function replaced in any way, even after typing and completing
>> 'git' commands. I don't know how that's possible, but that's why I
>> don't like to take these types of claims as face value.
>
> What version of the bash_completion library do you use? =C2=A0Lazy-lo=
ading
> was introduced in version 1.90.

1.99

> If you put
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0foobar() {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo hi
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0. /etc/bash_completion
>
> then is your private foobar unclobbered?

Yes, in that case it does, but that's not the default behavior, at
least not in my system, and I doubt anybody would define their
functions before loading library scripts.

> To answer your demand before for a function in the public interface o=
f
> a completion script, not library, which respects or does not respect
> the bash-completion convention: see the public _rpm_installed_package=
s
> helper from the rpm completion script[1].

What makes you think this is public? It's under the section '# helper
functions', which doesn't seem to be public. Plus, it's repeated in
rpm, rpmbuild, and rpmbuild-md5.

The fact that somebody uses it doesn't mean it's public.

Cheers.

--=20
=46elipe Contreras
