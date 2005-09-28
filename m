From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: More Porcelains?
Date: Wed, 28 Sep 2005 22:22:13 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.09.28.20.22.10.626793@smurf.noris.de>
References: <20050926175156.GB9410@reactrix.com> <20050926182341.GA26340@pasky.or.cz> <7v3bnrh85g.fsf@assigned-by-dhcp.cox.net> <20050927001542.GC15615@reactrix.com> <7v64sn8hml.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Wed Sep 28 22:27:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKiVS-0004Jb-1Y
	for gcvg-git@gmane.org; Wed, 28 Sep 2005 22:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbVI1U0E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Sep 2005 16:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbVI1U0E
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Sep 2005 16:26:04 -0400
Received: from main.gmane.org ([80.91.229.2]:64130 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750782AbVI1U0C (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Sep 2005 16:26:02 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EKiTE-0003it-R0
	for git@vger.kernel.org; Wed, 28 Sep 2005 22:24:04 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Sep 2005 22:24:04 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Sep 2005 22:24:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9448>

Hi, Junio C Hamano wrote:

> Matthias Urlichs said he is doing something with Python

Python integration needs either lots of fork+exec, a git rewrite in
Python, or a libgit reorganization in library-ized C.

I'm doing the latter, but my free time is kindof limited for now.

My library-ize branch is at 
	git fetch http://netz.smurf.noris.de/git/git.git libize
if anybody wants to have a look. My first goal is to get object access
working sanely (because that's what I need for my Python project).

I haven't merged up for some time, though.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Paul's Law:
	In America, it's not how much an item costs, it's how much you save.
