From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Remote branchs -- how can I check them out?
Date: Sun, 30 Jan 2011 19:05:57 +0300
Message-ID: <20110130160556.GI5713@localhost.localdomain>
References: <AANLkTin3Tfcf=WJHJdSA9TwhFXQfaMrnm5+YEWWjo=qj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT Mailing List <git@vger.kernel.org>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Melo de Sampaio <jpmelos@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 30 17:06:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjZn2-0002kP-Aj
	for gcvg-git-2@lo.gmane.org; Sun, 30 Jan 2011 17:06:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942Ab1A3QGF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Jan 2011 11:06:05 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:45338 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780Ab1A3QGE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jan 2011 11:06:04 -0500
Received: from proxysrv.domain007.com ([10.8.0.42])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p0UG5weU029650;
	Sun, 30 Jan 2011 19:05:59 +0300
Received: by proxysrv.domain007.com (Postfix, from userid 1000)
	id D8CABB22EEF; Sun, 30 Jan 2011 19:05:57 +0300 (MSK)
Content-Disposition: inline
In-Reply-To: <AANLkTin3Tfcf=WJHJdSA9TwhFXQfaMrnm5+YEWWjo=qj@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: Dr.Web (R) for Mail Servers on proxysrv host
X-Antivirus-Code: 100000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165687>

On Sun, Jan 30, 2011 at 01:05:07PM -0200, Jo=E3o Paulo Melo de Sampaio =
wrote:

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
These branches are local to your repository. They are "remote" in the
sense you're not supposed to modify them directly.
So to inspect such a branch just use its full name ("origin/next" for
instance) when working with commands like git-log.

See [1], [2] for more info.

Also your question appears to be quite basic which hints at that you di=
d
not read a good book on Git before using it.  So starting at [3] is
recommended -- it mentions a bunch of good books and manuals (some of
which are available freely).

1. http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#exa=
mining-remote-branches
2. http://progit.org/book/ch3-5.html
3. http://git-scm.com/documentation
