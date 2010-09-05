From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH] Fix whitespace issue in object.c
Date: Sun, 5 Sep 2010 15:36:33 -0400
Message-ID: <ae5b0b884e82af6fc731da8054421ec20f935bbd.1283715337.git.jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Sep 05 21:36:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsL1L-0007Op-BL
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 21:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754100Ab0IETgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 15:36:37 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55481 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224Ab0IETgh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 15:36:37 -0400
Received: by mail-vw0-f46.google.com with SMTP id 3so2764317vws.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 12:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=VCO4unHu42yAHWRbUcHZ6uADZ/EOr2fBNBC+ZqiV1NI=;
        b=Y8NXOrRPYjco1h5MUaR7X5tFXp4gYXJYDycnZsNv1oVtfKife3GKP9GjmySc78cBzi
         S3jDq07MSIuPwbAIhpjV7QITdsC1bv2SkwnFTALGdctroOA33q1VPBGFXzWwbTyWkWA8
         fhTgIamfBafPk1wg19n4L51h74aT6UJp67zcI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=ObctmCQCQjvXy12DUlwbODiLacv6Tco8fV+TgXX/7ZbhuhTI7721oRka/urVnTKIHb
         Hx3HZcTPqG/pkQGIxWsQEaGOj5hOKZZd56D53taE5etozFrJUJsqJDTZcqMjBP7Hle6a
         TOkcJeq48LxSgPoCA1Eo1MhoKvt2LH9GcN4rc=
Received: by 10.220.126.208 with SMTP id d16mr1065730vcs.66.1283715396734;
        Sun, 05 Sep 2010 12:36:36 -0700 (PDT)
Received: from localhost.localdomain (cpe-174-101-213-29.cinci.res.rr.com [174.101.213.29])
        by mx.google.com with ESMTPS id x15sm884233vcr.35.2010.09.05.12.36.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Sep 2010 12:36:36 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155477>

Change some expanded tabs (spaces) to tabs in object.c.

Signed-off-by: Jared Hance <jaredhance@gmail.com>
---
 object.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/object.c b/object.c
index 277b3dd..2eda53c 100644
--- a/object.c
+++ b/object.c
@@ -211,10 +211,10 @@ struct object_list *object_list_insert(struct object *item,
 				       struct object_list **list_p)
 {
 	struct object_list *new_list = xmalloc(sizeof(struct object_list));
-        new_list->item = item;
-        new_list->next = *list_p;
-        *list_p = new_list;
-        return new_list;
+	new_list->item = item;
+	new_list->next = *list_p;
+	*list_p = new_list;
+	return new_list;
 }
 
 int object_list_contains(struct object_list *list, struct object *obj)
-- 
1.7.2.2
