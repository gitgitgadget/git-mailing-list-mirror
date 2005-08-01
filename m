From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: git diffs
Date: Mon, 01 Aug 2005 09:55:47 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.08.01.07.55.40.43904@smurf.noris.de>
References: <20050731172256.73f91a20.akpm@osdl.org> <Pine.LNX.4.58.0507311725590.14342@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Mon Aug 01 09:58:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzVAr-0005k9-UH
	for gcvg-git@gmane.org; Mon, 01 Aug 2005 09:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbVHAH4w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Aug 2005 03:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVHAH4w
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Aug 2005 03:56:52 -0400
Received: from main.gmane.org ([80.91.229.2]:19884 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261787AbVHAH42 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2005 03:56:28 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DzV9o-0005dU-2w
	for git@vger.kernel.org; Mon, 01 Aug 2005 09:56:20 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Aug 2005 09:56:20 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Aug 2005 09:56:20 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Linus Torvalds wrote:

> 	git checkout -f master
> 	git-rev-parse master > .git/refs/heads/merge-branch
> 
> 	#
> 	# Switch to it, always leaving "master" untouched
> 	#
> 	git checkout -f merge-branch

Isn't that equivalent to (but slower than)

    git checkout -f -b merge-branch master

?

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
You can tell it's going to be a rotten day when the bird singing outside your
window is a buzzard.
