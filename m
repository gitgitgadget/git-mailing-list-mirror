From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: More Beginning Git Questions
Date: Mon, 26 Sep 2011 04:34:47 +0400
Message-ID: <20110926003447.GG10955@localhost.localdomain>
References: <4E7CCCA0.50909@gmail.com>
 <14gm3o851q0ad.1uoossmxgfyit.dlg@40tude.net>
 <op.v2byz2p80aolir@keputer.lokaal>
 <1m2c90ds9e46c.7agk88pbgjl8$.dlg@40tude.net>
 <201109242259.p8OMxqIM026259@no.baka.org>
 <1wllqv48uqfjq.lt9yp4rbxugb.dlg@40tude.net>
 <m31uv4rc47.fsf@localhost.localdomain>
 <1rwoliveqwr1v.u3bsx5axtgsb$.dlg@40tude.net>
 <m3oby8pcfz.fsf@localhost.localdomain>
 <1ttmqsxtaj98i$.hv6s5shjeugr.dlg@40tude.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: tactical <a5158017@nepwk.com>
X-From: git-owner@vger.kernel.org Mon Sep 26 02:35:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7zA8-0000ap-QB
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 02:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753282Ab1IZAe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Sep 2011 20:34:57 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:33359 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263Ab1IZAe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2011 20:34:56 -0400
Received: from proxysrv.domain007.com ([10.8.0.42])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p8Q0YnFd026064;
	Mon, 26 Sep 2011 04:34:50 +0400
Received: by proxysrv.domain007.com (Postfix, from userid 1000)
	id BFC9DB2318C; Mon, 26 Sep 2011 04:34:48 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <1ttmqsxtaj98i$.hv6s5shjeugr.dlg@40tude.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: Dr.Web (R) for Mail Servers on proxysrv host
X-Antivirus-Code: 100000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182085>

On Sun, Sep 25, 2011 at 10:07:24PM +0100, tactical wrote:

[...]
> > I think you can use detached HEAD for that, at least when working on
> > one issue at a time (you have to name branch when switching to some
> > other work).
> 
> But in Mercurial I can switch between anonymous branches as much as I like
> without anything ever being deleted.
> 
> >> From what I read, detached heads are subject to garbage collection.
> >  
> > No, HEAD is protected against garbage collecting.  To be sure you
> > should name a branch when switching branches, though reflog would
> > protect you for 30 days (by default) even if you don't do that.
> 
> So Git doesn't really support anonymous branching as part of a normal
> workflow.

I perceive a certain logical fallacy here: you cannot switch between
anything anonymous because to switch, you should somehow identify
something to switch to--a name in whatever sense we put into this word.
As I understand, by switching between branches in Mercurial you mean
switching between directories with clones; if so, you had had to name
those directories when they were created.

As to branches, they do have names in Git but they are very loosely
coupled with their names: tag a tip of some branch (to still have a
handle on that tip commit) then delete that branch--there will be no
traces of that branch's name left, the branch's name is not encoded in
its history in any way.  The branch names is just a way to not mess with
SHA-1 names of commits (and to have references to those commits to keep
them out of consideration for garbage collection).
Hence the idea to demand support for anonymous branches in Git's model
is just unfounded.
