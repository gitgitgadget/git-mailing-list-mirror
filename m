From: Jimmy Thrasibule <thrasibule.jimmy@gmail.com>
Subject: Git and Quilt
Date: Mon, 09 Jul 2012 13:57:09 +0200
Message-ID: <1341835029.10119.36.camel@sysadmin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 09 13:57:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoCai-0006ig-0h
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 13:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753341Ab2GIL5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 07:57:19 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:65368 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090Ab2GIL5S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2012 07:57:18 -0400
Received: by eaak11 with SMTP id k11so4293339eaa.19
        for <git@vger.kernel.org>; Mon, 09 Jul 2012 04:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:subject:from:to:date:content-type:x-mailer:mime-version
         :content-transfer-encoding;
        bh=OQIAuXYJ6lqx2nND+n0rmzGIC5Ivce7gF2AUt156+gk=;
        b=M2fMgStrQaDBmDt80ryxlWnBPbvYi6shSXzYSTUQXYlFZMUR8gzFc8TL175NpERTQY
         OG8/htNbRV+/6eQGSQXHR/kiX16uHcSFRh4MWWbC5WUH2p5h7NI6ikq3MikXKWJpqe/3
         8d/FDzyHKceXWOmFkkzYviJecxg2qh0vHwhBgNI7y1q0GVQ9h8++DxZnlEcLUxvwX5CM
         CiBFbFHw1VQX0PUTkrdEAisf2zl30K9rgj3r9DsdM32ncVR/+ffqL3zzrKkOJ+voF+b8
         /6bAeurQGbstdqOCCxiFxr+2d6wozm1c/wmu315zEvbM/6hoXEWPrX7sk5zFAemrHu9K
         Y74A==
Received: by 10.14.189.14 with SMTP id b14mr9075991een.141.1341835037311;
        Mon, 09 Jul 2012 04:57:17 -0700 (PDT)
Received: from [10.0.0.45] ([213.246.250.146])
        by mx.google.com with ESMTPS id y54sm93197282eef.10.2012.07.09.04.57.15
        (version=SSLv3 cipher=OTHER);
        Mon, 09 Jul 2012 04:57:16 -0700 (PDT)
X-Mailer: Evolution 3.4.3 (3.4.3-1.fc17) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201199>

Hello,

I have a core project on which I maintain a set of patches using Quilt.
This allows me to make changes to the project without touching the files
so I can upgrade to new versions easily.

I keep my patches and the core project in a Git repository. When I want
to change something, I apply my patches using Quilt, then I revert all
my changes and I just commit the resulting patch.

I would like to have a branch where all my patches are applied to deploy
the code but I can't find any good way to do this.

If I create a new branch from master and apply the patches, I will have
conflicts on the next merge. I need something to apply the patches
before the merge (maybe using one of the hooks?).

Any idea?

--
Jimmy
