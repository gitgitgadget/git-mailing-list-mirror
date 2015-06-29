From: Lawrence Siebert <lawrencesiebert@gmail.com>
Subject: [PATCH] --count feature for git shortlog
Date: Sun, 28 Jun 2015 18:22:00 -0700
Message-ID: <1435540922-12208-1-git-send-email-lawrencesiebert@gmail.com>
Cc: Johannes.Schindelin@gmx.de, apelisse@gmail.com, jrnieder@gmail.com,
	Lawrence Siebert <lawrencesiebert@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 29 03:22:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9NmB-0008RW-QF
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 03:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805AbbF2BWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 21:22:19 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:34601 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956AbbF2BWS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 21:22:18 -0400
Received: by ykfy125 with SMTP id y125so102664985ykf.1
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 18:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=0gzNAhGyIO3St8dOdUKRnbjZJhU1oDZZCpdCdexzTlA=;
        b=St6+AQXnRuFX5sim+hDnzFQcF/RTkJEc8Hq2VoN1KElL2BFPMbaZWAhsArAoBvNFSD
         6McaEJwCzbXFeiPaghYMZ84+FGkrEyBFIaHRU6qz0LN+cM3102SM9fvqdgZr2WRpeN8B
         ubNjmm02iEratpTZ6u6fMnBRbYU/UloUjLoVyHTEB5aLLvWRDteBqirznhU7TqqpU965
         RmWPfcFC6vVbz5QQ/M23Q5CKsXj8X3n96X5RbOVOmnPmeL4dwo5epwPDT8hUAlgj8Ifd
         uYA8o/RKgXaB4U4cV9odMhrs8L2Sa5b9G72nltAXk061Ka8gbFbu/KyGGC8tvMy70xsI
         fbEw==
X-Received: by 10.13.207.1 with SMTP id r1mr16121964ywd.166.1435540937387;
        Sun, 28 Jun 2015 18:22:17 -0700 (PDT)
Received: from localhost.localdomain (24-176-234-59.dhcp.atsc.ca.charter.com. [24.176.234.59])
        by mx.google.com with ESMTPSA id c3sm35528470ywd.39.2015.06.28.18.22.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 18:22:16 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272928>

This is a new feature for short log, which lets you count commits on a per
file or repository basis easily.

Currently if you want a total count of commits with shortlog, you would
need to add up each authors commits after using --summary. This adds a 
-N / --count option to shortlog for this purpose.  I also created
a test. It's not a great test, but it works.

I'm sure I've make a beginner mistake in some part of the process;
I've done my best to follow documentation, so please be explicit
when you tell me I've done something wrong.

Thanks,
Lawrence Siebert


Lawrence Siebert (2):
  shortlog: -N/--count option
  shortlog: added --count test

 builtin/shortlog.c  | 14 +++++++++-----
 shortlog.h          |  1 +
 t/t4201-shortlog.sh |  5 +++++
 3 files changed, 15 insertions(+), 5 deletions(-)

-- 
1.9.1
