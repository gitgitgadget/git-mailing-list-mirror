From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 08:58:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610200857250.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org> <45357411.20500@utoronto.ca>
 <200610180246.18758.jnareb@gmail.com> <45357CC3.4040507@utoronto.ca>
 <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <4536EC93.9050305@utoronto.ca>
 <87lkncev90.wl%cworth@cworth.org> <Pine.LNX.4.64.0610190757100.3962@g5.osdl.org>
 <20061019161319.GA75501@over-yonder.net> <Pine.LNX.4.64.0610190948540.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610191110290.3962@g5.osdl.org> <7vac3sru9a.fsf@assigned-by-dhcp.cox.net>
 <eha9no$5t7$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 17:59:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gawlp-0007tN-4p
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 17:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992591AbWJTP6u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 11:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992621AbWJTP6t
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 11:58:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61829 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992591AbWJTP6t (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 11:58:49 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9KFwiaX020950
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 20 Oct 2006 08:58:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9KFwhAv023550;
	Fri, 20 Oct 2006 08:58:44 -0700
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eha9no$5t7$1@sea.gmane.org>
X-Spam-Status: No, hits=-0.471 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29497>



On Fri, 20 Oct 2006, Jakub Narebski wrote:
> Junio C Hamano wrote:
> > 
> > An interesting effect on this is when people have a column for
> > merge performance in a SCM comparison table, they would include
> > time to run the diffstat as part of the time spent for merging
> > when they fill in the number for git, but not for any other SCM.
> 
> So if you want to compare merge performance with other SCM, you should
> either add time to run diffstat for other SCM, or substract time to
> run "git diff-tree --stat".

Naah. Just run "git pull -n". It's even documented:

	OPTIONS
	       -n, --no-summary
	              Do not show diffstat at the end of the merge.

so while the _default_ is to always show the diffstat, you certainly can 
easily do without it.

		Linus
