From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 1/2] git-show-ref.txt: remove word and make consistent
Date: Sat, 20 Jun 2009 21:40:45 -0700
Message-ID: <1245559246-11039-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 21 06:46:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIEwa-0006WR-CM
	for gcvg-git-2@gmane.org; Sun, 21 Jun 2009 06:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbZFUEkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 00:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbZFUEks
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 00:40:48 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:39226 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbZFUEkr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 00:40:47 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1204507wfd.4
        for <git@vger.kernel.org>; Sat, 20 Jun 2009 21:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=8L3laTn3wPh6UTxCpuZnuL+tWI9pdRc1fgte8TOAw98=;
        b=G5ZPZmpKjuSJeFHhZ04YLAY9acd/IHnNG/QLrzKB12npIytNkW38gvr4n+SWzwR/bF
         UTsJDvMtZrMG/JWnAC0wyTrJrCGKh0dKrZk/zZDPcXsr+48aHz/90yUixj0sP5AdPgpB
         +cR7nm90agBETbh5ljXBKzgRJuHbadURZkdwo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=KIuQWUAgUxiI0glJS0eD90F+/D61FrccnMxfJkwj42814jN0dxWlbbgSJ4Sqvc6BZg
         665P94DBmkOO3KHVlBbYuymXN2BMHL5GhPzekwffHfe7wKQ5LvF8AP4UKiL/2p00A//y
         Hu2gUUo5Tqe7CrNPp+oiQfIaOGjjKXCIGE8ZM=
Received: by 10.142.246.19 with SMTP id t19mr2002643wfh.202.1245559250244;
        Sat, 20 Jun 2009 21:40:50 -0700 (PDT)
Received: from earth (cpe-66-75-25-79.san.res.rr.com [66.75.25.79])
        by mx.google.com with ESMTPS id 22sm2971658wfg.7.2009.06.20.21.40.48
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Jun 2009 21:40:49 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sat, 20 Jun 2009 21:40:46 -0700
X-Mailer: git-send-email 1.6.3.2.316.gda4e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121961>

Under is better than in because of the nested nature of the .git
directory.

"also using" sounds a little odd, plus we say combined with later on so
just use that.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 Documentation/git-show-ref.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index 2f173ff..98e294a 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -24,7 +24,7 @@ The --exclude-existing form is a filter that does the inverse, it shows the
 refs from stdin that don't exist in the local repository.
 
 Use of this utility is encouraged in favor of directly accessing files under
-in the `.git` directory.
+the `.git` directory.
 
 OPTIONS
 -------
@@ -50,7 +50,7 @@ OPTIONS
 -s::
 --hash::
 
-	Only show the SHA1 hash, not the reference name. When also using
+	Only show the SHA1 hash, not the reference name. When combined with
 	--dereference the dereferenced tag will still be shown after the SHA1.
 
 --verify::
-- 
1.6.3.2.316.gda4e
