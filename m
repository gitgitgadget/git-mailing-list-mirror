From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH] mergetools: add config option to disable auto-merge
Date: Tue, 16 Jun 2015 17:35:13 -0400
Message-ID: <1434490514-36204-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: davvid@gmail.com, ssaasen@atlassian.com, john@keeping.me.uk,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jun 16 23:35:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4yWP-0007ks-7o
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 23:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757503AbbFPVfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 17:35:45 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:33884 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757477AbbFPVfb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 17:35:31 -0400
Received: by qkdm188 with SMTP id m188so16374050qkd.1
        for <git@vger.kernel.org>; Tue, 16 Jun 2015 14:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=3a9QakbyajAxa0fnmdxlEOc+QbWNhKZjeYhHIM5puOU=;
        b=JvlEH+sGTqyPpEFPV9sPCiJTjDz49jlGb9Rg4xJSbg82IjLf3RgDwl2TI4iGuA5w7E
         rMsLysyfnCf8yOdM6XJQIw9a1w/t5//eV2EntFSM0be3dxmx8okyq0hjClPRYTscKKlF
         O5JBhXBZPcqkLRYJeOpeunlnGMgm+FdxNYH2eHEgzMtXYQMHnnj0MaiRsov2ue6UevY+
         pZ4ZhtFfLKHLBK4r89qVJqb9YhrgkCZitu9QupCAXYypVtmnaGbzyWfYnE44jQT1ZxQR
         apFmrZIg833dqWm2WcC7RwYa3eFjOE9dfWT3tS/LZAlUTxwtb35QJA4ZS69j3DSatXcC
         R8GA==
X-Received: by 10.55.40.92 with SMTP id o89mr6068635qkh.74.1434490530229;
        Tue, 16 Jun 2015 14:35:30 -0700 (PDT)
Received: from ool-45729003.dyn.optonline.net (ool-45729003.dyn.optonline.net. [69.114.144.3])
        by mx.google.com with ESMTPSA id 139sm1100038qhx.22.2015.06.16.14.35.28
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Jun 2015 14:35:29 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271801>

During conflict resolution, invoking a mergetool which supports
auto-merge will pass that option by default to the underlying tool.

This patch is intended to allow one to set 'merge.automerge' to
'false' in order to override this behavior.

Michael Rappazzo (1):
  mergetools: add config option to disable auto-merge

 Documentation/config.txt        |  6 ++++++
 Documentation/git-mergetool.txt | 19 +++++++++++++------
 mergetools/araxis               |  4 +++-
 mergetools/diffmerge            |  4 +++-
 mergetools/kdiff3               |  4 +++-
 5 files changed, 28 insertions(+), 9 deletions(-)

-- 
2.4.2
