From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/7] A few gitweb cleanups and improvements
Date: Thu, 17 Aug 2006 11:21:21 +0200
Message-ID: <11558064883957-git-send-email-jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 17 11:21:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDe4J-00029F-8P
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 11:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbWHQJVf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 05:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbWHQJVf
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 05:21:35 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:16520 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S932417AbWHQJVe (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Aug 2006 05:21:34 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k7H9KPBV023240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 17 Aug 2006 11:20:25 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k7H9LSrH003683
	for <git@vger.kernel.org>; Thu, 17 Aug 2006 11:21:28 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k7H9LS81003682
	for git@vger.kernel.org; Thu, 17 Aug 2006 11:21:28 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25565>


A few gitweb cleanups, refactoring, and improvements.
Based on 'master', 1c2a4f5addce479c619057c6cdc841802139982f
First patch in series was sent earlier.

 gitweb/gitweb.perl |   80 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 74 insertions(+), 6 deletions(-)

Jakub Narebski:
      gitweb: Add support for per project git URLs
      gitweb: Refactor printing commit message
      gitweb: Fix typo in separation of git_difftree_body
      gitweb: Expand href() function to use key as param name for no mapping
      gitweb: Added parse_difftree_raw_line function for later use
      gitweb: Sort query string parameters in href() function
      gitweb: Uniquify version info output, add meta generator in page header

-- 
Jakub Narebski
Poland
