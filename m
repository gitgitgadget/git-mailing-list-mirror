From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: On Tabs and Spaces
Date: Tue, 16 Oct 2007 12:20:50 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu>
 <471476B7.5050105@users.sourceforge.net> <8c5c35580710160204s5a4f9fb3j68c0a86c4d080cb7@mail.gmail.com>
 <47148F72.1090602@users.sourceforge.net> <1192548367.3821.4.camel@lt21223.campus.dmacc.edu>
 <B2F6DB0C-4EFE-4C56-8E7A-31820320CA02@mit.edu> <3awb7zw6.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Tue Oct 16 21:21:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihrz6-0000cB-EZ
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 21:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933553AbXJPTVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 15:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760155AbXJPTVd
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 15:21:33 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:60068 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933509AbXJPTVc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2007 15:21:32 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9GJKoWH021182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 16 Oct 2007 12:20:52 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9GJKo4m011595;
	Tue, 16 Oct 2007 12:20:50 -0700
In-Reply-To: <3awb7zw6.fsf@blue.sea.net>
X-Spam-Status: No, hits=-2.68 required=5 tests=AWL,BAYES_00,TW_MF
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61240>



On Tue, 16 Oct 2007, Jari Aalto wrote:

> * Tue 2007-10-16 Michael Witten <mfwitten AT MIT.EDU>
> >
> > However, 8 spaces per tab is a lot of wasted
> > information to be bandying about.
> 
> Spaces are guaranteed to interpreted correctly in all environments. TABs
> are the source of too many problems.

No.

Tabs are 8 spaces wide. Live with it. It's the only sane solution.

The fact is, people do mix the two. No ifs, buts or maybes about it. Even 
in the absense of any actual *spaces*, the size of a tab matters, since 
you can - and do - have two separately indented things (the initial 
indentation, and then things like comments being indented separately).

The only sane solution is the one the kernel and git have always used: 
tabs are 8 spaces wide, and anybody who disagrees can go screw themselves. 
If you don't have 8-character tabs, you *will* get odd indentation.

And no, the answer is not to say "don't use tabs at all" and replace them 
by spaces. The answer is *also* not "tabs are just for initial code 
indents", because not only will most sane editors never even show the 
difference, it's simply not how people work. So such a rule about 
invisible things doesn't work.

People who want to be contrary, and have a 2-character-wide tab only have 
themselves to blame. It's THEIR problem, not somethign that is even worth 
trying to address. 

If there are problems with people having small screens, that is damn well 
not about TAB, it's about code being way too deeply indented, and smaller 
indents are absolutely *not* the answer - they are part of the damn 
problem to begin with.

The fact that some projects have encouraged bad coding style and *insane* 
tab values is not a git problem. We should teach people to do *better*, 
not become worse just because others have done idiotic things.

				Linus
