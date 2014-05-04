From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/4] remote-hg: more improvements
Date: Sat,  3 May 2014 21:16:50 -0500
Message-ID: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 04:27:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wgm9U-0004Qs-0l
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 04:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753480AbaEDC1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 22:27:36 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:58885 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753468AbaEDC1f (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2014 22:27:35 -0400
Received: by mail-ob0-f179.google.com with SMTP id wo20so1188009obc.24
        for <git@vger.kernel.org>; Sat, 03 May 2014 19:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=fkcOQKEBpBAKVP9UlwIFyEVzKxF2/O59qyNv0WG08n4=;
        b=cLm6aqcajGWl01hui6hJx7qx7o6Jlybt9Zu7fvvbjIow2M6aPXh2V5G6FVty1+mxzX
         Yu12oUeh4yQTSEMkUkYQLjzBG88x4EhAtZI2thsHa38D7o0P/9uUUGQtaoU4HhQbok6K
         Hnj/FUJec8WQkmo+YT0pmv9Gwsa2hMLKALrik7zNCUaIInOcaS4xkxZ/w6+kD25uRFWA
         /pRigo5YKQ9CeYBY6FmYRzoHkr9AMQU/21wsnJ+0j6OLgUA4vD8k4ZfltUwG5wCHHBx2
         oBj2XJTjG0e8LhWXBLV3d5jhw88k0oK768pT46EuAv5UXJ+EA+2ygPsmk9nVWtrz+KJt
         TmyQ==
X-Received: by 10.182.200.131 with SMTP id js3mr24246501obc.0.1399170455057;
        Sat, 03 May 2014 19:27:35 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id sm4sm8968266obc.3.2014.05.03.19.27.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 May 2014 19:27:33 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.20.g204a630
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248063>

Here's a bunch of tests more, and a fixes for Mercurial v3.0.


Felipe Contreras (4):
  remote-hg: add more tests
  t: remote-hg: add file operation tests
  t: remote-hg: trivial cleanups and fixes
  remote-hg: add support for hg v3.0

 contrib/remote-helpers/git-remote-hg |   6 +-
 contrib/remote-helpers/test-hg.sh    | 240 ++++++++++++++++++++++++++++++++++-
 2 files changed, 238 insertions(+), 8 deletions(-)

-- 
1.9.2+fc1.20.g204a630
