From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: Switching between branches
Date: Fri, 22 Apr 2005 00:12:49 +1000
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.04.21.14.12.46.905838@smurf.noris.de>
References: <1114047759.20044.22.camel@dv> <20050421073123.GD31910@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Apr 21 16:11:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOcOP-0007Cf-Rk
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 16:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVDUOPH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 10:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbVDUOPH
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 10:15:07 -0400
Received: from main.gmane.org ([80.91.229.2]:39303 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261371AbVDUOPB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 10:15:01 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DOcMH-0006oR-Dw
	for git@vger.kernel.org; Thu, 21 Apr 2005 16:08:45 +0200
Received: from 150.203.247.5 ([150.203.247.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Apr 2005 16:08:45 +0200
Received: from smurf by 150.203.247.5 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Apr 2005 16:08:45 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 150.203.247.5
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Petr Baudis wrote:

> Hello,
> 
>> Perhaps it's a naive question, but how do I switch between branches?  I
>> mean an equivalent of "svn switch" or "cvs update -r branch" that would
>> reuse the existing working directory.
> 
> you can't. There was 'git update' (and intermediate never-committed 'git
> switch'), but I decided not to support it for now, since I don't have any
> compelling usage case for it.

I do -- I have a project which builds several slightly-customized versions,
and I'd like to keep the generated objects around if possible.

So I just build one version, then "git cancel FOO" to the next version,
and let the make rules take care of rebuilding what needs to be rebuilt.

("cancel" already does most of the job anyway, i.e. cleanup stuff which
the build process might have changed that it shouldn't have.)

Cf. the last of the patches I've just mailed to the list.
-- 
Matthias Urlichs

