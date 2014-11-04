From: Ben North <ben@redfrontdoor.org>
Subject: [PATCH] gitignore.txt: fix spelling of "backslash"
Date: Tue, 4 Nov 2014 22:18:33 +0000
Message-ID: <CAHG0eJWMyps1DCO583+ShjH+hWW3dPbW++nZFo-n=hJgoNCtEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 04 23:18:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlmQw-0001cG-3d
	for gcvg-git-2@plane.gmane.org; Tue, 04 Nov 2014 23:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbaKDWSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2014 17:18:34 -0500
Received: from mail-qa0-f44.google.com ([209.85.216.44]:46411 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbaKDWSe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2014 17:18:34 -0500
Received: by mail-qa0-f44.google.com with SMTP id w8so10659312qac.31
        for <git@vger.kernel.org>; Tue, 04 Nov 2014 14:18:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc
         :content-type;
        bh=VBPVPgkjxnxeoBQLq1XyGiEZhEZ9YXA5ACkJl0IdiAE=;
        b=bBn8FW0+KJ+Ekw1YVbkwtl7mXgMtEyiMHyHiofpOzvB0NhWyfglVgJP/+o004rYd7h
         VdbzitTGWEh0C9r4AuV1RDCgxNR5WdB6o0T6YxxShzgq98XQQ+E/NloRnSzH+IcN6qCo
         TlXBLsSZ8HpYssHZycOTFzQ4/1TvcpOp55byAzWHaXsj2WnPl7Z7vqNa/X8nmclvseQq
         ZwA8H/wO1VFm4Nrrvvg0Nj0yYTUhgnqKBe2LqEDVDrdNj9nnSakOPhHpNser3uJZXmY7
         3j4cFw/FdKB3m3nUU515FrtsxJ9YosZuAM0lhR+mf+OR8SFKHK6VCLnYKVYVjjXrfzmn
         CqaA==
X-Gm-Message-State: ALoCoQnuVpAzTGEyNefdyi/7hKegDLSzS1yMTZUdJjeyi6DULYxuDhINpUBE+Mbtks6O7VyHsbkX
X-Received: by 10.140.30.165 with SMTP id d34mr58608033qgd.55.1415139513390;
 Tue, 04 Nov 2014 14:18:33 -0800 (PST)
Received: by 10.140.202.147 with HTTP; Tue, 4 Nov 2014 14:18:33 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ben North <ben@redfrontdoor.org>
---
 Documentation/gitignore.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 8734c15..09e82c3 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -77,7 +77,7 @@ PATTERN FORMAT
    Put a backslash ("`\`") in front of the first hash for patterns
    that begin with a hash.

- - Trailing spaces are ignored unless they are quoted with backlash
+ - Trailing spaces are ignored unless they are quoted with backslash
    ("`\`").

  - An optional prefix "`!`" which negates the pattern; any
-- 
1.8.3.2
