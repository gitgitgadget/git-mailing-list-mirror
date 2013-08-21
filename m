From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/3] t3404 incremental improvements
Date: Wed, 21 Aug 2013 15:12:55 -0400
Message-ID: <1377112378-45511-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 21 21:13:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCDqR-0004k4-PB
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 21:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502Ab3HUTNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 15:13:15 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:46726 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477Ab3HUTNO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 15:13:14 -0400
Received: by mail-oa0-f48.google.com with SMTP id o17so1712951oag.35
        for <git@vger.kernel.org>; Wed, 21 Aug 2013 12:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=zcqCWTJtqQqQgF9WspDqLvec2nRKK60IwfRHt5XCRNs=;
        b=KKQHBN7cqBAa4T2RELx/xKeOJ3G6kFUvrotNy265YOkVkp+YxP3BT5pCEG4E0DNRYj
         vrq5b6qyDD/YJsoh/6Z29CUxVzYdL57LVp6txPCY147yVteLatrt2H+7PQFrjdD+l+C9
         n2grQl9WP0TVsmp7IfCkgtVhHIiU/L4q811QWPf2RAXENHLlr4qJFbBknV+8OcsXs7/x
         Yr7k+i9SHBrX8h6WBAuSsLKUqVF7yDwmCOQJ8sHdLS9IybBDzyjKISzlXXL/STr6AhPS
         UEIrXmrRuN0+3dmXk1Yhq5BxsC+yjdfpadbEHxAplimlXPAN6qUrLkhg/B5O05T3irEE
         bn1Q==
X-Received: by 10.182.225.162 with SMTP id rl2mr9852901obc.72.1377112391538;
        Wed, 21 Aug 2013 12:13:11 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id z2sm12357303obi.3.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 21 Aug 2013 12:13:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc4.499.gfb33910
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232718>

This set of patches was meant to be a re-roll of [1] addressing Junio's
comments, however [1] graduated to 'next' before I found time to work on
it further, so these are instead incremental patches atop 'next'.

patch 1: address Junio's comment [2]

patch 2: address Junio's comment [3] with a sledge-hammer approach;
whether to accept this patch is a judgment call

patch 3: trivial cleanup which should make the test easier to comprehend
for future readers

[1]: http://thread.gmane.org/gmane.comp.version-control.git/232146
[2]: http://thread.gmane.org/gmane.comp.version-control.git/232146/focus=232159
[3]: http://thread.gmane.org/gmane.comp.version-control.git/232146/focus=232158

Eric Sunshine (3):
  t3404: preserve test_tick state across short SHA-1 collision test
  t3404: make tests more self-contained
  t3404: simplify short SHA-1 collision test

 t/t3404-rebase-interactive.sh | 77 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 72 insertions(+), 5 deletions(-)

-- 
1.8.4.rc4.499.gfb33910
