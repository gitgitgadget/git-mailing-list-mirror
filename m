From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Cloning from kernel.org, then switching to another repo
Date: Mon, 12 Nov 2007 12:31:02 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0711121229090.3062@woody.linux-foundation.org>
References: <9e4733910711120557w62a9966bvb61a02a2bf9b99e9@mail.gmail.com> <Pine.LNX.4.64.0711121412410.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 12 21:31:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrfwQ-0008DR-3N
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 21:31:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbXKLUbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 15:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbXKLUbO
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 15:31:14 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41540 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751405AbXKLUbO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Nov 2007 15:31:14 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lACKV3nC023548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 12 Nov 2007 12:31:06 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lACKV2US007641;
	Mon, 12 Nov 2007 12:31:02 -0800
In-Reply-To: <Pine.LNX.4.64.0711121412410.4362@racer.site>
X-Spam-Status: No, hits=-2.734 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64700>



On Mon, 12 Nov 2007, Johannes Schindelin wrote:
> 
> On Mon, 12 Nov 2007, Jon Smirl wrote:
> 
> > I'd like to do this sequence, but I can't figure out how without editing 
> > the config file. There doesn't seem to be a simple command to move the 
> > origin.
> > 
> > git clone linus
> > move origin to digispeaker.git
> 
> AKA "git config remote.origin.url <your-digispeaker-url-here>"

I really think people should at least also mention:

	"Or just edit your .git/config file by hand"

Quite frankly, the latter is *easier* to do. It's really hard to remember 
all the config entry names and then run "git config <entry> <value>". The 
command itself may be fairly simple, but rememberign the options is *not*.

In contrast, when you open up .git/config in your editor, it's all almost 
totally *obvious*.

So telling people to edit the config file is usually much more helpful in 
the long run. 

		Linus
