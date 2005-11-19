From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [RFC] Applying a graft to a tree and "rippling" the changes through
Date: Sat, 19 Nov 2005 18:23:20 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.11.19.17.23.17.920228@smurf.noris.de>
References: <20051117230723.GD26122@nowhere.earth> <Pine.LNX.4.63.0511180026080.18775@wbgn013.biozentrum.uni-wuerzburg.de> <20051119140404.GD3393@nowhere.earth> <20051119141341.GE3393@nowhere.earth> <Pine.LNX.4.63.0511191612350.4895@wbgn013.biozentrum.uni-wuerzburg.de> <20051119170929.GF3393@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sat Nov 19 18:26:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdWSn-0008A0-Vq
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 18:25:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbVKSRZS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 12:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbVKSRZS
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 12:25:18 -0500
Received: from main.gmane.org ([80.91.229.2]:221 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750723AbVKSRZQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Nov 2005 12:25:16 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EdWRE-0007gw-NT
	for git@vger.kernel.org; Sat, 19 Nov 2005 18:23:44 +0100
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 19 Nov 2005 18:23:44 +0100
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 19 Nov 2005 18:23:44 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12344>

Hi, Yann Dirson wrote:

> But the 2nd and 3rd levels are not currently distinct in git.

I don't think you *can* make them distinct. Sure, you could introduce 
"change" object which refers to a couple of source trees and a destination
tree, and then create a "history" object which links previous history and
a change, but what's the point? What can you do with such a thing
that you cannot do now, just as easily, besides slow down your programs
with an unnecessary level of indirection?

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
"To those who wish to punish others--or at least to see them punished, if
 the avengers are too cowardly to take matters in to their own hands-- the
 belief in a fiery, hideous hell appears to be a great source of comfort."
            [Steve Allen, "Steve Allen, on
             the Bible Religion & Morality"]
