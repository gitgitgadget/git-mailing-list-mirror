From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH v3 0/4] rebase -i: Teach "--edit-todo" action
Date: Mon, 17 Sep 2012 21:28:06 -0400
Message-ID: <1347931690-20625-1-git-send-email-andrew.kw.w@gmail.com>
References: <CANiSa6j2zA5P6yDaR7VU416Bzes6xbWuHbU83=BGN67Wo9j_Cw@mail.gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 18 04:29:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDnZF-0002fD-KQ
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 04:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295Ab2IRC3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 22:29:32 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:33129 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932106Ab2IRC3c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 22:29:32 -0400
Received: by ghbg15 with SMTP id g15so1696524ghb.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 19:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=OEKZwbznXUFKsT/MJ0WABdOZU04GkfD63NK+Cztcjqo=;
        b=mfEP6yncP+2V4mSqN96HsgUxMnZBDDQ6+8kR9zpT540xVZZfNVcJ/5itzsjXz0ggJ7
         jdMzJMpQf5hp/q4HOI4NI1zQ4USDMLMS2CGUE/Q85kyOxB0ru/hNOsjhNP5Zuo737z2b
         mci8cYk8P6hcVHjZyT3GC8DnK1Zy78jxExNV92otHlwBYZqcpmBhYPhLMTxes3ok5dRH
         b52cC0sCd2vY9uhzIrEQu2hmUEQWmFokPF9AJ08V/nJWTlaKQo+3LAfZXLnqyDINsLuH
         Ev30e+7kpQcnPL1buJ8r086yA4L2RPFbKT8+nVuTh2BPOs5UFAAptx3wIL3GAmHmkQP/
         HbZw==
Received: by 10.236.177.70 with SMTP id c46mr14034170yhm.33.1347935371546;
        Mon, 17 Sep 2012 19:29:31 -0700 (PDT)
Received: from localhost.localdomain ([69.165.255.59])
        by mx.google.com with ESMTPS id s12sm11226868anh.2.2012.09.17.19.29.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Sep 2012 19:29:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.318.g79683ba.dirty
In-Reply-To: <CANiSa6j2zA5P6yDaR7VU416Bzes6xbWuHbU83=BGN67Wo9j_Cw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205779>

Made the fixes as suggested by Martin.

Martin: Good points. Thanks!

Andrew Wong (3):
  rebase -i: Refactor help messages for todo file
  rebase -i: Teach "--edit-todo" action
  rebase -i: Add tests for "--edit-todo"

Martin von Zweigbergk (1):
  rebase usage: subcommands can not be combined with -i

 Documentation/git-rebase.txt  |  5 ++++-
 git-rebase--interactive.sh    | 48 +++++++++++++++++++++++++++++++++----------
 git-rebase.sh                 | 13 ++++++++++--
 t/t3404-rebase-interactive.sh | 18 ++++++++++++++++
 4 files changed, 70 insertions(+), 14 deletions(-)

-- 
1.7.12.318.g79683ba.dirty
