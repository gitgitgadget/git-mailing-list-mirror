From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH/RFC] "Recursive Make considered harmful"
Date: Thu, 28 Jul 2005 09:45:31 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.07.28.07.45.31.245357@smurf.noris.de>
References: <20050727083910.GG19290@mythryan2.michonline.com> <7v4qafrk8w.fsf@assigned-by-dhcp.cox.net> <7v64uvh0mo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Jul 28 09:49:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dy38u-0002bj-DR
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 09:49:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVG1Hsw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 03:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVG1HrE
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 03:47:04 -0400
Received: from main.gmane.org ([80.91.229.2]:16790 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261323AbVG1HqO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2005 03:46:14 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Dy35c-0002Iw-Ai
	for git@vger.kernel.org; Thu, 28 Jul 2005 09:46:02 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Jul 2005 09:46:00 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Jul 2005 09:46:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Junio C Hamano wrote:

> The Debian build is not affected because it does not produce
> separate git-core and doc-git-core packages[*1*]; probably this
> was the reason you did not notice this.

git-core-doc, actually.

Debian does that only if the documentation is substantial. Even then,
manpages may not be segregated into -doc.

However, I *would* segregate gitk into its own Debian package, because
it requires wish et al., which would pull a large chunk of X11 stuff,
which people may not want on their server.

Patch follows separately -- I'll have to pull it from my other mess
(which includes yet another Debian package for Cogito ;-).

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
A zealot's stones will break my bones, but gods will never hurt me.
