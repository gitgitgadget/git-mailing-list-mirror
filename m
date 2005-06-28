From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: CAREFUL! No more delta object support!
Date: Tue, 28 Jun 2005 22:18:01 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.06.28.20.17.59.178402@smurf.noris.de>
References: <Pine.LNX.4.21.0506281251380.30848-100000@iabervon.org> <Pine.LNX.4.58.0506281019450.19755@ppc970.osdl.org> <Pine.LNX.4.58.0506281111480.19755@ppc970.osdl.org> <pan.2005.06.28.19.49.33.828202@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Jun 28 22:19:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnMXk-0001sa-9n
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 22:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVF1UUe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 16:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbVF1UUc
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 16:20:32 -0400
Received: from main.gmane.org ([80.91.229.2]:27879 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261374AbVF1UTj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2005 16:19:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DnMR0-0000fr-Ul
	for git@vger.kernel.org; Tue, 28 Jun 2005 22:11:54 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Jun 2005 22:11:54 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Jun 2005 22:11:54 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I wrote:

> Linus Torvalds wrote:
> 
>> Ugly, in any case.
> 
> Why not chunk the thing?

Having the number of files sent first would work too, I'd think.

I'm wary of trying to interpret something non-decompressible as a sha1
chunk, however -- the set of random bytes that, to zlib, look like a
sufficiently valid zip header that it wants to read more than 20 of them
before punting is certainly not zero.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
I was sure the old fellow would never make it
to the other side of the curb when I struck him.
