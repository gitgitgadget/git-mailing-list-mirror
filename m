From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 0/7] Documentation/shortlog improvements
Date: Sun, 21 Apr 2013 14:20:45 +0530
Message-ID: <1366534252-12099-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 21 10:51:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTpzD-0008AF-Gn
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 10:51:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638Ab3DUIu7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 04:50:59 -0400
Received: from mail-da0-f49.google.com ([209.85.210.49]:45632 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752195Ab3DUIu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 04:50:58 -0400
Received: by mail-da0-f49.google.com with SMTP id t11so2570749daj.22
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 01:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=SZWWjotJxZZPd1YxWVhWJaTeNY8umRiRL2MtsBo5Wfs=;
        b=Mg6NuTwNnP2NITNdXuu0ve/EuJUew904l5JrEpto4vhvlkAZxvgeKJ7uq0gur2vVLB
         t7D7plbkj2eKTrVAFMRYdS+jXDyLXKBBsSQg180erAoWy5/dsbqkJWvqRHx+2APiFoFK
         nGtHijiIlZbNsUapWnrtr5dfX5JBPJ2a3SUVt05REZqbEivOgk42FknFKjuSd5e3bxjm
         dB/eiDbHep2E9dgdqn2RnQq7i/hDgAy/EKkXVFMN5WjUie/IykIfjDXzjLWjL2yD+7FV
         848rZKIxno1LZiODKgx07FtcNBsowvd9vKrkVc0Yn62sWV0ZtiFCXaF0cahMxtCoyziq
         LmfQ==
X-Received: by 10.68.200.10 with SMTP id jo10mr26907036pbc.53.1366534258436;
        Sun, 21 Apr 2013 01:50:58 -0700 (PDT)
Received: from localhost.localdomain ([122.174.41.136])
        by mx.google.com with ESMTPS id mm9sm20241909pbc.43.2013.04.21.01.50.56
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 01:50:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.501.gd2949c7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221927>

In this round, I've incorporated suggestions made by Junio:

[3/7] is entirely new.

[4/7] and [5/7] together re-order and replace '<since>..<until>' with
'<revision range>', in contrast to a single patch which attempted to
fix '<since>..<until>' in-place in the previous version.

[6/7] uses "the revision range" instad of "revisions".

[7/7] copies the latest text from git-log.txt, and doesn't attempt to
add rev-list-options.txt.

There's a parallel discussion going on about fixing the meaning of
"revision", but this series is entirely unrelated to that.

Ramkumar Ramachandra (7):
  git-shortlog.txt: remove (-h|--help) from OPTIONS
  builtin/shortlog.c: make usage string consistent with log
  revisions.txt: clarify the .. and ... syntax
  git-log.txt: order OPTIONS properly; move <since>..<until>
  git-log.txt: generalize <since>..<until>
  git-log.txt: rewrite note on why "--" may be required
  git-shortlog.txt: make SYNOPSIS match log, update OPTIONS

 Documentation/git-log.txt      | 22 ++++++++++++----------
 Documentation/git-shortlog.txt | 25 +++++++++++++++++++------
 Documentation/revisions.txt    |  6 ++++--
 builtin/shortlog.c             |  4 +---
 4 files changed, 36 insertions(+), 21 deletions(-)

-- 
1.8.2.1.501.gd2949c7
