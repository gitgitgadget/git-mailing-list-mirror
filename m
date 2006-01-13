From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: git pull on Linux/ACPI release tree
Date: Sat, 14 Jan 2006 00:35:01 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2006.01.13.23.34.58.269921@smurf.noris.de>
References: <20060109225143.60520.qmail@web31807.mail.mud.yahoo.com> <Pine.LNX.4.64.0601091845160.5588@g5.osdl.org> <99D82C29-4F19-4DD3-A961-698C3FC0631D@mac.com> <46a038f90601092238r3476556apf948bfe5247da484@mail.gmail.com> <252A408D-0B42-49F3-92BC-B80F94F19F40@mac.com> <Pine.LNX.4.64.0601101015260.4939@g5.osdl.org> <Pine.LNX.4.63.0601101938420.26999@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0601101048440.4939@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 14 00:35:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExYSD-00015D-FT
	for gcvg-git@gmane.org; Sat, 14 Jan 2006 00:35:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423108AbWAMXf3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 18:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423112AbWAMXf3
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 18:35:29 -0500
Received: from main.gmane.org ([80.91.229.2]:48290 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1423108AbWAMXf3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jan 2006 18:35:29 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ExYRr-000115-AS
	for git@vger.kernel.org; Sat, 14 Jan 2006 00:35:11 +0100
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Jan 2006 00:35:11 +0100
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Jan 2006 00:35:11 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14656>

Hi, Linus Torvalds wrote:

> I'm pretty proud of it. It's simple, and it's obvious once you think about 
> it, but it is pretty novel as far as I know. BK certainly had nothing 
> similar, not have I heard of anythign else that does it.

Actually, I've written a hackish script that tries to do simple-minded
bisection (read: it searched for the 50% point on the shortest path
between any-of-GOOD and any-of-BAD, instead of considering the whole
graph) on BK trees. I haven't exactly published the thing anyplace though,
because, well, it was ugly. :-/

Besides, actually working with the current bisection point is no problem
at all for git. Doing the same thing in BK's world view is *painful*,
esp. given the size of the kernel tree.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Arthur felt at a bit of a loss. There was a whole Galaxy
of stuff out there for him, and he wondered if it was
churlish of him to complain to himself that it lacked just
two things: the world he was born on and the woman he loved.
