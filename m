From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/5] Documentation/git-diff.txt improvements
Date: Wed, 24 Apr 2013 22:03:31 +0530
Message-ID: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 24 18:33:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV2dZ-0007KH-OL
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 18:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756407Ab3DXQdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 12:33:37 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:53389 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756241Ab3DXQdg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 12:33:36 -0400
Received: by mail-pb0-f42.google.com with SMTP id up7so506820pbc.15
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 09:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=dKSIfWb0YmRwrdLTwXmuNwMsvHh1gHNXF8G9zdP4QFY=;
        b=a5JEvP6LPpMQmmXhelkTYSmjcV14IPrqVWAYGxHAU+rSX0tGYTQf86uBhSTsdRORMI
         F6c9T0poUlUWNxq3eS/vedpcOfWvIOCf6Ff+7bhqTUJP/tvhHGQxvJpn6k6LPP+mViU5
         HIglZsD/EeyWawAQ5gFd2y7+v5bwSSfxLxgMgLK0jry077P201jQW+2CSt+4FHS+XmU9
         xnl2CkdcqnPTTyzJRlH3QHFIcRxTYBUcGmn9M9b1NSSOs8eWn68McqXnIBE5YzINIeIk
         IXOx2jnxVvN+2DCg7+alpnQWjbTdyTgb0rdqHt4rwF97DKudg7V3a0OAGs2DZdawD7jF
         KXLg==
X-Received: by 10.66.148.97 with SMTP id tr1mr20279145pab.49.1366821216378;
        Wed, 24 Apr 2013 09:33:36 -0700 (PDT)
Received: from localhost.localdomain ([122.164.164.124])
        by mx.google.com with ESMTPSA id dr4sm3646798pbb.19.2013.04.24.09.33.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 24 Apr 2013 09:33:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.502.g2d60b5c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222260>

Hi again,

So I decided that builtin/diff.c is hardcoded for the
<commit>..<commit> and <commit>...<commit> forms, and we can do
nothing about it unless we want to break compatibility (maybe a git
2.0 candidate?).  The least we can do is document it properly in the
SYNOPSIS.  I've done this in [4/5].

The other patches are just general "while we're there" cleanups.

Ramkumar Ramachandra (5):
  git-diff.txt: reorder the <commit> <commit> form
  git-diff.txt: strip the leading "--" from options template
  git-diff.txt: group the [--] and [<path>...] templates
  git-diff.txt: document the .. and ... forms in SYNOPSIS
  git-diff.txt: fix ordering of the [--no-index] form

 Documentation/git-diff.txt | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

-- 
1.8.2.1.502.g2d60b5c
