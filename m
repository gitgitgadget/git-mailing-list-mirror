From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v2 0/2] reroll bc/attr-ignore-case (top two commits)
Date: Wed,  5 Oct 2011 23:00:12 -0500
Message-ID: <1317873614-3057-1-git-send-email-drafnel@gmail.com>
Cc: git@vger.kernel.org, peff@peff.net,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Oct 06 06:00:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBf8V-0006X4-66
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 06:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863Ab1JFEAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 00:00:38 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40691 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703Ab1JFEAh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 00:00:37 -0400
Received: by yxl31 with SMTP id 31so2240401yxl.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 21:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=FNsR1JApuNUsPQYk4d8b+EQ6A2BJeTfsmolBc00vgi4=;
        b=Q69+8VcHsjBGrGnQs7FpFocWP7N9eCoCVBJoT/mvq+odhbzPsqgg+8qej3GU4rx0vn
         2yz4VU0qsWeErokB4wnrSQTwN+KEVCrEJwhsVbkW9kNpVit5DPBjcA/nLca5nszgJ3ZV
         iaD27LyJIEsMWU5IONfY926LWMz9aQ41gR9MM=
Received: by 10.151.114.19 with SMTP id r19mr210587ybm.110.1317873636801;
        Wed, 05 Oct 2011 21:00:36 -0700 (PDT)
Received: from localhost.localdomain ([96.19.140.155])
        by mx.google.com with ESMTPS id h20sm11169124ani.16.2011.10.05.21.00.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Oct 2011 21:00:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.1.ge3b6f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182923>

This is the re-roll of this series that I said I would do.

This just swaps the order of the top two patches around and *hopefully*
improves the commit messages.

My original "attr.c: respect core.ignorecase.." patch was broken and I
intended to mark it as WIP.  Your patch fixes it, but it's nicer if your
patch comes first, that way the test suite (and git) is never broken.

This is built on top of aae0befee293ebdf9aa6391a074eb0e7c10cdf75 in
bc/attr-ignore-case, which hopefully makes it easy to replace the top two
commits in that branch with these two commits.

I know this is already in next, and you seem poised to merge to master,
so feel free to drop these if you want.

Brandon Casey (1):
  attr.c: respect core.ignorecase when matching attribute patterns

Junio C Hamano (1):
  attr: read core.attributesfile from git_default_core_config

 attr.c                |   20 ++++------------
 builtin/check-attr.c  |    2 +
 cache.h               |    1 +
 config.c              |    3 ++
 environment.c         |    1 +
 t/t0003-attributes.sh |   60 ++++++++++++++++++++++++++++++++++++++++++++++++-
 6 files changed, 71 insertions(+), 16 deletions(-)

-- 
1.7.7.1.ge3b6f
