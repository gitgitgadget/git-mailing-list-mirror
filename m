From: Keshav Kini <keshav.kini@gmail.com>
Subject: [PATCH v2 0/4] git-svn.txt: miscellaneous changes
Date: Sun, 29 Sep 2013 18:45:56 -0500
Message-ID: <1380498360-18387-1-git-send-email-keshav.kini@gmail.com>
References: <1379971145-8971-1-git-send-email-keshav.kini@gmail.com>
Cc: Eric Wong <normalperson@yhbt.net>,
	Keshav Kini <keshav.kini@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 30 01:46:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQQgz-0000Ct-Hv
	for gcvg-git-2@plane.gmane.org; Mon, 30 Sep 2013 01:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752930Ab3I2XqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Sep 2013 19:46:22 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:34971 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210Ab3I2XqV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Sep 2013 19:46:21 -0400
Received: by mail-ob0-f175.google.com with SMTP id uz6so4609923obc.34
        for <git@vger.kernel.org>; Sun, 29 Sep 2013 16:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GX6OVVQeWlEIv7LxrmkrTNTodedQ32I6MKkE0UPAXRA=;
        b=maWGAPItUQmNhdqnJueF2uBWom0wXIxaz8rogp6bCBlvtgL0fErtZ8DtH2h7Fgsh1d
         SsziPgyy+hktm4R5CUDXL+PRfrRzRVvTkWt0w3UOijflrAz5c3Z3OGGZC70wA+pBT3Z5
         jslcqXPa1GGlUZPj/lxilZozE5vLLFRZIIY1mse/tXck1DwVbNHtxwRrk2fHXbV/I/d0
         vYYVrp60WeIfV6e7BYBVvxAOeYplyWzjHpQper3QQKSExTjGmw9pBFTdndTSdmdexydj
         gHCSniEKwykV7EPxeiBh0QHw1prlvOV0rHQ2XJuptnWo3xmSs9LDkFEAyUUJcCu76gk8
         h/Ug==
X-Received: by 10.182.246.39 with SMTP id xt7mr17303598obc.16.1380498380452;
        Sun, 29 Sep 2013 16:46:20 -0700 (PDT)
Received: from localhost (cpe-72-179-6-119.austin.res.rr.com. [72.179.6.119])
        by mx.google.com with ESMTPSA id xx9sm25700408obc.6.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 29 Sep 2013 16:46:19 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1379971145-8971-1-git-send-email-keshav.kini@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235608>

I'm not sure if this was the best way to split my changes into commits.
Please let me know if it wasn't.

Keshav Kini (4):
  git-svn.txt: fix AsciiDoc formatting error
  git-svn.txt: reword description of gc command
  git-svn.txt: replace .git with $GIT_DIR
  git-svn.txt: elaborate on rev_map files

 Documentation/git-svn.txt | 46 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 13 deletions(-)

-- 
1.8.3.2
