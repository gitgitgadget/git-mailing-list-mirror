From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: improve message when switching branches
Date: Thu, 12 Jun 2014 20:21:30 +0200
Message-ID: <1402597290-9374-1-git-send-email-ralf.thielow@gmail.com>
References: <5399EA72.7060609@gmail.com>
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org, stefanbeller@gmail.com
X-From: git-owner@vger.kernel.org Thu Jun 12 20:21:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv9d5-00016d-EU
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 20:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbaFLSVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 14:21:35 -0400
Received: from mail-we0-f175.google.com ([74.125.82.175]:65190 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbaFLSVf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 14:21:35 -0400
Received: by mail-we0-f175.google.com with SMTP id k48so962186wev.20
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 11:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yug66s8mgIpV719NuOd2SKJp8iQn389x07PF0b6pWiM=;
        b=fzvBMpcCS0cRzZP4dShKMUOF0GicjT+hNntfaIip7NgEKxfeBeohxUyZpcTOyroOPi
         huuGUfxr5uGCHCJav1XN+iGsg6TWw/z+DD1GWeRDVocXYjO860oC0TelWBv/IjVQ2ozH
         kiWy/y0yrnf4Nkpp4GwF76TvU2at7rc+76ccvcZvGdSSwdG74iYikL4LpaI0a5aPLK6M
         zidCK0ZrywAlTPEytjqMrV/dCo0zrZAzHMaO9eRZ6P0YCpWo5PsjouVn0R8tThX/+EkN
         USD9/ndu7rBAOvDIzrPqc/sWIW+hn1czG3PlVDlG72C29LqiG0hykl5piJpHWX9OuBvP
         H3kg==
X-Received: by 10.194.186.178 with SMTP id fl18mr36392863wjc.83.1402597293598;
        Thu, 12 Jun 2014 11:21:33 -0700 (PDT)
Received: from localhost (dslb-088-072-176-011.pools.arcor-ip.net. [88.72.176.11])
        by mx.google.com with ESMTPSA id j44sm6248587eeg.30.2014.06.12.11.21.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 12 Jun 2014 11:21:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.415.g8cd8cf8
In-Reply-To: <5399EA72.7060609@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251471>

Suggested-by: Stefan Beller <stefanbeller@gmail.com>
Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---

Am 12. Juni 2014 19:59 schrieb Stefan Beller <stefanbeller@gmail.com>:
> On 12.06.2014 18:12, Ralf Thielow wrote:
>> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
>>  #, c-format
>>  msgid "Switched to a new branch '%s'\n"
>> -msgstr "Gewechselt zu einem neuem Branch '%s'\n"
>> +msgstr "Gewechselt zu einem neuen Branch '%s'\n"
>
> How about ?
> +msgstr "Zu neuem Branch '%s' gewechselt\n"

Much better. Thanks!

 po/de.po | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/po/de.po b/po/de.po
index b777ef4..f7ecd1e 100644
--- a/po/de.po
+++ b/po/de.po
@@ -3498,17 +3498,17 @@ msgstr "Bereits auf '%s'\n"
 #: builtin/checkout.c:646
 #, c-format
 msgid "Switched to and reset branch '%s'\n"
-msgstr "Gewechselt zu umgesetzten Branch '%s'\n"
+msgstr "Zu umgesetztem Branch '%s' gewechselt\n"
 
 #: builtin/checkout.c:648 builtin/checkout.c:1033
 #, c-format
 msgid "Switched to a new branch '%s'\n"
-msgstr "Gewechselt zu einem neuem Branch '%s'\n"
+msgstr "Zu neuem Branch '%s' gewechselt\n"
 
 #: builtin/checkout.c:650
 #, c-format
 msgid "Switched to branch '%s'\n"
-msgstr "Gewechselt zu Branch '%s'\n"
+msgstr "Zu Branch '%s' gewechselt\n"
 
 #: builtin/checkout.c:706
 #, c-format
-- 
2.0.0.415.g8cd8cf8
