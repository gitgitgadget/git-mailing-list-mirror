From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/7] remote-bzr: generic updates
Date: Fri,  5 Apr 2013 21:49:16 -0600
Message-ID: <1365220163-13581-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 19:56:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWSC-0001b9-CB
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756816Ab3DFDuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 23:50:24 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:33924 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756470Ab3DFDuX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 23:50:23 -0400
Received: by mail-ob0-f182.google.com with SMTP id ef5so4315928obb.13
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 20:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=slBcQHP3tbDru+rq3kj930E8Qfwtdo8yxS1gNLWCjEI=;
        b=CosMktTJbWq3Ekk1vvtYeKBNB8APGSP+LslAY6u6BdlY6hqyP5aI7qfQ3OxvuqEU+p
         5BmlzSTLYjHwJTXYb6tDBjiEx/oyv+PXNOPUxT4sDU+2HNzLZ7GNvALg5SQpQcUWqsaU
         fH3AVqj2kBji3RVACc1tnJVkwTnjU9F6nSLTdlb21LzFDhvF+yOMA9mvHnQCfqoozCVX
         7Jrs0ZChwhx/cJMRRbL0WeCx9t1lCDRuRcYslW1GmxTWB/ivyy/qe89hWtwwvkK5JWCF
         iMQqVcLSv+F02lj2GO8Ouhtvtf1+BgGrBoXJNy7USAAjejyY3VVPkfhxgM7WHG4Xr0aw
         7Wog==
X-Received: by 10.60.50.102 with SMTP id b6mr9909453oeo.46.1365220223219;
        Fri, 05 Apr 2013 20:50:23 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id a10sm15191773oez.1.2013.04.05.20.50.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Apr 2013 20:50:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220245>

Hi,

Here are a couple fixes for remote-bzr, some of these can be really annoying to
certain users. I believe all of them should be safe.

Christophe Simonis (2):
  remote-bzr: fix directory renaming
  remote-bzr: remove files before modifications

David Engster (1):
  remote-bzr: set author if available

Felipe Contreras (3):
  remote-bzr: only update workingtree on local repos
  remote-bzr: avoid unreferred tags
  remote-bzr: add utf-8 support for pushing

Timotheus Pokorra (1):
  remote-bzr: add utf-8 support for fetching

 contrib/remote-helpers/git-remote-bzr | 36 ++++++++++---
 contrib/remote-helpers/test-bzr.sh    | 95 +++++++++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+), 8 deletions(-)

-- 
1.8.2
