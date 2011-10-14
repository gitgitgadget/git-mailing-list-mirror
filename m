From: Victor Engmark <victor.engmark@terreactive.ch>
Subject: Re: [BUG] git checkout <branch> allowed with uncommitted changes
Date: Fri, 14 Oct 2011 09:16:38 +0200
Message-ID: <20111014071638.GB2856@victor.terreactive.ch>
References: <loom.20111013T094053-111@post.gmane.org>
 <CACsJy8Dzy5-kOZAjwdx=ooUdnN0L2F3EiNQ7b==3AGQZYjEUXQ@mail.gmail.com>
 <20111013145924.2113c142@ashu.dyn.rarus.ru>
 <loom.20111013T130924-792@post.gmane.org>
 <loom.20111013T141239-151@post.gmane.org>
 <20111013144450.GA2856@victor.terreactive.ch>
 <loom.20111013T175500-495@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: arQon <arqon@gmx.com>
X-From: git-owner@vger.kernel.org Fri Oct 14 09:16:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REc0j-0003DY-Bo
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 09:16:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755126Ab1JNHQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 03:16:48 -0400
Received: from gate.terreactive.ch ([212.90.202.121]:59351 "EHLO
	mail.terreactive.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326Ab1JNHQs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 03:16:48 -0400
Mail-Followup-To: arQon <arqon@gmx.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <loom.20111013T175500-495@post.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-terreActive-From: victor.engmark@terreactive.ch
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183545>

On Thu, Oct 13, 2011 at 04:17:51PM +0000, arQon wrote:
> Victor Engmark <victor.engmark <at> terreactive.ch> writes:
> > 1. `checkout master` and commit the fix there, then shift back and
> > continue working
> 
> I absolutely agree. And it's far more common than any of us would like.
> My point is, you *can't* do this in git without first staging your current branch
> via either commit or stash, or you risk changes bleeding between the branches
> and/or work being lost irretrievably.

It's been pointed out enough times already that work is *not* lost (at
least unless you --force it to) *nor* the branches corrupted, so I'll
just advice to look at more Git documentation. I used CVS 2004-2006 or
so, Subversion 2006-2009, and Git since then. It's vastly superior to
either, and it's really difficult to lose any work unless getting into
the habit of forcing every change.

> This is not something that you would
> expect, and as you say:
> 
> > The second most important thing a VCS should do is not destroy any of your
> uncommitted work unless you tell it to
> 
> ... which is exactly what git does, and why I have a problem with it.

No, it does not. Others have explained this better already.

> But the response here is uniformly "that's just how git is", so obviously it's
> something you learn to become aware of over time, and avoid. It's not going to
> get "fixed", because people who are used to git don't see it as a bug, so I just
> have to decide whether I can live with it or not.

It took a while to get my head around just how broken the Subversion
model was, and why my expectations from using that model kept resulting
in "weird" state (although don't get me started on `svn clean`). Don't
worry, you'll see the light :)

-- 
terreActive AG
Kasinostrasse 30
CH-5001 Aarau
Tel: +41 62 834 00 55
Fax: +41 62 823 93 56
www.terreactive.ch

Wir sichern Ihren Erfolg - seit 15 Jahren
