From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: Some more cvsimport
Date: Sat, 11 Mar 2006 07:34:26 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2006.03.11.06.34.26.200002@smurf.noris.de>
References: <440E9AA8.2020605@asianetindia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sat Mar 11 07:41:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHxnB-00009M-Vh
	for gcvg-git@gmane.org; Sat, 11 Mar 2006 07:41:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWCKGlX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Mar 2006 01:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWCKGlX
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Mar 2006 01:41:23 -0500
Received: from main.gmane.org ([80.91.229.2]:14233 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751303AbWCKGlW (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Mar 2006 01:41:22 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FHxmu-00007Y-P7
	for git@vger.kernel.org; Sat, 11 Mar 2006 07:41:16 +0100
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 11 Mar 2006 07:41:16 +0100
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 11 Mar 2006 07:41:16 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17493>

Hi, Rajkumar S wrote:

> When I normally do cvsimport, the releng_1
> tree gets updated automatically, but if I have checked out the releng_1
> branch in my local git repository when cvsimport happens the files do not
> get updated.

Don't Do That.

I just removed the "update checked-out tree" logic because it has too many
corner cases.

I could conceivably add a check for HEAD pointing to the CVS branch I'm
just checking out, but on second thought I'd rather wait for the
refs/remotes/ work to show up, and then simply s/heads/remotes/g. ;-)

-- 
Matthias Urlichs
