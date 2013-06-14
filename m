From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH v2 0/2] module_list enhancements
Date: Fri, 14 Jun 2013 02:26:01 +0200
Message-ID: <1371169563-10267-1-git-send-email-iveqy@iveqy.com>
Cc: git@vger.kernel.org
To: iveqy@iveqy.com
X-From: git-owner@vger.kernel.org Fri Jun 14 02:23:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnHnH-00019F-7t
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 02:23:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759500Ab3FNAXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 20:23:00 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:57060 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759232Ab3FNAXA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 20:23:00 -0400
Received: by mail-la0-f53.google.com with SMTP id fs12so8089417lab.12
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 17:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=VjVYxQq6nqaGbZ796tZy/WpZyrlhAU66KqtMosWlSYc=;
        b=VUlXBwkN5Dewxqg02uugTc7thswlKHa0u2abpbG56/QWBxB02NLJDlXIYFC0votPLb
         mLUcCeAy0gpP3Bx/PYhky7BWh/sGk2cSGq22IWNBt+e//eyIeKT6V2aTykCI8TX+wnfW
         Ubj3ayTTe1nfsbowqTmowWG3jT+blnjSvFPjZRqT1dfIg/gCyC3XSI9aION7UO2qJbnC
         zMV/6LRI1kwk8ypcigbsR4JbKIlDIbphLqr8D+vvFj8VlrrGvlhFuDxRkrnNPFvudjJ9
         YcgqJcxdPRXoLWS5RmCbFWuNi14tV3392W1h4iRAtQ5V8vBNn1H6xsb5t9E+jymogpyT
         hbWg==
X-Received: by 10.152.23.99 with SMTP id l3mr1473306laf.82.1371169378523;
        Thu, 13 Jun 2013 17:22:58 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id w9sm9758532lbk.7.2013.06.13.17.22.57
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 13 Jun 2013 17:22:58 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UnHq8-0002gB-Q9; Fri, 14 Jun 2013 02:26:04 +0200
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227786>

The first iteration can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/227572/

The errors in the first patch was a faulty test. I also applied Junios solution in the
first patch, it was nicer.

Fredrik Gustafsson (2):
  [submodule] handle multibyte characters in name
  [submodule] Replace perl-code with sh

 git-submodule.sh           | 53 ++++++++++++++++++++--------------------------
 t/t7400-submodule-basic.sh | 12 +++++++++++
 2 files changed, 35 insertions(+), 30 deletions(-)

-- 
1.8.3.1.381.g2ab719e.dirty
