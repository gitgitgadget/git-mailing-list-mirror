From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 0/2] Add @ shortcut, again
Date: Mon,  2 Sep 2013 01:34:28 -0500
Message-ID: <1378103670-3394-1-git-send-email-felipe.contreras@gmail.com>
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 02 08:39:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGNnC-0004xe-Pm
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 08:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755613Ab3IBGjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 02:39:14 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:45368 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754388Ab3IBGjO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 02:39:14 -0400
Received: by mail-oa0-f42.google.com with SMTP id n12so827143oag.29
        for <git@vger.kernel.org>; Sun, 01 Sep 2013 23:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=nucXUA1wcOsE+4JHYcjLSlbQ4dR4x/eQnbnpR4577r8=;
        b=itzYWdoBp2FcaIctfb5Dg8LQvQidJ+4g8GWnSmtZKtz5H5rrb2lAaRrImV6gdLqPUe
         tVBQ/h/ERANgPLyKIL8vEMV6nXg4wKeM2sEQ6M2+tzYF3gGUskU3cDnWuPS7BVGz+nkA
         1yFA2Gz/tRqeYKVL4K9ZlVYRDDCDDPiuvpAYmdLlSNGvDDBb1jinhKbKAKum9Zv77/4z
         eSfgiQFvTY7YyxYkozMTGGPE47UEpehkBGEL+ac/N/ZOTtV3W4c+PwfjMisfqCs76cpi
         TSERXUULoPDim/9WWbtkW/rXrU6o/y5VWdpOKgJU+Zs3NlfYOmFxnvJJULduBLHCRqXS
         pinw==
X-Received: by 10.182.71.37 with SMTP id r5mr15993435obu.22.1378103953629;
        Sun, 01 Sep 2013 23:39:13 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id qi5sm11956488obb.6.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 01 Sep 2013 23:39:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-338-gefd7fa6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233615>

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
