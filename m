From: Astril Hayato <astrilhayato@gmail.com>
Subject: [PATCH] Documentation/gitk: Document new config file location
Date: Sun, 16 Mar 2014 14:10:23 +0000
Message-ID: <1394979023-2635-1-git-send-email-astrilhayato@gmail.com>
Cc: gitster@pobox.com, Astril Hayato <astrilhayato@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 16 15:11:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPBmY-0007RC-Ei
	for gcvg-git-2@plane.gmane.org; Sun, 16 Mar 2014 15:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbaCPOKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2014 10:10:47 -0400
Received: from mail-wi0-f193.google.com ([209.85.212.193]:62805 "EHLO
	mail-wi0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbaCPOKq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2014 10:10:46 -0400
Received: by mail-wi0-f193.google.com with SMTP id f8so506446wiw.8
        for <git@vger.kernel.org>; Sun, 16 Mar 2014 07:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=jhFAgGc5oIOd9cmeWpAmB238RZm7ZhPOaoVTX22/EKM=;
        b=LeUaigLSUxyX3H3DAJ/BpN1HZpMD8Zaxke1vkQ+lpV5i7iosdKQnGhtua45pA7RvXB
         01lfm8jS5cI4jSnYfunyLX0QwcZ6SLADeDlBXkD0ewe5ByzemBJXtuMC6+Vu1kPjHPPD
         IvdbXNDAwXkngB5BTWl13EL++c9O9lbSvMt2CTWq/AGKeJAw77l7TkHWp0LD49isaKk2
         uYEQe602NHn7EAHwV9uUa6adwLrReWrcDrUAWXuLmRgWg1fMEHzl4ZMrnXL/RQBklqKh
         MUqQuS6djfvXSM53bSegbH2gSzwTg0FWOYDWo5yOAnh3yKAd5abvG7SuCI/8aoZSwsQa
         NN6Q==
X-Received: by 10.194.185.148 with SMTP id fc20mr14608088wjc.27.1394979045101;
        Sun, 16 Mar 2014 07:10:45 -0700 (PDT)
Received: from localhost.localdomain (cpc4-blbn8-2-0-cust14.10-1.cable.virginm.net. [86.22.6.15])
        by mx.google.com with ESMTPSA id n3sm15662012wix.10.2014.03.16.07.10.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 16 Mar 2014 07:10:44 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244201>

User configuration file is now stored at $XDG_CONFIG_HOME/git/gitk

Signed-off-by: Astril Hayato <astrilhayato@gmail.com>
---
 Documentation/gitk.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index 1e9e38a..417a707 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -166,8 +166,8 @@ gitk --max-count=100 --all \-- Makefile::
 
 Files
 -----
-Gitk creates the .gitk file in your $HOME directory to store preferences
-such as display options, font, and colors.
+User configuration and preferences are stored at $XDG_CONFIG_HOME/git/gitk or
+$HOME/.config/git/gitk if $XDG_CONFIG_HOME is not set.
 
 History
 -------
-- 
1.9.0
