From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
	summary continued
Date: Wed, 24 Oct 2007 18:38:15 -0400
Message-ID: <20071024223815.GN29830@fieldses.org>
References: <20071024192058.GF29830@fieldses.org> <471F9FD1.6080002@op5.se> <20071024194849.GH29830@fieldses.org> <86784BB7-076F-4504-BCE6-4580A7C68AAC@zib.de> <20071024203335.GJ29830@fieldses.org> <471FB3D0.4040800@op5.se> <20071024212854.GB6069@xp.machine.xx> <05B279A2-98A3-45F1-9661-AB361F7CAA37@zib.de> <Pine.LNX.4.64.0710242258201.25221@racer.site> <008A7EF9-6F58-47AE-9AA0-B466797F6B1D@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Peter Baumann <waste.manager@gmx.de>,
	Andreas Ericsson <ae@op5.se>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Oct 25 00:38:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ikorz-00019V-B9
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 00:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756812AbXJXWiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 18:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756647AbXJXWiW
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 18:38:22 -0400
Received: from mail.fieldses.org ([66.93.2.214]:40368 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756235AbXJXWiV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 18:38:21 -0400
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1Ikorf-0006dR-Qu; Wed, 24 Oct 2007 18:38:15 -0400
Content-Disposition: inline
In-Reply-To: <008A7EF9-6F58-47AE-9AA0-B466797F6B1D@zib.de>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62250>

On Thu, Oct 25, 2007 at 12:33:37AM +0200, Steffen Prohaska wrote:
> Maybe. I know git quite well now and in a shared workflow "git pull"
> with auto-fast-forward would help me. I often need to run "for each
> local branch: git checkout ; git merge" to get rid of the errors
> reported by "git push".

Hm.  There's gotta be more efficient ways to do that.  Maybe "git push .
origin/branch:branch" for each local "branch"?

But I'm still a little confused why you don't just want to "git push
name-of-branch" and avoid the whole problem.

--b.
