From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: Small team cogito/git setup
Date: Thu, 18 Aug 2005 11:37:27 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.08.18.09.37.25.359432@smurf.noris.de>
References: <46a038f9050817211446684aac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Aug 18 11:41:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5gsh-0006UH-6F
	for gcvg-git@gmane.org; Thu, 18 Aug 2005 11:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbVHRJkH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 05:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbVHRJkH
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 05:40:07 -0400
Received: from main.gmane.org ([80.91.229.2]:40070 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932150AbVHRJkF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Aug 2005 05:40:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1E5grL-00061M-Hz
	for git@vger.kernel.org; Thu, 18 Aug 2005 11:38:51 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Aug 2005 11:38:51 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Aug 2005 11:38:51 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Martin Langhoff wrote:

> Or are we forced to run an 'integration' repo so that we work with a
> 'star' arrangement? I am actually trying to avoid needing a central
> repo if possible.

Personally, I like the idea of an integration repository. The main reason
is that it avoids duplicate work and shifting blame for broken software,
particularly if you have a test suite.

My workflow is "develop, test, check-in, pull-and-merge, test-if-merged,
push". That tends to yield a saner change history, and requires less work,
than doing it for every co-worker.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
"Fundamentalists are like the fir trees in German forests: they cannot
 stand alone, and are only stable when crowded together, branches locked
 with those of their brothers. That is why we must always fear them,
 because they will always hate us for our individualism."
     [Brent Yaciw, with inspirational regards to Jack M. Bickham]
