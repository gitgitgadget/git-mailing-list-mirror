From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: "git-send-pack"
Date: Fri, 01 Jul 2005 11:50:28 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.07.01.09.50.25.353825@smurf.noris.de>
References: <Pine.LNX.4.58.0506301025510.14331@ppc970.osdl.org> <42C4419C.7000309@timesys.com> <Pine.LNX.4.58.0506301233270.14331@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Fri Jul 01 11:45:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoI4w-0002c3-75
	for gcvg-git@gmane.org; Fri, 01 Jul 2005 11:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbVGAJwb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jul 2005 05:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263299AbVGAJwb
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jul 2005 05:52:31 -0400
Received: from main.gmane.org ([80.91.229.2]:11240 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S263298AbVGAJw3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jul 2005 05:52:29 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DoI3i-0002Rx-JY
	for git@vger.kernel.org; Fri, 01 Jul 2005 11:43:42 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Jul 2005 11:43:42 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Jul 2005 11:43:42 +0200
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

> maybe it would be ok to
> even have "git-receive-pack" as the shell for the receiver side, so that
> you don't actually give the mirrorer any shell access at all.

You can probably just set the remote command (in ~/.ssh/authorized_keys)
to git-receive-pack. That also works around any $PATH issues.

Once this is stable, master.kernel.org should be updated with the
latest git.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
People are never so ready to believe you as when you say things in dispraise
of yourself; and you are never so much annoyed as when they take you at your
word.
					-- Somerset Maugham
