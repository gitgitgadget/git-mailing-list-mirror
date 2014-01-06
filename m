From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/2] Minor convinience feature: format.defaultTo
Date: Mon,  6 Jan 2014 22:48:50 +0530
Message-ID: <1389028732-27760-1-git-send-email-artagnon@gmail.com>
Cc: Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 06 18:18:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0DpK-0000Af-5g
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 18:18:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755851AbaAFRSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 12:18:52 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:60170 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755259AbaAFRSs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 12:18:48 -0500
Received: by mail-pa0-f48.google.com with SMTP id rd3so18731888pab.21
        for <git@vger.kernel.org>; Mon, 06 Jan 2014 09:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=VbZlZ7YU9R7rAzQV7sJSxHl5KT2hD4j3+lhHQMMYWRQ=;
        b=WOJciNSXB5RnSP7tn4XbkRWlAqsZu1ncF6QvMCXzlUq94S/NV6yowTkSl9RoceW3LO
         6Q/TepCPQ8PpWWQr/XFH8ylVckGUFcRq8trMjromPgn6xili91imHWSm8D9i2QE5gt9Z
         PmXnCCbl2MwYxeLVYfj7gVlVGhftn8TXBkkVHtBRmWVTMi1E8CW6GoVdPNph7PurmfVr
         Bsoq7oejUpFamq7mecs1rXVm1n/JbcPz9QnvkFGEJ1WlyA1N6luZr0vy+qz3DKMt/hup
         nOTTEQ2/5oIPQfJa81GU1941zdP0oAuxxcpvSInsKhFGlJWqyQXbv4u/nddFDAsz9mRs
         B6XA==
X-Received: by 10.68.8.136 with SMTP id r8mr128056534pba.36.1389028727241;
        Mon, 06 Jan 2014 09:18:47 -0800 (PST)
Received: from localhost.localdomain ([122.164.141.93])
        by mx.google.com with ESMTPSA id jk16sm130131323pbb.34.2014.01.06.09.18.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Jan 2014 09:18:46 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.229.g4448466.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240030>

Hi,

This is inspired by merge.defaultToUpstream. Disclaimer: I have an
"fpm" alias for doing this (separate from "fp" for when I need to
generate patches against some other branch), which I'd like to get rid
of.

Thanks.

Ramkumar Ramachandra (2):
  completion: complete format.coverLetter
  format-patch: introduce format.defaultTo

 Documentation/config.txt               |  4 ++++
 builtin/log.c                          |  7 +++++++
 contrib/completion/git-completion.bash |  2 ++
 t/t4014-format-patch.sh                | 10 ++++++++++
 4 files changed, 23 insertions(+)

-- 
1.8.5.2.229.g4448466.dirty
