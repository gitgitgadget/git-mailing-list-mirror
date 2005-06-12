From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: reducing line crossings in gitk
Date: Sun, 12 Jun 2005 16:30:49 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.06.12.14.30.49.114182@smurf.noris.de>
References: <17066.53047.660907.453399@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sun Jun 12 16:27:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DhTQH-0006Ku-TT
	for gcvg-git@gmane.org; Sun, 12 Jun 2005 16:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262612AbVFLOb0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Jun 2005 10:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbVFLObZ
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jun 2005 10:31:25 -0400
Received: from main.gmane.org ([80.91.229.2]:48343 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262612AbVFLObY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Jun 2005 10:31:24 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DhTPz-0006Jf-8Z
	for git@vger.kernel.org; Sun, 12 Jun 2005 16:26:31 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 12 Jun 2005 16:26:31 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 12 Jun 2005 16:26:31 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Paul Mackerras wrote:

> I could add a heuristic to look for this case and reverse the order of
> the parents, which would reduce the line crossings and make the graph
> look neater.  Would this be worth the slight loss of information (in
> that the stuff pulled in would no longer always be to the right)?

Yes.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
All interesting actions are overdetermined. -- Arthur D. Hlavaty


