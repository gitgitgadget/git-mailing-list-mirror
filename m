From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [BUG] git-svnimport doesn't import actual code
Date: Thu, 17 Nov 2005 18:05:23 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.11.17.17.05.21.780279@smurf.noris.de>
References: <20051117160645.GA26871@lumumba.uhasselt.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Nov 17 18:17:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcnIj-0002wR-Dz
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 18:11:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbVKQRLx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 12:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbVKQRLx
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 12:11:53 -0500
Received: from main.gmane.org ([80.91.229.2]:28835 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932404AbVKQRLx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2005 12:11:53 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EcnEA-00016i-FG
	for git@vger.kernel.org; Thu, 17 Nov 2005 18:07:14 +0100
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Nov 2005 18:07:13 +0100
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Nov 2005 18:07:13 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12135>

Hi, Panagiotis Issaris wrote:

> git-svnimport -v svn://svn.berlios.de/rtnet/trunk

That's easy -- you can't svn-pull the trunk that way.
(Note that you got a lot of "skipped" messages...)

Just drop the "trunk", add a "-b branches" if that repository
needs it, and svnimport will handle it.

ASIDE: All the repositories in my import list need that flag, so I am
considering changing the default name from "branch" to "branches".
Objections, anybody?

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
It is impossible to travel faster than light, and certainly not desirable,
as one's hat keeps blowing off.
		-- Woody Allen
