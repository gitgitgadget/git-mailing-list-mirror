From: Martin Geisler <mg@lazybytes.net>
Subject: Re: potential improvement to 'git log' with a range
Date: Thu, 24 Jun 2010 00:04:08 +0200
Message-ID: <87hbkth0dj.fsf@hbox.dyndns.org>
References: <w2j3abd05a91004091624mb2836ff4v118a1ae9ac5ca6e7@mail.gmail.com>
	<201006232002.18921.jnareb@gmail.com> <877hlpimkq.fsf@hbox.dyndns.org>
	<201006232324.32516.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: mercurial list <mercurial-devel@selenic.com>,
	git list <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 00:04:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORY3O-00076Y-Np
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 00:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713Ab0FWWEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 18:04:13 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51092 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940Ab0FWWEM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 18:04:12 -0400
Received: by fxm10 with SMTP id 10so3471568fxm.19
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 15:04:10 -0700 (PDT)
Received: by 10.223.56.212 with SMTP id z20mr8341350fag.1.1277330650181;
        Wed, 23 Jun 2010 15:04:10 -0700 (PDT)
Received: from hbox.dyndns.org (77-58-145-114.dclient.hispeed.ch [77.58.145.114])
        by mx.google.com with ESMTPS id x3sm5133760fag.35.2010.06.23.15.04.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jun 2010 15:04:09 -0700 (PDT)
In-Reply-To: <201006232324.32516.jnareb@gmail.com> (Jakub Narebski's message
	of "Wed, 23 Jun 2010 23:24:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149552>

--=-=-=
Content-Transfer-Encoding: quoted-printable

Jakub Narebski <jnareb@gmail.com> writes:

Hi Jakub,

By the way: please let me know if you prefer that I keep these mails on
Mercurials mailinglist. I've just had a long chat about it with our own
moderator and he felt it was rude to cross-post like this. I, on the
other hand, value a polite cross-list discussion like this.

> On Wed, 23 Jun 2010, Martin Geisler wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>>> On Wed, 23 Jun 2010, Martin Geisler wrote:
>>>
>>>> This is fixed with Mercurial 1.6: we now have a query language where
>>>> 'X..Y' (or 'X::Y') is understood as the set of changesets that are
>>>> both descendents of X and ancestors of Y.
>>>
>>> Thanks. It looks like Mercurial's 'X::Y' is equivalent to Git's
>>> '--ancestry-path X..Y' (the --ancestry-path option is a new feature).
>>=20
>> Yeah, it is equivalent to --ancestry-path. I had no idea Git's range
>> operator worked the way it does :-)
>>=20
>> For mercurial-devel: 'X..Y' is a shorthand for '^X Y', which in turn
>> means ancestors of Y, excluding ancestors of X (and excluding X).
>
> Err... so how it is for X..Y / X::Y in Mercurial? "Ancestors of Y,
> excluding ancestors of X" is larger range (and default result for X..Y
> in Git) than "descendants of X and ancestors of Y" (i.e. the result of
> new --ancestry-path X..Y in Git).

I described Git's X..Y for people on mercurial-devel. Mercurial's X..Y
is like Git's --ancestry-path X..Y (except that Mercurial include both
endpoints whereas Git excludes X).

Mercurial's X..Y behave the way it does because it felt natural and
because I though Git's X..Y behaved that way.

> See http://repo.or.cz/w/git.git/blob/refs/heads/pu:/Documentation/rev-lis=
t-options.txt#l582

Yes, that was the document I read in order to see how Git's X..Y works.

>>>>> [1]
>>>>> http://stackoverflow.com/questions/1598759/git-and-mercurial-compare-=
and-contrast/1599930#1599930
>>>
>>> Fixed. Could you please take a look if it is correct, and if there
>>> are errors, either correct it yourself, or ask me to do it (either
>>> via comments for this question, or via email)? Thanks in advance.
>>=20
>> Yes, its correct now. But would you object if I or someone else took
>> out all those personal opinions and rewrote it from a neutral point
>> of view?
>
> Well, I do provide disclaimer upfront that I am biased towards Git,
> and I have tried to be objective.
>
> But I don't mind if someone who uses Mercurial fixed that side, and
> tried for neutral point of view (but not introducing the opposite
> bias). There would be problem with NPOV with issues without clear
> answer, where personal preference matters, though.

Great, then I may edit it a bit sometime...

=2D-=20
Martin Geisler

Mercurial links: http://mercurial.ch/

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkwihNgACgkQ/GWFsD4LxSMWfACfUC3fZ5qXCQC2OMTu38UQoPJu
AlwAnivpcJY1KBJmrRFyNLxT4P1jJb0B
=0TWu
-----END PGP SIGNATURE-----
--=-=-=--
