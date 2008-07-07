From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-rerere: fix conflict markers parsing
Date: Mon, 7 Jul 2008 16:29:35 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807071627020.18205@racer>
References: <1215434568-30456-1-git-send-email-dkr+ml.git@free.fr> <alpine.DEB.1.00.0807071400180.18205@racer> <48722038.1010203@free.fr> <alpine.DEB.1.00.0807071505470.18205@racer> <48722BD9.4090406@free.fr>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-612054422-1215444576=:18205"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Mon Jul 07 17:32:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFshZ-0008MF-8V
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 17:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753304AbYGGPbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 11:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752184AbYGGPbb
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 11:31:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:50678 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751789AbYGGPba (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 11:31:30 -0400
Received: (qmail invoked by alias); 07 Jul 2008 15:31:29 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp058) with SMTP; 07 Jul 2008 17:31:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18TwLc/pGUTBN5Lymna+3jOUN8+AZ9DpaG8efBuqC
	+1itLw6KwPIkzV
X-X-Sender: gene099@racer
In-Reply-To: <48722BD9.4090406@free.fr>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87626>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-612054422-1215444576=:18205
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 7 Jul 2008, Olivier Marin wrote:

> Johannes Schindelin a écrit :
> > 
> > Okay, but then the obvious question is: what do you do about "<<<<<<" 
> > lines that are not a marker?
> 
> The answer is the same.

I think not.  You say you want to do something about the ambiguity, but 
fact is: the conflict markers are ambiguous.  They always have been, will 
ever be, and I do not even have to argue for it.  Or do I?

> > Same remark as before: if you fix rerere, why not do it properly?
> 
> If you have a better fix send a patch or at least give me some clues.

Did I not say that the index has enough information?  Or at least hint at 
it?

Of course, we could run with your solution.  But that only fixes a corner 
case, right?

So a proper fix will be needed eventually anyway.

And no, I will not work on it: this is not my itch, and my time is being 
stolen too much already, these days.

Ciao,
Dscho

--8323329-612054422-1215444576=:18205--
