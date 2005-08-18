From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: Git 1.0 Synopis (Draft v4)
Date: Thu, 18 Aug 2005 11:27:44 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.08.18.09.27.42.884179@smurf.noris.de>
References: <junkio@cox.net> <200508161941.j7GJfpI3023107@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Aug 18 11:31:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5gis-0002ip-6R
	for gcvg-git@gmane.org; Thu, 18 Aug 2005 11:30:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbVHRJ3y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 05:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbVHRJ3y
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 05:29:54 -0400
Received: from main.gmane.org ([80.91.229.2]:43752 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932142AbVHRJ3y (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Aug 2005 05:29:54 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1E5ghD-00020U-Ls
	for git@vger.kernel.org; Thu, 18 Aug 2005 11:28:23 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Aug 2005 11:28:23 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Aug 2005 11:28:23 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Horst von Brand wrote:

> And teach make(1) about checking out files from git... or just create a
> co(1) command for git.

Ummm... why?

make's SCCS support depends on the presence of a SCCS/s.<name> file
for each <name>. We don't have that. Teaching make about git would be
equivalent to teaching it about parsing the index file.

Technically, that would require a stable libgit.so or so.
In reality, however, I don't know when I last had a tree which wasn't
fully populated, but it's been a while, and it's something that can be
readily fixed by "git-checkout-cache -a".

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
One possible reason that things aren't going according to plan
is that there never was a plan in the first place.
