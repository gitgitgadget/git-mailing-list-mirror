From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH] Document .git/modules
Date: Sun,  9 Jun 2013 13:11:36 +0200
Message-ID: <1370776296-4625-1-git-send-email-iveqy@iveqy.com>
References: <CAPig+cTHFcvWyoQMConxRTgEz4pq4_3Y-abFp8xAPjsdHniQ8Q@mail.gmail.com>
Cc: iveqy@iveqy.com, gitster@pobox.com, sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 13:09:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UldUl-0002Da-Ac
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 13:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933Ab3FILJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 07:09:06 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:33505 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797Ab3FILJF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 07:09:05 -0400
Received: by mail-lb0-f172.google.com with SMTP id v20so996602lbc.3
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 04:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=1V+XwV1j6U2fVqEX6u9vRntdbvVoYP5tZT9bPpyvkYE=;
        b=Iq0CD3Vw8iZ9yF0Jb2p1rWAMZkExvDVKCZyWW25NyTGVx2eeKmsNXgDzM3AQr3nDIc
         ierguyQq7bMwlAhctFqTotfOTxs+GIBVtgQq74wrN+NOx9VUUMtA5J9GPhh+VkAm+WqX
         AHipWFRMTbwN62QR7Er1v07AzzF3f63i1wIWad34FtdWY+dkYtHaJlhSAnMJNKlzaq9Z
         4HqFqr5NXrowADt771AHaP2/OWOox3EuqCoYznmJpeZpC3JiOAHULqHFiQqE+Jp6fYol
         PEvIWf0cEFbGWojwicmhsS0Jea1eefU5SV1sckzeuYKRpVj09caMo5kvZGySTr+j0xYs
         Ncog==
X-Received: by 10.112.182.39 with SMTP id eb7mr4421672lbc.30.1370776141554;
        Sun, 09 Jun 2013 04:09:01 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id x5sm3852426lbx.8.2013.06.09.04.09.00
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 04:09:01 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UldXB-0001DA-1F; Sun, 09 Jun 2013 13:11:41 +0200
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <CAPig+cTHFcvWyoQMConxRTgEz4pq4_3Y-abFp8xAPjsdHniQ8Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226953>

A note in the beginning of this document describes the behavior already.
This patch just adds where to find the repositories.

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
---
 Documentation/gitrepository-layout.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index d6f3393..aa03882 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -211,6 +211,9 @@ shallow::
 	and maintained by shallow clone mechanism.  See `--depth`
 	option to linkgit:git-clone[1] and linkgit:git-fetch[1].

+modules::
+	Contains the git-repositories of the submodules.
+
 SEE ALSO
 --------
 linkgit:git-init[1],
-- 
1.8.1.5
