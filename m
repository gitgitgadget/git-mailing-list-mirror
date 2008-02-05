From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add platform-independent .git "symlink"
Date: Tue, 5 Feb 2008 12:57:54 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802051256080.8543@racer.site>
References: <8c5c35580802020959v613b9e32v321e97f93f2af761@mail.gmail.com> <1201975757-13771-1-git-send-email-hjemli@gmail.com> <alpine.LSU.1.00.0802021815510.7372@racer.site> <alpine.LSU.1.00.0802021825220.7372@racer.site> <47A78104.9050909@nrlssc.navy.mil>
 <alpine.LSU.1.00.0802042128170.8543@racer.site> <47A78CF9.6040001@nrlssc.navy.mil> <alpine.LSU.1.00.0802042218280.8543@racer.site> <47A79541.6070900@nrlssc.navy.mil> <alpine.LSU.1.00.0802050047340.8543@racer.site> <47A7CD29.40306@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Lars Hjemli <hjemli@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Feb 05 13:59:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMNOJ-0007ec-C7
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 13:59:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbYBEM6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 07:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbYBEM6h
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 07:58:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:36575 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750989AbYBEM6h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 07:58:37 -0500
Received: (qmail invoked by alias); 05 Feb 2008 12:58:34 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp026) with SMTP; 05 Feb 2008 13:58:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19FZn1YIddFmiFaxCUy9HwlcUvkE5uW+0T/3KbNh0
	kH0Ok1Qu7/KTWt
X-X-Sender: gene099@racer.site
In-Reply-To: <47A7CD29.40306@nrlssc.navy.mil>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72651>

Hi,

On Mon, 4 Feb 2008, Brandon Casey wrote:

> Johannes Schindelin wrote:
> 
> > On Mon, 4 Feb 2008, Brandon Casey wrote:
> > 
> >> If your statement above is rephrased to "I _want_ the original 
> >> repository to know that it has conjoined siblings.", then we have a 
> >> new repository type:
> >>
> >> 	4) conjoined repository (it has multiple sibling repositories each
> >> 	   with their own working directory, but they all share and modify the
> >> 	   same .git directory)
> > 
> > No.  The repository does not even need a working directory (in which case 
> > we call it "bare").
> 
> The additional term "bare" that is used with such a repository without a 
> working directory implies to me that this is a "special" or "uncommon" 
> repository configuration.

By the same reasoning, a "good day" would be a "special" or "uncommon" 
day.

> So I hope you excuse me for referring to the result of git-clone as a 
> repository. I'll try to think of something else to call it (above I used 
> repo/workdir).

But that's what I am saying: a git-clone clones a repository.  If you 
happen to clone without the "--bare" option, it will additionally create a 
working directory.

Hth,
Dscho
