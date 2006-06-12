From: David Kowis <dkowis@shlrm.org>
Subject: Thoughts on adding another hook to git
Date: Mon, 12 Jun 2006 13:27:13 -0500
Message-ID: <448DB201.5090208@shlrm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jun 12 20:27:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fpr8E-0007ZW-FX
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 20:27:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWFLS1T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 14:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbWFLS1T
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 14:27:19 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:34280 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP
	id S1751215AbWFLS1S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 14:27:18 -0400
Received: from pimout5-ext.prodigy.net (pimout5-int.prodigy.net [207.115.4.21])
	by ylpvm01.prodigy.net (8.13.6 out spool5000 dk/8.12.10) with ESMTP id k5CIRBaa016562
	for <git@vger.kernel.org>; Mon, 12 Jun 2006 14:27:11 -0400
X-ORBL: [66.143.247.87]
Received: from mail.shlrm.org (adsl-66-143-247-87.dsl.snantx.swbell.net [66.143.247.87])
	by pimout5-ext.prodigy.net (8.13.6 out.dk/8.13.6) with ESMTP id k5CIRD4T172960
	for <git@vger.kernel.org>; Mon, 12 Jun 2006 14:27:14 -0400
Received: from [192.168.2.111] (rrcs-24-173-63-133.sw.biz.rr.com [24.173.63.133])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.shlrm.org (Postfix) with ESMTP id 9142028034B0
	for <git@vger.kernel.org>; Mon, 12 Jun 2006 13:27:13 -0500 (CDT)
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
To: git@vger.kernel.org
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21722>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

I'd like to be able to modify the commit message before it ends up in
the $EDITOR. This is a fairly trivial thing to implement:
Call ${GIT_DIR}/hooks/pre-editor on COMMIT_MESSAGE before opening it in
$EDITOR.

My question to you all is should I set it up so that the hook only opens
when the $EDITOR is actually being called? (really easy)
Or, do I set it up so that the hook always happens. In which case it's
similar to the commit-msg hook already, just happens before the message
instead of after.

Thanks,
- --
David Kowis

ISO Team Lead - www.sourcemage.org
Source Mage GNU/Linux

Progress isn't made by early risers. It's made by lazy men trying to
find easier ways to do something.
  - Robert Heinlein
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)

iQGVAwUBRI2yAMnf+vRw63ObAQpNSgv+OCXYSDlW96K9M5QZvSaEbdZOGorYZg5Y
RSh9WUXS2ribYRr1TbplD0Fp4vGnG8CB6qvr2QF8vP3tbEMjnwk4LobeWaUtK2Kn
Hja3TgIUPWkzHMLleToe5o99r8v/6LFf9rkBxvFw3TMkuxsFS/lFlxy1eRa43rvd
Skod2cA7RWus1IFJcbDKNonjhJkVkHylSMjT8iVQDbgY0hg7PEy2ZW3XB0MJJRZC
lLsDDIJ4msPCXSx/lDRGaJj+m7IrvUgnEDzkX0jTT8DeZqnlC8nRM/2dOS72b/5w
gIBYu49DvTL8ynod2mmYTyBynfRpVxPjxnXbubn/M+N+0WCTXIUTPCbyW2MOscjA
pFe6/S1qKaTqc06VBDabYxdvGrHG6v+KkaJhu2XoLOHWVoBblobBBNrpIkA6GNqz
H7JHNJDF+JbshlW2aU2HazDINRfD/AfrJmDx4Xn91qAKiegyO3wRA1rM6a0LEpun
zg3haF3l0rfBEdFpz21gNQbYxNHaRkwg
=Rxm/
-----END PGP SIGNATURE-----
