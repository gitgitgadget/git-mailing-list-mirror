From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Tue, 09 Jan 2007 20:15:58 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701092014390.4964@xanadu.home>
References: <87odphgfzz.wl%cworth@cworth.org>
 <7vbql9ydd7.fsf@assigned-by-dhcp.cox.net>
 <20070108131735.GA2647@coredump.intra.peff.net>
 <7vzm8tt5kf.fsf@assigned-by-dhcp.cox.net>
 <20070109142130.GA10633@coredump.intra.peff.net>
 <7virffkick.fsf@assigned-by-dhcp.cox.net>
 <20070109213117.GB25012@fieldses.org> <87zm8ryiyz.wl%cworth@cworth.org>
 <20070109234421.GD30023@spearce.org> <eo1bqu$hji$1@sea.gmane.org>
 <20070110003433.GH30023@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 02:16:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4S4S-0004U0-VI
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 02:16:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932619AbXAJBQA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 20:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbXAJBQA
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 20:16:00 -0500
Received: from relais.videotron.ca ([24.201.245.36]:57143 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932619AbXAJBQA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 20:16:00 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JBM0034VOUNJJF0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 09 Jan 2007 20:15:59 -0500 (EST)
In-reply-to: <20070110003433.GH30023@spearce.org>
X-X-Sender: nico@xanadu.home
To: "Shawn O. Pearce" <spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36461>

On Tue, 9 Jan 2007, Shawn O. Pearce wrote:

> Jakub Narebski <jnareb@gmail.com> wrote:
> > Shawn O. Pearce wrote:
> > 
> > > In my mind that is a small price to pay for making sure the
> > > commit currently in a detached HEAD doesn't get orphaned off
> > > into never-never land.
> > 
> > By the way, would detached HEAD be reflogged, and if it would
> > (and certainly it would be nice to have, because protection or
> > not sh*t happens) how it would be implemented?
> 
> Ohhhhh.  It should reflog if .git/logs/HEAD exists, so long as
> changes to HEAD are done via update-ref and not just by echo (as
> one of Junio's versions of the feature had done).
> 
> Unfortunately .git/logs/HEAD wouldn't be created by default as its
> not under refs/heads or refs/remotes.  Though it could be made to be
> on by default, in which case it would only log changes while HEAD
> is detached.  If HEAD is attached to a branch then .git/logs/HEAD
> wouldn't be appended to (or even created), while the branch's own
> log is still appended to.

Is this worth the trouble and complexity?  After all detached heads are 
not meant to be used for serious development.


Nicolas
