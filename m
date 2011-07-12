From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 0/3] doc/{fast-import,remote-helpers}: few clarifications
Date: Tue, 12 Jul 2011 21:10:25 +0600
Message-ID: <1310483428-29833-1-git-send-email-divanorama@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Johan Herland <johan@herland.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 17:10:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgebP-0005RE-7Z
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 17:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218Ab1GLPKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 11:10:13 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40863 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072Ab1GLPKL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 11:10:11 -0400
Received: by bwd5 with SMTP id 5so4115707bwd.19
        for <git@vger.kernel.org>; Tue, 12 Jul 2011 08:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=/EdsXrfGV4eV76Mfp4/y/sxpQSDMMz8ccWj4kkbU/ms=;
        b=FNX0XQvWFQeic9RS3v3N0ECZm3OQLF6zT/cJ/rvgkG09AXEm1d782gtJ+PVdYD8vdf
         zoilNf56p+/ZPAUQoGvUpz8z8lfbEil+QJ1O91PmVvbciOEseep3pELnyrYNkknGfvlh
         4qkjAdKHTlZqZH7pviD0RMw9Ocys8YAzfyVIg=
Received: by 10.204.126.36 with SMTP id a36mr38028bks.33.1310483410450;
        Tue, 12 Jul 2011 08:10:10 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id u32sm1398878bkk.49.2011.07.12.08.10.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Jul 2011 08:10:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176941>

doc/fast-import part seems pretty clear.
doc/remote-helpers is related to a recent remote-helpers series [1] and 
may need some discussion. For example, should we mention a bug [2] 
addressed as a part of [1], should we wait for [1] to document the 
fact that gitdir response can be read in the middle of capabilities 
reporting.

[1] http://thread.gmane.org/gmane.comp.version-control.git/176002
[2] http://thread.gmane.org/gmane.comp.version-control.git/176002/focus=176020

Dmitry Ivankov (3):
  doc/fast-import: clarify notemodify command
  doc/fast-import: document feature import-marks-if-exists
  doc/remote-helpers: document the gitdir feature

 Documentation/git-fast-import.txt    |   16 +++++++++++++---
 Documentation/git-remote-helpers.txt |   15 +++++++++++++++
 t/t9300-fast-import.sh               |   15 +++++++++++++++
 3 files changed, 43 insertions(+), 3 deletions(-)

-- 
1.7.3.4
