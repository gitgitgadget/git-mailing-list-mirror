From: Techlive Zheng <techlivezheng@gmail.com>
Subject: [PATCH/RFC v2 0/8] contrib/subtree: Reroll to follow Git's whitespace policy
Date: Mon, 14 Jan 2013 11:52:13 +0800
Message-ID: <1358135541-10349-1-git-send-email-techlivezheng@gmail.com>
References: <1358041958-1998-1-git-send-email-techlivezheng@gmail.com>
Cc: apenwarr@gmail.com, greened@obbligato.org,
	Techlive Zheng <techlivezheng@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 14 04:58:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TubC4-0005rR-H7
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 04:58:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754930Ab3AND6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2013 22:58:14 -0500
Received: from mail-da0-f50.google.com ([209.85.210.50]:49417 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754863Ab3AND6N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 22:58:13 -0500
Received: by mail-da0-f50.google.com with SMTP id h15so1620501dan.23
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 19:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=rogBaTdvM3YaSxEVJ13Eji6ywfpcszlI6dj3MFidvXw=;
        b=gUTnmcuelNIYePDAmpHdoI0hfWfyTW6oJDPFSz6lJNe9hnLpj7CZGQF3tfC1qHexVT
         90D8OCdXtgsbeu/CV/3qMCGhfwo2zLi1rsezscNdTtCkZ+Ji/oE2jvKr8M7I6dN72lAj
         4xc0h0bzWsmRyDm7XCdzKK8mpm0eGTmP/hY1XKXwuwEB8oa4MTTj5WjoWSK/MoURBAxs
         MbivikH2tlElgu1lrRodbcRKQ/XzrAGr2YGDt9WVpGNHLoeCq/QwBxrp7cfXMqVe3xvG
         V4HObn90Yc5camRbCv1vatfG1nVDOVPssCs3RWCVL8s3r7JkkYJSm6hBVk0F0emqU9E/
         /RJQ==
X-Received: by 10.68.209.170 with SMTP id mn10mr252559555pbc.11.1358135893151;
        Sun, 13 Jan 2013 19:58:13 -0800 (PST)
Received: from home.techlive.me ([122.244.159.146])
        by mx.google.com with ESMTPS id kl3sm7400598pbc.15.2013.01.13.19.58.08
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 19:58:12 -0800 (PST)
X-Mailer: git-send-email 1.8.1
In-Reply-To: <1358041958-1998-1-git-send-email-techlivezheng@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213421>

David A. Greene (1):
  contrib/subtree: Remove test number comments

Techlive Zheng (7):
  contrib/subtree: Fix whitespaces
  contrib/subtree: Add vim modeline
  contrib/subtree: Ignore testing directory
  contrib/subtree: Code cleaning and refactoring
  contrib/subtree: Make each test self-contained
  contrib/subtree: Use %B for the split commit message
  contrib/subtree: Handle '--prefix' argument with a slash appended

 contrib/subtree/.gitignore         |    5 +-
 contrib/subtree/git-subtree.sh     |   85 +--
 contrib/subtree/git-subtree.txt    |   55 +-
 contrib/subtree/t/t7900-subtree.sh | 1255 +++++++++++++++++++++++-------------
 4 files changed, 905 insertions(+), 495 deletions(-)

-- 
1.8.1
