From: timo@dspsrv.com
Subject: Re: master has some toys
Date: Fri, 18 Nov 2005 13:01:42 +0100
Message-ID: <20051118120016.GD1920@ELSAMSW37164>
References: <20051115144223.GA18111@diana.vm.bytemark.co.uk> <b0943d9e0511160311k725526d8v@mail.gmail.com> <7vr79g8mys.fsf@assigned-by-dhcp.cox.net> <7v7jb83w8m.fsf_-_@assigned-by-dhcp.cox.net> <81b0412b0511170029xac34cdbtddf74eb766281b3c@mail.gmail.com> <Pine.LNX.4.63.0511171207580.20898@wbgn013.biozentrum.uni-wuerzburg.de> <7vsltvwmlr.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0511171249550.737@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Nov 18 13:02:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ed4vq-0000R0-33
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 13:01:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161069AbVKRMBX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 07:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161073AbVKRMBX
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 07:01:23 -0500
Received: from vir.dspsrv.com ([193.120.211.34]:12955 "EHLO dspsrv.com")
	by vger.kernel.org with ESMTP id S1161069AbVKRMBX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2005 07:01:23 -0500
Received: from [145.36.48.101] (helo=localhost)
	by dspsrv.com with asmtp (Exim 3.36 #1)
	id 1Ed4vY-00072s-00
	for git@vger.kernel.org; Fri, 18 Nov 2005 12:01:12 +0000
To: git@vger.kernel.org
Mail-Followup-To: timo@dspsrv.com, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511171249550.737@wbgn013.biozentrum.uni-wuerzburg.de>
\From: Tim O'Callaghan <timo@dspsrv.com>
User-Agent: mutt-ng/devel-r570 (CYGWIN_NT-5.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12227>

On Thu, Nov 17, 2005 at 12:51:22PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 17 Nov 2005, Junio C Hamano wrote:
> 
> > It appears we'd better have something like this in the main
> > Makefile, so people do not have to do it themselves everywhere?
> 
> I'd like to wait to have a reaction from other people. I vividly remember 
> my eyes falling out of my sockets when somebody reported success on cygwin 
> without NO_MMAP. If there is *any* cygwin version which fixes it, we 
> should rather make people upgrade, no?
> 

It is not in the official Cygwin distribution yet. Though I've started the
formalities, moving house as been taking all my spare time. So, the upgrade
worries would be for those people tracking the main git repo. As they are
almost certainly on this list, they should be aware of possible breakage.

I've noted some breakage with git-archimport, git-svnimport and git-cvsimport,
though i have not yet looked into it, some are due to the lack of necessary
tools under Cygwin. I'm re-jigging my distro script to emulate the new package
split and plan to distribute just the git 'core' stuff for the moment.

I was wondering if anyone has scripts that i could use to test the
svn/arch/CVS import/export for expected behavior?

Tim.
"However beautiful the strategy, you should occasionally look at the results."
-- Winston Churchill
