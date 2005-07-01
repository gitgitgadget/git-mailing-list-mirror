From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: "git-send-pack"
Date: Fri, 01 Jul 2005 12:31:53 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.07.01.10.31.53.906759@smurf.noris.de>
References: <Pine.LNX.4.21.0506301403300.30848-100000@iabervon.org> <Pine.LNX.4.58.0506301302410.14331@ppc970.osdl.org> <42C454B2.6090307@zytor.com> <Pine.LNX.4.58.0506301344070.14331@ppc970.osdl.org> <42C462CD.9010909@zytor.com> <Pine.LNX.4.58.0506301432500.14331@ppc970.osdl.org> <42C46B86.8070006@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Fri Jul 01 12:25:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoIhQ-0007pQ-Hi
	for gcvg-git@gmane.org; Fri, 01 Jul 2005 12:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVGAKcQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jul 2005 06:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263303AbVGAKcQ
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jul 2005 06:32:16 -0400
Received: from main.gmane.org ([80.91.229.2]:35216 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261332AbVGAKcM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jul 2005 06:32:12 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DoIh8-0007ni-B9
	for git@vger.kernel.org; Fri, 01 Jul 2005 12:24:26 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Jul 2005 12:24:26 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Jul 2005 12:24:26 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, H. Peter Anvin wrote:

> In the end, it might be that the right thing to do for git on kernel.org 
> is to have a single, unified object store which isn't accessible by 
> anything other than git-specific protocols.

Makes sense.

>  There would have to be some 
> way of dealing with, for example, conflicting tags that apply to 
> different repositories, though.
>
It seems that user-specific subdirectories in refs/heads (and, presumably,
../tags) mostly work already.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Don't lock the barn after it is stolen.
