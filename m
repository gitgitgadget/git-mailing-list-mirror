From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/3] Support :/quuxery in rebase (early preview)
Date: Thu, 13 Jun 2013 23:45:59 +0530
Message-ID: <1371147362-26962-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 13 20:18:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnC5x-00082x-PY
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 20:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758856Ab3FMSR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 14:17:57 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:61175 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754414Ab3FMSR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 14:17:56 -0400
Received: by mail-pb0-f53.google.com with SMTP id xb12so10517580pbc.26
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 11:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=PFfTxz2TsLAuoE68RtEr0slkojyo4WAIWyt2RHU1AR8=;
        b=KxjI33AVXwrgdA0/5fi5B6UnI/bI01RuqtORa5g0kJIk0FoFBH/uqxx2NsPLnXHPXg
         6jRkmTuMi68uzkyNK9QGwnPW9XpmyQkbtw69EcNfWpIdTJd/wMEhMD4x0C8LVYosIPj1
         cAlEk7ncL9yAiPYMOrxgD1simpqS2fKi5pqaEVVsU0kFH1lCxT970Vafc9REZgxVpEBN
         XE6hovK1X5aryJ9eCyjDFANl2RgEspGWkV+09flPSyZRaUxxnLlz0mGRgsPPh+EYqhmL
         ownFNbrQ+Pih6iB0jNS8nLx3aLOTOk2QhHwrc6zVqo/i/1naMCGBg+FYMo+02iwJ19OH
         dopA==
X-Received: by 10.66.255.99 with SMTP id ap3mr4060934pad.102.1371147476263;
        Thu, 13 Jun 2013 11:17:56 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id pm7sm24250605pbb.31.2013.06.13.11.17.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 13 Jun 2013 11:17:55 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.381.g31c8856.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227764>

Hi,

So this is a series to make git rebase [-i] :/quuxery possible.  It is
an early preview, because I have not tested that :/quuxery works as
the <onto>, <upstream>, and <branch>.

Thanks.

Ramkumar Ramachandra (3):
  t/rebase: add failing tests for a peculiar revision
  sh-setup: add new peel_committish() helper
  rebase: use peel_committish() where appropriate

 git-rebase.sh                 |  6 +++---
 git-sh-setup.sh               | 13 +++++++++++++
 t/t3400-rebase.sh             |  8 ++++++++
 t/t3404-rebase-interactive.sh |  8 ++++++++
 4 files changed, 32 insertions(+), 3 deletions(-)

-- 
1.8.3.1.381.g31c8856.dirty
