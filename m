From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: auto gc again
Date: Thu, 20 Mar 2008 18:31:01 +0100
Message-ID: <20080320173100.GJ17940@kernel.dk>
References: <20080318180118.GC17940@kernel.dk> <alpine.LFD.1.00.0803181112270.3020@woody.linux-foundation.org> <20080318181948.GH17940@kernel.dk> <alpine.LFD.1.00.0803191629240.2947@xanadu.home> <20080319211733.GD17940@kernel.dk> <alpine.LFD.1.00.0803191856290.2947@xanadu.home> <20080320074057.GH17940@kernel.dk> <7vhcf1ygl4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 18:32:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcOcJ-0004jN-R2
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 18:31:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757979AbYCTRbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 13:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757595AbYCTRbH
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 13:31:07 -0400
Received: from brick.kernel.dk ([87.55.233.238]:22544 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757589AbYCTRbG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 13:31:06 -0400
Received: by kernel.dk (Postfix, from userid 500)
	id 901FF258863; Thu, 20 Mar 2008 18:31:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vhcf1ygl4.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77678>

On Thu, Mar 20 2008, Junio C Hamano wrote:
> Jens Axboe <jens.axboe@oracle.com> writes:
> 
> > gc.auto covering everything is good enough for me, GIT_GC_AUTO
> > environment variable would be better because of the way that I work. But
> > I can get by knowing that the gc.auto thing will at least only bite me
> > once per tree. And perhaps just wrap git clone in one of my scripts
> > that'll then do the gc.auto thing automatically.
> 
> You missed --global part of the suggestion, perhaps?

I did indeed, --global does exactly what I meant with GIT_GC_AUTO.
Thanks!

-- 
Jens Axboe
