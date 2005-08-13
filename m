From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: gitweb - feature request
Date: Sat, 13 Aug 2005 06:13:19 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.08.13.04.13.18.159941@smurf.noris.de>
References: <20050809193104.GA10858@mars.ravnborg.org> <20050809195818.GA19284@vrfy.org> <1123653220.1183.26.camel@azathoth.hellion.org.uk> <20050810083113.GN49964@gaz.sfgoth.com> <20050812203322.GB9696@vrfy.org> <20050812211600.GA61428@gaz.sfgoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sat Aug 13 06:15:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3nQC-0007Go-0E
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 06:15:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbVHMEOx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 00:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbVHMEOx
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 00:14:53 -0400
Received: from main.gmane.org ([80.91.229.2]:56268 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751045AbVHMEOx (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2005 00:14:53 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1E3nP1-0007D8-Pn
	for git@vger.kernel.org; Sat, 13 Aug 2005 06:13:47 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 13 Aug 2005 06:13:47 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 13 Aug 2005 06:13:47 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Mitchell Blank Jr wrote:

> Is it really hard to just make it purely time-based (git-rev-list
> --max-age)? Think of if Linus is merging with a lot of people and then
> pushes the results to the master repository -- suddenly there's, say,
> 400 new commits since the last time my aggregator checked 2 hours ago.

Think of Linus merging a bunch of trees with 1-month old commits, all of
which you'd miss that way.

IMHO, you definitely need a static file for RSS -- do a git-rev-list
between HEAD and HEAD-as-of-the-last-time-you-generated-the-RSS,
concatenate with the old RSS, then trim appropriately.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
You judge the acts of others only by their intentions.
