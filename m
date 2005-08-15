From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: Switching heads and head vs branch after CVS import
Date: Mon, 15 Aug 2005 12:38:53 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.08.15.10.38.50.677503@smurf.noris.de>
References: <Pine.LNX.4.58.0508141737270.3553@g5.osdl.org> <20050815080931.64F0D352633@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Mon Aug 15 12:41:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4cOT-00040T-1S
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 12:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629AbVHOKke (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 06:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932660AbVHOKke
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 06:40:34 -0400
Received: from main.gmane.org ([80.91.229.2]:25761 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932629AbVHOKkd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Aug 2005 06:40:33 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1E4cNE-0003e4-3P
	for git@vger.kernel.org; Mon, 15 Aug 2005 12:39:20 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Aug 2005 12:39:20 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Aug 2005 12:39:20 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Wolfgang Denk wrote:

> Assume I know exactly where the merge back happenend - is  there  any
> way to tell git about it, so I don't see all these dangling heads any
> more?

Two ways:
- you can enhance cvs2git to do it at the appropriate time. Good luck.
- after the fact, and after finding the relevant heads manually, you can
  use .git/info/grafts to fake it.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
As crazy as hauling timber into the woods.
		-- Quintus Horatius Flaccus (Horace)
