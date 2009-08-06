From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH] gitignore: git-remote-ftp git-remote-http and git-remote-https
Date: Thu,  6 Aug 2009 17:38:31 +0200
Message-ID: <8dc576fd37e450975746688994599ea61b539bdb.1249573014.git.nicolas.s.dev@gmx.fr>
Cc: Daniel Barkalow <barkalow@iabervon.org>, <git@vger.kernel.org>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 17:39:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ53n-0002nE-4g
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 17:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756012AbZHFPip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 11:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755516AbZHFPip
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 11:38:45 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:44181 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753756AbZHFPio (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 11:38:44 -0400
Received: by mail-ew0-f214.google.com with SMTP id 10so877264ewy.37
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 08:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=5D2BJV3PgRapl+oQ/wY2sWFgIwLIxljxlgIJjQnMeJI=;
        b=BEtP+L69MjtTH2u+aN3oLzit832YZFVuZRpVB1e2bVmYmhbG9a4Oe2m1nHYQzQRB3a
         HFBHh+Oime32G5vGeB+Hc7X63xb4lYRB2zxMlKRykK+w0C2H7PAWCWWCvSHSPmXEef+i
         /Bx1yb7IHuJWnVYB7BIfqIjlajfRwUNnkdP7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=BjRh/7I1GURV2pUUCvQCiPk8t0p/5sgjutx1CjYKjO8p/Uei36OpYjP0cqy54b1ySV
         a9+V5KnN7IghnD+sOBgq90hXtxNWjgNaz70qs7yLRzxrE44b7oeWdmV1YP2KFuP8jL1/
         JDO+ANqWDpBaCFXTilbzmWvitKhuNr7cMWBn4=
Received: by 10.210.53.1 with SMTP id b1mr9807550eba.62.1249573123572;
        Thu, 06 Aug 2009 08:38:43 -0700 (PDT)
Received: from localhost (91-164-149-117.rev.libertysurf.net [91.164.149.117])
        by mx.google.com with ESMTPS id 28sm574154eyg.42.2009.08.06.08.38.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Aug 2009 08:38:42 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.112.gc57a6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125088>

Since commit a2d725b we use a new external program.
Ignore the related compiled files.

Signed-off-by: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
---
 .gitignore |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 10808e3..c446290 100644
--- a/.gitignore
+++ b/.gitignore
@@ -104,6 +104,9 @@ git-receive-pack
 git-reflog
 git-relink
 git-remote
+git-remote-ftp
+git-remote-http
+git-remote-https
 git-repack
 git-replace
 git-repo-config
-- 
1.6.4.112.gc57a6
