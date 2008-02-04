From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add platform-independent .git "symlink"
Date: Mon, 4 Feb 2008 22:19:37 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802042218280.8543@racer.site>
References: <8c5c35580802020959v613b9e32v321e97f93f2af761@mail.gmail.com> <1201975757-13771-1-git-send-email-hjemli@gmail.com> <alpine.LSU.1.00.0802021815510.7372@racer.site> <alpine.LSU.1.00.0802021825220.7372@racer.site> <47A78104.9050909@nrlssc.navy.mil>
 <alpine.LSU.1.00.0802042128170.8543@racer.site> <47A78CF9.6040001@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Lars Hjemli <hjemli@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Feb 04 23:20:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM9gI-0002G0-Ch
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 23:20:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753815AbYBDWUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 17:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753692AbYBDWUQ
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 17:20:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:46723 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753490AbYBDWUP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 17:20:15 -0500
Received: (qmail invoked by alias); 04 Feb 2008 22:20:13 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp032) with SMTP; 04 Feb 2008 23:20:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+cUY0I4P2c/ajF2HPlWu3XzNNBOWvEG6p8JMNWy9
	UDpT7sO+dUMwKB
X-X-Sender: gene099@racer.site
In-Reply-To: <47A78CF9.6040001@nrlssc.navy.mil>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72580>

Hi,

On Mon, 4 Feb 2008, Brandon Casey wrote:

> Johannes Schindelin wrote:
> > 
> > On Mon, 4 Feb 2008, Brandon Casey wrote:
> 
> >> Have you thought about using git-clone instead?
> > 
> > Briefly.  But this is not about cloning the repository.  It is about 
> > having an additional working directory for the current repository.
> 
> I think that is true at the low level, but from a high level it feels 
> similar to me.
> 
> [...]
> 
> > I _want_ the original repository to know that there is another working 
> > directory.
> 
> Yes, your ideas are much better than simply adding the functionality of 
> the git-new-workdir script (which is what I was planning on doing btw :)

Somehow these two statements do not work together.  Either you have a 
clone, or you accept that a new working directory is actually working on 
the _same_ repository.

Ciao,
Dscho
