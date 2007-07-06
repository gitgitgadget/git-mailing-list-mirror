From: Adrian Bunk <bunk@stusta.de>
Subject: Re: git-apply{,mbox,patch} should default to --unidiff-zero
Date: Fri, 6 Jul 2007 03:42:23 +0200
Message-ID: <20070706014222.GK3492@stusta.de>
References: <20070705232210.GR3492@stusta.de> <Pine.LNX.4.64.0707060217460.9789@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 06 03:41:59 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6cpZ-0005gS-Lt
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 03:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758137AbXGFBlz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 21:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758219AbXGFBlz
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 21:41:55 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:52204 "EHLO
	mailhub.stusta.mhn.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751636AbXGFBly (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 21:41:54 -0400
Received: from r063144.stusta.swh.mhn.de (r063144.stusta.swh.mhn.de [10.150.63.144])
	by mailhub.stusta.mhn.de (Postfix) with ESMTP id 04355181C28;
	Fri,  6 Jul 2007 03:43:07 +0200 (CEST)
Received: by r063144.stusta.swh.mhn.de (Postfix, from userid 1000)
	id 1040BE0FA5; Fri,  6 Jul 2007 03:42:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707060217460.9789@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51713>

On Fri, Jul 06, 2007 at 02:18:46AM +0100, Johannes Schindelin wrote:

> Hi,

Hi Johannes,

> On Fri, 6 Jul 2007, Adrian Bunk wrote:
> 
> > git-apply{,mbox,patch} should default to doing --unidiff-zero:
> 
> But is that not dangerous? At least now the committer has some safeguard 
> against this kind of mistakes. Because you can easily introduce mistakes 
> that way.

you are saying "easily".

Did you ever actually run into such a problem?

You must do something like "diff -U0" or manually editing patches for 
creating such patches, and that's very unusual.

And although GNU patch (which has a much bigger userbase than git) 
applies such patches without any warning I don't remember having ever 
seen what you call "easily".

> Ciao,
> Dscho

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
