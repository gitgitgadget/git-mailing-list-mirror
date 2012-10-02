From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/5] submodule: introduce diff.submoduleFormat
Date: Tue,  2 Oct 2012 22:21:05 +0530
Message-ID: <1349196670-2844-1-git-send-email-artagnon@gmail.com>
Cc: Jens Lehmann <Jens.Lehmann@web.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 02 18:52:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ5he-0007bu-9y
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 18:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463Ab2JBQv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 12:51:29 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:48220 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373Ab2JBQv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 12:51:28 -0400
Received: by padhz1 with SMTP id hz1so5408625pad.19
        for <git@vger.kernel.org>; Tue, 02 Oct 2012 09:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=EJ+0GSD/cI2gHnQsdKV6LYdI9vp72/8fIrV1LQTx/d8=;
        b=lMFm5cXnJwDOR3MLhVbVT38FCoYD3kSvKsn4lh0m4uOCbzmc4efCeKlK5i+f4NBaqc
         q7vTEBLWkw2ul8P2EYBJzlddsbdPeVAHtESniJ1cxuTq1HuBJ5YycHbqj0hZ2a5beq9K
         5gX4br+Hme+1WQLyPFej4eQZR72mRKwL24kgV3fdXt1LbQ/n1NOg60GhsG9XhpUKbK4l
         JwASWZR4vIF4O3RPRS6QJvBNzJkUlsm+yceOPtMV7lN1ZQL26c0uoryjxGJNGWOYZT4U
         swqti31XpApiasvopBNH2SDLQ19gRXicDlL4UOGjvKZvedAMJSoqYVi/e6JxRCCnUo00
         5bOw==
Received: by 10.68.224.132 with SMTP id rc4mr5629002pbc.155.1349196687908;
        Tue, 02 Oct 2012 09:51:27 -0700 (PDT)
Received: from localhost.localdomain ([49.206.137.123])
        by mx.google.com with ESMTPS id qd9sm1151524pbb.31.2012.10.02.09.51.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Oct 2012 09:51:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.1.362.g5d6df.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206816>

Hi,

The fourth patch is the crux of the series.  The first two patches
clear up config.txt, diff-config.txt for the fourth patch.  The third
patch turned out to be a prerequisite.  And the fifth patch is a
bonus.

Thanks for reading.

Ram

Ramkumar Ramachandra (5):
  Documentation: move diff.wordRegex from config.txt to diff-config.txt
  Documentation: sort diff-config.txt alphabetically
  diff: acknowledge --submodule=short command-line option
  diff: introduce diff.submoduleFormat configuration variable
  submodule: display summary header in bold

 Documentation/config.txt         |    6 ------
 Documentation/diff-config.txt    |   21 +++++++++++++++++----
 Documentation/diff-options.txt   |    3 ++-
 diff.c                           |   29 +++++++++++++++++++----------
 diff.h                           |   17 +++++++++--------
 submodule.c                      |    8 ++++----
 submodule.h                      |    2 +-
 t/t4041-diff-submodule-option.sh |   10 ++++++++++
 8 files changed, 62 insertions(+), 34 deletions(-)

-- 
1.7.8.1.362.g5d6df.dirty
