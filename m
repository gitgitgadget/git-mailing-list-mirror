From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 0/4] git-p4: fix filetype detection on files opened exclusively
Date: Fri,  3 Apr 2015 19:53:34 +0100
Message-ID: <1428087218-8186-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Junio C Hamano <gitster@pobox.com>,
	Blair Holloway <Blair_Holloway@playstation.sony.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 03 20:54:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ye6jR-0001C6-34
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 20:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767AbbDCSyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 14:54:12 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:36572 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbbDCSyL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 14:54:11 -0400
Received: by wizk4 with SMTP id k4so51479400wiz.1
        for <git@vger.kernel.org>; Fri, 03 Apr 2015 11:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=pUO1Q+kXVg3rJLI2RlEytihkkrBJfbo9l+I+xnZBB08=;
        b=fUosnqR9/y+f0ELzAlp6bNHx+8dYJgXgQl7NuG4F5yZELl5VeYJBOTg0TRzhxOVnqX
         DxTWIp1J2ppXsFBrAd1AjIFIJE+L68LzskFehc0ABIR9SKmYB7wDSVEHfbL1XnGt9GJl
         OpoVXTxszAHuoclXmCQLHU4TpL8MBRRpdWRzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pUO1Q+kXVg3rJLI2RlEytihkkrBJfbo9l+I+xnZBB08=;
        b=dd+JoVXTtA8r5j3z82MOkq/zJtOacr4MLmb3PVWbMwhoxMOOURtuON74Son7QZiQnL
         KIlUljt7eUXTNEVZyQBAyzSbwtVqT0sdx7ztS/aPRIm9a3Hot/pCWLGsZikLNQD5qeGZ
         fXRoSwBXWypk5+XG8w/xTUEPUBkAEWfzzqibVJLKOQHjjeIUKpSbLdkS8v2mSUnQolfy
         62Ts45N/Py544WAsEAOndDeaCXwMhz+H7xKCziSYRrAW1nwfjk1ztHhFEvpKZ7v3I8x+
         GduNgbCJnYLCkdQMdcOeYWtDwoQK6fNMFPdSurfn9OvsDM7E8bWXMlxH+Q40lcZ3GRdb
         YiLg==
X-Gm-Message-State: ALoCoQlKTOpzlZKM8Vd1S2ssFAxburJx1dqGCs8+q7xzCzOcCqrarjUrbDYMaBUnoSrlDw3OTXaT
X-Received: by 10.180.74.144 with SMTP id t16mr7949576wiv.33.1428087249794;
        Fri, 03 Apr 2015 11:54:09 -0700 (PDT)
Received: from ethel.local.diamand.org (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id fy2sm3782967wic.15.2015.04.03.11.54.08
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2015 11:54:08 -0700 (PDT)
X-Mailer: git-send-email 2.3.4.48.g223ab37
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266716>

This is a followup series to Blair's patch to fix filetype detection on files
opened exclusively. It updates the git-p4 unit tests to catchup with that
fix, fixing a couple of small bugs in the original tests.

Holloway, Blair (1):
  git-p4: fix filetype detection on files opened exclusively

Luke Diamand (3):
  git-p4: fix small bug in locked test scripts
  git-p4: small fix for locked-file-move-test
  git-p4: update locked test case

 git-p4.py                |  2 +-
 t/t9816-git-p4-locked.sh | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.3.0.rc1.30.g76afe74
