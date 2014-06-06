From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 00/20] avoid "test <cond> -a/-o <cond>"
Date: Fri,  6 Jun 2014 07:55:43 -0700
Message-ID: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 16:57:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsvZr-0002D8-KY
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 16:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbaFFO4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 10:56:09 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:36613 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbaFFO4I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 10:56:08 -0400
Received: by mail-pb0-f45.google.com with SMTP id um1so2579179pbc.32
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 07:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=MczDALJzvQrZeFG8VBGKKFNDdYM/RMDCMoQ2Hn+uO3U=;
        b=h7sncyozbZxLycgxxSiNEVTlrRrl/iz18UTVUsrG+/r9KhX4giXAwOLfXy3taY+l02
         puKA/92u44D11vdcyCTCj99dNoBanrwQJ7bEmwQ5Gh0RI2ujCO36r9xKAgbNUe72Kl57
         KefM3rKhv50ADn+PoIPBNP0L4pG4u6+o4kZB5PAfSvTbiEdQPgLBscnMmA8j9X9dI2uS
         tRbEhP05mMnYCk9BgZP1eQy8LFkW1E8fUPRMUoIQOoeDbiMhul+udwnCyWyraIysvwLG
         igxBVCdIUftc1NKeCSXiy8w7Vfgt9Abl6YYY1tLr9vwctrMMLJXhhqgmgHELHdUt9IAb
         L+FA==
X-Received: by 10.68.172.193 with SMTP id be1mr7434813pbc.31.1402066567640;
        Fri, 06 Jun 2014 07:56:07 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pu5sm36850769pbb.4.2014.06.06.07.56.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Jun 2014 07:56:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250937>

These patch series  convert test -a/-o to && and ||.

This is the the third version.

Changes:

- Change the commit message for consistency with the comment to the patch to the CodingGuideline (Junio proposed patch
 http://www.spinics.net/lists/git/msg232199.html) expressing even better the meaning 
 of the patches ( in particular, the phrase "Better known" vs. "error prone").
 The previous comment was "convert test -a/-o to && and ||"


- Therefore also includes the Julio patch to the CodingGuideline


I have done the rebase with "master" and the patches also apply to "next".

I hope I have done the right thing in  resending the patch series.
I am Sorry if not.


Elia Pinto (20):
  check_bindir: avoid "test <cond> -a/-o <cond>"
  contrib/examples/git-clone.sh: avoid "test <cond> -a/-o <cond>"
  contrib/examples/git-commit.sh: avoid "test <cond> -a/-o <cond>"
  contrib/examples/git-merge.sh: avoid "test <cond> -a/-o <cond>"
  contrib/examples/git-repack.sh: avoid "test <cond> -a/-o <cond>"
  contrib/examples/git-resolve.sh: avoid "test <cond> -a/-o <cond>"
  git-bisect.sh: avoid "test <cond> -a/-o <cond>"
  git-mergetool.sh: avoid "test <cond> -a/-o <cond>"
  git-rebase--interactive.sh: avoid "test <cond> -a/-o <cond>"
  git-submodule.sh: avoid "test <cond> -a/-o <cond>"
  t/lib-httpd.sh: avoid "test <cond> -a/-o <cond>"
  t/t0025-crlf-auto.sh: avoid "test <cond> -a/-o <cond>"
  t/t0026-eol-config.sh: avoid "test <cond> -a/-o <cond>"
  t/t4102-apply-rename.sh: avoid "test <cond> -a/-o <cond>"
  t/t5000-tar-tree.sh: avoid "test <cond> -a/-o <cond>"
  t/t5403-post-checkout-hook.sh: avoid "test <cond> -a/-o <cond>"
  t/t5538-push-shallow.sh: avoid "test <cond> -a/-o <cond>"
  t/t9814-git-p4-rename.sh: avoid "test <cond> -a/-o <cond>"
  t/test-lib-functions.sh: avoid "test <cond> -a/-o <cond>"
  CodingGuidelines: avoid "test <cond> -a/-o <cond>"

 Documentation/CodingGuidelines  |   12 ++++++++++++
 check_bindir                    |    2 +-
 contrib/examples/git-clone.sh   |    2 +-
 contrib/examples/git-commit.sh  |    4 ++--
 contrib/examples/git-merge.sh   |    4 ++--
 contrib/examples/git-repack.sh  |    4 ++--
 contrib/examples/git-resolve.sh |    2 +-
 git-bisect.sh                   |    2 +-
 git-mergetool.sh                |    4 ++--
 git-rebase--interactive.sh      |    2 +-
 git-submodule.sh                |   32 ++++++++++++++++++++------------
 t/lib-httpd.sh                  |    2 +-
 t/t0025-crlf-auto.sh            |    6 +++---
 t/t0026-eol-config.sh           |    8 ++++----
 t/t4102-apply-rename.sh         |    2 +-
 t/t5000-tar-tree.sh             |    2 +-
 t/t5403-post-checkout-hook.sh   |    8 ++++----
 t/t5538-push-shallow.sh         |    2 +-
 t/t9814-git-p4-rename.sh        |    4 ++--
 t/test-lib-functions.sh         |    4 ++--
 20 files changed, 64 insertions(+), 44 deletions(-)

-- 
1.7.10.4
