From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Remote branchs -- how can I check them out?
Date: Sun, 30 Jan 2011 08:35:19 -0800 (PST)
Message-ID: <m3lj229wpp.fsf@localhost.localdomain>
References: <AANLkTin3Tfcf=WJHJdSA9TwhFXQfaMrnm5+YEWWjo=qj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT Mailing List <git@vger.kernel.org>
To: =?iso-8859-15?q?Jo=E3o_Paulo_Melo_de_Sampaio?= <jpmelos@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 30 17:35:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjaFR-0007Jx-Jm
	for gcvg-git-2@lo.gmane.org; Sun, 30 Jan 2011 17:35:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942Ab1A3QfX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Jan 2011 11:35:23 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64610 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807Ab1A3QfW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jan 2011 11:35:22 -0500
Received: by wyb28 with SMTP id 28so4770346wyb.19
        for <git@vger.kernel.org>; Sun, 30 Jan 2011 08:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=4MKDdi0gppQx5+O0kakjbDeuyodMUB/aLeUaGfm6BpM=;
        b=Kh2RsGK2oL40kF7H8pOaC9OnNFnbuz6b+jKsmT1YOoazaTA+BvEKX1rcHnbsMq081c
         dAtiXZzSiAVecuuby1H+g+eYcStTjSWstMBqoO5j2Lsk1f4CLoe0fI5aEgmtk+/HUMqj
         o8KtaHDhsLfDQVkZie6B3xHN4JMrF8REKqmH4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=RR7P9yaU9BOoNK7vWNh7IRWxXOCkQwZ1JS9mzmbesxDwDNLY41o/Xoomi5eWXUzv/i
         BAp36cudv7ClGHKqhSoDzGs7R0WGbgvJN4ZgRBJBTDd4jZTI/ORIB7aiNPShCymClhqh
         xqjq3jpW74X4WZxW4UzN2U0Xq8hLlDrSPD46E=
Received: by 10.216.180.76 with SMTP id i54mr11060379wem.33.1296405320465;
        Sun, 30 Jan 2011 08:35:20 -0800 (PST)
Received: from localhost.localdomain (abvr78.neoplus.adsl.tpnet.pl [83.8.215.78])
        by mx.google.com with ESMTPS id n78sm10266073weq.3.2011.01.30.08.35.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 30 Jan 2011 08:35:19 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p0UGYqmu027575;
	Sun, 30 Jan 2011 17:35:03 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p0UGYgwg027568;
	Sun, 30 Jan 2011 17:34:42 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTin3Tfcf=WJHJdSA9TwhFXQfaMrnm5+YEWWjo=qj@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165688>

Jo=E3o Paulo Melo de Sampaio <jpmelos@gmail.com> writes:

> Hello, people.
>=20
> When I just cloned git using
>=20
>     git clone git://git.kernel.org/pub/scm/git/git.git
>=20
> and I type
>=20
>     git branch
>=20
> it shows me I have only the 'master' branch in my local repository
>=20
>     * master
>=20
> and when I type
>=20
>     git branch -a
>=20
> it shows that there's all these branches remotely
>=20
>     * master
>       remotes/origin/HEAD -> origin/master
>       remotes/origin/html
>       remotes/origin/maint
>       remotes/origin/man
>       remotes/origin/master
>       remotes/origin/next
>       remotes/origin/pu
>       remotes/origin/todo
>=20
> What do I have to do to be able to see what's in the 'maint', 'next'
> and 'todo' branches, for example?

Those are so called "remote-tracking branches", i.e. refs which follow
branches in some remote repository.  For example 'remotes/origin/master=
'
follows branch 'master' in remote 'origin'.  By follow I mean here that
on "git fetch" (also "git pull" and "git remote update") these=20
remote-tracking branches would get updated to their value at remote.
=20
Now if you only want to check wah's in given branch (beside using
"git show <branch>", "git ls-tree <branch>", "git show <branch>:<file>"=
)
you can use e.g.

  $ git checkout origin/next

to check out _state_ of remotr-tracking branch origin/next, landing
in so called "detached HEAD" state, or unnamed branch (no branch).


If you want to do some work based on given branch, you should create
new local branch based on remote-tracking one, e.g. via

  $ git checkout -b --track next origin/next

IIRC nowadays doiung simply

  $ git checkout -t next

should DWIM to do the same.

> And by the way, what are those branches all about? Their names
> suggests they are maintenance branches (where you keep backward
> compatibility with an older version?), the next version of git (1.7.4
> version?) and future features under implementation (the to-do list?).

It is described in "Notes from maintainer" which you can find in git
mailing list archives, in 'todo' branch of git repository, and on Git
Wiki.


* 'master' - stable development, new major version is cut from it
* 'next' - development branch, not everything that makes it here
           would be in next version.  Rewound on new major version.
* 'maint' - maintenance branch for last version, minor revisions are
            cut from this; only bugfixes, no new development
* 'pu' - proposed updates, merge of interesting topic branches,
         very unstable, used to review proposed features

* 'todo' - not wery well maintained TODO list, som scripts used e.g.
           to send "What's cooking..." emails to git mailing list
* 'html', 'man' - compiled documentation

todo, html and man are detached branches.

HTH
--=20
Jakub Narebski
Poland
ShadeHawk on #git
