From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/6] branch: trivial style fix
Date: Fri, 30 Aug 2013 16:56:46 -0500
Message-ID: <1377899810-1818-3-git-send-email-felipe.contreras@gmail.com>
References: <1377899810-1818-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 31 00:01:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFWlF-0006zB-5Y
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 00:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755412Ab3H3WBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 18:01:35 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:50118 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753582Ab3H3WBe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 18:01:34 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so2405336obc.40
        for <git@vger.kernel.org>; Fri, 30 Aug 2013 15:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XTtwyTy8+jt6kDoSwgrUtt3Ty1h7qZ+wtGM5p8/hV6I=;
        b=CWa2JRQKwCXx3VXSrEXQUkcwc9RbfFJSDl64U2l23+ZrnE2nD2dNgFhyc5m9SAcM/T
         SiLoGMtvtrWt6u09GmKnKy4munM2PXBTFrldduwzWxcGhGuMMtoyWNbH22NCbXZxC0xn
         e6Fu52cGutgg8hQX5M/WGJTSj3QMjPluzWOzEka/trSn+ThgQ6XpSF7JJlOeyG+nQjfv
         /b3lW7PCEOK1I0LeRxpidnM8HpauTFMf8NLj01Lz7H21EJasYnhqVyRiDuaDRmjjgIM7
         SCKONvXof+XMaFMkcz/UnTGmAp8j6LNaIoVVP/Kt6Px+NF+Y76Mv45jknCTwKXkyyxK9
         PjHg==
X-Received: by 10.182.18.102 with SMTP id v6mr8516509obd.71.1377900093611;
        Fri, 30 Aug 2013 15:01:33 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id pt4sm62948obb.14.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 30 Aug 2013 15:01:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377899810-1818-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233474>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/branch.c b/branch.c
index c5c6984..546c4b4 100644
--- a/branch.c
+++ b/branch.c
@@ -307,7 +307,7 @@ void create_branch(const char *head,
 			 start_name);
 
 	if (real_ref && track)
-		setup_tracking(ref.buf+11, real_ref, track, quiet);
+		setup_tracking(ref.buf + 11, real_ref, track, quiet);
 
 	if (!dont_change_ref)
 		if (write_ref_sha1(lock, sha1, msg) < 0)
-- 
1.8.4-fc
