From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/4] Trivial cleanups to t3400 (rebase)
Date: Fri, 10 May 2013 19:59:34 +0530
Message-ID: <1368196178-5807-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 10 16:28:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaoJU-0002Nb-0u
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 16:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756855Ab3EJO2E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 10:28:04 -0400
Received: from mail-da0-f52.google.com ([209.85.210.52]:62321 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756830Ab3EJO2A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 10:28:00 -0400
Received: by mail-da0-f52.google.com with SMTP id o9so1002907dan.11
        for <git@vger.kernel.org>; Fri, 10 May 2013 07:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:subject:date:message-id:x-mailer;
        bh=qiF0xh9PyPQWgj3Wz1Y8QUsZUZl6tKpcApkLJ2ZACuQ=;
        b=boABvFUCmF85NkffIigzVuji/Wdh+fkok9TsxBd5CR5dJOLMLuz2/stxl+ccEPpHRj
         Zw3VNfAyEybS8A2Y5nz+d5O0l/vlkl3QT/tsA4F6D92yhewlQ0DAhZkB371wIeZDyz/0
         9rO1c+hpg6UxkDdSF/+X7fisLxpY38vyXGAOhl+Iq5taV24Zdp07o1J1qsTlRRX2I+bh
         Ob4FFZ1toqLAsQGMVc0lYEDZGe8Zm8CGx//EaHhPA7qeDmteHeOFnPta9TOPnHhWZzIZ
         Coi8jNjKu2tECC/eqO6tbiru2ff+KTAuY8Nz5qVRoyO7Z5IXqH/1AdGVWJ/0wb1GUFpq
         BqHA==
X-Received: by 10.68.11.73 with SMTP id o9mr17726880pbb.18.1368196080358;
        Fri, 10 May 2013 07:28:00 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id ih1sm2885215pbb.44.2013.05.10.07.27.58
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 10 May 2013 07:27:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.52.gc14258d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223852>

Hi,

I was just going through t3400 when wondering where to put the tests
for rebase.autostash.  Here's a set of trivial patches.

Thanks.

Ramkumar Ramachandra (4):
  t3400 (rebase): don't set GIT_AUTHOR_{NAME,EMAIL}
  t3400 (rebase): downcase a couple of test titles
  t3400 (rebase): move lone statement into a test
  t4300 (rebase): don't unnecessarily set GIT_TRACE

 t/t3400-rebase.sh | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

-- 
1.8.3.rc1.52.gc14258d
