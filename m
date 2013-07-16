From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] git-log.txt: fix typesetting of example "git-log -L" invocation
Date: Mon, 15 Jul 2013 20:10:36 -0400
Message-ID: <1373933436-28599-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 16 02:11:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uysrf-0006hn-Sw
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 02:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755367Ab3GPALc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 20:11:32 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:39135 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755264Ab3GPALb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 20:11:31 -0400
Received: by mail-ie0-f173.google.com with SMTP id k13so154442iea.18
        for <git@vger.kernel.org>; Mon, 15 Jul 2013 17:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=f7e0zB3XAo3IFpcqpdf7rBDHw/gfZIhtnlnzyAn86xM=;
        b=o0LMQhERSk3UkSgU4rTUf5t90ukvXgLgkLp/1niMhjhZyJy8RkwHG9jiy2it8U7sE2
         JQW+dmMBqbAjWhRH/yqjwoXy5XlWF9TYQr+HVMXRL3kM9FaxXYXlGD3an63Ue4sZFNjq
         XLiLw/NhM3F45hMvlzRENLSyWnoqp8R7uIooewQJ6s9CbduNtGbefZEUdBL9lu1+AXf1
         BKGQxUkSYEfbZfpmepAdKLRcF5Iq4inNhKQx/qY08F9xB8ZmmuHMlRYpENUZGVo3aN9i
         6VR9nPOpf1RefIrbRlkCEadZn7Mbit5oYaqj7HXMh6odTWLHsDWpdHm0890flvhQzBYf
         PS7w==
X-Received: by 10.50.119.74 with SMTP id ks10mr8423651igb.59.1373933490903;
        Mon, 15 Jul 2013 17:11:30 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id t10sm21449855igz.9.2013.07.15.17.11.28
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jul 2013 17:11:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.3.1016.g4f0baba
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230532>

All surrounding examples are typeset as monospaced text. Follow suit.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-log.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 2ea79ba..2ee6962 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -153,7 +153,7 @@ Examples
 	This makes sense only when following a strict policy of merging all
 	topic branches when staying on a single integration branch.
 
-git log -L '/int main/',/^}/:main.c::
+`git log -L '/int main/',/^}/:main.c`::
 
 	Shows how the function `main()` in the file 'main.c' evolved
 	over time.
-- 
1.8.3.3.1016.g4f0baba
