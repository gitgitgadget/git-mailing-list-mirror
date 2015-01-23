From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT 4/5] doc: don't use guilt-foo invocations in usage messages.
Date: Fri, 23 Jan 2015 14:24:58 +0100
Message-ID: <1422019499-2012-5-git-send-email-cederp@opera.com>
References: <1422019499-2012-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri Jan 23 14:26:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEeGD-0004gM-CG
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 14:26:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755340AbbAWN0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 08:26:49 -0500
Received: from mail-wi0-f170.google.com ([209.85.212.170]:47574 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755329AbbAWN0s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 08:26:48 -0500
Received: by mail-wi0-f170.google.com with SMTP id em10so2938537wid.1
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 05:26:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=riD2OwnIPZDmJblehTF1qPPbMDRkUl5WK3GxdsfICfc=;
        b=ScnORv57S0JgGlGPhnmJ1GV+7/2JRenuUP6XkTDgFHjBs3bPauOW6tV0XC2xNXuHSO
         UFO601OTmbeqGqVN2xWSuYPVVPr+r2VJYlSeO/SFxZlXSjJiChDoJ20JEAf20KS+ryJM
         qed4VZp+1gYmVSZN+AxzF5qVk8kwTQxRYZ0zAYK44jf8/m/6Q7z+VtcH+yURPBuZYno2
         ivoM8wQ3x88hyXbRFf1VW6nTqfAmK2Xo29+ZHl5bxUQuCMWCAvI2XW5ba+srtQXGQeV4
         uV906vRR4tXLxatzkRkBOyKT58O5WivZEnVudDewPiMgWqGgs7ynN3cGGJBDP61GfRG0
         kwOg==
X-Gm-Message-State: ALoCoQliK32+Q+NfwWOhTW+YYrAHfaHOlvHcc33F1E/KCzkzBYp73YMsfLRJ/ZF0FlcxfHsm5Nr0
X-Received: by 10.194.87.100 with SMTP id w4mr14216813wjz.65.1422019607704;
        Fri, 23 Jan 2015 05:26:47 -0800 (PST)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id fi10sm1841950wib.13.2015.01.23.05.26.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Jan 2015 05:26:46 -0800 (PST)
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1422019499-2012-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262925>

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 Documentation/usage.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/usage.sh b/Documentation/usage.sh
index 629f546..9cc49f7
--- a/Documentation/usage.sh
+++ b/Documentation/usage.sh
@@ -2,4 +2,4 @@
 
 name=$(basename $1)
 u=$(grep USAGE $1 |  sed 's/USAGE="//' | sed 's/"$//') 
-echo "'$name' $u"  > usage-$name.txt
+echo "'`echo $name|sed -e 's/^guilt-/guilt /'`' $u"  > usage-$name.txt
-- 
2.1.0
