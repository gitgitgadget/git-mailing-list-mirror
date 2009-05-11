From: Don Slutz <Don.Slutz@SierraAtlantic.com>
Subject: [PATCH 0/6] Add core.autocrlf=true on cygwin by default during tests
Date: Mon, 11 May 2009 15:28:55 -0400
Message-ID: <1242070141-2936-1-git-send-email-Don.Slutz@SierraAtlantic.com>
Cc: Don Slutz <Don.Slutz@SierraAtlantic.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 21:30:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3bCE-0007Nk-Oh
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 21:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756616AbZEKT3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 15:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755347AbZEKT3J
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 15:29:09 -0400
Received: from krl.krl.com ([192.147.32.3]:46834 "EHLO krl.krl.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751845AbZEKT3I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 15:29:08 -0400
Received: from krl.krl.com (localhost [127.0.0.1])
	by krl.krl.com (8.13.1/8.13.1) with ESMTP id n4BJT7T2002982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 11 May 2009 15:29:07 -0400
Received: (from slutz@localhost)
	by krl.krl.com (8.13.1/8.13.1/Submit) id n4BJT55d002981;
	Mon, 11 May 2009 15:29:05 -0400
X-Mailer: git-send-email 1.6.3.15.g49878
X-Virus-Scanned: ClamAV version 0.94.2, clamav-milter version 0.94.2 on krl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118830>

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
