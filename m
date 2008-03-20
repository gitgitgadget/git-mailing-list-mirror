From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: auto gc again
Date: Thu, 20 Mar 2008 07:01:19 +0100
Message-ID: <20080320060119.GF17940@kernel.dk>
References: <20080318180118.GC17940@kernel.dk> <alpine.LFD.1.00.0803181112270.3020@woody.linux-foundation.org> <20080318181948.GH17940@kernel.dk> <alpine.LFD.1.00.0803191629240.2947@xanadu.home> <47E18540.4020908@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Mar 20 07:02:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcDqj-0006E3-R0
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 07:02:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753353AbYCTGBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 02:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753349AbYCTGBW
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 02:01:22 -0400
Received: from brick.kernel.dk ([87.55.233.238]:15824 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753332AbYCTGBV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 02:01:21 -0400
Received: by kernel.dk (Postfix, from userid 500)
	id 5A46F257AC9; Thu, 20 Mar 2008 07:01:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <47E18540.4020908@nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77632>

On Wed, Mar 19 2008, Brandon Casey wrote:
> Nicolas Pitre wrote:
> > On Tue, 18 Mar 2008, Jens Axboe wrote:
> > 
> >> But freshly pulled repo, git auto gc is enabled. And that is my main
> >> annoyance, I just don't think that type of policy should be in there.
> > 
> > Just do this once:
> > 
> > 	git config --global gc.auto 0
> > 	git config --global gc.autopacklimit 0
> 
> Is there any reason why gc.auto=0 couldn't be used to disable auto
> packing entirely?
> 
> Said differently, are there valid use cases where one might want automatic
> repacking based on the number of packs but _not_ based on the number of
> loose objects?
> 
> If the answer is "no", then "gc.auto=0 means completely disable auto-gc"
> seems intuitive and would have protected Jens in this case.

Totally agree, makes a lot more sense.

-- 
Jens Axboe
