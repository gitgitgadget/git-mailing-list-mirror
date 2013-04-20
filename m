From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/5] Documentation/shortlog improvements
Date: Sat, 20 Apr 2013 17:15:08 +0530
Message-ID: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 20 13:45:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTWEb-0000Y6-Em
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 13:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755026Ab3DTLpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 07:45:22 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:41597 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754991Ab3DTLpV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 07:45:21 -0400
Received: by mail-pd0-f173.google.com with SMTP id v14so2688741pde.18
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 04:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=RHp6aAj1XJZ2AAKKtLq98P3ZFmAIVPRtL7PNnxEuyHE=;
        b=0QbRk+4x9HrC9cVLw2L42raSEtQElA6GhI/5d5qeckbUX/QDxaFf+nIuxACn/PIZvd
         bwspMUjFUCuwsv0O9Cpe8kRtx+OjwcN9T8vm6AdUjc1+B5H6Sygpt6tkSxwBx6/jOxZD
         g2bPw3Umd1L2OnCHgQuf4mfIhZPqOIrqE8vEzqaQeb20xFC7isR+xO6wGjpan9VnMNYy
         d4KlcGU5BOGiXu9ea98xarRjQMBUZsBk7nmuZSsXuFzvo3bAg01sTTYburcnR8tyq2sO
         qmqe0scOFvAuG3Gp80s54Y3SA1TxHRZwR2ssAUsrmAp6DAj23gcIJiApcMo9IPlalCN3
         uPjQ==
X-Received: by 10.66.197.165 with SMTP id iv5mr7101318pac.7.1366458321142;
        Sat, 20 Apr 2013 04:45:21 -0700 (PDT)
Received: from localhost.localdomain ([122.174.41.136])
        by mx.google.com with ESMTPS id ag4sm629048pbc.20.2013.04.20.04.45.18
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Apr 2013 04:45:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.506.gbce9ff0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221846>

Hi,

I was going through the shortlog documentation and was saddened to see
that it was inaccurate and inconsistent with the log documentation.  I
use shortlog quite a lot, and like it very much.  So, here's a small
series fixing some problems.

[3/5] and [4/5] came out of my desire to copy out parts of git-log.txt
into git-shortlog.txt (I had to fix git-log.txt first).

Thanks.

Ramkumar Ramachandra (5):
  git-shortlog.txt: remove (-h|--help) from OPTIONS
  builtin/shortlog.c: make usage string consistent with log
  git-log.txt: fix description of <since>..<until>
  git-log.txt: rewrite note on why "--" may be required
  git-shortlog.txt: make SYNOPSIS match log, update OPTIONS

 Documentation/git-log.txt      | 10 +++++-----
 Documentation/git-shortlog.txt | 23 ++++++++++++++++++-----
 builtin/shortlog.c             |  4 +---
 3 files changed, 24 insertions(+), 13 deletions(-)

-- 
1.8.2.1.506.gbce9ff0
