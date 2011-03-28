From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH 07/10] Docs: git tag: Use 'who' again
Date: Mon, 28 Mar 2011 14:58:05 +0000
Message-ID: <1301327622-8595-8-git-send-email-mfwitten@gmail.com>
References: <1301327622-8595-1-git-send-email-mfwitten@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 17:55:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Emb-0004Wa-Hk
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 17:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754731Ab1C1Pyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 11:54:54 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:45043 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754207Ab1C1Pyx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 11:54:53 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1221676ewy.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 08:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:message-id:x-mailer
         :in-reply-to:references:date;
        bh=Rn+9P1egpNyD00pSN4XmGovTJlyAMoRccEojw+qczDw=;
        b=w1N3EAEJm1LMjr5xy/ROgd1m58yq+LqBHaOzDF/gXf7uv0uypx1AhVeLm3OJmBKlkV
         9ByUId66+L/DnDvgScJW8+GMbOzWZEqJrib3Sd+jGs3jZ6r93RCJLpfwd6SaavWN06V7
         OsnezH9oDwfJBhUPaxDDW6VVPRJ52za2jTpSc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:message-id:x-mailer:in-reply-to:references:date;
        b=b4HVLTzDFnUhJF9L/o4cdtLlkL+x5q/5vDls1x6VOIdJUHkbuwu4IygTvFFQ+0lw4g
         5hcqKzaYTpmRegYdZt6JImLEKvQ/AcIKF3mMRxOcufuSeC7TzE+x3Hju6x7/TM4EgRCq
         Oae74qzugDE1Sr0vtmXr//FLjDt+G65xDufvg=
Received: by 10.14.8.131 with SMTP id 3mr1772593eer.134.1301327692638;
        Mon, 28 Mar 2011 08:54:52 -0700 (PDT)
Received: from localhost.localdomain ([174.143.243.243])
        by mx.google.com with ESMTPS id v1sm2878807eeh.6.2011.03.28.08.54.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 08:54:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.18.g68fe8
In-Reply-To: <1301327622-8595-1-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170147>

Also, remove an unnecessary parenthetical comment.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-tag.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 73f340b..695a224 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -225,9 +225,9 @@ primarily interested in the networking part of the kernel") who may
 have their own set of tags (e.g. "this is the third release
 candidate from the networking group to be proposed for general
 consumption with 2.6.21 release") to another circle of people
-(e.g. "people who integrate various subsystem improvements").
-The latter are usually not interested in the detailed tags used
-internally in the former group (that is what "internal" means).
+(e.g. "people who integrate various subsystem improvements") who
+are usually not interested in the detailed tags used
+internally in the former group.
 That is why it is desirable not to follow tags automatically in
 this case.
 
-- 
1.7.4.18.g68fe8
