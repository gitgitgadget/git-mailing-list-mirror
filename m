From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/2] version-gen: fixes and cleanups
Date: Thu, 12 Sep 2013 20:17:24 -0500
Message-ID: <1379035046-6688-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 13 03:23:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKI64-0007LY-7Z
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 03:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755224Ab3IMBWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 21:22:38 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:57292 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998Ab3IMBWi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 21:22:38 -0400
Received: by mail-oa0-f41.google.com with SMTP id j6so611283oag.0
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 18:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=TmIkGcD3P9SQniRpY2boibPJFgrk3KzYgrjwvnCbyYM=;
        b=0WUeas+gR0acH1dVbjsccILwqUDPvtworCfsaeT0HF+mHID/2b5VhCSM4KqUFTrDTn
         2lOs7+wSEV7PP0zpPIXEpXlXf1qK+iEpIqTZDQugz27vZhk0xAAl+hDrESMRTfZgEL7W
         itmNEKmCIZ8KMGdz0O9X4W5wcqUJyTV75piSN+N2qDTZoTftc6G5fyuce7AjwsvU6rBg
         epFvfvlAmn5EBwo9VH0oDMZ9OqRBzVgUwHwhO1r9uwP9TRVYI9hHqkHFqe7KcnEt4Qbr
         A67qnYUZRScqyYjbJGNDcNyKWW77FLTirEMeSE8JVw19cqAl2WucZC29HvM7KFpTl96Y
         YrmQ==
X-Received: by 10.60.93.105 with SMTP id ct9mr9620394oeb.42.1379035357339;
        Thu, 12 Sep 2013 18:22:37 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s14sm10336407oeo.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 12 Sep 2013 18:22:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-338-gefd7fa6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234719>

Felipe Contreras (2):
  version-gen: cleanup
  version-gen: avoid messing the version

 GIT-VERSION-GEN | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

-- 
1.8.4-338-gefd7fa6
