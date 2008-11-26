From: neale@lanl.gov (Neale T. Pickett)
Subject: git configure script
Date: 26 Nov 2008 12:30:08 -0700
Message-ID: <njx4p1ub7zz.fsf@cfl-sunray1.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 26 21:11:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5QjZ-00061y-K8
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 21:11:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408AbYKZUKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 15:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752301AbYKZUKQ
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 15:10:16 -0500
Received: from proofpoint3.lanl.gov ([204.121.3.28]:59661 "EHLO
	proofpoint3.lanl.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092AbYKZUKP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 15:10:15 -0500
X-Greylist: delayed 2404 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Nov 2008 15:10:15 EST
Received: from mailrelay1.lanl.gov (mailrelay1.lanl.gov [128.165.4.101])
	by proofpoint3.lanl.gov (8.13.8/8.13.8) with ESMTP id mAQJUBf9030424
	for <git@vger.kernel.org>; Wed, 26 Nov 2008 12:30:11 -0700
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailrelay1.lanl.gov (Postfix) with ESMTP id 32B1E341158
	for <git@vger.kernel.org>; Wed, 26 Nov 2008 12:30:11 -0700 (MST)
X-NIE-2-Virus-Scanner: amavisd-new at mailrelay1.lanl.gov
Received: from ccn-mail.lanl.gov (ccn-mail.lanl.gov [128.165.4.105])
	by mailrelay1.lanl.gov (Postfix) with ESMTP id 1C1B5340CDE
	for <git@vger.kernel.org>; Wed, 26 Nov 2008 12:30:11 -0700 (MST)
Received: from cfl-sunray1.lanl.gov (cfl-sunray1.lanl.gov [128.165.5.23])
	by ccn-mail.lanl.gov (Postfix) with ESMTP id 511271D0005
	for <git@vger.kernel.org>; Wed, 26 Nov 2008 12:30:08 -0700 (MST)
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
X-NIE-2-MailScanner-Information: Please see http://network.lanl.gov/email/virus-scan.php
X-NIE-2-MailScanner: Found to be clean
X-NIE-2-MailScanner-From: neale@lanl.gov
X-Spam-Status: No
X-Proofpoint-Virus-Version: vendor=fsecure engine=4.65.7400:2.4.4,1.2.40,4.0.164 definitions=2008-11-26_12:2008-11-24,2008-11-26,2008-11-26 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101763>

I downloaded 1.6.0.4 from
http://kernel.org/pub/software/scm/git/git-1.6.0.4.tar.gz 
and ran

  ./configure --prefix=$HOME/opt

But it installed everything in $HOME/bin and $HOME/libexec.  Looking
into it, it seems the shipped Makefile doesn't look to see what --prefix
is, despite the configure script claiming that "make install" would
honor this.

I'm guessing it should have shipped with a Makefile.in or something, but
honestly Autoconf confuses the dickens out of me.

Neale
