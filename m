From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: git merging
Date: Mon, 20 Jun 2005 21:21:29 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.06.20.19.21.26.676320@smurf.noris.de>
References: <Pine.LNX.4.58.0506200844420.2268@ppc970.osdl.org> <Pine.LNX.4.21.0506201156360.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Mon Jun 20 21:20:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkRoC-00066Y-Ak
	for gcvg-git@gmane.org; Mon, 20 Jun 2005 21:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbVFTTYz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Jun 2005 15:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVFTTWv
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jun 2005 15:22:51 -0400
Received: from main.gmane.org ([80.91.229.2]:57546 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261519AbVFTTW0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jun 2005 15:22:26 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DkRkb-0005LL-8B
	for git@vger.kernel.org; Mon, 20 Jun 2005 21:16:05 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Jun 2005 21:16:05 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Jun 2005 21:16:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Daniel Barkalow wrote:

> Basically, it needs a "process_unknown()" which does the
> appropriate thing, and pull() needs to call that instead of
> process_commit().

It also needs a request queue.

The beauty of rsync() is that it doesn't depend on a low-latency wire to
work efficiently. Right now, pull() needs one round trip per object, and
that's way too much.

I hope to have some free time for that this week, but no promises. :-/

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Creativity varies inversely with the number of cooks involved with the
broth.
					-- Bernice Fitz-Gibbon


