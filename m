From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH 3/3] i18n: Remove obsolete comments for translators
Date: Thu, 17 Apr 2014 13:37:19 +0800
Message-ID: <dc0974cc87aa692fdea4f145935df2c1ac3c9f49.1397712142.git.worldhello.net@gmail.com>
References: <cover.1397712142.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Brian Gesiak <modocache@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 07:38:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Waf1w-0001q0-Cy
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 07:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755221AbaDQFiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 01:38:11 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:32936 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087AbaDQFhz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 01:37:55 -0400
Received: by mail-pb0-f53.google.com with SMTP id rp16so11696034pbb.40
        for <git@vger.kernel.org>; Wed, 16 Apr 2014 22:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=eertwPotcXlen5ADV7UpIk9BEVVIO/uKi2b+oIBcbdM=;
        b=XVoiDY+3xPsyt6497ZBWRDfW1H8JX9Yv6VKHxziQyIRGzsTCvRv14k4HFqE6Csesvk
         7QxSzGbJ/+ngfEmdPT6GUKn/Fx8CbA8mJKT0wTqbHAxyVLHGZUckeEJz6FziAwcAzGEx
         4kbEH9lCBiw+0DcYcvC+K9fNt9kRGGKlaGrBtdHNuQmKrLQwE1IQP5WrN6BDPUpwWMA5
         w24jrmp59mhLzOVtATh3Xet46U7izFmodQGI+xM6RNyTceKPk9IFsRR+BT8GDjhRFYm6
         T/Ov+hpXAZlEeZ+NwVhCKnM3Z8rH0XwIwrkUQTvoQ0+3D2QFzLYuTIzqpkYz1xQOAD+i
         7CaA==
X-Received: by 10.68.221.129 with SMTP id qe1mr13079100pbc.135.1397713074640;
        Wed, 16 Apr 2014 22:37:54 -0700 (PDT)
Received: from localhost.localdomain ([124.207.10.6])
        by mx.google.com with ESMTPSA id n6sm50901640pbj.22.2014.04.16.22.37.51
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Apr 2014 22:37:53 -0700 (PDT)
X-Mailer: git-send-email 1.9.2.461.g942803f
In-Reply-To: <cover.1397712142.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1397712142.git.worldhello.net@gmail.com>
References: <CAN7MxmV5tzvGTTG+aOL73fLhbXc7YeOWvYwLkMyad0=mvffMHQ@mail.gmail.com> <cover.1397712142.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246405>

Since we do not translate diffstat any more, remove the obsolete comments.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 diff.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/diff.c b/diff.c
index 539997f..54d5308 100644
--- a/diff.c
+++ b/diff.c
@@ -1461,20 +1461,12 @@ int print_stat_summary(FILE *fp, int files, int insertions, int deletions)
 	 * but nothing about added/removed lines? Is this a bug in Git?").
 	 */
 	if (insertions || deletions == 0) {
-		/*
-		 * TRANSLATORS: "+" in (+) is a line addition marker;
-		 * do not translate it.
-		 */
 		strbuf_addf(&sb,
 			    (insertions == 1) ? ", %d insertion(+)" : ", %d insertions(+)",
 			    insertions);
 	}
 
 	if (deletions || insertions == 0) {
-		/*
-		 * TRANSLATORS: "-" in (-) is a line removal marker;
-		 * do not translate it.
-		 */
 		strbuf_addf(&sb,
 			    (deletions == 1) ? ", %d deletion(-)" : ", %d deletions(-)",
 			    deletions);
-- 
1.9.2.461.g942803f
