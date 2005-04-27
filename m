From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: git "tag" objects implemented - and a re-done commit
Date: Wed, 27 Apr 2005 13:36:51 +1000
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.04.27.03.36.51.65390@smurf.noris.de>
References: <Pine.LNX.4.58.0504251213530.18901@ppc970.osdl.org> <Pine.LNX.4.58.0504251318290.11481@sam.ics.uci.edu> <Pine.LNX.4.58.0504251339020.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Wed Apr 27 05:33:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQdHx-0005Hm-RF
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 05:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbVD0Dht (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 23:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbVD0Dht
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 23:37:49 -0400
Received: from main.gmane.org ([80.91.229.2]:1232 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261902AbVD0Dhh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 23:37:37 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DQdHE-0005Db-GH
	for git@vger.kernel.org; Wed, 27 Apr 2005 05:31:55 +0200
Received: from intern146.lnk.telstra.net ([165.228.245.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 Apr 2005 05:31:52 +0200
Received: from smurf by intern146.lnk.telstra.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 Apr 2005 05:31:52 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: intern146.lnk.telstra.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Linus Torvalds wrote:

> And if two different developers tag exactly the same object with exactly 
> the same tag-name and exactly the same signature, then they get the same 
> tag object, and that's fine. They should.

... except that they can't. I mean, the signature is done by different
people at different times, so it can't well be identical.

-- 
Matthias Urlichs

