From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: [PATCH] git status: fix grammar when in detached head
Date: Sat, 19 Mar 2011 22:33:29 +0100
Message-ID: <4D852129.7050205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 19 22:34:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q13n2-0003pr-Dy
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 22:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757580Ab1CSVeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 17:34:19 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57573 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757562Ab1CSVeR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 17:34:17 -0400
Received: by bwz15 with SMTP id 15so4208196bwz.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 14:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:content-type:content-transfer-encoding;
        bh=Er3P3dWFY3lwyu98DtFUMnGW4avKvA48+lHhTAmSBwI=;
        b=naF76+bovyq5p8l5OI57EMA7hB/0Jx7km1a09y6Io75hLBpdj+vLOChLKLo6kP5u7a
         9ATfsxkD65eN9SWSbhnossLFHL9i6+1a44WR2xt4hlUtmWWaiVu98zh7Tc/E+KL2FlD5
         EMhDddP80re8gIulbqn/HVT/sUfh1uAou909E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=rB+OKKNB//mVWrhPlsIJNZKwYlrUZeXYrGZarmL9mR+acfmF+x3fAS/dr2WdAKORyP
         Tk3kN+kd4OwuihFpzDqS+x0Ubux7fEAQDxjMtI/4T16WgrR34jvDEWCrW3E32AvAzETJ
         Zqh8Ptz3XgFXB1au3OVAcjqGUrDIs2CoaQFvU=
Received: by 10.204.73.206 with SMTP id r14mr2128979bkj.181.1300570417163;
        Sat, 19 Mar 2011 14:33:37 -0700 (PDT)
Received: from [192.168.1.101] (app184.neoplus.adsl.tpnet.pl [83.26.149.184])
        by mx.google.com with ESMTPS id z18sm812361bkf.8.2011.03.19.14.33.35
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Mar 2011 14:33:36 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169466>


Signed-off-by: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
---
 wt-status.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

Not a native English speaker, but IMO the previous version isn't 
correct.

diff --git a/wt-status.c b/wt-status.c
index 4daa8bb..3214f52 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -643,7 +643,7 @@ void wt_status_print(struct wt_status *s)
 		else if (!strcmp(branch_name, "HEAD")) {
 			branch_name = "";
 			branch_status_color = color(WT_STATUS_NOBRANCH, s);
-			on_what = "Not currently on any branch.";
+			on_what = "Not on any branch currently.";
 		}
 		color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "# ");
 		color_fprintf(s->fp, branch_status_color, "%s", on_what);
-- 
1.7.4.1.295.ged435

-- 
Piotr Krukowiecki
