From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/6] completion: fixes
Date: Wed, 30 Apr 2014 06:07:39 -0500
Message-ID: <1398856065-2982-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 13:18:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfSWv-00038T-S5
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 13:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758670AbaD3LSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 07:18:22 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:53628 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691AbaD3LSV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 07:18:21 -0400
Received: by mail-yk0-f180.google.com with SMTP id q9so1313910ykb.39
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 04:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=/j+Z1zAFbwFKPb4YY+WE6wWHXV/uSPahsiiLSwdRHZk=;
        b=GPpMNx7TBNQOetWuNtHXO93LXlUwwMrww4180WRnl+Zfqa+1iW/+TAWSZ3YSYIT1aV
         ow96QD6acoTCA5/gszwMHlha4kQCTKxTIT4xYLrD00Mugn2jLA3IvT8INhb8gMEpwoha
         lQ4gSdh9svO4xPBBbzIbpnzMPn3kSCn2CP7z8RG+GjY29l53tNqsB/LPb1K4dizODAr8
         69xGG+taBUPPy13HW0dtQE70KUFFJ6LTdz/S30DbTpWRcC2d+kQ0vRPQKwCi4tFM9MEe
         BG8conGM6YGHu99lHeQO1/nzfzfH5Z8GWIjbnAZ678DPmqV/Gp11C0Y8hW4jRyNbECfr
         461A==
X-Received: by 10.236.75.74 with SMTP id y50mr4900694yhd.38.1398856700893;
        Wed, 30 Apr 2014 04:18:20 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id t9sm42277007yhg.18.2014.04.30.04.18.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Apr 2014 04:18:19 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.11.g71fb719
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247698>

A bunch of cleanups and fixes.


Felipe Contreras (6):
  completion: bash: remove old wrappers
  completion: bash: remove zsh wrapper
  completion: zsh: don't hide ourselves
  completion: remove zsh hack
  completion: zsh: trivial cleanups
  completion: bash: cleanup cygwin check

 contrib/completion/git-completion.bash | 80 +---------------------------------
 contrib/completion/git-completion.zsh  | 18 ++------
 2 files changed, 6 insertions(+), 92 deletions(-)

-- 
1.9.2+fc1.11.g71fb719
