From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v3] worktree: add 'list' command
Date: Mon, 10 Aug 2015 16:53:01 -0400
Message-ID: <1439239982-42826-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Mon Aug 10 22:53:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOu4b-0001SF-HJ
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 22:53:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932777AbbHJUxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 16:53:22 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:32873 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932553AbbHJUxD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 16:53:03 -0400
Received: by qged69 with SMTP id d69so126411138qge.0
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 13:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=uqwtqCv4RwbFNbunMpGZqKa3meQMsEowCGRV/klBsJ8=;
        b=mZF95oOZCo+DPIHZ8J8GQNEXza/yDfCegCRloiixDyTSKo2XIXdGbKHaYk0N9zdCb1
         S8ZfME7bjcHI3Whx9fETqn9xRyeIQEGmY2aKORaMSWnXh9gQ9kYf9HST9OSd9HY4SogA
         eASb85tA3yMT/YxkzABeS0ejGevvtQepL9K2BFoVVJVEN7SK15+sy8DYa0BD+YjJBTdu
         wYmYhTGwu3s0t6kk4wF7BXMOLREt+3wtS8EHl48WOXFg9qB1JBqS7yM+a6RSfd9xsLa/
         Opc9wEjvsXlcoJlDwjwE+D8bcJunLEwXLlLoIt5s6FfJF7Zvk1nHBS956dNfKP0U6W35
         7Egw==
X-Received: by 10.140.80.209 with SMTP id c75mr41127783qgd.20.1439239981824;
        Mon, 10 Aug 2015 13:53:01 -0700 (PDT)
Received: from MRappazzo.local.info (ool-45729006.dyn.optonline.net. [69.114.144.6])
        by smtp.gmail.com with ESMTPSA id d70sm8704784qkh.45.2015.08.10.13.53.00
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Aug 2015 13:53:00 -0700 (PDT)
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275653>

Differences from [v2](http://www.mail-archive.com/git@vger.kernel.org/msg75467.html)
   - removed unintended whitespace changes
   - cleanup based on comments from v2

Michael Rappazzo (1):
  worktree: add 'list' command

 Documentation/git-worktree.txt |  6 +++-
 builtin/worktree.c             | 67 ++++++++++++++++++++++++++++++++++++++++++
 t/t2027-worktree-list.sh       | 30 +++++++++++++++++++
 3 files changed, 102 insertions(+), 1 deletion(-)
 create mode 100755 t/t2027-worktree-list.sh

-- 
2.5.0
