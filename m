From: Pascal Obry <pascal@obry.net>
Subject: [PATCH v4 0/3]  Add support for SMTP server options
Date: Mon,  6 Sep 2010 19:38:00 +0200
Message-ID: <1283794683-2796-1-git-send-email-pascal@obry.net>
Cc: Pascal Obry <pascal@obry.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 19:37:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osfdb-0003aE-E8
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 19:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225Ab0IFRhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 13:37:42 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41796 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804Ab0IFRhl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 13:37:41 -0400
Received: by wwj40 with SMTP id 40so6854761wwj.1
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 10:37:40 -0700 (PDT)
Received: by 10.227.134.144 with SMTP id j16mr103604wbt.50.1283794660058;
        Mon, 06 Sep 2010 10:37:40 -0700 (PDT)
Received: from localhost (AVelizy-154-1-100-4.w90-2.abo.wanadoo.fr [90.2.58.4])
        by mx.google.com with ESMTPS id b23sm4835871wbb.10.2010.09.06.10.37.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 10:37:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155587>

This is v4 of the patch thanks to Junio and AEvar for the review and help.

context:
--------

I'm not familiar at all with Perl so comments on style or usage most
welcomed. This patch is to introduce a way to pass specific options to the
SMTP server used by git-send-email.

I need that to be able to use different SMTP account (wanadoo, gmail...) on
some Git repositories to send over proper identity.

change since v3:
----------------

I have moved smtp server option description after smtp server port. Seems
more natural to me.

I have added note about the fact that multiple lines are needed for each
option in configuration files.

patches:
--------

The two first patches are really code clean-up found while working on this
new feature. The last patch is the actual implementation of this new
feature.

Pascal Obry (3):
  Minor indentation fix.
  Remove @smtp_host_parts variable as not used.
  New send-email option smtpserveroption.

 Documentation/config.txt         |    1 +
 Documentation/git-send-email.txt |    9 +++++++++
 git-send-email.perl              |   12 +++++++++---
 3 files changed, 19 insertions(+), 3 deletions(-)

-- 
1.7.2.2.277.gb49c4
