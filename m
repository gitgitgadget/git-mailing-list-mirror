From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add platform-independent .git "symlink"
Date: Tue, 5 Feb 2008 00:49:36 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802050047340.8543@racer.site>
References: <8c5c35580802020959v613b9e32v321e97f93f2af761@mail.gmail.com> <1201975757-13771-1-git-send-email-hjemli@gmail.com> <alpine.LSU.1.00.0802021815510.7372@racer.site> <alpine.LSU.1.00.0802021825220.7372@racer.site> <47A78104.9050909@nrlssc.navy.mil>
 <alpine.LSU.1.00.0802042128170.8543@racer.site> <47A78CF9.6040001@nrlssc.navy.mil> <alpine.LSU.1.00.0802042218280.8543@racer.site> <47A79541.6070900@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Lars Hjemli <hjemli@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Feb 05 01:51:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMC1S-0002zv-Sa
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 01:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757454AbYBEAuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 19:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757438AbYBEAuS
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 19:50:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:45411 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757392AbYBEAuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 19:50:16 -0500
Received: (qmail invoked by alias); 05 Feb 2008 00:50:14 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO [192.168.1.71]) [86.138.198.40]
  by mail.gmx.net (mp047) with SMTP; 05 Feb 2008 01:50:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+M7jlg3fWMwqMYkOw406fWtHhnVtMY9n6h3Xm6s7
	QFbXG3917Fg6b9
X-X-Sender: gene099@racer.site
In-Reply-To: <47A79541.6070900@nrlssc.navy.mil>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72602>

Hi,

On Mon, 4 Feb 2008, Brandon Casey wrote:

> When we talk about clones we are not always talking about a strict 
> "full" clone.

Here, sir, we disagree.  I tend to like the fact that a clone is a clone 
is a clone.  Which BTW is the reason why I do not like requests to "clone" 
only one branch: this is not a clone.

> If your statement above is rephrased to "I _want_ the original 
> repository to know that it has conjoined siblings.", then we have a new 
> repository type:
> 
> 	4) conjoined repository (it has multiple sibling repositories each
> 	   with their own working directory, but they all share and modify the
> 	   same .git directory)

No.  The repository does not even need a working directory (in which case 
we call it "bare").  Up until now, it _can_ have _one_ working directory.  
With my plans, it can have more than one.

Ciao,
Dscho
