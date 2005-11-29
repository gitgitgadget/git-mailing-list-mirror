From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] Re: keeping remote repo checked out?
Date: Tue, 29 Nov 2005 14:39:02 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.11.29.13.39.01.958465@smurf.noris.de>
References: <m3k6et9rdw.fsf@lugabout.cloos.reno.nv.us> <7vbr051ad1.fsf@assigned-by-dhcp.cox.net> <20051128105736.GO22159@pasky.or.cz> <7vsltgtvk4.fsf@assigned-by-dhcp.cox.net> <20051128212804.GV22159@pasky.or.cz> <Pine.LNX.4.64.0511281420390.3263@g5.osdl.org> <Pine.LNX.4.64.0511281845280.25300@iabervon.org> <Pine.LNX.4.64.0511281637480.3177@g5.osdl.org> <Pine.LNX.4.64.0511282027360.25300@iabervon.org> <Pine.LNX.4.64.0511281837040.3177@g5.osdl.org> <Pine.LNX.4.64.0511282208050.25300@iabervon.org> <Pine.LNX.4.64.0511282029290.3177@g5.osdl.org> <Pine.LNX.4.64.0511282337170.25300@iabervon.org> <7vmzjom00m.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511290141220.25300@iabervon.org> <7v8xv7lwlr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Nov 29 16:28:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eh6r5-0000q0-D8
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 15:53:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbVK2OxM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 09:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbVK2OxM
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 09:53:12 -0500
Received: from main.gmane.org ([80.91.229.2]:53151 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751374AbVK2OxL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2005 09:53:11 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Eh6MY-0002Tv-U8
	for git@vger.kernel.org; Tue, 29 Nov 2005 15:21:42 +0100
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Nov 2005 15:21:42 +0100
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Nov 2005 15:21:42 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12945>

Hi, Junio C Hamano wrote:

> When everything goes well, the daemon goes to treeP and pulls
> from treeR's master into "deploy", which is checked out.

Why do you need a separate tree for that? -EOVERKILL.
I just use a separate index file for the production tree (and a well-known
name in refs/heads that's associated with it, for which the commit hook
blocks updates).

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Nothing is so important that nothing else is important.
