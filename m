From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Need help for migration from CVS to git in one go (ie,
	FORGETTING CVS history)
Date: Wed, 5 Nov 2008 15:44:25 -0800
Message-ID: <20081105234425.GA2932@spearce.org>
References: <200811060014.57046.fg@one2team.net> <20081105232348.GP15463@spearce.org> <200811060034.48053.fg@one2team.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Francis Galiegue <fg@one2team.net>
X-From: git-owner@vger.kernel.org Thu Nov 06 00:45:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kxs4C-0006r6-Qw
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 00:45:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbYKEXo1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Nov 2008 18:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752660AbYKEXo0
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 18:44:26 -0500
Received: from george.spearce.org ([209.20.77.23]:50492 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752657AbYKEXo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 18:44:26 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 5D8E938151; Wed,  5 Nov 2008 23:44:25 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200811060034.48053.fg@one2team.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100203>

=46rancis Galiegue <fg@one2team.net> wrote:
> Le Thursday 06 November 2008 00:23:48 Shawn O. Pearce, vous avez =E9c=
rit=A0:
> > Francis Galiegue <fg@one2team.net> wrote:
> > > Finally, about the Eclipse plugin:
>=20
> > > * if the plugin can push, can you configure from within the plugi=
n what
> > > branches can be pushed where, or should you edit .git/config by h=
and?
> >
> > I don't think you can edit saved configurations in the plugin UI.
>=20
> Not a big deal, I guess. This can be handled... (BTW, what about "git=
 clone"?=20
> Still not there, although _this_ can be dealt with also)

=46ile->Import... from Git.  That can clone a repository.  After it
finishes you'll have to use the import wizard again to actually
import existing .project files, or create new projects, etc.
=20
> > > * "git stash": is it supported?
> >
> > Not in Eclipse, no.
>=20
> What do you mean by this?

I mean there's no implementation of git stash.  Eclipse doesn't
support git stash, the notion of the stash, the branch the stash
is on.  Its not in the Eclipse plugin.
=20
> > > * can you "copy" a commit, or even a set of commits, and "cherry-=
pick"
> > > them into another branch? Or even rebase a branch onto antoher?
> >
> > Not in Eclipse, no.
>=20
> Same question... What exactly is the problem with Eclipse wrt this ki=
nd of=20
> operation?

Its also not implemented in the eclipse UI.

--=20
Shawn.
