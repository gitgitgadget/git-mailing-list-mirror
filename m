From: Don Slutz <slutz@krl.com>
Subject: (unknown)
Date: Mon, 11 May 2009 14:57:12 -0400
Message-ID: <200905111857.n4BIvC7E002313@krl.krl.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 21:25:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3b7x-0005Ox-Eb
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 21:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756085AbZEKTZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 15:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756257AbZEKTZQ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 15:25:16 -0400
Received: from krl.krl.com ([192.147.32.3]:42939 "EHLO krl.krl.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758069AbZEKTZP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 15:25:15 -0400
X-Greylist: delayed 1681 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 May 2009 15:25:15 EDT
Received: from krl.krl.com (localhost [127.0.0.1])
	by krl.krl.com (8.13.1/8.13.1) with ESMTP id n4BIvDUJ002334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 11 May 2009 14:57:13 -0400
Received: (from slutz@localhost)
	by krl.krl.com (8.13.1/8.13.1/Submit) id n4BIvC7E002313
	for git@vger.kernel.org; Mon, 11 May 2009 14:57:12 -0400
X-Virus-Scanned: ClamAV version 0.94.2, clamav-milter version 0.94.2 on krl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118821>

From: Don Slutz <Don.Slutz@SierraAtlantic.com>
Date: Fri, 1 May 2009 15:32:18 -0400
Subject: [PATCH 0/6] Add core.autocrlf=true on cygwin by default during tests

This is a patch set to do the work from mail message:

http://kerneltrap.org/mailarchive/git/2007/8/7/254415

It is split into 6 parts.  This is because the tests do not work on
Linux if autocrlf=true.

1) The change to autocrlf=true by default for cygwin

2) Changes to t/test-lib.sh

3) The simple changes to tests to use the new functions.

4) Force core.autocrlf=false tests

5) The changes that switch from using cmp to using test_cmp.

6) Add 'make test-text' to use these changes
