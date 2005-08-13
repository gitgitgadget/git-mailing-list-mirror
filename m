From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] fetch-pack: start multi-head pulling.
Date: Sat, 13 Aug 2005 05:25:30 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.08.13.03.25.28.489523@smurf.noris.de>
References: <7vwtmr4hm5.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0508120858420.3295@g5.osdl.org> <Pine.LNX.4.63.0508121818230.26488@wgmdd8.biozentrum.uni-wuerzburg.de> <7vk6irumv3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sat Aug 13 05:28:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3mgu-0004ow-KK
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 05:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbVHMD1v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 23:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbVHMD1v
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 23:27:51 -0400
Received: from main.gmane.org ([80.91.229.2]:15283 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750952AbVHMD1v (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Aug 2005 23:27:51 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1E3mfT-0004lI-EN
	for git@vger.kernel.org; Sat, 13 Aug 2005 05:26:43 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 13 Aug 2005 05:26:43 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 13 Aug 2005 05:26:43 +0200
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

> I have been trying, admittably perhaps not very successfully, to
> stay away from bashism in the core GIT scripts.

We should probably use #!/bin/bash for scripts with bashisms...

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
He has more goodness in his little finger Than you have in your whole
body.
					-- Jonathan Swift
