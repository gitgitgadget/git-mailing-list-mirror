From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/7] remote-bzr: generic updates
Date: Mon,  8 Apr 2013 12:27:09 -0500
Message-ID: <1365442036-25732-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 19:28:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPFrj-00017Y-1J
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 19:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762680Ab3DHR2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 13:28:18 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:52342 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762355Ab3DHR2R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 13:28:17 -0400
Received: by mail-oa0-f44.google.com with SMTP id h1so6504429oag.3
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 10:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=9BuCv9wIimGKdVRu0Ygbp2lh2G2YtHFxE+5SYVwgsEM=;
        b=mvGLNjJ0AMQNcak5g0OGF/tOQvrJbf72lrmra7dK/bSynwvMq07GbaXT7WnT9gloGr
         KugK2HXKfsE0R2pPXSa1qAeNPCCEB8foQcatVwd5BCO+uyCTkHrNodNUnwofhSw0LfSW
         diPHDPYASwbR0XvWmO6sgTqaAV1XFQ75YBssms1aWGrJ58gKsoRtcsWCcF5wRlyNf/iw
         CFrPF9v4NKKjRmjW5f8TUN8B0SNLLU47hthp2LGnvW2QAkMXg/Balt3+JDqGz6LuZx7k
         RYek+p1xM7cnvPx/KJDCOCfAXn8B+DGQc0QSpr+0VPB9Ihq2JuLkb/yGZGlZDssHOwwy
         pJzg==
X-Received: by 10.60.93.105 with SMTP id ct9mr15837194oeb.70.1365442097204;
        Mon, 08 Apr 2013 10:28:17 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id qk4sm25051322obc.5.2013.04.08.10.28.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 10:28:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220464>

Hi,

Basically the same couple of fixes, plus a fixed fix.

Christophe Simonis (3):
  remote-bzr: fix directory renaming
  remote-bzr: remove files before modifications
  remote-bzr: add utf-8 support for fetching

David Engster (1):
  remote-bzr: set author if available

Felipe Contreras (3):
  remote-bzr: only update workingtree on local repos
  remote-bzr: improve tag handling
  remote-bzr: add utf-8 support for pushing

 contrib/remote-helpers/git-remote-bzr |  64 +++++++++++++++------
 contrib/remote-helpers/test-bzr.sh    | 102 ++++++++++++++++++++++++++++++++++
 2 files changed, 149 insertions(+), 17 deletions(-)

-- 
1.8.2
