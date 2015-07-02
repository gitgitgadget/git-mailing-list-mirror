From: Lawrence Siebert <lawrencesiebert@gmail.com>
Subject: [PATCH v2 0/4] git log --count
Date: Thu,  2 Jul 2015 16:50:07 -0700
Message-ID: <1435881011-13879-1-git-send-email-lawrencesiebert@gmail.com>
Cc: remi.galan-alfonso@ensimag.grenoble-inp.fr, gitster@pobox.com,
	Lawrence Siebert <lawrencesiebert@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 03 01:50:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAoFi-0005CD-SS
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 01:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753022AbbGBXun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 19:50:43 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:32796 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754186AbbGBXul (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 19:50:41 -0400
Received: by ykdv136 with SMTP id v136so82839780ykd.0
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 16:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=dEVcGDbvRw+4W+6yDKqo26ofwzd804OG5Uouq8roDnM=;
        b=JsvCxNEp+qlR6NSlG3EG1E/e0xJ6zSadla4cljOaK5WPqCnjC4dJE5B54kBYKVxEdU
         EOtClYdkaw7O19KxTBSOwVLlJAVKdzcpSW3caweVkFqjPOcpuHxEUv6yZqEUTCY5OElr
         IvDWac+QMIGBPwGbP4T4iiTr6gxGzyu/K/YkoBS34P1IdhsqoqP0HZCY53+0jv48Q+UY
         Q0/OfQfmq1L5W+GOcjE1jBU1pSVijLSidJeUevoIsE459dKUH86+ryV0hsEjJNM2tp/9
         qXwrJgiYQyjdAnYvBZGUhxWxLgqv5KIDJra1v6s+F+VRrpW4oz+OpnWlsYQ7A4LwAwqv
         F9gQ==
X-Received: by 10.13.251.199 with SMTP id l190mr42130879ywf.148.1435881040351;
        Thu, 02 Jul 2015 16:50:40 -0700 (PDT)
Received: from localhost.localdomain (24-176-234-59.dhcp.atsc.ca.charter.com. [24.176.234.59])
        by mx.google.com with ESMTPSA id b131sm7190938ywc.18.2015.07.02.16.50.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jul 2015 16:50:39 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273274>

This should fix the whitespace issues this had previously.  

Lawrence Siebert (4):
  list-object: add get_commit_count function
  log: add --count option to git log
  log --count: added test
  git-log: update man documentation for --count

 Documentation/git-log.txt          |  2 ++
 Documentation/rev-list-options.txt |  2 +-
 builtin/log.c                      | 29 +++++++++++++++++++++++++++++
 builtin/rev-list.c                 | 12 ++----------
 list-objects.c                     | 14 ++++++++++++++
 list-objects.h                     |  1 +
 t/t4202-log.sh                     |  7 +++++++
 7 files changed, 56 insertions(+), 11 deletions(-)

-- 
1.9.1
