From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: pushing patches to an imap folder
Date: Thu, 17 Nov 2005 00:49:49 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.11.16.23.49.48.613211@smurf.noris.de>
References: <43799A67.9030705@codeweavers.com> <7vd5l2qnq6.fsf@assigned-by-dhcp.cox.net> <4379B9F6.5020402@codeweavers.com> <Pine.LNX.4.63.0511151227300.21902@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Nov 17 00:55:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcX5x-0005wC-Jv
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 00:53:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030578AbVKPXxi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 18:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030579AbVKPXxi
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 18:53:38 -0500
Received: from main.gmane.org ([80.91.229.2]:50828 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030578AbVKPXxh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2005 18:53:37 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EcX3Z-0004k3-4B
	for git@vger.kernel.org; Thu, 17 Nov 2005 00:51:13 +0100
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Nov 2005 00:51:13 +0100
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Nov 2005 00:51:13 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12075>

Hi, Johannes Schindelin wrote:

> It would be cool to have something like git-cvs-daemon, which simulates a 
> CVS server.

read-only would not be that difficult. You'd have to cache CVS version
numbers for individual files and decide on a branch ordering, but those
are basically non-problems.

Don't even *think* about committing.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Conscience is what hurts when everything else feels so good.
