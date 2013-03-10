From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH v2 13/23] contrib/subtree: Add prune command to OPTS_SPEC
Date: Sun, 10 Mar 2013 23:41:21 +0000
Message-ID: <1362958891-26941-14-git-send-email-pcampbell@kemitix.net>
References: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
Cc: David Greene <greened@obbligato.org>,
	Herman van Rink <rink@initfour.nl>,
	Paul Campbell <pcampbell@kemitix.net>,
	"Peter Jaros" <pjaros@pivotallabs.com>,
	"Matt Hoffman" <matt.hoffman@quantumretail.com>,
	"Avery Pennarun" <apenwarr@gmail.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 11 00:45:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEpvd-0004fj-3V
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 00:45:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753453Ab3CJXoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 19:44:54 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:64583 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228Ab3CJXox (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 19:44:53 -0400
Received: by mail-wg0-f45.google.com with SMTP id dq12so4277010wgb.0
        for <git@vger.kernel.org>; Sun, 10 Mar 2013 16:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=DhJCeC0fKsckD0V6Rq8XbXUO7U5YM0PfAWUZicWFsso=;
        b=MKXTbqyF+oK/rvXQAG61jJ1N2DCGF45N/0vdWVO2F//aizzWNkHVQk7+A+gdoviC0I
         U+6CgAim+JC2DAANWptwZDirHNlrqoRfehJ63lzlUCFsJSu+wYyzh278VYp91iAzP7ec
         1cJ3vK8srMJ+TjPf6Ym7b3xM2EpXVqXM9TAIvG/cXBil0kFGOMLtzv5by5mYq2Ou4Zem
         X+X31TVmWqTQa5+rBffWwrIlymBS84L38zI9LIgF5YbsSqXBCw+9DQylVn/r+p8V/ngU
         vU15X4P2gb8kyvPwrCNNxb+KQf9Owdk9eM0j5J34Fd5hjXL8VyCwVkMHSAUFYu08RQbb
         1gTQ==
X-Received: by 10.194.19.135 with SMTP id f7mr15671472wje.27.1362959092558;
        Sun, 10 Mar 2013 16:44:52 -0700 (PDT)
Received: from coyote.home (host-2-102-87-75.as13285.net. [2.102.87.75])
        by mx.google.com with ESMTPS id r7sm13757148wiz.2.2013.03.10.16.44.48
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 10 Mar 2013 16:44:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.rc1
In-Reply-To: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
X-Gm-Message-State: ALoCoQmZaVcZSvhpMBallsnLP3bGidTql0n2l19R2i09VKYOAccA51Zc0tXnMVInISvZIGtYmJQd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217833>

From: Herman van Rink <rink@initfour.nl>

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>

Conflicts:
	git-subtree.sh
---
 contrib/subtree/git-subtree.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 0c41383..d67fe5a 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -18,6 +18,7 @@ git subtree push  --prefix=<prefix> <repository> <refspec...>
 git subtree split --prefix=<prefix> <commit...>
 git subtree diff  --prefix=<prefix> [<repository> [<refspec>...]]
 git subtree from-submodule --prefix=<prefix>
+git subtree prune
 --
 h,help        show the help
 q             quiet
-- 
1.8.2.rc1
