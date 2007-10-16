From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: On Tabs and Spaces
Date: Tue, 16 Oct 2007 12:51:59 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710161247511.6887@woody.linux-foundation.org>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu>
 <471476B7.5050105@users.sourceforge.net> <8c5c35580710160204s5a4f9fb3j68c0a86c4d080cb7@mail.gmail.com>
 <47148F72.1090602@users.sourceforge.net> <1192548367.3821.4.camel@lt21223.campus.dmacc.edu>
 <B2F6DB0C-4EFE-4C56-8E7A-31820320CA02@mit.edu> <3awb7zw6.fsf@blue.sea.net>
 <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org>
 <20071016193605.GA829@glandium.org>
 <alpine.LFD.0.999.0710161240510.6887@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 21:52:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhsSz-0007Uc-0w
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 21:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934520AbXJPTwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 15:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932987AbXJPTwT
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 15:52:19 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:36781 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934520AbXJPTwS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2007 15:52:18 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9GJq0FY022960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 16 Oct 2007 12:52:01 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9GJpxUT012724;
	Tue, 16 Oct 2007 12:51:59 -0700
In-Reply-To: <alpine.LFD.0.999.0710161240510.6887@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.718 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61244>



On Tue, 16 Oct 2007, Linus Torvalds wrote:
> 
> But when it comes to computers, 8-character wide tab stops is the 
> de-facto standard. It's what every single terminal defaults to. It's the 
> only thing that some printers/terminals support. Anything else is by 
> definition non-standard.

Side note: one reason you *have* to use 8-character wide tab stops if you 
want to be sane is that while your editor may have alternate tab-stops, 
but when you look at the sources any other ways or on any other setup, the 
default is *always* going to be that 8-character wide tab-stop.

Do a "git cat-file -p :Makefile", and it will default to using "less". 
Have you added "-x2" to you LESS environment variable? Has everybody else? 
Not likely.

Or what happens when you just cat it straight, without any less at all? 

In short: using anything but 8-char wide tab-stops is INSANE, because it 
will inevitably showing the same source code in different ways depending 
on which editor or other environment you use.

In contrast, if you just accept that 8-wide tabs are a fact, you never see 
any of these issues. Everything "just works".

			Linus
