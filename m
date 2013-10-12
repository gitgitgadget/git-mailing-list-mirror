From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 13/20] transport-helper: trivial style fix
Date: Sat, 12 Oct 2013 02:07:03 -0500
Message-ID: <1381561636-20717-8-git-send-email-felipe.contreras@gmail.com>
References: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:13:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtOP-0005ga-Kr
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754649Ab3JLHNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:13:38 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:49863 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754508Ab3JLHNf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:13:35 -0400
Received: by mail-ob0-f181.google.com with SMTP id va2so3474106obc.12
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rrZ5vDDUzQ1cYKB2oshXt44pOtHuHOKDtkFUBpgbmbw=;
        b=SPCGV0EfjqBAMFA0o2OqNu8XNYxJWyHtLbfnnNP6vwscaUPQYT/q7K3MZU0/bypkZy
         SObc0IPQ0h4v82To+nfYirXofE4KWfGZsGcWWdAq/zAOucsIJue6igzXLAlfrx+v7MXs
         hx7c53UbcLkk/b2bCAZECZ4epo90iXyhizV5fYSMiQybZIGnB3n7OIx1WFbOZhOTg9Kd
         ivH9q/pJZ46OFm1l5mL+ENcruswpyFp1OnaQD6QZVovOyWQm3EzApmLtu5WPax0ISilQ
         I0jjyOEfMXOizdAiDcCgYdD7exQnN/rrLBI4BBgbqtgqcic+pjYFm4uPgJzk+Kq18pzw
         4ABA==
X-Received: by 10.182.104.130 with SMTP id ge2mr17633026obb.6.1381562015057;
        Sat, 12 Oct 2013 00:13:35 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s14sm101400720oeo.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:13:34 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236016>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 transport-helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/transport-helper.c b/transport-helper.c
index b32e2d6..673b7c2 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -269,6 +269,7 @@ static const char *unsupported_options[] = {
 	TRANS_OPT_THIN,
 	TRANS_OPT_KEEP
 	};
+
 static const char *boolean_options[] = {
 	TRANS_OPT_THIN,
 	TRANS_OPT_KEEP,
-- 
1.8.4-fc
