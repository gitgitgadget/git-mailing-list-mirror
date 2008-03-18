From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: auto gc again
Date: Tue, 18 Mar 2008 19:39:07 +0100
Message-ID: <20080318183906.GL17940@kernel.dk>
References: <20080318180118.GC17940@kernel.dk> <alpine.LFD.1.00.0803181112270.3020@woody.linux-foundation.org> <20080318181948.GH17940@kernel.dk> <20080318182421.GI17940@kernel.dk> <alpine.LFD.1.00.0803181130240.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 19 20:44:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc4CD-0002JK-Ap
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 20:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757633AbYCSTlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 15:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757626AbYCSTk7
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 15:40:59 -0400
Received: from brick.kernel.dk ([87.55.233.238]:26248 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757609AbYCSTk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 15:40:59 -0400
Received: by kernel.dk (Postfix, from userid 51)
	id 3B0AC257795; Wed, 19 Mar 2008 20:40:53 +0100 (CET)
Received: by kernel.dk (Postfix, from userid 500)
	id 2CD91258789; Tue, 18 Mar 2008 19:39:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0803181130240.3020@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77517>

On Tue, Mar 18 2008, Linus Torvalds wrote:
> 
> 
> On Tue, 18 Mar 2008, Jens Axboe wrote:
> > 
> > axboe@carl:~/git/linux-2.6-block> git count-objects
> > 901 objects, 6448 kilobytes
> 
> The default auto-gc threshold is 6700 objects. You should *not* be even 
> close to hitting it.
> 
> But there's a 20-pack pack-limit. Do you have lots of pack-files? But you 
> can disable that one with
> 
> 	[gc]
> 		autopacklimit = 0
> 
> and I do think the default might be a bit low.

I let gc run last time to get rid of the complaint, so I cannot answer
that question. It's probably the pack limit if that is newer, since the
object count was so low.

But you never answer the question on whether you really consider any
form of autopacking or auto gc sane? Next time some other limit is added
for auto gc, it'll be annoying once more.

-- 
Jens Axboe
