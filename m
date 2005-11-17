From: Yann Dirson <ydirson@altern.org>
Subject: Re: [Question] info/grafts file.
Date: Thu, 17 Nov 2005 22:45:57 +0100
Message-ID: <20051117214557.GA26122@nowhere.earth>
References: <20051114182019.GA19105@hpsvcnb.fc.hp.com> <7vhdafx81m.fsf@assigned-by-dhcp.cox.net> <20051115000349.GA32136@hpsvcnb.fc.hp.com> <437BD56A.7030402@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Baldwin <cnb@fc.hp.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 22:47:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcrYf-0000rF-Ou
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 22:44:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbVKQVoj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 16:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbVKQVoj
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 16:44:39 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:47563 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751354AbVKQVoi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2005 16:44:38 -0500
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 3C6A2979D;
	Thu, 17 Nov 2005 22:44:37 +0100 (CET)
Received: from dwitch by nan92-1-81-57-214-146 with local (Exim 4.54)
	id 1EcrZt-0006tX-Ve; Thu, 17 Nov 2005 22:45:58 +0100
To: Ryan Anderson <ryan@michonline.com>
Content-Disposition: inline
In-Reply-To: <437BD56A.7030402@michonline.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12155>

On Wed, Nov 16, 2005 at 07:57:14PM -0500, Ryan Anderson wrote:
> Carl Baldwin wrote:
> > This is fine, I just needed to know.
> > 
> > How hard is it to, in a generic way, take a grafts file and reconstruct
> > commits to include the parents in the graft file in the actual tree?  I
> > am wondering because I couldn't, after much work, get git-svnimport to
> > find my merges correctly.  So, I am needing to hand-graft some merges in
> > to make things right.  Any suggestions?  I could try to figure something
> > out if I can find some time.  I'm good with graph traversals and such.
> 
> It's actually pretty easy.  I wrote a rough (and not quite safe) tool to
> do this a week or so ago.
> 
> http://marc.theaimsgroup.com/?l=git&m=113131673606637&w=2
> 
> I will try and clean it up a bit and submit it for inclusion in contrib/
> sometime this coming weekend, but you should be able to use it to solve
> this problem.
> 
> It's pretty straightforward, honestly.  (And I'm pretty sure it could be
> faster if I did things slightly differently.)

Hey, this exactly looks like the kind of script I intended to write in
the following days !  I'll have a close look at it.  Do you have a git
repo from where I could pull the latest version ?

My goal is to write an "AcheoloGIT" toolkit, to be able to reconstruct
an history incrementally, from patches, identifying in the way patches
which build upon other patches.  To make it more clear, there are in
the embedded world a number of vendor shipping "jumbo patches", which
include parts or all of official arch-specific trees, with more stuff
added.

And well, since it is not an easy task, the process has to be
incremental, grafting here and there between various parts of the tree
to gradually refine my view of its history.

There is some preliminary work, but for now only focussed on making
the import of series of patches more comforable.  Grafting was
supposed to be the next step :)

http://ydirson.free.fr/soft/git/argit.git/

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
