From: Quint Guvernator <quintus.public@gmail.com>
Subject: [PATCH v3 0/1] general style: replaces memcmp() with starts_with()
Date: Sat, 15 Mar 2014 12:39:12 -0400
Message-ID: <1394901553-69548-1-git-send-email-quintus.public@gmail.com>
Cc: Quint Guvernator <quintus.public@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 15 17:39:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOrcX-0004ZA-Om
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 17:39:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755611AbaCOQjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2014 12:39:20 -0400
Received: from mail-qc0-f171.google.com ([209.85.216.171]:54335 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754478AbaCOQjT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2014 12:39:19 -0400
Received: by mail-qc0-f171.google.com with SMTP id x13so4266170qcv.16
        for <git@vger.kernel.org>; Sat, 15 Mar 2014 09:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=kA4gXfvvPHAHYJTj2no1MdrFvtYtScVBcfeOg6n7HRQ=;
        b=zSNuE7tpjjfNS+s1/+CUz+KhA6sAJ5xJMUfxBlBFiPfrV1jQFYNidsYMyNz9PXNCQF
         +muhKo3X+aODqQoUDAPmC3+ZIjRq2UszOwZAtkUwJB1KSXDtcjdTQCe520YWpY7gOKFM
         IkVv5TsQP/5Mg0mctmiTKbTe50xsv33AoNJzVv1jkfQv9J5Q+scWtM6LshmLXKpDMuqS
         B1G1NZWcpNYvn0awPBYobrHFiac03PrsF5WW988XiWNNWMVdRsah2SL2Wmfh+tkOygAU
         rl9AtQYFT86+sF5uzb6PBrcOpt3/Bz75+AdPG/Bzyzce8DtNTCysZoaNdcpBqTn4nfbt
         c88w==
X-Received: by 10.224.41.68 with SMTP id n4mr9892328qae.59.1394901559166;
        Sat, 15 Mar 2014 09:39:19 -0700 (PDT)
Received: from lovelace.wm.edu ([128.239.171.194])
        by mx.google.com with ESMTPSA id t5sm13163491qge.0.2014.03.15.09.39.17
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 15 Mar 2014 09:39:18 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244159>

Hi, folks.

I've looked through the list's responses and removed the most objectionable
hunks from the patch v2, especially in cases where starts_with either hurts
readability or further obscures the use of magic numbers. Let me know what you
all think about the changes.

Thank you all again for your help. This is my first patch here, and has been
quite a microproject indeed!

Quint Guvernator (1):
  general style: replaces memcmp() with starts_with()

 builtin/apply.c                           |  6 +++---
 builtin/for-each-ref.c                    |  2 +-
 builtin/get-tar-commit-id.c               |  2 +-
 builtin/mktag.c                           |  8 ++++----
 builtin/patch-id.c                        | 18 +++++++++---------
 commit.c                                  |  4 ++--
 connect.c                                 |  6 +++---
 contrib/convert-objects/convert-objects.c |  6 +++---
 convert.c                                 |  2 +-
 http-walker.c                             |  2 +-
 imap-send.c                               |  6 +++---
 pack-write.c                              |  2 +-
 remote.c                                  |  2 +-
 13 files changed, 33 insertions(+), 33 deletions(-)

-- 
1.9.0
