From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 0/2] Add @ shortcut, yet again
Date: Sun,  8 Sep 2013 21:06:32 -0500
Message-ID: <1378692394-27096-1-git-send-email-felipe.contreras@gmail.com>
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 09 04:11:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIqx5-0005xN-ID
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 04:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638Ab3IICLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 22:11:39 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:58251 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624Ab3IICLi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 22:11:38 -0400
Received: by mail-ob0-f179.google.com with SMTP id fb19so5463609obc.10
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 19:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=nucXUA1wcOsE+4JHYcjLSlbQ4dR4x/eQnbnpR4577r8=;
        b=FjZ3wbnjy0puzFXIvE0vahct3gFdMdZrw4jizZreYDvAl0jCtJg1sxfK2O0//K68VN
         keyQZz5Llb2YrpRz6doACk4hQgV6M9/2W8UD5YfDn3BmFs4YgUL5ZNfvyt3bm2K/I1CZ
         6r2QmmSIsx4GBpalU7jbtSjfRwgrjvJNpd3EJxH5pNX22vqloaYTNCqR7GaDMyhtx2sI
         /QlWqI3qAbQFcrkuEEfQ6KJfmOOA/WCLhwULNS24TtER8mNPV/wyvSFU4cNty8SsoeRJ
         OT5+lSXJhTCrLIv7F3aAJWLKh8Ocw78AAPBqTwP0jH8PfKxVC6i1NVBkfe4K7NRDq9TT
         QKTA==
X-Received: by 10.60.52.244 with SMTP id w20mr9797896oeo.30.1378692696291;
        Sun, 08 Sep 2013 19:11:36 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id y1sm11157933oek.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 19:11:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-338-gefd7fa6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234304>

Felipe Contreras (2):
  sha1-name: pass len argument to interpret_branch_name()
  Add new @ shortcut for HEAD

 Documentation/git-check-ref-format.txt |  2 ++
 Documentation/revisions.txt            |  3 +++
 cache.h                                |  2 +-
 refs.c                                 |  6 +++++-
 revision.c                             |  2 +-
 sha1_name.c                            | 36 ++++++++++++++++++++++++++++++----
 t/t1508-at-combinations.sh             |  4 ++++
 7 files changed, 48 insertions(+), 7 deletions(-)

-- 
1.8.4-338-gefd7fa6
