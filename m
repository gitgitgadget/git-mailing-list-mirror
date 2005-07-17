From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: "git cvsimport" with branches?
Date: Sun, 17 Jul 2005 11:37:59 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.07.17.09.37.58.463540@smurf.noris.de>
References: <20050717084053.94D603525D1@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sun Jul 17 11:39:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Du5cD-0008Kb-4r
	for gcvg-git@gmane.org; Sun, 17 Jul 2005 11:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVGQJjB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jul 2005 05:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVGQJjB
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jul 2005 05:39:01 -0400
Received: from main.gmane.org ([80.91.229.2]:13717 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261239AbVGQJil (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jul 2005 05:38:41 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Du5bU-0008Gg-Qb
	for git@vger.kernel.org; Sun, 17 Jul 2005 11:38:32 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 17 Jul 2005 11:38:32 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 17 Jul 2005 11:38:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Wolfgang Denk wrote:

> Is there a way to make "git cvsimport" create branches in git for any
> branches it encounters in the CVS repository?
> 
That's what it does.

> All my imports so far show just a linear line of development, and CVS
> branch information seems lost.

Umm, exactly what did you do to visualize that? "gitk origin" obvioously
shows only one branch, because CVS doesn't have merge infe. Use
"gitk $(cat .git/revs/heads/*)" to show everything.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
"Any body of men who believe in hell will
 persecute whenever they have the power."
  [Joseph McCabe, "What Gods Cost Men"]
