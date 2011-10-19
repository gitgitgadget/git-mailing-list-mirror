From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 0/6] Sequencer fixups mini-series
Date: Thu, 20 Oct 2011 02:33:22 +0530
Message-ID: <1319058208-17923-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 19 23:06:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGdKp-000098-UC
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 23:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754031Ab1JSVFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 17:05:55 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52807 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248Ab1JSVFz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 17:05:55 -0400
Received: by gyb13 with SMTP id 13so2083069gyb.19
        for <git@vger.kernel.org>; Wed, 19 Oct 2011 14:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=DMFhmkow82ZUQYMwsjy0+FHVdZXa0rKy4Q43b+Jn42g=;
        b=JAzRzyTE4lflc8ryqAn8be1XKtAUI8aN6tQVK/vhb7wb2IJvcXtdnKBBAVzxVWpnaz
         tZKd5SDHIy8Nhr47obBLGj3cDQuHplHtfDkOZwW/tTfgZsk9kJZ7TAMze5yOsMUlUsMA
         YPqkzr2/ZHHWICLsrBG34JU2Z85CfJLowr9nk=
Received: by 10.68.38.42 with SMTP id d10mr14867106pbk.50.1319058354037;
        Wed, 19 Oct 2011 14:05:54 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id jm5sm11111752pbc.1.2011.10.19.14.05.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 19 Oct 2011 14:05:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183962>

Hi,

This is the second iteration of series I first posted in
$gmane/183157.  The improvements can be summarized as follows:
1. Junio wrote some extra code to squash into the fourth part.  It
took me some time to resolve conflicts correctly while rebasing.
2. Jonathan and Tay (off-list) have helped improve all the commit
messages.

Thanks.

Jonathan Nieder (1):
  revert: simplify communicating command-line arguments

Ramkumar Ramachandra (5):
  revert: free msg in format_todo()
  revert: simplify getting commit subject in format_todo()
  revert: fix buffer overflow in insn sheet parser
  revert: make commit subjects in insn sheet optional
  revert: allow mixed pick and revert instructions

 builtin/revert.c                |  219 +++++++++++++++++++--------------------
 sequencer.h                     |    8 ++
 t/t3510-cherry-pick-sequence.sh |   86 +++++++++++++++
 3 files changed, 202 insertions(+), 111 deletions(-)

-- 
1.7.6.351.gb35ac.dirty
