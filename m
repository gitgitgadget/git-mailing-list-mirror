From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: How is working on arbitrary remote heads supposed to work in Cogito (+ PATCH)?
Date: Thu, 28 Jul 2005 21:47:40 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.07.28.19.47.38.753705@smurf.noris.de>
References: <Pine.LNX.4.58.0507281931180.30371@wgmdd8.biozentrum.uni-wuerzburg.de> <200507271458.43063.Josef.Weidendorfer@gmx.de> <7vll3rlnqm.fsf@assigned-by-dhcp.cox.net> <200507271458.43063.Josef.Weidendorfer@gmx.de> <20050728120806.GA2391@pasky.ji.cz> <Pine.LNX.4.58.0507281504100.25402@wgmdd8.biozentrum.uni-wuerzburg.de> <20050728153506.GL14229@pasky.ji.cz> <Pine.LNX.4.58.0507281747320.29968@wgmdd8.biozentrum.uni-wuerzburg.de> <20050728161815.GC17952@pasky.ji.cz> <7v1x5ic1pe.fsf@assigned-by-dhcp.cox.net> <20050728183904.GA24948@pasky.ji.cz> <Pine.LNX.4.58.0507282047360.30638@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Jul 28 21:54:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyES7-0007mU-0S
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 21:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbVG1TxV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 15:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVG1TvA
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 15:51:00 -0400
Received: from main.gmane.org ([80.91.229.2]:19332 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261566AbVG1Tuu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2005 15:50:50 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DyENS-00071Z-Sb
	for git@vger.kernel.org; Thu, 28 Jul 2005 21:49:11 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Jul 2005 21:49:10 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Jul 2005 21:49:10 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Johannes Schindelin wrote:

> Are you really sure you want to slave git into being a "better
> Subversion"?

Since git is better than all of these, we should be able to easily write a
SVN-like porcelain, so ... ;-)

> IMHO, if you need a central repository, you should also have
> one central HEAD.

I disagree. Larger projects have multiple HEADs (stable, oldstable,
development, ...). I don't like putting those in different repositories,
you end up with a heap of housekeeping effort to hardlink duplicate
objects, all of which is going to be wasted when different people run
"git repack".

Not everybody has 100-GB disks and multi-MB Internet pipes to play with...

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
On ability:
	A dwarf is small, even if he stands on a mountain top;
	a colossus keeps his height, even if he stands in a well.
		-- Lucius Annaeus Seneca, 4BC - 65AD
