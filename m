From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/5] Trivial cleanups
Date: Sat, 14 Sep 2013 01:38:32 -0500
Message-ID: <1379140717-12940-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 14 08:43:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKjaH-0003OR-JV
	for gcvg-git-2@plane.gmane.org; Sat, 14 Sep 2013 08:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163Ab3INGnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Sep 2013 02:43:52 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:59631 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234Ab3INGnv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Sep 2013 02:43:51 -0400
Received: by mail-ob0-f178.google.com with SMTP id uy5so1897592obc.37
        for <git@vger.kernel.org>; Fri, 13 Sep 2013 23:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=K2qYyKN8hOuto4nd/cEuUG22yAc2pZ5P1KO1W4zc3jU=;
        b=woclbADQy01udHUB1HDf+r2jX2b4i88tq1/Og8owcph8yfrzqqraHCZGGtmBPARnef
         +HvN2N0yz8FlHeVzX0DJu3hmGO50oy8WQnRjJmXp6CAXAb/V2GcdCSVXTSQOotZ+OWN0
         mtWDbtd4ZKteQPsi9YvKIBD17CCftMt+uyxfl9gizy5gARF03w1CfOm6t5Mv57KGVTrM
         7hqYx4ozupLMUfg6LH/ozHGzrJepW2w8MW2+coIu0AbDiCksV9G/q1FI3KaN2l4f8Th8
         drNybSNwOEswDeQImzMx/PJEqCTPKB2N42EqOdvwT4BmwP0mdxxIeav7MsLm8dbWbU2c
         yU1Q==
X-Received: by 10.182.22.226 with SMTP id h2mr16036575obf.8.1379141030658;
        Fri, 13 Sep 2013 23:43:50 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id d3sm21059437oek.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 13 Sep 2013 23:43:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234796>

Felipe Contreras (5):
  branch: trivial style fix
  sha1-name: trivial style cleanup
  merge: simplify ff-only option
  t: replace pulls with merges
  pull: cleanup documentation

 Documentation/git-pull.txt             |  4 ++--
 builtin/branch.c                       |  3 +--
 builtin/merge.c                        | 11 ++---------
 sha1_name.c                            |  1 -
 t/annotate-tests.sh                    |  2 +-
 t/t4200-rerere.sh                      |  2 +-
 t/t9114-git-svn-dcommit-merge.sh       |  2 +-
 t/t9500-gitweb-standalone-no-errors.sh |  2 +-
 8 files changed, 9 insertions(+), 18 deletions(-)

-- 
1.8.4-fc
