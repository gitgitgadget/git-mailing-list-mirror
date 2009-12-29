From: Peter Vereshagin <peter@vereshagin.org>
Subject: signing tags: user.name assumed to be gpg uid?
Date: Wed, 30 Dec 2009 00:36:37 +0400
Organization: '
Message-ID: <20091229203637.GA3036@screwed.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 21:47:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPiyI-00008K-Nj
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 21:47:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbZL2UrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 15:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbZL2UrF
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 15:47:05 -0500
Received: from ns1.skyriver.ru ([89.108.82.27]:50221 "EHLO mx1.skyriver.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751375AbZL2UrE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 15:47:04 -0500
X-Greylist: delayed 591 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Dec 2009 15:47:04 EST
Received: from localhost (unknown [216.224.124.124])
	by mx1.skyriver.ru (Postfix) with ESMTPSA id 2C4575AB7
	for <git@vger.kernel.org>; Tue, 29 Dec 2009 23:31:08 +0300 (MSK)
Content-Disposition: inline
X-Face: 8T>{1owI$Byj]]a;^G]kRf*dkq>E-3':F>4ODP[#X4s"dr?^b&2G@'3lukno]A1wvJ_L (~u 6>I2ra/<,j1%@C[LN=>p#_}RIV+#:KTszp-X$bQOj,K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135819>

Como esta, git?

I notice that after I init and config user.name and user.email the user.comment gets taken from ~/.gpg automatically. Is it a correct behaviour?
And, when I try
git tag v0.1 -s
I get :
===
gpg: skipped "Peter Vereshagin <peter@vereshagin.org>": secret key not available
===
and this is because I need to config user.name with the gpg comment: when I 
===
git config --global user.name "Peter Vereshagin (http://vereshagin.org)"
===
the git tag signs well. But is it a correct behaviour to need the comment as a user's name? On key editing the gpg makes difference between (N)ame and (C)omment by far.

73! Peter pgp: A0E26627 (4A42 6841 2871 5EA7 52AB  12F8 0CE1 4AAC A0E2 6627)
-- 
http://vereshagin.org
