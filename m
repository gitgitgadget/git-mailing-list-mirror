From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/5] Fixes
Date: Wed,  9 Apr 2014 13:49:59 -0500
Message-ID: <1397069404-7451-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 09 21:00:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXxjM-0006F9-0Z
	for gcvg-git-2@plane.gmane.org; Wed, 09 Apr 2014 21:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933720AbaDITAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2014 15:00:07 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:55914 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933354AbaDITAF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2014 15:00:05 -0400
Received: by mail-ob0-f181.google.com with SMTP id wp4so3190600obc.40
        for <git@vger.kernel.org>; Wed, 09 Apr 2014 12:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=2Wrfo/BMoBnenWFXgronkYgWuY9wYXnU6DgpyoVln2M=;
        b=O730T6ZKjoKuBs4uFJpy87rsJBT9lrochsMYiAxrROO79XyxvGamaFIUqi/M2UzMAl
         bazmt9A2sTIdnbBCG9ILMVTv3znM6AX+aH74AHbI0SV/eYLtZJD8ZY2vvZBiD3UovZ/z
         C7SrfglYxrBax6qruMV7b+0YkgCA4X4dWIUQCoatEHN6sroaEaYMMLdD7Yyn++MHHLUk
         Ia9EgUX+BbFe/kST+vGPbyMJTEY/EVM8Zd9xZMByeCfb+7OoQ0Y7ImzzXfjQw8StxX+w
         NiA+asOBESVv+ooJ4M4qYUUGyAtojDBOjvGCqUZmZxn87WdlLyMai5rnOpTBd7E+nMWZ
         LFLw==
X-Received: by 10.60.69.71 with SMTP id c7mr1480562oeu.82.1397070004689;
        Wed, 09 Apr 2014 12:00:04 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id qh7sm2863838obc.13.2014.04.09.11.59.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Apr 2014 12:00:00 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245988>

Felipe Contreras (4):
  remote-helpers: allow all tests running from any dir
  remote-hg: always normalize paths
  remote-bzr: add support for older versions
  completion: fix completion of certain aliases

dequis (1):
  remote-bzr: include authors field in pushed commits

 contrib/completion/git-completion.bash   |  1 +
 contrib/completion/git-completion.zsh    |  1 +
 contrib/remote-helpers/git-remote-bzr    |  6 ++++--
 contrib/remote-helpers/git-remote-hg     |  1 +
 contrib/remote-helpers/test-bzr.sh       | 24 ++++++++++++++++++++++++
 contrib/remote-helpers/test-hg-bidi.sh   |  3 ++-
 contrib/remote-helpers/test-hg-hg-git.sh |  3 ++-
 7 files changed, 35 insertions(+), 4 deletions(-)

-- 
1.9.1+fc1
