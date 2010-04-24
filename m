From: Petr Baudis <pasky@suse.cz>
Subject: Re: 'commit -a' safety (was: Re: Please default to 'commit -a'
 when no changes were added)
Date: Sat, 24 Apr 2010 18:42:47 +0200
Message-ID: <20100424164247.GM3563@machine.or.cz>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
 <20100422155806.GC4801@progeny.tock>
 <m3633hdw9u.fsf_-_@localhost.localdomain>
 <AC853FF9-6723-4824-BB2C-E7E8F79AA95E@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Goswin von Brederlow <goswin-v-b@web.de>,
	578764@bugs.debian.org, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sat Apr 24 18:43:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5iRl-0003FN-5D
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 18:43:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704Ab0DXQmx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Apr 2010 12:42:53 -0400
Received: from w241.dkm.cz ([62.24.88.241]:59861 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751406Ab0DXQmw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 12:42:52 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 8D3A686208E; Sat, 24 Apr 2010 18:42:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AC853FF9-6723-4824-BB2C-E7E8F79AA95E@wincent.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145687>

On Sat, Apr 24, 2010 at 01:10:24PM +0200, Wincent Colaiuta wrote:
> El 24/04/2010, a las 11:40, Jakub Narebski escribi=F3:
> > I'd like for 'git commit -a' to *fail* if there are staged changes =
for
> > tracked files, excluding added, removed and renamed files.

Thanks for this suggestion, this is exactly what I wanted to propose!
+1 here.

I think this could even be made a default in some time, I don't see any
useful workflows this could prevent and adding -f is trivial enough for
those who really want to go forward.

> For me this is going to far. While we don't want to make it _easy_ fo=
r users to shoot themselves in the foot, neither do we want to make it =
difficult or impossible for them to get the tool to do things that _mig=
ht_ be a mistake. And what's the risk here? Accidentally committing too=
 much is not a destructive change, and can be easily undone.

Have you ever done this mistake? If you have done some extensive index
editing, it is actually a major PITA to restore, and can be even
destructive if your index and working tree are too much out-of-sync
(this does happen to me not so seldom while I also use -a a lot for
trivial commits).

> IMO, the fact that the commit message editor is populated with a list=
 of changed files that will be included in the commit is enough for peo=
ple to see what's actually going to happen.

BTW, I almost always use -m instead of the commit editor. ;-)

--=20
				Petr "Pasky" Baudis
When I feel like exercising, I just lie down until the feeling
goes away.  -- xed_over
