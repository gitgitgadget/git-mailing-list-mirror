From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: gitk with hyperspace support
Date: Wed, 17 Aug 2005 17:56:38 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.08.17.15.56.37.841163@smurf.noris.de>
References: <17154.33520.584666.701545@cargo.ozlabs.ibm.com> <7vr7ct124c.fsf@assigned-by-dhcp.cox.net> <60088.10.10.10.28.1124266400.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Wed Aug 17 18:03:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5QM9-0002a6-PT
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 18:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbVHQQBa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 12:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbVHQQBa
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 12:01:30 -0400
Received: from main.gmane.org ([80.91.229.2]:2731 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751154AbVHQQBa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Aug 2005 12:01:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1E5QKi-0001eB-MH
	for git@vger.kernel.org; Wed, 17 Aug 2005 18:00:04 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Aug 2005 18:00:04 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Aug 2005 18:00:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Sean wrote:

> The line flowing from this commit extends ~200 more commits downward
> before it is finally terminated with an arrowhead.   It would be nice if
> this line could be made shorter, such that the arrowhead was drawn much
> closer to commit in question.

Good point. The arrowheads tend to get lost otherwise; in my tree, the
problem is even worse since the downward-pointing arrow (drawn in grey) is
directly below a horizontal line connecting two unrelated changes -- which
is *also* grey.  That makes the actual arrowhead perceptually invisible.

If the arrow appears directly below a node, you don't get that problem.

Another point I just noticed: The arrows should be directly below
each other, if at all possible; i.e. the one pointing up should be in the
same column as the corresponding arrow pointing down.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Money is the root of all evil, and man needs roots.
