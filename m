From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] Teach parse_commit_buffer about grafting.
Date: Sat, 30 Jul 2005 10:40:20 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.07.30.08.40.11.725422@smurf.noris.de>
References: <Pine.LNX.4.58.0507261136280.19309@g5.osdl.org> <1122457238.3027.37.camel@baythorne.infradead.org> <Pine.LNX.4.58.0507270819550.3227@g5.osdl.org> <1122478870.28128.52.camel@hades.cambridge.redhat.com> <Pine.LNX.4.58.0507270846360.3227@g5.osdl.org> <7vslxw4tb1.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sat Jul 30 10:40:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dymtm-0004EQ-OC
	for gcvg-git@gmane.org; Sat, 30 Jul 2005 10:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbVG3Ikk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jul 2005 04:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbVG3Ikk
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jul 2005 04:40:40 -0400
Received: from main.gmane.org ([80.91.229.2]:62869 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S263014AbVG3Iki (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jul 2005 04:40:38 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DymtZ-0004Cm-K7
	for git@vger.kernel.org; Sat, 30 Jul 2005 10:40:37 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jul 2005 10:40:37 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jul 2005 10:40:37 +0200
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

> Introduce a new file $GIT_DIR/info/grafts

Nice work.

Has anybody git-imported the old tarfile+patch history yet?
If not, I'll do it over the weekend.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Whatever occurs from love is always beyond good and evil.
		-- Friedrich Nietzsche
