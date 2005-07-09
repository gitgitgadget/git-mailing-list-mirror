From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: Bootstrapping into git, commit gripes at me
Date: Sat, 09 Jul 2005 23:04:37 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.07.09.21.04.29.263374@smurf.noris.de>
References: <20050708230750.GA23847@buici.com> <7v4qb46dff.fsf@assigned-by-dhcp.cox.net> <20050709011119.GA10981@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sat Jul 09 23:05:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrMVv-0003YD-Uw
	for gcvg-git@gmane.org; Sat, 09 Jul 2005 23:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbVGIVFW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jul 2005 17:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVGIVFW
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jul 2005 17:05:22 -0400
Received: from main.gmane.org ([80.91.229.2]:26292 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261729AbVGIVFT (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Jul 2005 17:05:19 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DrMVb-0003Wa-K2
	for git@vger.kernel.org; Sat, 09 Jul 2005 23:05:11 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 09 Jul 2005 23:05:11 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 09 Jul 2005 23:05:11 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Marc Singer wrote:

> Yet, patch does apply. [...]
>   patching file drivers/ide/ide-io.c
>   Hunk #1 succeeded at 96 with fuzz 2 (offset -33 lines).

git-apply cowardly (but sensibly) refuses to apply patches with fuzz
(i.e., ignoring some supplied context lines). 

Fuzz indicates problems.

I'd suggest that you apply the patch to whatever version it is based on...

>  o Is there a way to force git to apply and safe the rejects?

Well, you can use "patch -p1 ..." directly, and manually add the files it
created to the object cache. Personally I wouldn't, if at all possible.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
I couldn't remember things until I took that Sam Carnegie course.
		-- Bill Peterson, former Houston Oiler football coach
