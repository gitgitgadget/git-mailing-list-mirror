From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Census] So who uses git?
Date: Wed, 1 Feb 2006 14:35:33 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602011433290.21884@g5.osdl.org>
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
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 23:37:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4QZs-0007Ji-DI
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 23:35:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422975AbWBAWfu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 17:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422986AbWBAWfu
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 17:35:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6119 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422975AbWBAWft (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2006 17:35:49 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k11MZaDZ030096
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 1 Feb 2006 14:35:37 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k11MZX5u002628;
	Wed, 1 Feb 2006 14:35:33 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xsu91vf.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15457>



On Wed, 1 Feb 2006, Junio C Hamano wrote:
> 
> ... the original complaint was that "git commit" without
> explicit paths does not quack like "cvs/svn commit" -- commit
> all my changes in the working tree.

Agreed. However, I think that one is pretty easy to explain, and 
conceptually it's not a problem to just tell people to use the "-a" flag 
if they want to get CVS/SVN semantics.

After all, "git commit" will actually make it pretty obvious in the commit 
message status, _and_ if you haven't done any "git add" you'll get the 
"nothing to commit" thing, so it's not like this is hard to explain.

The real _confusion_ I think came from the filename usage.

		Linus
