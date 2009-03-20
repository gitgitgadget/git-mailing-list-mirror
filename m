From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Document and test the new % shotcut for the tracked
 branch
Date: Fri, 20 Mar 2009 11:31:31 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903201128380.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0903201027450.10279@pacific.mpi-cbg.de> <1237543471-27248-1-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Petr Baudis <pasky@suse.cz>,
	Andreas Gruenbacher <agruen@suse.de>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 20 11:32:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lkc1B-0001rz-GB
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 11:32:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762801AbZCTK3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 06:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762803AbZCTK3h
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 06:29:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:59949 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762767AbZCTK3g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 06:29:36 -0400
Received: (qmail invoked by alias); 20 Mar 2009 10:29:33 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp063) with SMTP; 20 Mar 2009 11:29:33 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/UmoI2EO3Uii2JkkNxqsGsmWsDt9AuzSTgethTP5
	EoLslO5Z0onGid
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1237543471-27248-1-git-send-email-git@drmicha.warpmail.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113935>

Hi,

On Fri, 20 Mar 2009, Michael J Gruber wrote:

> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---

That is brutal.  First shot, then cut.

> Johannes Schindelin venit, vidit, dixit 20.03.2009 10:29:
> > 
> > Often, it is quite interesting to inspect the branch tracked by a 
> > given branch.  This patch introduces a nice notation to get at the 
> > tracked branch: 'BEL<branch>' can be used to access that tracked 
> > branch.
> > 
> > A special shortcut 'BEL' refers to the branch tracked by the current 
> > branch.
> > 
> > Suggested by Pasky and Shawn.
> > 
> > This patch extends the function introduced to handle the nth-last 
> > branch (via the {-<n>} notation); therefore that function name was 
> > renamed to something more general.
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> I guess you beat me to it then, which is fine.

I had it ready yesterday!  But the real problem is not addressed by your 
patch, either: '%<branch>' is a legal branch name.

I briefly considered <branch>^{tracked}, but

- the ^{} codepath does not try to substitute branch _names_, so we'd have 
  to duplicate that ^{} detection, and,

- it is really cumbersome to write.

> But haven't you seen my note about the failing test either? The code 
> below tests with branches which track local branches. merge and remote 
> is set for the branch in question ("tracking"), it's just that remote is 
> ".". It seems that the remote.c code does not set up merge info for 
> these branches.

I have seen it, it's just not my itch, and I am busy enough as it is.

> <Goes to figure out how to enter BEL...>

Ctrl-v Ctrl-g

Ciao,
Dscho
