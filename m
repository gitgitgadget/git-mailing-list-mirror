From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] Adapt tutorial to cygwin and add test case
Date: Wed, 12 Oct 2005 03:27:26 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.10.12.01.27.25.688169@smurf.noris.de>
References: <Pine.LNX.4.63.0510111333160.27109@wbgn013.biozentrum.uni-wuerzburg.de> <7vu0fnsu6f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Wed Oct 12 03:29:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPVPU-0000Sn-A4
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 03:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbVJLB15 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 21:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbVJLB15
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 21:27:57 -0400
Received: from main.gmane.org ([80.91.229.2]:226 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750746AbVJLB15 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Oct 2005 21:27:57 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EPVP7-0000Ir-RP
	for git@vger.kernel.org; Wed, 12 Oct 2005 03:27:37 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Oct 2005 03:27:37 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Oct 2005 03:27:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9998>

Hi, Junio C Hamano wrote:

> The Kosher way would be
> 
>     tree=$(git-write-tree)
>     commit=$(echo 'Initial commit' | git-commit-tree $tree)
>     git-update-ref HEAD $(commit)
> 
> but looks quite intimidating as a tutorial material.

... which is probably why there's a "git commit" command these days.

Those three commands may be The Works, but they also expose exactly what
git does behind the scenes, and thus explains reasonably well what you'd
need to think about if you want to do something that's not just a simple
commit.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
The Killer Ducks are coming!!!
