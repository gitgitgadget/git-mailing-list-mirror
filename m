From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Git Cygwin - unable to create any repository - help!
Date: Thu, 17 Jan 2008 21:18:29 +0100
Message-ID: <20080117201829.GA3615@steel.home>
References: <a5eb9c330801151212y30cf4f63r9c294ba33da2b8f@mail.gmail.com> <200801160002.51048.robin.rosenberg.lists@dewire.com> <20080116071832.GA2896@steel.home> <a5eb9c330801160742j645ee50p72ee0a93adf8f94f@mail.gmail.com> <20080116183124.GA3181@steel.home> <a5eb9c330801161048x4b5a88dcsebd7cf9754f72ba6@mail.gmail.com> <20080116191737.GD3181@steel.home> <a5eb9c330801161344i1da447c7sb447bf6274d408e8@mail.gmail.com> <20080116234527.GA3499@steel.home> <a5eb9c330801171037v333becc2lbc5873383d07a358@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Paul Umbers <paul.umbers@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 21:19:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFbCY-0000HU-Ti
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 21:19:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbYAQUSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 15:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbYAQUSe
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 15:18:34 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:40249 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbYAQUSd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 15:18:33 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2hcNrFIbA=
Received: from tigra.home (Fa9df.f.strato-dslnet.de [195.4.169.223])
	by post.webmailer.de (mrclete mo47) (RZmta 15.4)
	with ESMTP id K01d10k0HID9aC ; Thu, 17 Jan 2008 21:18:30 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 2284F277AE;
	Thu, 17 Jan 2008 21:18:30 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id B17EF56D22; Thu, 17 Jan 2008 21:18:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <a5eb9c330801171037v333becc2lbc5873383d07a358@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70916>

Paul Umbers, Thu, Jan 17, 2008 19:37:37 +0100:
> Made the changes you specify below & re-ran "make install".

no need for "make install", just "make" would be enough:
you run the commands explicitely in the current directory:

    strace -o log -mall -f ./git --exec-path $(pwd) add testfile

> Attached is the log from the latest strace.

Are you sure? It looks like a strace of some random git program...
The link, which failed in log_2 attempt is not even called.
Oh... Could you redo the test after running "git reset --hard" first?

And have you tried running tests in a directory without whitespace in
path? Like "c:/windows", for example?
