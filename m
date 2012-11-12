From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/4] remote-hg: small fixes
Date: Mon, 12 Nov 2012 18:41:04 +0100
Message-ID: <1352742068-15346-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 18:41:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXy0x-0004Px-1f
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 18:41:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752795Ab2KLRlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 12:41:25 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:36570 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305Ab2KLRlX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 12:41:23 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so197208bkw.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 09:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=GKB/kQSdZR3VYJi9QDoTifZBbS7GFBb3vz/B37qVjKc=;
        b=wEBLo7rcGzcedfA6HmOYFp2oFRDRTtK0QnOVk4Y5Z+MRPnxYQmlsfjTfH5rUfeCN8q
         +7Q4MNEZXEU1Ig5YraNzbhzzR8Ipl1ljzSAB54LGdEua9HK8kHuF+ENSCxSNL/x6afE6
         dM3l/QlTlmmfCRwuFNkfMKKaht65KsA6AY9uOaW/VWAO1JVyO9wKksZZQzvjuZrEUZD+
         L6CCUH3Blr97uX5Gew5CBZzoBHShEUFNs22AXmOctp0NTqbeUnWGdMYEQ++XtShpyawk
         0RkrFgn0usyso7VkUKrwIFTdAaYdTT2G2kHoklhd/Oh4/fjrRUC6vgw1Ne6MOkUke0ii
         bBAw==
Received: by 10.204.146.23 with SMTP id f23mr7254428bkv.69.1352742082119;
        Mon, 12 Nov 2012 09:41:22 -0800 (PST)
Received: from localhost (ip-109-43-0-114.web.vodafone.de. [109.43.0.114])
        by mx.google.com with ESMTPS id fm5sm3862115bkc.5.2012.11.12.09.41.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 12 Nov 2012 09:41:20 -0800 (PST)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209491>

Hi,

Just a few fixes, nothing major.

Felipe Contreras (3):
  remote-hg: fix compatibility with older versions of hg
  remote-hg: try the 'tip' if no checkout present
  remote-hg: avoid bad refs

Ramkumar Ramachandra (1):
  remote-hg: add missing config for basic tests

 contrib/remote-helpers/git-remote-hg | 7 ++++++-
 contrib/remote-helpers/test-hg.sh    | 9 +++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

-- 
1.8.0
