From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git Cygwin - unable to create any repository - help!
Date: Thu, 17 Jan 2008 12:24:27 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801171218470.14959@woody.linux-foundation.org>
References: <20080114202932.GA25130@steel.home>  <20080116071832.GA2896@steel.home>  <a5eb9c330801160742j645ee50p72ee0a93adf8f94f@mail.gmail.com>  <20080116183124.GA3181@steel.home>  <a5eb9c330801161048x4b5a88dcsebd7cf9754f72ba6@mail.gmail.com> 
 <20080116191737.GD3181@steel.home>  <a5eb9c330801161344i1da447c7sb447bf6274d408e8@mail.gmail.com>  <20080116234527.GA3499@steel.home>  <a5eb9c330801171037v333becc2lbc5873383d07a358@mail.gmail.com>  <alpine.LFD.1.00.0801171046040.14959@woody.linux-foundation.org>
 <a5eb9c330801171213l2c06c4e4s718324f5b66f0db6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Paul Umbers <paul.umbers@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 21:25:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFbIj-0002fW-GZ
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 21:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281AbYAQUYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 15:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753295AbYAQUYk
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 15:24:40 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43724 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751905AbYAQUYj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jan 2008 15:24:39 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0HKOSkR026085
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 17 Jan 2008 12:24:29 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0HKORVm011238;
	Thu, 17 Jan 2008 12:24:27 -0800
In-Reply-To: <a5eb9c330801171213l2c06c4e4s718324f5b66f0db6@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.715 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70917>



On Thu, 17 Jan 2008, Paul Umbers wrote:
>
> Quite possibly. We have Embassy Trust Suite and Symantec Endpoint
> Security installed

That's it.

Do a google for 

	Embassy Trust Suite cygwin

and revel in all the reports of problems with cygwin with that thing 
installed.

See for example Dave Korn at:

	http://www.cygwin.com/ml/cygwin/2007-05/msg00132.html

or this on:

	http://www.cygwin.com/ml/cygwin-talk/2007-q1/msg00270.html
	http://sourceware.org/ml/cygwin/2006-05/msg00856.html

so I'm pretty sure that's it.

Ahh, the joys of Windows.

Btw, did you ever test the msys version of git

	http://code.google.com/p/msysgit/

since I suspect that it's likely to not just be faster, but also more 
robust, since there is a much thinner layer between git and windows (and 
thus hopefully many fewer complex dependencies that can go wrong).

			Linus
		
