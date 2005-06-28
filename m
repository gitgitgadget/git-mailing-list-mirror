From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: GIT-CVS sync script
Date: Tue, 28 Jun 2005 21:33:43 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.06.28.19.33.40.876796@smurf.noris.de>
References: <20050628191445.GA27979@lumumba.uhasselt.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Jun 28 21:35:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnLqY-0008A4-6h
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 21:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVF1TlC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 15:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVF1Tky
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 15:40:54 -0400
Received: from main.gmane.org ([80.91.229.2]:1988 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261232AbVF1Tjf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2005 15:39:35 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DnLlf-0006Ng-Hh
	for git@vger.kernel.org; Tue, 28 Jun 2005 21:29:11 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Jun 2005 21:29:11 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Jun 2005 21:29:11 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Panagiotis Issaris wrote:

> I find the included script useful to easily track a CVS repository in
> GIT. You can both call it for the initial import and ofcourse for the
> subsequent resynchronisation with the parent CVS repository (that's what
> the script's about).
> 
Hmm, my Perl script (just posted...) should do the same thing without
depending on .git* files which may or may not still exist when you do an
incremental import half a year later.

Can you test whether that script works for you?

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
I may not be totally perfect, but parts of me are excellent.
		-- Ashleigh Brilliant
