From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH 2/2] Unify usage strings declaration
Date: Sat, 30 Jul 2005 08:03:35 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.07.30.06.03.34.432362@smurf.noris.de>
References: <20050729085819.GL24895@pasky.ji.cz> <20050729090126.GN24895@pasky.ji.cz> <7vfytx82m3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sat Jul 30 08:04:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DykSM-0004ew-7j
	for gcvg-git@gmane.org; Sat, 30 Jul 2005 08:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262946AbVG3GEP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jul 2005 02:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262948AbVG3GEP
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jul 2005 02:04:15 -0400
Received: from main.gmane.org ([80.91.229.2]:29904 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262946AbVG3GEO (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jul 2005 02:04:14 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DykS4-0004eS-UC
	for git@vger.kernel.org; Sat, 30 Jul 2005 08:04:04 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jul 2005 08:04:04 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jul 2005 08:04:04 +0200
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

> I do not have preference either way, and I've already merged
> them, but why char[] not char*?

A char* is a variable which points to the char[].
That's four (or eight) bytes we don't need. ;-)

C conflates the two concepts somewhat, which is one of the reasons
optimizing compiled C is somewhat more challenging than, say, FORTRAN.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Giving every man a vote has no more made men wise
and free than Christianity has made them good.
		-- H.L. Mencken
