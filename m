From: Lukas Fleischer <git@cryptocrack.de>
Subject: [PATCH 0/3] Remove ~25 lines of duplicate code
Date: Fri, 12 Apr 2013 19:26:10 +0200
Message-ID: <1365787573-597-1-git-send-email-git@cryptocrack.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 12 19:26:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQhk9-0004WE-VZ
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 19:26:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755504Ab3DLR0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 13:26:17 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:27412 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847Ab3DLR0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 13:26:16 -0400
Received: from localhost (p57B41A7F.dip.t-dialin.net [87.180.26.127])
	by elnino.cryptocrack.de (OpenSMTPD) with ESMTP id c51de830
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128)
	for <git@vger.kernel.org>; Fri, 12 Apr 2013 19:26:14 +0200 (CEST)
X-Mailer: git-send-email 1.8.2.675.gda3bb24.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221003>

Merge read_index_data() and has_cr_in_index() which are almost 1:1
copies of each other.

Lukas Fleischer (3):
  Make read_index_data() public
  Add size parameter to read_index_data()
  convert.c: Remove duplicate code

 attr.c       | 35 +----------------------------------
 cache.h      |  1 +
 convert.c    | 27 ++-------------------------
 read-cache.c | 36 ++++++++++++++++++++++++++++++++++++
 4 files changed, 40 insertions(+), 59 deletions(-)

-- 
1.8.2.675.gda3bb24.dirty
