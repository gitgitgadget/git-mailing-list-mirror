From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: for newbs = little exercise / tutorial / warmup for windows and
 other non-sophisticated new Git users :-)
Date: Tue, 30 Dec 2008 14:42:40 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0812301348440.19665@iabervon.org>
References: <gj68a0$u56$3@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Zorba <cr@altmore.co.uk>
X-From: git-owner@vger.kernel.org Tue Dec 30 20:44:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHkW1-0005P1-ML
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 20:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752381AbYL3Tmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 14:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752612AbYL3Tmn
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 14:42:43 -0500
Received: from iabervon.org ([66.92.72.58]:40871 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753471AbYL3Tmm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 14:42:42 -0500
Received: (qmail 10277 invoked by uid 1000); 30 Dec 2008 19:42:40 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Dec 2008 19:42:40 -0000
In-Reply-To: <gj68a0$u56$3@ger.gmane.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104198>

On Sat, 27 Dec 2008, Zorba wrote:

> Here is a little exercise / tutorial / warm-up for someone starting out with 
> Git. If you're anyting like me you may find the tutorials etc. on git.or.cz 
> a bit daunting. I recommend you try this after reading the user manual but 
> before tearing your hair out trying to follow all the examples in the user 
> manual. After you've followed this simple workflow, then go back to the more 
> advanced stuff  in the tutorials and user manuals (like cloning repositories 
> and creating and merging branches).
>
> I created this exercise to try and model our workflow and what we wanted to 
> use git for = tracking a project with multiple files where the filebase 
> might change frequently from one version to the next.

One thing I find unrealistic about this example is that you've got BC.txt 
and C.txt when you're creating version A, and you've even copied them to 
the working directory. In real life, you'd almost certainly not create the 
files until you're preparing the version that includes them, at least if 
your history is version A, version B, version C. (Now, it's possible that 
your history is "create a bunch of files", "create version A without 
BC.txt and C.txt"; in parallel to version A, create version B without 
AC.txt and C.txt; but that's a different process entirely.)

I think the exercise would come out much more easily if you only created 
ABC.txt and AC.txt at the beginning, made version A, added BC.txt and 
removed AC.txt, made version B, created C.txt and recovered AC.txt, and 
made version C; this is, I believe, what would actually happen.

If you're having trouble with "git commit" putting you in a lousy editor, 
somebody probably needs to do better packaging. "git commit" (without the 
-m) should open up the best editor available on your computer, but it 
doesn't seem to have a good idea about your preferences for editors. Of 
course, part of the problem is people who don't like that editor rarely 
use the command line on Windows. Do you have a good editor for Windows? 
How have you specified it, if so?

	-Daniel
*This .sig left intentionally blank*
