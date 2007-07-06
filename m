From: Adrian Bunk <bunk@stusta.de>
Subject: Re: git-apply{,mbox,patch} should default to --unidiff-zero
Date: Fri, 6 Jul 2007 04:26:29 +0200
Message-ID: <20070706022629.GL3492@stusta.de>
References: <20070705232210.GR3492@stusta.de> <Pine.LNX.4.64.0707060217460.9789@racer.site> <20070706014222.GK3492@stusta.de> <Pine.LNX.4.64.0707060243110.4093@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 06 04:26:16 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6dWR-0002Yv-Nv
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 04:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759695AbXGFC0A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 22:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759637AbXGFC0A
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 22:26:00 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:52219 "EHLO
	mailhub.stusta.mhn.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758440AbXGFCZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 22:25:59 -0400
Received: from r063144.stusta.swh.mhn.de (r063144.stusta.swh.mhn.de [10.150.63.144])
	by mailhub.stusta.mhn.de (Postfix) with ESMTP id 135E2181C28;
	Fri,  6 Jul 2007 04:27:13 +0200 (CEST)
Received: by r063144.stusta.swh.mhn.de (Postfix, from userid 1000)
	id 1B1FDE0FC2; Fri,  6 Jul 2007 04:26:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707060243110.4093@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51715>

On Fri, Jul 06, 2007 at 02:51:07AM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 6 Jul 2007, Adrian Bunk wrote:
> 
> > On Fri, Jul 06, 2007 at 02:18:46AM +0100, Johannes Schindelin wrote:
> > 
> > > On Fri, 6 Jul 2007, Adrian Bunk wrote:
> > > 
> > > > git-apply{,mbox,patch} should default to doing --unidiff-zero:
> > > 
> > > But is that not dangerous? At least now the committer has some 
> > > safeguard against this kind of mistakes. Because you can easily 
> > > introduce mistakes that way.
> > 
> > you are saying "easily".
> > 
> > Did you ever actually run into such a problem?
> 
> Not yet, thankfully.
> 
> > You must do something like "diff -U0" or manually editing patches for 
> > creating such patches, and that's very unusual.
> 
> The point is that the _committer_ is not necessarily involved in that 
> business.
> 
> And "git apply" is strict for a reason. It catches possibly unwanted 
> things much earlier than patch. I _want_ to be warned that somebody is 
> introducing some code at a certain position, which might, or might not be 
> correct. apply has no way to tell, since there is no context to at least 
> minimally verify.
>...

That's wrong.

My use cases are replacing or deleting lines.

In these cases there is context in the deleted lines that is already 
being verified even with --unidiff-zero.

> Ciao,
> Dscho

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
