From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH v5 0/4] Updated patch series for default upstream merge
Date: Thu, 10 Feb 2011 18:52:40 -0500
Message-ID: <1297381964-7137-1-git-send-email-jaredhance@gmail.com>
Cc: Jared Hance <jaredhance@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 11 00:53:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PngKN-0006BZ-Hh
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 00:53:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757392Ab1BJXw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 18:52:56 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:35144 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757351Ab1BJXwy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 18:52:54 -0500
Received: by qyj19 with SMTP id 19so2886290qyj.19
        for <git@vger.kernel.org>; Thu, 10 Feb 2011 15:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=/odGy+tt1UHxoIz6rkWmeYH+F1ReOPwO62rNEqV3KcI=;
        b=HlcZA/ZvzgtyFy25M1dls+nkQNY277t5a3qtOfUsMsdmIYVsKG3/9QxDnGygfS4NFk
         pQdhi9/XEhLzbuLCLhCi60xJvUcQg1Vkxl4GMjnh3vgJsXSUc8XP2G9eJXCnQSbYVHLr
         fLnzggWoeuQgUgFaN/kqBqr5PL6X5GDCXZ7ow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=CzOb7pEtO0XXvS+WzlIUV0dFW9TbuFhWQSj5vXKqs/ifWWUxkKnv7SFA3S+PZxtPob
         rL8TpEt670E//sofbhphBUCAgc1lMyZ4pFZg/qPmY0/rSPnWlJc4GW3tghEWsm8TIQMt
         LmKudX0Qs9LBrAzyf3OCrJqQpHmxalbpeO1I8=
Received: by 10.229.221.149 with SMTP id ic21mr8774278qcb.190.1297381973787;
        Thu, 10 Feb 2011 15:52:53 -0800 (PST)
Received: from localhost.localdomain (cpe-75-186-7-248.cinci.res.rr.com [75.186.7.248])
        by mx.google.com with ESMTPS id t7sm123028qcs.4.2011.02.10.15.52.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Feb 2011 15:52:53 -0800 (PST)
X-Mailer: git-send-email 1.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166526>

This patch series allows merge, when given proper configuration, to default
to the upstream of the current branch.

The last one I sent was malformed due to two versions of the patch series
being in the tree at once; this is fixed and has some minor changes from
v4.

Jared Hance (4):
  merge: update the usage information to be more modern
  merge: introduce setup_merge_commit helper function
  merge: introduce per-branch-configuration helper function
  merge: add support for merging from upstream by default

 Documentation/config.txt |    6 +++
 builtin/merge.c          |   90 ++++++++++++++++++++++++++++++++--------------
 2 files changed, 69 insertions(+), 27 deletions(-)

-- 
1.7.4
