From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add platform-independent .git "symlink"
Date: Mon, 4 Feb 2008 14:34:59 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802041434360.7372@racer.site>
References: <8c5c35580802020959v613b9e32v321e97f93f2af761@mail.gmail.com> <1201975757-13771-1-git-send-email-hjemli@gmail.com> <alpine.LSU.1.00.0802021815510.7372@racer.site> <alpine.LSU.1.00.0802021825220.7372@racer.site> <20080204015707.GH24004@spearce.org>
 <7vk5llmnf6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 15:36:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM2Qf-00080Q-83
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 15:36:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724AbYBDOfk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 09:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752408AbYBDOfk
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 09:35:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:51798 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752229AbYBDOfj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 09:35:39 -0500
Received: (qmail invoked by alias); 04 Feb 2008 14:35:37 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp035) with SMTP; 04 Feb 2008 15:35:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18EekUtrJAEgiqqkxSpaC1WTLKqqc7UIRlHK5pHfS
	4BOaZGCjwJPm2e
X-X-Sender: gene099@racer.site
In-Reply-To: <7vk5llmnf6.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72507>

Hi,

On Sun, 3 Feb 2008, Junio C Hamano wrote:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > The second biggest problem is checking out the same branch in two 
> > different directories at once.  This becomes a problem only if you 
> > modify the branch, but still, its a problem.
> 
> I agree.  The biggest benefit I am getting out of the workdir layout is 
> that it allows me to check out the same branch in two directories, and 
> let me work further on one while the other one is compiling and running 
> the testsuite.  The other "compile and test tree" needs to be reset with 
> --hard once I commit in the "edit tree", but by definition "reset 
> --hard" is always a safe operation in a "compile and test tree".
> 
> In short, you need to know what you are doing.

But that's exactly what you can use throw-away branches for.  I do.

Ciao,
Dscho
