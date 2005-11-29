From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: ARCH: Failure to import visdn archive
Date: Tue, 29 Nov 2005 14:35:19 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.11.29.13.35.16.755560@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Nov 29 16:09:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eh6ic-0005EW-B6
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 15:44:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbVK2OoN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 09:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbVK2OoN
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 09:44:13 -0500
Received: from main.gmane.org ([80.91.229.2]:38292 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751364AbVK2OoM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2005 09:44:12 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Eh6EI-0006w2-KZ
	for git@vger.kernel.org; Tue, 29 Nov 2005 15:13:12 +0100
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Nov 2005 15:13:10 +0100
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Nov 2005 15:13:10 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12943>

Bug in arch-import, or in the arch repository?

$ tla archives
daniele@orlandi.com--2005
    http://repo.visdn.org/archives/daniele@orlandi.com--2005

$ /usr/bin/git-archimport -v daniele@orlandi.com--2005/isdn--devel--0.1
[...]
 * Starting to work on daniele@orlandi.com--2005/isdn--devel--0.1--patch-4
patching file lapd/af_lapd.c
patching file lapd/tei_mgmt_nt.h
patching file lapd/tei_mgmt_te.h
can't find file to patch at input line 3 Perhaps you used the wrong -p or
--strip option? The text leading up to this was:
--------------------------
|--- orig/lapd/tei_mgmt.c
|+++ mod/lapd/tei_mgmt.c
--------------------------
File to patch: ^C

$ ls lapd/
af_lapd.c   lapd.h        lapd_user.h  tei_mgmt_nt.c  tei_mgmt_te.h
FEATURES    lapd_inout.c  Makefile     tei_mgmt_nt.h  TODO lapd_dev.c 
lapd_proto.h  tei_mgmt.h   tei_mgmt_te.c  vihai_isdn.h

NB: I hacked the script to use system() instead of backticks, so that
stdout doesn't get thrown away and people can actually see what breaks. :-/

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
"The worst criminals are not half so immoral as the creators and
 perpetrators of the unquestionable hell of Christian theology"
      [M.M. Mangasarian  _Morality Without God_, 1913]
