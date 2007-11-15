From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: auto gc
Date: Thu, 15 Nov 2007 09:28:09 +0100
Message-ID: <20071115082808.GD638@kernel.dk>
References: <20071115081025.GC638@kernel.dk> <20071115082004.GL14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Nov 15 09:28:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Isa5R-00042L-2d
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 09:28:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756619AbXKOI2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 03:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756578AbXKOI2N
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 03:28:13 -0500
Received: from brick.kernel.dk ([87.55.233.238]:10500 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756368AbXKOI2M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 03:28:12 -0500
Received: by kernel.dk (Postfix, from userid 500)
	id 5413E2571FE; Thu, 15 Nov 2007 09:28:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071115082004.GL14735@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65087>

On Thu, Nov 15 2007, Shawn O. Pearce wrote:
> Jens Axboe <jens.axboe@oracle.com> wrote:
> ...
> > Packing your repository for optimum performance. You may also
> > run "git gc" manually. See "git help gc" for more information.
> > Generating pack...
> > [...]
> > 
> > This is extremely annoying behaviour! If I'm on battery or just in a bit
> > of a hurry, I defeinitely don't want git second guessing me and deciding
> > that it's time to run git gc.
> > 
> > I'd suggest just printing a hint that running git gc would increase
> > performance, doing it automatically is definitely bad style (even more
> > so when then yet again changed git refs layout even breaks old scripts,
> > when git gc has run).
> 
> Set the following and it won't run automatically anymore for you:
> 
> 	git config --global gc.auto 0
> 	git config --global gc.autopacklimit 0

OK

> More recently this message has been changed to:
> 
>   Packing your repository for optimum performance. You may also
>   run "git gc" manually. See "git help gc" for more information.

Great, that's a lot more appropriate in my opinion. I'll just update to
a later git.

Thanks!

-- 
Jens Axboe
