From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 0/4] prepare for histogram diff
Date: Thu,  7 Jul 2011 00:38:53 +0800
Message-ID: <1309970337-6016-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 06 18:39:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeV89-0006Dt-Dg
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 18:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753770Ab1GFQjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 12:39:12 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48574 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282Ab1GFQjL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 12:39:11 -0400
Received: by qyk29 with SMTP id 29so2178965qyk.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 09:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=dor/H7Y2N8oS9ErJ2p6o6V+yQ4432uoH7VhEtBeEi3U=;
        b=xOdrpmRqz0OAd9EkQ870IF64o0uBDbeXyyDCa0XJAV45GdRC2eKr1v010G34amUwLF
         CPTlh70jZVXJN6YkJVojc6cvs131LG42E51XRXAuT4GRMDyOgKBnIkkf6EUBjb5RiRoM
         PM9f7V1Yl77X3RUfIL2Rt/azXn2ej2YaNIzew=
Received: by 10.224.36.202 with SMTP id u10mr6999097qad.83.1309970350703;
        Wed, 06 Jul 2011 09:39:10 -0700 (PDT)
Received: from localhost (cm119.beta238.maxonline.com.sg [116.86.238.119])
        by mx.google.com with ESMTPS id r33sm6507986qcs.42.2011.07.06.09.39.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 09:39:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176710>

Tay Ray Chuan (4):
  xdiff/xprepare: use memset()
  xdiff/xprepare: refactor abort cleanups
  xdiff/xpatience: factor out fall-back-diff function
  t4033-diff-patience: factor out tests

 t/lib-diff-patience.sh   |  163 ++++++++++++++++++++++++++++++++++++++++++++++
 t/t4033-diff-patience.sh |  162 +--------------------------------------------
 xdiff/xpatience.c        |   27 +-------
 xdiff/xprepare.c         |  104 +++++++++++-------------------
 xdiff/xutils.c           |   31 +++++++++
 xdiff/xutils.h           |    2 +
 6 files changed, 238 insertions(+), 251 deletions(-)
 create mode 100644 t/lib-diff-patience.sh

-- 
1.7.3.4.721.g4666.dirty
