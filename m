From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH 0/7] git-submodule enhancements
Date: Fri, 14 Mar 2008 01:56:34 +0800
Message-ID: <1205431001-18590-1-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 13 18:58:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZrhC-0002de-4t
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 18:58:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754375AbYCMR4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 13:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754359AbYCMR4u
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 13:56:50 -0400
Received: from mail.qikoo.org ([60.28.205.235]:43765 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757101AbYCMR4o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 13:56:44 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 17D4D470AE; Fri, 14 Mar 2008 01:56:41 +0800 (CST)
X-Mailer: git-send-email 1.5.4.4.653.g7cf1e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77113>

This patch series do following enhancements for git-submodule

  - Fall back on .gitmodules if info not found in $GIT_DIR/config
  - multi-level module definition
  - Don't die when command fails for one submodule 

with diffstat

 git-submodule.sh           |  316 +++++++++++++++++++++++++++++++-------------
 t/t7400-submodule-basic.sh |   31 ++++-

and commits

      git-submodule: Avoid 'fatal: cannot describe' message
      git-submodule: Extract functions module_info and module_url
      git-submodule: Extract absolute_url & move absolute url logic to module_clone
      git-submodule: Fall back on .gitmodules if info not found in $GIT_DIR/config
      git-submodule: Extract module_add from cmd_add
      git-submodule: multi-level module definition
      git-submodule: Don't die when command fails for one submodule
