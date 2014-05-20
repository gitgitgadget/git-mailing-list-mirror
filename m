From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 00/19]  convert test -a/-o to && and || patch series
Date: Tue, 20 May 2014 06:50:13 -0700
Message-ID: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 15:50:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmkRI-00088X-Hn
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 15:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753530AbaETNuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 09:50:39 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:37719 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456AbaETNuj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 09:50:39 -0400
Received: by mail-pd0-f176.google.com with SMTP id p10so338676pdj.21
        for <git@vger.kernel.org>; Tue, 20 May 2014 06:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=N6UvRNWTXUi0f/GZdDCdHfbonoxVC8sdJNUXT1QH9o4=;
        b=wCElPDSnGbm79iTT+QRbGMvdRLCU74BTrru9/4CVqrzzdVTmuQb86b1yKJdeW9T9Ei
         Hofw4LTpVqdiFG99WO2EX4150QSdEAnWcNmnMvtZBBi4DgYqBm4zI2g2/lSp2EylvXp4
         eBHsp2lj8MzET2WDMK1yzeL7A6mSAS0Mw6zm/tlSOrPCnJsjp2FFYP6/JnGyYN4781Lx
         bXRIoUn0pV0YqrwHkxrEqMMEqZKfJmvXJl+cb31hojTATOJZYV2M093NvC5fKKE+Uykj
         0F4skJ9fBFS8e8Q6d9pm7XNEclg3oTY6JL+3Qy+TaIqXORySaWoXfUYzj08hiGyx9Sa0
         rAnA==
X-Received: by 10.68.133.229 with SMTP id pf5mr51484038pbb.115.1400593838561;
        Tue, 20 May 2014 06:50:38 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id oe4sm3317286pbb.33.2014.05.20.06.50.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 May 2014 06:50:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249661>


These patch series  convert test -a/-o to && and ||.

This is the second version.

Changes:

- Modified commit comment based on Jonathan Nieder suggestions
(was "don't use the -a or -o option with the test command")

- Modified patch on git-submodule.sh based on Jonathan Nieder suggestions


Elia Pinto (19):
  check_bindir: convert test -a/-o to && and ||
  contrib/examples/git-clone.sh: convert test -a/-o to && and ||
  contrib/examples/git-commit.sh: convert test -a/-o to && and ||
  contrib/examples/git-merge.sh: convert test -a/-o to && and ||
  contrib/examples/git-repack.sh: convert test -a/-o to && and ||
  contrib/examples/git-resolve.sh: convert test -a/-o to && and ||
  git-bisect.sh: convert test -a/-o to && and ||
  git-mergetool.sh: convert test -a/-o to && and ||
  git-rebase--interactive.sh: convert test -a/-o to && and ||
  git-submodule.sh: convert test -a/-o to && and ||
  t/t0025-crlf-auto.sh: convert test -a/-o to && and ||
  t/t0026-eol-config.sh: convert test -a/-o to && and ||
  t/t4102-apply-rename.sh: convert test -a/-o to && and ||
  t/t5000-tar-tree.sh: convert test -a/-o to && and ||
  t/t5403-post-checkout-hook.sh: convert test -a/-o to && and ||
  t/t5537-fetch-shallow.sh: convert test -a/-o to && and ||
  t/t5538-push-shallow.sh: convert test -a/-o to && and ||
  t/t9814-git-p4-rename.sh: convert test -a/-o to && and ||
  t/test-lib-functions.sh: convert test -a/-o to && and ||

 check_bindir                    |    2 +-
 contrib/examples/git-clone.sh   |    2 +-
 contrib/examples/git-commit.sh  |    4 ++--
 contrib/examples/git-merge.sh   |    4 ++--
 contrib/examples/git-repack.sh  |    4 ++--
 contrib/examples/git-resolve.sh |    2 +-
 git-bisect.sh                   |    2 +-
 git-mergetool.sh                |    4 ++--
 git-rebase--interactive.sh      |    2 +-
 git-submodule.sh                |   29 +++++++++++++++++------------
 t/t0025-crlf-auto.sh            |    6 +++---
 t/t0026-eol-config.sh           |    8 ++++----
 t/t4102-apply-rename.sh         |    2 +-
 t/t5000-tar-tree.sh             |    2 +-
 t/t5403-post-checkout-hook.sh   |    8 ++++----
 t/t5537-fetch-shallow.sh        |    2 +-
 t/t5538-push-shallow.sh         |    2 +-
 t/t9814-git-p4-rename.sh        |    4 ++--
 t/test-lib-functions.sh         |    4 ++--
 19 files changed, 49 insertions(+), 44 deletions(-)

-- 
1.7.10.4
