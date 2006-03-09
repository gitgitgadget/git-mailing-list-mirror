From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: "fatal: protocol error: bad line length character": ??
Date: Thu, 09 Mar 2006 16:15:43 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2006.03.09.15.15.42.109356@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Mar 09 16:28:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHN1G-0002wz-Gq
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 16:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbWCIPZX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 10:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbWCIPZW
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 10:25:22 -0500
Received: from main.gmane.org ([80.91.229.2]:3787 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751990AbWCIPZV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Mar 2006 10:25:21 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FHMzP-0002JJ-Ge
	for git@vger.kernel.org; Thu, 09 Mar 2006 16:23:43 +0100
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Mar 2006 16:23:43 +0100
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Mar 2006 16:23:43 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17418>

Anybody seen this? The problem is benign, but ...

$ git push HOST master
updating 'refs/heads/master'
  from f18c5d41ede0c4179d6821d2cc7ef7feaaca2f99
  to   d9205cd53bb97febbff8b43cbc93e60f735e32dd
Generating pack...
Done counting 5 objects.
Deltifying 5 objects.
 100% (5/5) done
Total 5, written 5 (delta 0), reused 0 (delta 0)
Unpacking 5 objects
fatal: protocol error: bad line length character
refs/heads/master: f18c5d41ede0c4179d6821d2cc7ef7feaaca2f99 -> d9205cd53bb97febbff8b43cbc93e60f735e32dd
$ git push HOST master
Everything up-to-date
$
