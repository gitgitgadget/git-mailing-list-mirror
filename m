From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: gitk with hyperspace support
Date: Wed, 17 Aug 2005 16:37:33 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.08.17.14.37.30.131036@smurf.noris.de>
References: <17154.33520.584666.701545@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Wed Aug 17 16:44:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5P7e-0003FG-6p
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 16:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbVHQOm1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 10:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbVHQOm1
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 10:42:27 -0400
Received: from main.gmane.org ([80.91.229.2]:62918 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751111AbVHQOm1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Aug 2005 10:42:27 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1E5P59-0002Z6-9C
	for git@vger.kernel.org; Wed, 17 Aug 2005 16:39:55 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Aug 2005 16:39:55 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Aug 2005 16:39:55 +0200
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

> http://ozlabs.org/~paulus/gitk/gitk.hs
> 
Unfortunately, this fails on my git-plus-assorted-crap archive:

can't read "mainlinearrow(c1a9ddb1e9f30029384bd687d90af5796a280283)": no such element in array
can't read "mainlinearrow(c1a9ddb1e9f30029384bd687d90af5796a280283)": no such element in array
    while executing
"if {$mainlinearrow($id) ne "none"} {
	    set mainline($id) [trimdiagstart $mainline($id)]
	}"
    (procedure "drawcommitline" line 44)
    invoked from within
"drawcommitline $dlevel"
    (procedure "drawmore" line 65)
    invoked from within
"drawmore 1"
    (procedure "drawcommit" line 33)
    invoked from within
"drawcommit $id"
    (procedure "getcommitlines" line 50)
    invoked from within
"getcommitlines file23"


Another problem: when I click on a line, I get the parent and *all* its
children, not just the child(ren) on the other end of the segment I was
clicking on.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
There are some micro-organisms that exhibit characteristics of both plants
and animals.  When exposed to light they undergo photosynthesis; and when
the lights go out, they turn into animals.  But then again, don't we all?
