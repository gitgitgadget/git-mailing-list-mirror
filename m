From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v4] cleanup duplicate name_compare() functions
Date: Thu, 19 Jun 2014 01:07:21 -0700
Message-ID: <1403165242-16849-1-git-send-email-jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 10:08:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxXO8-0004Wa-L1
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 10:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757470AbaFSIH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 04:07:59 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45562 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757393AbaFSIH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 04:07:57 -0400
Received: by mail-pb0-f46.google.com with SMTP id md12so1671885pbc.33
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 01:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=io5WbAF8q/47vZFmTamvNEosgtyqj0Z9WhoEuvHxVnU=;
        b=s+s46HcIHkRvqW8DRY/6kUahBDvaono5LW1inMGom+Hnucv3kuhcs6F/QHY49vTqQN
         8mvQd8HgRx6RI3KfN+Pje0s7M/uILrbnlNuCIkED/gvhivTwF+Bg+ZWl8JLIAguCIRHR
         vIagvbO7LIh3Q/4mdzmU/AexCGur6ii6A6ul5phNDykzHWO7jLATalp8gCfZUunoIyRO
         8HV2Gt/yNXD6gMVBu5TvbjDHULuEsUZ7opZGr9hIgYVJzTpttTLTt92sk2TSPf5TbKIS
         dQE+a4pHWqo2xi7l8oPit5pRBS99ls+oiRAi4HhWCLCqSZ3w3VMT2F4BZbxgiNMjrQaj
         C1lA==
X-Received: by 10.66.136.103 with SMTP id pz7mr3725778pab.140.1403165276367;
        Thu, 19 Jun 2014 01:07:56 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id dd5sm7160118pbc.85.2014.06.19.01.07.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jun 2014 01:07:55 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.693.g5dae59c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252101>

Version 4 of the patch series to cleanup the duplicate name_compare()
functions.

The previous patch series would have left the system in a broken state
if only part of the patches were applied.  This version condenses all
the patches in to a single working patch as Jonathan Nieder suggested [1].

[1]: http://marc.info/?l=git&m=140311885416615&w=2

Jeremiah Mahler (1):
  cleanup duplicate name_compare() functions

 cache.h        |  2 +-
 dir.c          |  3 +--
 name-hash.c    |  2 +-
 read-cache.c   | 23 +++++++++++++----------
 tree-walk.c    | 10 ----------
 unpack-trees.c | 11 -----------
 6 files changed, 16 insertions(+), 35 deletions(-)

-- 
2.0.0
