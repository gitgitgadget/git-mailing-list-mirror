From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: How is working on arbitrary remote heads supposed to work in Cogito (+ PATCH)?
Date: Fri, 29 Jul 2005 22:40:13 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.07.29.20.40.11.910646@smurf.noris.de>
References: <20050728120806.GA2391@pasky.ji.cz> <Pine.LNX.4.58.0507281504100.25402@wgmdd8.biozentrum.uni-wuerzburg.de> <20050728153506.GL14229@pasky.ji.cz> <Pine.LNX.4.58.0507281747320.29968@wgmdd8.biozentrum.uni-wuerzburg.de> <20050728161815.GC17952@pasky.ji.cz> <7v1x5ic1pe.fsf@assigned-by-dhcp.cox.net> <20050728183904.GA24948@pasky.ji.cz> <7v4qaeqrh3.fsf@assigned-by-dhcp.cox.net> <20050729070628.GA24895@pasky.ji.cz> <7vmzo6jbme.fsf@assigned-by-dhcp.cox.net> <20050729081051.GH24895@pasky.ji.cz> <7vek9igfgw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sat Jul 30 02:03:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyepR-0007NJ-CV
	for gcvg-git@gmane.org; Sat, 30 Jul 2005 02:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262828AbVG3AD0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 20:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbVG3ABT
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 20:01:19 -0400
Received: from main.gmane.org ([80.91.229.2]:47773 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262821AbVG2UnG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 16:43:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Dybfe-0005me-UR
	for git@vger.kernel.org; Fri, 29 Jul 2005 22:41:31 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Jul 2005 22:41:30 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Jul 2005 22:41:30 +0200
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

> Porcelain can keep track of
> mapping between b00:b24 for you,

Exactly.

> but you still need to keep
> track of b00:XYZ and b24:XYZ mapping in your head.

This is why I name my local branch "XYZ". ;-)

XYZ may not be an appropriate name for the remote branch, or maybe the
remote repo is *not* under my direct control, e.g. a shared-master style
setup.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
:munch: vt. [often confused with {mung}, q.v.] To transform information
   in a serial fashion, often requiring large amounts of computation. To
   trace down a data structure. Related to {crunch} and nearly synonymous
   with {grovel}, but connotes less pain.
