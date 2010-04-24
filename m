From: Petr Baudis <pasky@suse.cz>
Subject: Re: 'commit -a' safety (was: Re: Please default to 'commit -a'
 when no changes were added)
Date: Sat, 24 Apr 2010 19:47:13 +0200
Message-ID: <20100424174712.GN10939@machine.or.cz>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
 <20100422155806.GC4801@progeny.tock>
 <m3633hdw9u.fsf_-_@localhost.localdomain>
 <AC853FF9-6723-4824-BB2C-E7E8F79AA95E@wincent.com>
 <20100424164247.GM3563@machine.or.cz>
 <8B19818F-6578-420B-974D-28C9E3283FD4@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Goswin von Brederlow <goswin-v-b@web.de>,
	578764@bugs.debian.org, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sat Apr 24 19:47:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5jS4-0007g5-9H
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 19:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379Ab0DXRrS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Apr 2010 13:47:18 -0400
Received: from w241.dkm.cz ([62.24.88.241]:57762 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045Ab0DXRrR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 13:47:17 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 0E84286208E; Sat, 24 Apr 2010 19:47:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <8B19818F-6578-420B-974D-28C9E3283FD4@wincent.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145692>

On Sat, Apr 24, 2010 at 06:59:33PM +0200, Wincent Colaiuta wrote:
> El 24/04/2010, a las 18:42, Petr Baudis escribi=F3:
>=20
> > Have you ever done this mistake? If you have done some extensive in=
dex
> > editing, it is actually a major PITA to restore, and can be even
> > destructive if your index and working tree are too much out-of-sync
> > (this does happen to me not so seldom while I also use -a a lot for
> > trivial commits).
>=20
> Yes I have occasionally committed more than I meant to, but rarely mu=
ch more, and almost never due to using "git commit -a", seeing as I har=
dly ever use it. I am of the "commit early and often" school, and my mo=
st common pattern is committing tiny batches of changes which I review =
frequently with "git diff" and then again by staging them with "git add=
 --patch" (aliased as "git patch" seeing as I use it so often).

I also commit early and often, but I just do the review with "git diff"
and then commit right away, I guess I don't see much value to do anothe=
r
pass staging everything using "git add -p".

> >> IMO, the fact that the commit message editor is populated with a l=
ist of changed files that will be included in the commit is enough for =
people to see what's actually going to happen.
> >=20
> > BTW, I almost always use -m instead of the commit editor. ;-)
>=20
> Are you not a big fan of "subject line + justification" commit messag=
e format? Consider it one of the perks of using the format: your editor=
 will show you a nice summary that gives you yet another chance to doub=
le-check what you're about to commit.

I'm a huge fan of "subject line + justification", so I use multiple -m
parameters; frequently, for simple changes subject line is enough, in
most of the other cases the justification is a one-liner as well, and
only in the rest of the cases I defer to the editor.

--=20
				Petr "Pasky" Baudis
When I feel like exercising, I just lie down until the feeling
goes away.  -- xed_over
