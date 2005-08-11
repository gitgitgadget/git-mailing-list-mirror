From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] Teach git push .git/branches shorthand
Date: Thu, 11 Aug 2005 18:29:37 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.08.11.16.29.34.384813@smurf.noris.de>
References: <7viryhgdo5.fsf@assigned-by-dhcp.cox.net> <200508081225.59949.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.63.0508081234300.32668@wgmdd8.biozentrum.uni-wuerzburg.de> <200508081822.24582.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Aug 11 18:34:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3Fzj-0005Ea-9O
	for gcvg-git@gmane.org; Thu, 11 Aug 2005 18:33:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbVHKQdI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 12:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbVHKQdI
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 12:33:08 -0400
Received: from main.gmane.org ([80.91.229.2]:5058 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751103AbVHKQdG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Aug 2005 12:33:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1E3Fxb-0004qe-Js
	for git@vger.kernel.org; Thu, 11 Aug 2005 18:31:15 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 Aug 2005 18:31:15 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 Aug 2005 18:31:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Josef Weidendorfer wrote:

> My understanding of .git/branches was that Cogito uses this as mapping of 
> remote branches/heads to local branches/refs, and not to store shortcuts for 
> remote git repositories.

That seems to be the case, yes.

I'd argue that the shortcut idea is inherently more flexible, as it can
emulate mappings, but not vice versa -- for instance, if my local branch
foo corresponds to more than one remote branch, .git/branches/* cannot
comprehend that idea.

That being said, I do like Junio's
>>    $ cat .git/remotes/ko
>>    URL: kernel.org:/pub/scm/git/git.git/
>>    Fetch-Reference: master:ko-master pu:ko-pu rc:ko-rc
>>    Push-Reference: master pu rc
idea. A lot.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Sometimes I think my head is like a gas tank -- you have to be really
careful what you put into it 'cos it might affect the whole system.
-- I'VE HEARD THE MERMAIDS SINGING
