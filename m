From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH 0/3] fixup remaining cvsimport tests
Date: Thu, 10 Jan 2013 22:27:16 -0600
Message-ID: <1357878439-27500-1-git-send-email-chris@rorvick.com>
Cc: "Eric S. Raymond" <esr@thyrsus.com>,
	Chris Rorvick <chris@rorvick.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 05:28:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtWEf-0004ot-M3
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 05:28:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753879Ab3AKE2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2013 23:28:33 -0500
Received: from mail-ia0-f178.google.com ([209.85.210.178]:60581 "EHLO
	mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271Ab3AKE2c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 23:28:32 -0500
Received: by mail-ia0-f178.google.com with SMTP id k25so1195561iah.37
        for <git@vger.kernel.org>; Thu, 10 Jan 2013 20:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=s2Kb3RSaskTeb62qM7p9l7P534IkPmzF4hyGfsxawGQ=;
        b=bS1O6w6MCEi/K2KOtpA3nM/KuQFX+XhF8AuuKLecimaZW9+QfdxWTuy9k7wbQz9uCV
         ghYUOW1t489tXcG7v/2qfOS7Uw9wLcUj6gGpEznOMj5l9mLnqF+9EyydvN79zE6EdQND
         Mf6cYtIG4Um2sKEhdOgBUNj4ruPiSCW7bMa+Kfro5W+OiNUHJfDBucKBdHTnQi2WUp8Z
         i0f7reI3JAqZbgf8KD6zFRsL3De+QJlWCQv7cODtIuWUCKPEbqUMxy8qM8s2F5o38KZL
         Qcxyf13s0WxIijiOkmkh1yTSUhmANcX71gRAAWKCYiBJNmCDHY1TYfcfeFURnmFJ75Qn
         6/XQ==
X-Received: by 10.50.196.130 with SMTP id im2mr7871393igc.17.1357878512364;
        Thu, 10 Jan 2013 20:28:32 -0800 (PST)
Received: from marlin.localdomain ([70.131.98.170])
        by mx.google.com with ESMTPS id s20sm3793135igs.10.2013.01.10.20.28.30
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 10 Jan 2013 20:28:31 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.g220e17a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213175>

These patchs apply on top of of Eric Raymond's cvsimport patch.  7 of 15
tests in t9600 fail, one of which is fixed w/ a cvsps patch I've sent
to Eric (fixes revision map.)  It no longer uses "origin" as the default
branch which I suspect is a problem for at least some of the remaining
tests.  Both of the t9604 tests pass.

Chris

Chris Rorvick (3):
  t/lib-cvs.sh: allow cvsps version 3.x.
  t9600: fixup for new cvsimport
  t9604: fixup for new cvsimport

 t/lib-cvs.sh                    |  2 +-
 t/t9600-cvsimport.sh            | 10 ++++------
 t/t9604-cvsimport-timestamps.sh |  5 ++---
 3 files changed, 7 insertions(+), 10 deletions(-)

-- 
1.8.1.1.g220e17a
