From: Fabio Porcedda <fabio.porcedda@gmail.com>
Subject: [PATCH] contrib/subtree: remove "push" command from the "todo" file
Date: Thu,  5 Nov 2015 16:26:57 +0100
Message-ID: <1446737217-6646-1-git-send-email-fabio.porcedda@gmail.com>
Cc: git@vger.kernel.org, James Denholm <nod.helm@gmail.com>,
	Alexey Shumkin <Alex.Crezoff@gmail.com>,
	David Aguilar <davvid@gmail.com>,
	Danny Lin <danny0838@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Thomas Ackermann <th.acker@arcor.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 16:27:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuMRX-0001mp-6b
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 16:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1033021AbbKEP1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 10:27:10 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36776 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754933AbbKEP1J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 10:27:09 -0500
Received: by pacdm15 with SMTP id dm15so66201203pac.3
        for <git@vger.kernel.org>; Thu, 05 Nov 2015 07:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=vijGXJ0ubzEZKnPsjyS4doXWjVshsVqhsIOu00hSq8Q=;
        b=wE+Uf1hH324Af68Tv2ct6y21inmnOI7VUu4T+HdJnVUV87F4VNGUC5dZearKlOmLk6
         32oeXF0wknACwMlD3bvui+k23XnfaNxFaxdIqmSHX238nqe9a8N8qIzEyzPJ4acW1dfN
         H3XjSysaFmnCsGvNXFfg/sUbQflmOl8QfmwJtty0cEN2LTMOpGcOKIfv71hc0m3plg1E
         EdLsagl1/hexDGw5lbFV8ywk1P/VYLzlCTsEyS8YnhJLBlSDUAxITumvsi84UHp3FPPS
         ARbaNfXaa8RB1FV/LUWwXoLgocMhEP1B7izFTLcK9viEGkE7AYPL4mtoF4E1v6MuH11W
         8kDA==
X-Received: by 10.66.150.165 with SMTP id uj5mr9891312pab.23.1446737228078;
        Thu, 05 Nov 2015 07:27:08 -0800 (PST)
Received: from ld2077.tmt.telital.com ([213.205.6.118])
        by smtp.gmail.com with ESMTPSA id ku1sm8563967pbc.47.2015.11.05.07.27.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2015 07:27:06 -0800 (PST)
X-Mailer: git-send-email 2.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280921>

Because the "push" command is already avaiable, remove it from the
"todo" file.

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 contrib/subtree/todo | 2 --
 1 file changed, 2 deletions(-)

diff --git a/contrib/subtree/todo b/contrib/subtree/todo
index 7e44b00..0d0e777 100644
--- a/contrib/subtree/todo
+++ b/contrib/subtree/todo
@@ -12,8 +12,6 @@
 		exactly the right subtree structure, rather than using
 		subtree merge...)
 
-	add a 'push' subcommand to parallel 'pull'
-	
 	add a 'log' subcommand to see what's new in a subtree?
 
 	add to-submodule and from-submodule commands
-- 
2.6.2
