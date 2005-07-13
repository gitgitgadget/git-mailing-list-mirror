From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [RFC PATCH] cogito --- don't overwrite metadata files in place (breaks CoW use)
Date: Wed, 13 Jul 2005 09:03:26 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.07.13.07.03.26.398212@smurf.noris.de>
References: <20050712190552.GA7178@taniwha.stupidest.org> <loom.20050712T233332-364@post.gmane.org> <20050713045338.GA19819@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Wed Jul 13 09:04:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsbHi-0005r2-Rn
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 09:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbVGMHDy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 03:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbVGMHDy
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 03:03:54 -0400
Received: from main.gmane.org ([80.91.229.2]:47785 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262605AbVGMHDx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2005 03:03:53 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DsbHO-0005ob-EV
	for git@vger.kernel.org; Wed, 13 Jul 2005 09:03:38 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Jul 2005 09:03:38 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Jul 2005 09:03:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Chris Wedgwood wrote:

> Symlink'd trees don't really make sense to me (they seem fragile and
> somewhat pointless) but perhaps I'm missing something?

You are ;-)  the tree itsels is no symlinked, but HEAD points to
refs/heads/<branch> by default.

Don't clobber that, please.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Though many hands make light work, too many cooks spoil the broth.
