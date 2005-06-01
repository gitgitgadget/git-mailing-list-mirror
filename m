From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: git-rev-list: proper lazy reachability
Date: Wed, 01 Jun 2005 18:38:45 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.06.01.16.38.35.273889@smurf.noris.de>
References: <Pine.LNX.4.58.0505301847120.1876@ppc970.osdl.org> <17052.21846.816147.370354@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0505310735260.1876@ppc970.osdl.org> <Pine.LNX.4.58.0505310813540.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Wed Jun 01 18:41:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdWF7-0005sV-3G
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 18:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVFAQlt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 12:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbVFAQlt
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 12:41:49 -0400
Received: from main.gmane.org ([80.91.229.2]:3200 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261393AbVFAQlr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jun 2005 12:41:47 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DdWDz-0005j3-8n
	for git@vger.kernel.org; Wed, 01 Jun 2005 18:37:47 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Jun 2005 18:37:47 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Jun 2005 18:37:47 +0200
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

> So I guess you'll have to wait for the end and do the toposort after all.

We could add a cache file, listing commit nodes which predate one of
their parents. Hit one of those and you know you need to immediately
examine their parents instead of waiting for them to come up in date order.

There shouldn't be too many of those in any tree.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Truth is a statue, and you are all just a bunch of pigeons.


