From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH 0/3] Fix some documented fixmes
Date: Fri,  2 Mar 2012 21:31:12 -0500
Message-ID: <cover.1330740964.git.jaredhance@gmail.com>
Cc: Jared Hance <jaredhance@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 03:31:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3ekz-00005M-3D
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 03:31:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946Ab2CCCbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 21:31:32 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43617 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771Ab2CCCbc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 21:31:32 -0500
Received: by iagz16 with SMTP id z16so3102984iag.19
        for <git@vger.kernel.org>; Fri, 02 Mar 2012 18:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=yUG32UbhJ+H9tp0U8wlNzHpOelrJrHpgxRta+RDiWzM=;
        b=wAGexmoYIb69pWbuuI6gd1XrrEOlEP7MnjBKXXc1it0pReCnR/rHd9zpv9iX6Q0JX2
         H+MLVMTEBOmt2Wt9MyX6lp6aKqqrrdTS38+EST9HgYsFPO9QcZ2xr01uACa0uhjMNVj8
         0g76OlGAkcdOTAo+LqKkJJpajtcHYx4rRLRZD+FTIJ4LAV948m0N0Izje03tc5B93fXv
         kaWnaKycKPkllBT+hvjYTiOwNxqqF8M38mIzQgAFiRrWWATttDv2dHcxH2xSdrKzrCYm
         amYwm2LKdJRmA+6mYPHbfgj8SCONlS70udwTUxxIq3sWkSXN7KubR4Pr1zFAMSn46PQP
         rn3w==
Received: by 10.50.178.8 with SMTP id cu8mr509110igc.12.1330741891553;
        Fri, 02 Mar 2012 18:31:31 -0800 (PST)
Received: from localhost.localdomain (cpe-174-101-220-163.cinci.res.rr.com. [174.101.220.163])
        by mx.google.com with ESMTPS id v3sm2578583igw.6.2012.03.02.18.31.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 Mar 2012 18:31:31 -0800 (PST)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192089>

A few patches that (hopefully) don't change the behavior of git except to
rectify a memory error. Also, this should ever so slightly help with
the parallelism of git (a GSoC proposal). All of these were found with
commented FIXME and git grep.

Jared Hance (3):
  Use startup_info->prefix rather than prefix.
  Fix memory leak in apply_patch in apply.c.
  Add threaded versions of functions in symlinks.c.

 builtin/apply.c |   10 ++++++++--
 cache.h         |    4 +++-
 git.c           |    2 +-
 symlinks.c      |   28 ++++++++++++++++++++++++++--
 trace.c         |   10 +++++-----
 5 files changed, 43 insertions(+), 11 deletions(-)

-- 
1.7.3.4
