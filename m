From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git svn : hook before 'git svn dcommit'
Date: Sat, 02 Jul 2011 23:59:11 +0200
Message-ID: <vpqfwmos5sg.fsf@bauges.imag.fr>
References: <4E0F1383.8080804@gmail.com> <vpqboxcu6td.fsf@bauges.imag.fr>
	<4E0F5485.9010201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Heitzmann 
	<frederic.heitzmann@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 02 23:59:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qd8Dh-0007r8-85
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jul 2011 23:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755799Ab1GBV7Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Jul 2011 17:59:16 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33122 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754879Ab1GBV7P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2011 17:59:15 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p62Lx8bN024741
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 2 Jul 2011 23:59:08 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Qd8DX-0004H5-Cn; Sat, 02 Jul 2011 23:59:11 +0200
In-Reply-To: <4E0F5485.9010201@gmail.com> (=?iso-8859-1?Q?=22Fr=E9d=E9ric?=
 Heitzmann"'s message of
	"Sat, 02 Jul 2011 19:25:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 02 Jul 2011 23:59:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p62Lx8bN024741
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1310248749.53235@8Ip9gmmB4spEGCe705bhKQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176572>

=46r=E9d=E9ric Heitzmann <frederic.heitzmann@gmail.com> writes:

> Le 02/07/2011 15:54, Matthieu Moy a =E9crit :
>> Fr=E9d=E9ric Heitzmann<frederic.heitzmann@gmail.com>  writes:
>>
>>> The 'pre-svn-dcommit' hook si called before 'git svn dcommit', whic=
h aborts
>>> if return value is not zero.
>>> ---
>>>   git-svn.perl |   19 +++++++++++++++++++
>> What about documentation?
> Should documentation be part of githooks or git-svn man page ?
> I vote for the latest, in order to avoid

I'd also put it in the git-svn page, since git-svn is somehow not reall=
y
part of Git.

> +prevent some diff to be committed to a SVN repository.

I'd say "an SVN", not "a SVN", but the documentation already use both
forms.

>>> +       if ($? =3D=3D -1) {
>>> +               print "[pre_svn_dcommit_hook] failed to execute $ho=
ok:
>>> $!\n";
>> whitespace damage (extra newline)
>>
>
>As for the 'whitespace damage", I do not understand what you mean.
>The \n look mandatory to me.
>You may look at 'info perlfunc' for the original code snippet (see
>system' function).

I'm not talking about the \n, but the fact that what used to be a singl=
e
line of code is broken in two parts in your message.

A patch hunk has lines starting with " ", "+" or "-", yours have a line
starting with $. It won't apply with "patch" or "git apply", hence extr=
a
work for our maintainer.

Try using "git send-email" to avoid that.

And actually, read Documentation/SubmittingPatches, in particular the
part about Signed-off-by.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
