From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 0/5] Sequencer fixups mini-series
Date: Sun, 23 Oct 2011 00:43:41 +0530
Message-ID: <1319310826-508-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 22 21:16:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHh3Y-0003PV-LZ
	for gcvg-git-2@lo.gmane.org; Sat, 22 Oct 2011 21:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270Ab1JVTQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Oct 2011 15:16:18 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:62916 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792Ab1JVTQS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Oct 2011 15:16:18 -0400
Received: by pzk36 with SMTP id 36so12597396pzk.1
        for <git@vger.kernel.org>; Sat, 22 Oct 2011 12:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=zJTa1i5ZiV71lbrWRcyH8RGf6Tm9trcfAho5/wBTsIw=;
        b=wM3z8mLDJFKTz41T8w+7ilqCj06yR0e4pW5s4yr/YmgDd0dZVcLFhK7OlXK1L4pclq
         /oMYelqLmY9mPJOyTpnvvtqaZerM1CuV/RrF1n8J+pTmHNNTPkd9LTqTKhNlX66X9LDm
         8H59fE94yhgD8ltTF6M9FQb/MbHGoOzGcvvLk=
Received: by 10.68.7.166 with SMTP id k6mr37083312pba.128.1319310977584;
        Sat, 22 Oct 2011 12:16:17 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id e10sm36939881pbq.10.2011.10.22.12.16.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 22 Oct 2011 12:16:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184113>

Hi,

This is the third iteration of the series, with one change since the
previous round: the 3rd and 4th parts have been squashed together as
suggested by Junio and Jonathan.  As a result, it's a five-part series
instead of a six-part series now.

Second iteration: $gmane/183962
First iteration: $gmane/183157

Thanks.

Jonathan Nieder (1):
  revert: simplify communicating command-line arguments

Ramkumar Ramachandra (4):
  revert: free msg in format_todo()
  revert: simplify getting commit subject in format_todo()
  revert: make commit subjects in insn sheet optional
  revert: allow mixed pick and revert instructions

 builtin/revert.c                |  221 +++++++++++++++++++--------------------
 sequencer.h                     |    8 ++
 t/t3510-cherry-pick-sequence.sh |   86 +++++++++++++++
 3 files changed, 203 insertions(+), 112 deletions(-)

-- 
1.7.6.351.gb35ac.dirty
