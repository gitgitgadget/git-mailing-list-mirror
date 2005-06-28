From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: CAREFUL! No more delta object support!
Date: Tue, 28 Jun 2005 21:49:35 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.06.28.19.49.33.828202@smurf.noris.de>
References: <Pine.LNX.4.21.0506281251380.30848-100000@iabervon.org> <Pine.LNX.4.58.0506281019450.19755@ppc970.osdl.org> <Pine.LNX.4.58.0506281111480.19755@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Jun 28 21:51:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnM7N-0005TT-HD
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 21:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVF1TzG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 15:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVF1TyH
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 15:54:07 -0400
Received: from main.gmane.org ([80.91.229.2]:35793 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261179AbVF1TwQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2005 15:52:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DnLzH-00036t-NN
	for git@vger.kernel.org; Tue, 28 Jun 2005 21:43:15 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Jun 2005 21:43:15 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Jun 2005 21:43:15 +0200
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

> Ugly, in any case.

Why not chunk the thing?

In other words, the stream shouldn't be

	"here's a big-ass packfile of unknown size"

but an arbitrary number of

	"here's a N-byte sized chunk of the current pack file"
snippets, followed by a
	"here's the SHA1 of the whole thing"
packet.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Be like a duck -- keep calm and unruffled on the surface but paddle like the
devil under water.
