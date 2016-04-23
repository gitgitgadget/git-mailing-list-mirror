From: Luke Diamand <luke@diamand.org>
Subject: [PATCH 0/2] git-p4: support python3 in the tests
Date: Sat, 23 Apr 2016 15:13:44 +0100
Message-ID: <1461420826-4416-1-git-send-email-luke@diamand.org>
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>,
	Sam Hocevar <sam@hocevar.net>, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 16:11:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atyHK-0001cG-HB
	for gcvg-git-2@plane.gmane.org; Sat, 23 Apr 2016 16:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718AbcDWOLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2016 10:11:12 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34393 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbcDWOLL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2016 10:11:11 -0400
Received: by mail-wm0-f67.google.com with SMTP id n3so12264922wmn.1
        for <git@vger.kernel.org>; Sat, 23 Apr 2016 07:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jzHvs4dr/7N0ZN0Natx5IExuyj2W3+087zdqWpdJRUE=;
        b=Ayh9w1n//m0D2WDslGP37fT0upzsm2EBajHDInF7FZ6UdScgDJYSje+EUN4ywDGact
         esDdYVtoWbkl/bie+qyNPUWMMw+e7VBUJLGBsPPXuzLUyTwoQhk440ctnH49ntLoHp+Z
         +tAlhTLRiZbFvD8vHDdRxp3f32cUv17tgaxUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jzHvs4dr/7N0ZN0Natx5IExuyj2W3+087zdqWpdJRUE=;
        b=af5KhvbacideACeQajJpkgvjPGJMwfre4AU7eTMUc64SROEKtcaSpRbbGMrWrD2Jw4
         Wk0f6gV6iGLIpdWCDk9QDhw1/+CwSIsrOfBkCn2SWxqI5wZOMC4wf76NBtvYNuhejfnB
         Qdj6RCcwB1RYzUkmmciX1wGvIJsN4UYGbMLUA8q7NwwHTJOC9yci2TrsBlVZCMK3tZFp
         UcFvSHOXvuDLWh7+3MisglQ98NzPp+n87TjXBbmPtrnEMmS4csf/2Iw9lgAkyESS0BsH
         SBDpcxzOg4jla565V0QT0bdJdzLCKHXTI7i/iuCJqE8RM/8lAYQz8jo6Lukm98nuF7tp
         nhFA==
X-Gm-Message-State: AOPr4FWcyXnO3xs/QiOYqUqkjSN2USD8AVNUfAtdZjnxm5f3rVkf//CrI3tUTfqZRInhJw==
X-Received: by 10.28.216.76 with SMTP id p73mr2925555wmg.3.1461420669527;
        Sat, 23 Apr 2016 07:11:09 -0700 (PDT)
Received: from ethel.local.diamand.org (cpc92798-cmbg19-2-0-cust327.5-4.cable.virginm.net. [80.1.41.72])
        by smtp.gmail.com with ESMTPSA id u3sm8537920wmg.15.2016.04.23.07.11.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 23 Apr 2016 07:11:08 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.218.gd2cea43.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292303>

This patchset updates the git-p4 tests so that they work with
either Python2 or Python3.

Note that this does *not* fix git-p4 to work with Python3 - that's
a much bigger challenge.

Luke Diamand (2):
  git-p4 tests: cd to testdir before running python
  git-p4 tests: work with python3 as well as python2

 t/lib-git-p4.sh            | 7 ++++---
 t/t9802-git-p4-filetype.sh | 6 +++---
 2 files changed, 7 insertions(+), 6 deletions(-)

-- 
2.8.1.218.gd2cea43.dirty
