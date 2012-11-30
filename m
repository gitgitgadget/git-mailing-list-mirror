From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 0/4] t4041 (diff-submodule-option): minor cleanup
Date: Fri, 30 Nov 2012 17:07:32 +0530
Message-ID: <1354275456-11104-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 30 12:38:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeOuu-0002aT-5H
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 12:38:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757646Ab2K3Lhn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2012 06:37:43 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:59889 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691Ab2K3Lhm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2012 06:37:42 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so192334dak.19
        for <git@vger.kernel.org>; Fri, 30 Nov 2012 03:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Ykfp3q0C4SHhVp80Oc2kgf6RLAz5LitRPTdqFhmXoUM=;
        b=LdQaSWZBjFHRA+bw9q8RUdRZ1L3hqD4ezXXOELscPQC53KDJ4H0Qn7jRkH3rAiLcqI
         WRn3eieow8+9N8Kcs7A9ltX0NJxpTSqr9bMUWrefT/xGptG4HHvobiw2r7NdBZHOVzj1
         g32odmK9XRifT1tpYQBvBzHH3Btnx8hAxcY9E/NS8G9a153ztozvKTI9hKFYa2UzPxr0
         wHR0KA4QcMzuvilrJwWCTf2PuayO2oA67/JnBN4EzmzWiDcCA7RcN8auW+TKU4rXlpwo
         QvGAPR8aq2Wha4/BZj5ArHfQd7y3Hzut7DUd4DZaBsRQMpnMWudl2IGRimY/RW4nfXGi
         jo3g==
Received: by 10.68.232.195 with SMTP id tq3mr4838562pbc.70.1354275462433;
        Fri, 30 Nov 2012 03:37:42 -0800 (PST)
Received: from fran.foss.conf ([59.90.224.156])
        by mx.google.com with ESMTPS id ok8sm2923120pbb.42.2012.11.30.03.37.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 30 Nov 2012 03:37:41 -0800 (PST)
X-Mailer: git-send-email 1.7.8.1.362.g5d6df.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

v1 is here: 1354005692-2809-1-git-send-email-artagnon@gmail.com

This is in response to Junio's review of v1.

Thanks.

Ram

Ramkumar Ramachandra (4):
  t4041 (diff-submodule-option): don't hardcode SHA-1 in expected
    outputs
  t4041 (diff-submodule-option): parse digests sensibly
  t4041 (diff-submodule-option): rewrite add_file() routine
  t4041 (diff-submodule-option): modernize style

 t/t4041-diff-submodule-option.sh |  496 +++++++++++++++++++-------------------
 1 files changed, 247 insertions(+), 249 deletions(-)

-- 
1.7.8.1.362.g5d6df.dirty
