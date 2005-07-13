From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: Compilation troubles
Date: Wed, 13 Jul 2005 08:56:55 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.07.13.06.56.52.447219@smurf.noris.de>
References: <B1091462CF5479489B1D8FE818330D2C01371D9F@exchange2003.ad.skymv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Wed Jul 13 08:58:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsbBq-0005Gp-Nr
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 08:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262551AbVGMG5u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 02:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262548AbVGMG5u
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 02:57:50 -0400
Received: from main.gmane.org ([80.91.229.2]:45990 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262551AbVGMG5r (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2005 02:57:47 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DsbBY-0005D2-Bi
	for git@vger.kernel.org; Wed, 13 Jul 2005 08:57:36 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Jul 2005 08:57:36 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Jul 2005 08:57:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Dan Kohn wrote:

> UBUNTU 5.04

You want zlib1g-dev, libssl-dev, asciidoc, xmlto, libcurl3-dev.

I'll prepare a patch to do a simple set of Debian packages (so that "make
debian" works) for git(k)/cogito. I already use them locally, but that
branch is too unclean. :-/

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
The City of Palo Alto, in its official description of parking lot standards,
specifies the grade of wheelchair access ramps in terms of centimeters of
rise per foot of run.  A compromise, I imagine...
