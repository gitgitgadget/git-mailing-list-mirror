From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: [ANNOUNCE] GIT MinGW port is now at v1.5.3-rc4
Date: Thu, 16 Aug 2007 11:43:37 +0200
Organization: eudaptics software gmbh
Message-ID: <46C41C49.A92AEF07@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 16 11:43:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILbsu-00068J-Ji
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 11:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653AbXHPJm5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 05:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754484AbXHPJm4
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 05:42:56 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:51551 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753917AbXHPJm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 05:42:56 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <J.Sixt@eudaptics.com>)
	id 1ILbsU-00010r-PG
	for git@vger.kernel.org; Thu, 16 Aug 2007 11:42:55 +0200
Received: from eudaptics.com (unknown [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP id 5AA4EFCD1
	for <git@vger.kernel.org>; Thu, 16 Aug 2007 11:42:54 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 1.3 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, AWL=-0.395, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55999>

I've just pushed an update of the MinGW port to:

clone:  git://repo.or.cz/git/mingw.git
gitweb: http://repo.or.cz/w/git/mingw.git

This passes the test suite, but I still haven't used it in production.

There are two additional changes that are of interest for the msysgit
effort:

- The test scripts no longer accept --no-symlinks becaust test-lib.sh
auto-detects whether the file system supports symbolic links.

- The devel branch no longer patches out libiconv, which is now required
in the shipped configuration (the one from
http://gnuwin32.sourceforge.net/packages/libiconv.htm, which requires
the OLD_ICONV setting in the Makefile).

-- Hannes
