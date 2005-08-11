From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: gitk: integer overflow
Date: Thu, 11 Aug 2005 18:07:14 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.08.11.16.07.13.369857@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Aug 11 18:14:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3FfM-00024m-5f
	for gcvg-git@gmane.org; Thu, 11 Aug 2005 18:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbVHKQMV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 12:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbVHKQMV
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 12:12:21 -0400
Received: from main.gmane.org ([80.91.229.2]:36278 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932267AbVHKQMU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Aug 2005 12:12:20 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1E3Fdr-0001sH-BC
	for git@vger.kernel.org; Thu, 11 Aug 2005 18:10:51 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 Aug 2005 18:10:51 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 Aug 2005 18:10:51 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Run gitk on the kernel archive, wait for it to finish reading commit
changesets, scroll to the middle, and watch all the pretty (NOT)
superfluous vertical lines appear and disappear pseudo-randomly.

Looks like something in there (TK or even X11, most likely) cuts off
screen coordinates after 16 bits ..?

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
You know things are bad when you're surrounded by four lawyers, and none of
them is yours.
