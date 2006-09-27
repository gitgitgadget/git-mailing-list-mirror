From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: Notes on Using Git with Subprojects
Date: Wed, 27 Sep 2006 14:44:13 +0200
Message-ID: <20060927124413.GN1221MdfPADPa@greensroom.kotnet.org>
References: <45196628.9010107@gmail.com>
 <Pine.LNX.4.64.0609261629160.9789@iabervon.org>
 <20060926213003.GA8177@spearce.org> <4519AACD.7020508@gmail.com>
 <20060927080652.GA8056@admingilde.org>
 <Pine.LNX.4.63.0609271152270.14200@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060927113813.GC8056@admingilde.org>
 <Pine.LNX.4.63.0609271358100.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Martin Waitz <tali@admingilde.org>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 14:44:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSYmA-0007X5-1A
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 14:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWI0MoR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 08:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbWI0MoQ
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 08:44:16 -0400
Received: from smtp18.wxs.nl ([195.121.247.9]:65429 "EHLO smtp18.wxs.nl")
	by vger.kernel.org with ESMTP id S932382AbWI0MoP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Sep 2006 08:44:15 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp18.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with SMTP id <0J690029I4PPAK@smtp18.wxs.nl> for git@vger.kernel.org; Wed,
 27 Sep 2006 14:44:14 +0200 (CEST)
Received: (qmail 27511 invoked by uid 500); Wed, 27 Sep 2006 12:44:13 +0000
In-reply-to: <Pine.LNX.4.63.0609271358100.14200@wbgn013.biozentrum.uni-wuerzburg.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27902>

On Wed, Sep 27, 2006 at 02:01:11PM +0200, Johannes Schindelin wrote:
> On Wed, 27 Sep 2006, Martin Waitz wrote:
> > On Wed, Sep 27, 2006 at 11:55:22AM +0200, Johannes Schindelin wrote:
> > > Nevertheless, you have to take care of the fact that you need to commit 
> > > the state of the root project just after committing to any subproject.

So what happens if you pull some changes into a subproject?
Are you going to create a commit in the root project for each
intermediate commit that you pulled into your subproject?
If no, then why should you do so if you happen to do these change
in your local repo?

> AFAICT this is not the idea of subprojects-in-git.

As already pointed out by Daniel, there is no such thing as
"the idea of subprojects-in-git".  There are many ideas of
subprojects-in-git.

I, for one, would want to commit the changed state of a subproject
to the superproject explicitly.

> If you have to track 
> the subprojects in the root project manually anyway, you don't need _any_ 
> additional tool (you _can_ track files in a subdirectory containing a .git 
> subdirectory).

If I switch to a different branch or bisect in the superproject,
then the states of the subprojects should be changed accordingly.

skimo
