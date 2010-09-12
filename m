From: "Tjernlund" <tjernlund@tjernlund.se>
Subject: RE: gitweb: please show tags file history browsing
Date: Sun, 12 Sep 2010 15:11:30 +0200
Message-ID: <001101cb527c$041a0eb0$0c4e2c10$@se>
References: <000001cb51be$ed214dd0$c763e970$@se> <m3r5h0kwn5.fsf@localhost.localdomain> <000d01cb525c$c6c2b8b0$54482a10$@se> <201009121219.58191.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Jakub Narebski'" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 12 15:12:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OumMJ-0006dF-Kv
	for gcvg-git-2@lo.gmane.org; Sun, 12 Sep 2010 15:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691Ab0ILNM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Sep 2010 09:12:26 -0400
Received: from csmtp2.one.com ([91.198.169.22]:56822 "EHLO csmtp2.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751827Ab0ILNMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Sep 2010 09:12:25 -0400
Received: from jockexp (84-217-13-162.tn.glocalnet.net [84.217.13.162])
	by csmtp2.one.com (Postfix) with ESMTPA id 9B584C00A3B3;
	Sun, 12 Sep 2010 13:11:39 +0000 (UTC)
In-Reply-To: <201009121219.58191.jnareb@gmail.com>
X-Mailer: Microsoft Office Outlook 12.0
thread-index: ActSZEgZ3avo3ApeSc+IEYTBhOAunQAFmvxw
Content-Language: sv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156033>

Jocke

> -----Original Message-----
> From: Jakub Narebski [mailto:jnareb@gmail.com]
> On Sun, 12 Sep 2010, Tjernlund wrote:
> > > -----Original Message-----
> > > From: Jakub Narebski [mailto:jnareb@gmail.com]
> > >
> > > "Tjernlund" <tjernlund@tjernlund.se> writes:
> > >
> > > > I would really like to see where the tags are when browsing
> > > > file or directory history in gitweb. Would that be possible?
> 
> > > While it probably be possible to show tags in 'history' view, it would
> > > be not easy.  The problem is that 'history' view shows only commits
> > > that touch specified file or directory, and tagged commits usually do
> > > not touch those files (at least if one is using "bump version number"
> > > commits to tag them).
> > >
> > > So you would have:
> > > 1. Design where to show those tags - they would be between shown
> > >    commits.
> > > 2. Create code which shows some/all tags that are between commits in
> > >    the presence of nonlinear history, without affecting performance
> > >    too badly.
> >
> > Ah, that is too bad because I think it would really useful.
> > Image browsing a drivers history in the linux kernel. Then it would be
> > really nice to see what changes/bug fixes went into what release.
> 
> First, you can help with the first issue even if you can't help with
> the coding itself.

I like the gitk way of showing tags, won't that work in gitweb too?

> 
> Second, with single 'git name-rev --tags --stdin' or with '--decorate'
> or '%d' in format we could (I think) either display at least some tags,
> or name-rev decorations, i.e. something like:
> 
>   (v1.7.3-rc0~38) gitweb: Don't die_error in git_tag after already printing headers
>   (v1.7.3-rc0~44) Merge branch 'maint'
>   (v1.7.2.3~15) Typos in code comments, an error message, documentation
>   (v1.7.3-rc0~85) Merge branch 'jn/maint-gitweb-dynconf'
>   (v1.7.3-rc0~92) Merge branch 'maint'
>   (v1.7.2.2~12) gitweb: clarify search results page when no matching commit found
>   [...]
> 
> If we want to display all tags we would have IIUC extend git-log to
> generate such information.

if displaying tags is a too expensive operation one could have a knob
in gitweb to get at the tags.
