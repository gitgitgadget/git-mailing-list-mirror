From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v6 0/2] worktree: for-each function and list command
Date: Sun, 30 Aug 2015 15:10:37 -0400
Message-ID: <1440961839-40575-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com, sunshine@sunshineco.com,
	dturner@twopensource.com
X-From: git-owner@vger.kernel.org Sun Aug 30 21:10:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZW807-0007Wd-LL
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 21:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753713AbbH3TKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2015 15:10:43 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:33439 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753611AbbH3TKm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2015 15:10:42 -0400
Received: by qgp105 with SMTP id 105so3578139qgp.0
        for <git@vger.kernel.org>; Sun, 30 Aug 2015 12:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=HG+6U2WlEK9hB70gV5bHv5aK9IWSwvQv9zj78xUx7x4=;
        b=KlPaW/ZK4ktM5Li1H4MHiLlQDqrlJ4hdPzWSiIJkhaOE3zJIkt3OWFakTjz9bn0KoK
         qwgk9fC6T+d9ZLEZL5wkxDZcuLVOX2B3abcoJSAxpOgxtzkkOrVAXfzGNKNsRb+7X0OL
         IbhXRWyqyhotJGTpPoe58S3Yv5R2tXYZMPVkw11vz1AJOwKA08UqT/r4zAOBAkkg1jQz
         kPxE130lQFZT0M/MfjzH7RJA1QOYTmZupLFnO5VFOoo8YsFyXsJG1ECNvLY9OY8R9J4r
         nteQEc0/Goe3tzpaCrb+H/5Ehing6tfPDf+3/V3MmxIzV3K96tPperlQDeerFwlBb30u
         2Oaw==
X-Received: by 10.140.151.212 with SMTP id 203mr34187572qhx.1.1440961841592;
        Sun, 30 Aug 2015 12:10:41 -0700 (PDT)
Received: from MRappazzo.local.com (cpe-74-76-66-5.nycap.res.rr.com. [74.76.66.5])
        by smtp.gmail.com with ESMTPSA id 100sm7449213qky.6.2015.08.30.12.10.39
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 30 Aug 2015 12:10:40 -0700 (PDT)
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276829>

Changes since v5:
 - used already existing functions instead of reimplementing:
     - resolve_ref_unsafe
     - find_unique_abbrev
     - shorten_unambiguous_ref
 - added more tests for 'worktree list'

Michael Rappazzo (2):
  worktree: add 'for_each_worktree' function
  worktree: add 'list' command

 Documentation/git-worktree.txt |  10 +++-
 builtin/worktree.c             | 125 +++++++++++++++++++++++++++++++++++++++++
 t/t2027-worktree-list.sh       | 100 +++++++++++++++++++++++++++++++++
 3 files changed, 233 insertions(+), 2 deletions(-)
 create mode 100755 t/t2027-worktree-list.sh

-- 
2.5.0
