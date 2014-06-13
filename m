From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 0/2] Fixes for the ref-transactions series in origin/pu
Date: Fri, 13 Jun 2014 08:51:04 -0700
Message-ID: <1402674666-6634-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 17:51:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvTlF-0003o6-9G
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 17:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718AbaFMPvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 11:51:11 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:48426 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbaFMPvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 11:51:09 -0400
Received: by mail-pd0-f201.google.com with SMTP id v10so97539pde.0
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 08:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=dxns8gqhYqknLfcvOhZr9j6pVPBNuu3fqZmYJrewTnU=;
        b=isevfIRiua/Eqsl2qNzFapZQwNMk/i0NtB69wcBVaWmFXou03wvCjqYQoS0Cg1UgV8
         Aa5v+Kvn1+ShQ+0fseVyC0+LS5eeBscKWukQuyVR/qLVDKlG2M4Ce4fr9oGjCErHMC2h
         DmzVd63qJ6AiqErBXu8L+qTyuFoccXlclIIqo90Mvg6qVZTM/LAQg49niU0CXIplfmLO
         tI2/2fss8aKpASb7RQT+q5gJoie5tt7YL8RXBjZjo67tNDiY28TBGQllHCSepGkyo7Kb
         oXUm3KQxT2Rl57UKaDs1/93aLFRnkGZnMT5eZhN0FjNpVi76YsAJBRjirpy39EvGj3S3
         sIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dxns8gqhYqknLfcvOhZr9j6pVPBNuu3fqZmYJrewTnU=;
        b=b08bCtCKHHrK6lfts1I+Whmax923/2BeU+flSDMAjCBl17A7GbGd1F43HfbZGxz9zl
         WG6lPUfNvr6hLgqM9C6G/n4yBDpre+pogBlC5zEXreD9JnlShRBj6ZuTDOUHB2089ysM
         ylGIXitEibLZoDvTahVOtPxksVIjb9xjR715TqpQzYotuIvwbf1Q/n8cFV97x2PULLEV
         4hXgXBYXppAE5Ar40OYnj6Aah8YVeRGyUplrni1xenyvD7hm/dsV1gFy1v/ieRYOP5/A
         l41Yyui5vjGt+CYEJopCchIhxMxUS5Q+50k6wzIGUUGKUCIBS0DElxo5Kk72EWCMV4NL
         PEKg==
X-Gm-Message-State: ALoCoQkebMiN+4BZi4bD8IOcvunvGpGvgED6mLv/BYdzpPPLDDTEHBkq5+8Ipd0AL4n9LfdIlgNU
X-Received: by 10.66.137.105 with SMTP id qh9mr1160236pab.30.1402674669209;
        Fri, 13 Jun 2014 08:51:09 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id i65si334712yhg.2.2014.06.13.08.51.09
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Jun 2014 08:51:09 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 007115A4762;
	Fri, 13 Jun 2014 08:51:09 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 98F61E0C3A; Fri, 13 Jun 2014 08:51:08 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.415.g8cd8cf8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251603>

Jun,
Please find two fixes for the ref-transactions series in origin/pu

Ronnie Sahlberg (2):
  remotes.c: update calls to new signature for repack_without_refs
  receive-pack.c: add missing xstrdup

 builtin/receive-pack.c | 21 +++++++++++----------
 builtin/remote.c       |  5 +++--
 refs.h                 |  3 ++-
 3 files changed, 16 insertions(+), 13 deletions(-)

-- 
2.0.0.415.g8cd8cf8
