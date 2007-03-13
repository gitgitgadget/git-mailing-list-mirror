From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: MinGW port updated, now self-hosting again
Date: Tue, 13 Mar 2007 10:59:04 +0100
Organization: eudaptics software gmbh
Message-ID: <45F675E8.2E4B58B4@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 13 11:00:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HR3nc-0003ZU-M5
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 11:00:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753209AbXCMJ7G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 05:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753203AbXCMJ7G
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 05:59:06 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160]:21833 "EHLO
	linz.eudaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753207AbXCMJ7F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 05:59:05 -0400
Received: from eudaptics.com (tethys.linz.eudaptics [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP id 802C954D
	for <git@vger.kernel.org>; Tue, 13 Mar 2007 10:58:59 +0100 (CET)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42112>

I've updated the MinGW port at

pull/clone: git://repo.or.cz/git/mingw.git
gitweb:     http://repo.or.cz/w/git/mingw.git

Thanks to the recent additions of fake symlink support, this version is
now self-hosting on Windows again.

Unfortunately, my time to work on this port is currently very limited.
For this reason, this version is already a week behind Junio's master.
This time I also did not make sure that the test-suite passes.

I also see that Shawn has updated the run_command family of functions to
make them more useful for MinGW. But I fear I won't find time to
integrate this work during this or next week.

-- Hannes
