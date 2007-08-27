From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: repo.or.cz wishes?
Date: Mon, 27 Aug 2007 16:38:48 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708271635170.25853@woody.linux-foundation.org>
References: <20070826235944.GM1219@pasky.or.cz> <46D356F9.1010506@vilain.net>
 <alpine.LFD.0.999.0708271616520.25853@woody.linux-foundation.org>
 <200708280127.47808.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>, Martin Mares <mj@ucw.cz>,
	Petr Baudis <pasky@suse.cz>, skimo@liacs.nl,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 16:12:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPoBj-0004y0-G4
	for gcvg-git@gmane.org; Tue, 28 Aug 2007 01:40:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752642AbXH0XkE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 19:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753414AbXH0XkE
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 19:40:04 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:36810 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751690AbXH0XkC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Aug 2007 19:40:02 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7RNcnfM010657
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 27 Aug 2007 16:38:50 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7RNcm2C002031;
	Mon, 27 Aug 2007 16:38:48 -0700
In-Reply-To: <200708280127.47808.jnareb@gmail.com>
X-Spam-Status: No, hits=-2.75 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.29__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56897>



On Tue, 28 Aug 2007, Jakub Narebski wrote:
> 
> Not exactly. You can browse using http:// and file:// protocols,
> rsync:// is simply rsync, while ssh:// (or git_ssh://) can be limited
> using git-shell.

Bullshit. You carefully left out "git://", since that doesn't fit your 
"argument".

The fact is, all git URL's make sense for *git*, not necessarily for 
anything else. They may have incidental meanings outside of git, but 
certainly nothing that is really *sensible*.

And that is how it was designed to be. The URL's are for *git*, not for 
other uses. If you want to do cross-SCM tools, you need to let them know 
it's a "git" thing wheher it's browsable or not, so the argument that ssh 
is something "different" is bogus crapola.

Just face it, ssh is in no way different from any of the other git URL 
specifiers. 

			Linus
