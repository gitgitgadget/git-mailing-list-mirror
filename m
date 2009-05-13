From: Don Slutz <Don.Slutz@SierraAtlantic.com>
Subject: [PATCH v2 0/7] Add GIT_TEST_AUTO_CRLF environment variable to set core.autocrlf on init
Date: Wed, 13 May 2009 15:35:41 -0400
Message-ID: <1242243348-6690-1-git-send-email-Don.Slutz@SierraAtlantic.com>
References: <1242070141-2936-1-git-send-email-Don.Slutz@SierraAtlantic.com>
Cc: Don Slutz <Don.Slutz@SierraAtlantic.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 21:36:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4KFc-0005kd-71
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 21:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753997AbZEMTgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 15:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752509AbZEMTgH
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 15:36:07 -0400
Received: from krl.krl.com ([192.147.32.3]:59277 "EHLO krl.krl.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752365AbZEMTgF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 15:36:05 -0400
Received: from krl.krl.com (localhost [127.0.0.1])
	by krl.krl.com (8.13.1/8.13.1) with ESMTP id n4DJZxFx006777
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 May 2009 15:36:00 -0400
Received: (from slutz@localhost)
	by krl.krl.com (8.13.1/8.13.1/Submit) id n4DJZx06006776;
	Wed, 13 May 2009 15:35:59 -0400
X-Mailer: git-send-email 1.6.3.15.g49878
In-Reply-To: <1242070141-2936-1-git-send-email-Don.Slutz@SierraAtlantic.com>
X-Virus-Scanned: ClamAV version 0.94.2, clamav-milter version 0.94.2 on krl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119098>

This is v2 of [PATCH 0/6] Add core.autocrlf=true on cygwin by default during tests

Changes: 

Changed #1 to no longer default to true for CYGWIN.

Modified t7610-mergetool.sh in #3 to correctly change core.autocrlf mode
and add test for the right thing in core.autocrlf=false

New patch #6 -- switch to using cmp instead of test_cmp for test that are
                checking autocrlf does the right thing.
