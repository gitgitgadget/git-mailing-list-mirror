From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH] Documentation: add a planning document for the next
	CLI revamp
Date: Thu, 30 Oct 2008 23:46:25 +0100
Message-ID: <20081030224625.GA4030@nan92-1-81-57-214-146.fbx.proxad.net>
References: <1225338485-11046-1-git-send-email-sam@vilain.net> <alpine.LFD.2.00.0810301024300.13034@xanadu.home> <20081030145253.GK14786@spearce.org> <20081030145928.GA21707@glandium.org> <20081030150135.GG24098@artemis.corp> <alpine.LFD.2.00.0810301105350.13034@xanadu.home> <1225387882.19891.9.camel@maia.lan> <alpine.LFD.2.00.0810301423520.13034@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>, Pierre Habouzit <madcoder@debian.org>,
	Mike Hommey <mh@glandium.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Oct 30 23:48:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvgJ4-0003pJ-Oy
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 23:47:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbYJ3Wqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 18:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753522AbYJ3Wqr
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 18:46:47 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:58512 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753022AbYJ3Wqq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 18:46:46 -0400
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 8F6BA19785;
	Thu, 30 Oct 2008 23:46:44 +0100 (CET)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 34D82196FA;
	Thu, 30 Oct 2008 23:46:38 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 474491F0C4; Thu, 30 Oct 2008 23:46:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0810301423520.13034@xanadu.home>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99530>

On Thu, Oct 30, 2008 at 02:28:35PM -0400, Nicolas Pitre wrote:
> > It's not about magic, it's about sensible defaults.  Currently this use
> > case is an error, and the resultant command is very long to type, and
> > involves typing the branch name twice.  I end up writing things like:
> > 
> >   git checkout -b {,origin/}wr34251-do-something
> > 
> > For the user who doesn't know to use the ksh-style {} blocks this is
> > voodoo.  The longer form is cumbersome.
> 
> This is no excuse for promoting semantics only useful in such special 
> cases.

It is really not so rare to have an upstream repo with branches such
as "stable", "next" and the like.  This syntax extension would make is
as straightforward to work on "stable" as it is on remote HEAD
(usually master, which has already been magically setup for you).


BTW this use case reminds me that the remote HEAD has its own special
treatment for "clone", which AFAIK cannot be overriden from
command-line (I still sometimes lack what cogito provided as "cg clone
URL#branch").


> As long as it checks it out with a detached head if it is a remote 
> branch then I have no issue.

Yes it is possible, but that does not necessarily make a UI
improvement worthless.

Best regards,
-- 
Yann
