From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/2] Slightly prettier reflog message from checkout
Date: Sat, 15 Jun 2013 23:08:24 +0530
Message-ID: <1371317906-3991-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 15 19:40:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnuSp-0002G9-4c
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 19:40:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754238Ab3FORkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 13:40:17 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:61436 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754190Ab3FORkR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 13:40:17 -0400
Received: by mail-pd0-f173.google.com with SMTP id v14so1516256pde.18
        for <git@vger.kernel.org>; Sat, 15 Jun 2013 10:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=uSYwQo7+Sn4ApFng9u2cPNPNcvbX1ITs9z+5YrDU88M=;
        b=HFXVJEjOGUU2AAXMGvVGIt/Z819Mp0Jme+g8t3rvsD9DlBwDl2tZ5+DYoAuLc10ydh
         eR3bC1/aBXXZDpvBtNUFgrFFf3oBODsRe4v/Uy0CQ9AExGH42xNV8bwynJhz2ywhViZy
         dvDTufLzUCEzua3C7vvSgWPFlPBxIxq4H5fG7YU1xYDCUa2lx5O3JRMSDsHydYKCuxWd
         md1FWevMtV2Dk1iD+2+EXVqusAjZ8lkEJFwX6zV7ODeCbvKa+DNeUM72vzmMcVxcTghL
         sfAoK4N5Lh35LK0Gd5zDuu25TPluHbK4UVhdiK0IlU50/DIcDfGEnKbkzpJwFmhnneJ7
         1OBA==
X-Received: by 10.68.244.164 with SMTP id xh4mr6947400pbc.157.1371318016350;
        Sat, 15 Jun 2013 10:40:16 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id ri8sm7032290pbc.3.2013.06.15.10.40.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Jun 2013 10:40:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.438.g96d34e8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227962>

[1/2] is important.  [2/2] is a minor prettification, that wouldn't
have been possible without [1/2].

Thanks.

Ramkumar Ramachandra (2):
  sha1_name: stop hard-coding 40-character hex checks
  checkout: do not write full sha1 to reflog

 builtin/checkout.c | 2 +-
 sha1_name.c        | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
1.8.3.1.438.g96d34e8
