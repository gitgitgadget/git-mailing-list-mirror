From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: MinGW port now with core.autocrlf
Date: Thu, 01 Mar 2007 11:33:32 +0100
Organization: eudaptics software gmbh
Message-ID: <45E6ABFC.69962750@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 11:31:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMiZH-0005Vo-DM
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 11:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbXCAKbO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 05:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964919AbXCAKbO
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 05:31:14 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160]:20606 "EHLO
	linz.eudaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964916AbXCAKbN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 05:31:13 -0500
Received: from eudaptics.com (tethys.linz.eudaptics [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP id A5CAEB581
	for <git@vger.kernel.org>; Thu,  1 Mar 2007 11:31:10 +0100 (CET)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41077>

Here's another cut of the MinGW port, based on master (c260d790c8),
which is now obviously en route to 1.5.1.

pull/clone: git://repo.or.cz/git/mingw.git
gitweb:     http://repo.or.cz/w/git/mingw.git

News:
- core.autocrlf (automatic CRLF<->LF conversion upon checkout and
commit); this flag must still be turned on manually per repository.

- Fixed that incomplete data was sent to the automatically invoked pager
(fflush(stdout) was missing; embarrassing).

- Perl scripts, like git-remote, now work.


-- Hannes
