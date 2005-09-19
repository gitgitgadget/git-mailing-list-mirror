From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCHES] CURLDIR support, more usable cmd-rename.sh
Date: Mon, 19 Sep 2005 16:37:14 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.09.19.14.37.11.966217@smurf.noris.de>
References: <1127128475.781.6.camel@divert> <20050919133731.GB2903@pasky.or.cz> <1127139079.781.9.camel@divert>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Mon Sep 19 16:46:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHMrq-0003W4-5z
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 16:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbVISOnf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 10:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbVISOnf
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 10:43:35 -0400
Received: from main.gmane.org ([80.91.229.2]:3566 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932445AbVISOnf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 10:43:35 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1EHMpD-0002ig-TM
	for git@vger.kernel.org; Mon, 19 Sep 2005 16:40:55 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Sep 2005 16:40:55 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Sep 2005 16:40:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8870>

Hi, Patrick Mauritz wrote:

> -CFLAGS = -g -O2 -Wall
> +CFLAGS = -g -O2

Umm, no, you don't get to unconditionally throw way -Wall.

*Some* people think this flag makes sense and that the sane default
(on sane OSes, i.e. those who have GCC and glibc) should be to include it. 
 ;-)

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
I must have a prodigious quantity of mind; it takes me as much as a
week sometimes to make it up.
		-- Mark Twain, "The Innocents Abroad"
