From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 1/4] completion: be nicer with zsh
Date: Thu, 2 Feb 2012 12:12:35 +0200
Message-ID: <CAMP44s0w1eXWWaMT3WAfLxFHPQvc9dp33cyJ=T2im6g7rsrKhw@mail.gmail.com>
References: <1328145320-14071-1-git-send-email-felipe.contreras@gmail.com>
	<20120202084859.GC3823@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 11:12:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rstel-0001pB-HW
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 11:12:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755276Ab2BBKMi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Feb 2012 05:12:38 -0500
Received: from mail-lpp01m020-f174.google.com ([209.85.217.174]:52328 "EHLO
	mail-lpp01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754095Ab2BBKMh convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 05:12:37 -0500
Received: by lbom4 with SMTP id m4so328403lbo.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 02:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=uPpxmw+0+YXXAOD2fAJU+Ffr50QSfPKOwLbr9Tl+Km4=;
        b=m1hjSxqERZ3KwA4vDFvTBtKLmutK/QC6J3h0rLpkFt1dvF14hCTQY9TP2oLkpU5WWY
         bHl0hJ4ADU1+qSVsFukQsJwD3VYI4BJueKCY52fRLchhwOXIgb0CyR7aIJaDiNpwpGqt
         OBDlo10y+siO20kH9Xdof0Gc6TyC+nd3IeZ2k=
Received: by 10.112.101.134 with SMTP id fg6mr573799lbb.63.1328177555711; Thu,
 02 Feb 2012 02:12:35 -0800 (PST)
Received: by 10.112.40.202 with HTTP; Thu, 2 Feb 2012 02:12:35 -0800 (PST)
In-Reply-To: <20120202084859.GC3823@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189614>

On Thu, Feb 2, 2012 at 10:48 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Felipe Contreras wrote:
>
>> Felipe Contreras (4):
>> =C2=A0 completion: be nicer with zsh
>
> Since I can't find this patch in the mail archive, I'll reply here.
> Luckily the most important bit is above already.
>
> I think I mentioned before that this subject line is what will appear
> in the shortlog and the shortlog is all that some people will see of
> the changelog, so it should include a self-contained description of
> the impact of the patch.

Exactly, and "completion: avoid default value assignment on : true
command" tells *nothing* to most people. Why is this patch needed? Do
I care about it?

OTOH "completion: be nicer with zsh" explains the purpose of the patch
and people that don't care about zsh can happily ignore it if they
want, and the ones that care about zsh might want to back port it, or
whatever.

Also, if you are looking at a shortlog and looking for patches related
to zsh, you would easily see this.

"completion: avoid default value assignment on : true command" almost
ensures that the people reading that summary would need to read
further to see *why*.

> -- >8 --
> From: Felipe Contreras <felipe.contreras@gmail.com>
> Date: Thu, 2 Feb 2012 03:15:17 +0200
> Subject: completion: avoid default value assignment on : true command

No useful information provided yet. Should I care about this? I guess
I need to open the mail and see.

> zsh versions from 4.3.0 to present (4.3.15) do not correctly propagat=
e
> the SH_WORD_SPLIT option into the subshell in ${foo:=3D$(bar)}
> expressions. =C2=A0For example, after running

Ok, a bug in zsh, I can skip this. Or if I care about zsh, then I
still have to read further, because I still don't know what's the
problem.

And BTW, this is extremely detailed. Where's the evidence? Is there a
bug report? How can I follow this to find out when it's fixed. (hint:
missing link)

> =C2=A0 =C2=A0 =C2=A0 =C2=A0emulate sh
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fn () {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0var=3D'one two=
'
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf '%s\n' =
$var
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0x=3D$(fn)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0: ${y=3D$(fn)}
>
> printing "$x" results in two lines as expected, but printing "$y"
> results in a single line because $var is expanded as a single word
> when evaluating fn to compute y.

Ok, still reading.

> So avoid the construct, and use an explicit 'test -n "$foo" ||
> foo=3D$(bar)' instead.

Yeah...

> This fixes a bug tht caused all commands to be
> treated as porcelain and show up in "git <TAB><TAB>" completion,
> because the list of all commands was treated as a single word in
> __git_list_porcelain_commands and did not match any of the patterns
> that would usually cause plumbing to be excluded.

Aha! Finally we arrive to the important part.

I guess we have different styles of writing. Personally, I don't see
the point of forcing the readers to go through the whole thing.
Compare this to mine:

| Subject: [PATCH v3 1/4] completion: be nicer with zsh

At this point most people can skip this.

| And yet another bug in zsh[1] causes a mismatch; zsh seems to have
| problem emulating wordspliting, but only on the command substitution.
|
| Let's avoid it.

A bug in zsh in certain situations... got it.

| I found this issue because __git_compute_porcelain_commands listed al=
l
| commands (not only porcelain).

At this point it might have been better to mention "git <TAB><TAB>"
instead, as you did. But not a big deal, the problem is clear; all
commands are listed.

Almost all people would stop at this point; either they don't care
about zsh, or they care, and they want the patch.

| This is because in zsh the following code:
|
|  for i in $__git_all_commands
|
| would evaluate $__git_all_commands as a single word (with spaces),
| ${=3D__git_all_commands} should be used to do word splitting expansio=
n
| (unless SH_WORD_SPLIT is used).
|
| sh emulation should take care of that, but the command expantion is
| messing up with that.

And more details for the skeptics, or the ones that want to learn more.

| tl;dr: $__git_porcelain_commands =3D $__git_all_commands

Wrapping it up, to make clear what happens.

| [1] http://article.gmane.org/gmane.comp.shells.zsh.devel/24296

And then a link to further details, discussion, and possible fixes.

Cheers.

--=20
=46elipe Contreras
