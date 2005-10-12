From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [RFC] Cleaning up die() error messages
Date: Wed, 12 Oct 2005 03:20:19 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.10.12.01.20.17.917829@smurf.noris.de>
References: <20051010105008.GB30202@gentoo.org> <7vzmph42j2.fsf@assigned-by-dhcp.cox.net> <pan.2005.10.11.19.48.04.675482@smurf.noris.de> <434C2590.3040107@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Wed Oct 12 03:24:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPVKr-0007zv-4z
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 03:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbVJLBXK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 21:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbVJLBXJ
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 21:23:09 -0400
Received: from main.gmane.org ([80.91.229.2]:61407 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932389AbVJLBXI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Oct 2005 21:23:08 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EPVJa-0007lx-NS
	for git@vger.kernel.org; Wed, 12 Oct 2005 03:21:54 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Oct 2005 03:21:54 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Oct 2005 03:21:54 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9996>

H. Peter Anvin wrote:

> The sane way to do this is probably to call an overridable git_die() 
> function, which can be specified by the user to use longjmp(), to use 
> exceptions, or do something else appropriately.
> 
I thought about doing something like that, but ...

> However, a much bigger problem is cleanup.
> 
... exactly.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
BOFH excuse #282:

High altitude condensation from U.S.A.F prototype aircraft has contaminated
the primary subnet mask. Turn off your computer for 9 days to avoid
damaging it.
