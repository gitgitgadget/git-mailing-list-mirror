From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Census] So who uses git?
Date: Tue, 31 Jan 2006 09:30:48 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601310926330.7301@g5.osdl.org>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
 <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
 <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
 <1138446030.9919.112.camel@evo.keithp.com> <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
 <20060130185822.GA24487@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Carl Baldwin <cnb@fc.hp.com>, Junio C Hamano <junkio@cox.net>,
	Keith Packard <keithp@keithp.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 31 18:39:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3zRx-00005Y-20
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 18:37:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWAaRh3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 12:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWAaRh3
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 12:37:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29887 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751298AbWAaRh1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 12:37:27 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0VHUnDZ026316
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 31 Jan 2006 09:30:50 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0VHUmFj020660;
	Tue, 31 Jan 2006 09:30:48 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15326>



On Tue, 31 Jan 2006, Johannes Schindelin wrote:
> 
> On Mon, 30 Jan 2006, Carl Baldwin wrote:
> 
> > In general, I think it is grasping the reason for the index file and how 
> > git commands like git-commit and git-diff interact with it.
> 
> IMHO this is the one big showstopper. I had problems explaining the 
> concept myself.
> 
> For example, I had a hard time explaining to a friend why a git-add'ed 
> file is committed when saying "git commit some_other_file", but not 
> another (modified) file. Very unintuitive.

I really think you should explain it one of two ways:

 - ignore it. Never _ever_ use git-update-index directly, and don't tell 
   people about use individual filenames to git-commit. Maybe even add 
   "-a" by default to the git-commit flags as a special installation 
   addition.

 - talk about the index, and revel in it as a way to explain the staging 
   area. This is what the old tutorial.txt did before it got simplified.

The "ignore the index" approach is the simple one to explain. It's 
strictly less powerful, but hey, what else is new? 

		Linus
