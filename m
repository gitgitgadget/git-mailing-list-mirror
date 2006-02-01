From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [Census] So who uses git?
Date: Wed, 1 Feb 2006 17:57:47 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602011747380.25300@iabervon.org>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
 <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
 <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
 <1138446030.9919.112.camel@evo.keithp.com> <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
 <20060130185822.GA24487@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0601311750270.25300@iabervon.org> <7vek2oot7z.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0601311623240.7301@g5.osdl.org> <7v4q3jlgw2.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602011125370.5397@localhost.localdomain>
 <7vhd7ibza2.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0602011307250.21884@g5.osdl.org>
 <7v8xsu91vf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 23:57:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4Qsw-00054g-EP
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 23:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422998AbWBAWzb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 17:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422999AbWBAWzb
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 17:55:31 -0500
Received: from iabervon.org ([66.92.72.58]:21006 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1422998AbWBAWza (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2006 17:55:30 -0500
Received: (qmail 11606 invoked by uid 1000); 1 Feb 2006 17:57:48 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 1 Feb 2006 17:57:48 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xsu91vf.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15461>

On Wed, 1 Feb 2006, Junio C Hamano wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > If somebody doesn't know about the index, he normally will never have 
> > index changes _anyway_, except for the "git add" case. In which case "git 
> > commit" does the right thing for him: it will either commit the added 
> > files, or it will say "nothing to commit".
> 
> ... the original complaint was that "git commit" without
> explicit paths does not quack like "cvs/svn commit" -- commit
> all my changes in the working tree.

Actually, the original complaint was about "git commit path ...", I 
believe. That's the case where new users are finding that the behavior is 
surprising, rather than just unfamiliar.

	-Daniel
*This .sig left intentionally blank*
