From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: Linux 2.6.24-rc6
Date: Thu, 20 Dec 2007 22:50:36 -0500
Message-ID: <20071221035036.GE8535@fattire.cabal.ca>
References: <alpine.LFD.0.9999.0712201731010.21557@woody.linux-foundation.org> <20071221024805.GB8535@fattire.cabal.ca> <20071221030152.GC8535@fattire.cabal.ca> <alpine.LFD.0.9999.0712201937470.21557@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Dec 21 04:51:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5Yui-000210-Bt
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 04:51:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753849AbXLUDuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 22:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753648AbXLUDui
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 22:50:38 -0500
Received: from there.is.no.cabal.ca ([134.117.69.58]:60718 "EHLO
	fattire.cabal.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753392AbXLUDui (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 22:50:38 -0500
Received: by fattire.cabal.ca (Postfix, from userid 1000)
	id C294A23E08; Thu, 20 Dec 2007 22:50:36 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0712201937470.21557@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69037>

On Thu, Dec 20, 2007 at 07:49:05PM -0800, Linus Torvalds wrote:
> 
> 
> On Thu, 20 Dec 2007, Kyle McMartin wrote:
> > 
> > I think I see the problem, it's lack of context in the diff,
> 
> No, the problem is that "git diff" is apparently broken by a recent 
> optimization. The diff is simply broken.
> 
> The tar-ball and the git archive itself is fine, but yes, the diff from 
> 2.6.23 to 2.6.24-rc6 is bad. It's the "trim_common_tail()" optimization 
> that has caused way too much pain.
> 
> Sorry about that, I'll fix it up asap.
> 

no biggie, thanks!

cheers, Kyle
