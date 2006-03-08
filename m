From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: git-svn, tree moves, and --no-stop-on-copy
Date: Wed, 08 Mar 2006 18:02:05 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2006.03.08.17.02.04.503230@smurf.noris.de>
References: <20060307220837.GB27397@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Wed Mar 08 18:25:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FH2NA-0001wW-0v
	for gcvg-git@gmane.org; Wed, 08 Mar 2006 18:22:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbWCHRWs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Mar 2006 12:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbWCHRWs
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Mar 2006 12:22:48 -0500
Received: from main.gmane.org ([80.91.229.2]:33208 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964777AbWCHRWs (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Mar 2006 12:22:48 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FH2Dw-0006kR-Pk
	for git@vger.kernel.org; Wed, 08 Mar 2006 18:13:21 +0100
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Mar 2006 18:13:20 +0100
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Mar 2006 18:13:20 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17377>

Hi, Yann Dirson wrote:

> "svn switch --relocate" does not seem to be of any help.  Switching
> manually .git/git-svn/tree/ to the new repository location does not
> help either, since I must obviously update to r166 in that case, and
> then a further "git-svn fetch" fails because it does not find
> .git/git-svn/revs/166 aleady imported.
> 
> Any idea as to how to get the work done ?

You can manually edit the .git/corr file. Simply add an entry for #166
that has your reorganized (if necessary) head's SHA1.
-- 
Matthias Urlichs
