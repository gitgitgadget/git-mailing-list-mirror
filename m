From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [RFC][PATCH] Rewriting revs in place in push target repository
Date: Sun, 14 Aug 2005 12:02:42 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.08.14.10.02.41.120567@smurf.noris.de>
References: <20050813214725.GM5608@pasky.ji.cz> <20050814022011.GA19897@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sun Aug 14 12:07:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4FNO-0001P4-NU
	for gcvg-git@gmane.org; Sun, 14 Aug 2005 12:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbVHNKEk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Aug 2005 06:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbVHNKEk
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Aug 2005 06:04:40 -0400
Received: from main.gmane.org ([80.91.229.2]:44202 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932465AbVHNKEj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Aug 2005 06:04:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1E4FL8-0001KI-3D
	for git@vger.kernel.org; Sun, 14 Aug 2005 12:03:38 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 14 Aug 2005 12:03:38 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 14 Aug 2005 12:03:38 +0200
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

> On Sat, Aug 13, 2005 at 11:47:25PM +0200, Petr Baudis wrote:
> 
>> 	I think it does not in real setups, since thanks to O_RDWR the
>> 	file should be overwritten only when the write() happens.
>> 	Can a 41-byte write() be non-atomic in any real conditions?
> 
> if you journal metadata only you can see a file extended w/o having
> the block flushed

??? but the file is *not* extended. Also, whether or not a block is
flushed should only matter if the machine crashes ..?

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
CONS [from LISP] 1. v. To add a new element to a list.	2. CONS UP:
   v. To synthesize from smaller pieces: "to cons up an example".
				-- From the AI Hackers' Dictionary
