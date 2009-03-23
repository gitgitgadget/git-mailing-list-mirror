From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] difftool: add git-difftool to the list of commands
Date: Mon, 23 Mar 2009 01:41:15 -0700
Message-ID: <1237797676-32047-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 23 09:42:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlfjX-0005mJ-F4
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 09:42:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757952AbZCWIkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 04:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757734AbZCWIkj
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 04:40:39 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:47373 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757533AbZCWIki (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 04:40:38 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1673228rvb.1
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 01:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=yrjRd7llWDdAtZZM5Tlfr9/J0zwvxmi9fhZ6wOyJry4=;
        b=dUn06Zdx0KOpHjkYMIPNAqvVu9i9EFf+V9hmHmB98Kw1jR9oveX7Qw5z4l+640HWh4
         JaDMBVG7ycqDyk6nUUWKIcu/698wi3njx6K+L9+ZTcYhEV5ShczOwM1mdrVCIa2wsOgk
         Vuq6WJNp8gD6dFI8gbnBYmeDExQE5/1V/G5CA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=mq6mTDlIoSz033cwj3ZGVhqGP27WQhAhU8zmFyJYiNsqelff9L1+6L7bw/km+qKlOz
         JAQqsaxl7HlIP2TDQmyKYOpGMehy9AyM+7t4qCYGd1H/k22tI0goqA4FFW6F54z4SlmE
         /d7ApsiLAItGPoqZX3x7/JbkF8lWGNf1KvfKY=
Received: by 10.115.73.20 with SMTP id a20mr4648935wal.1.1237797635742;
        Mon, 23 Mar 2009 01:40:35 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id k37sm5188482waf.7.2009.03.23.01.40.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Mar 2009 01:40:35 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.303.g63699
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114264>

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 command-list.txt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/command-list.txt b/command-list.txt
index 3583a33..fb03a2e 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -33,6 +33,7 @@ git-diff                                mainporcelain common
 git-diff-files                          plumbinginterrogators
 git-diff-index                          plumbinginterrogators
 git-diff-tree                           plumbinginterrogators
+git-difftool                            ancillaryinterrogators
 git-fast-export				ancillarymanipulators
 git-fast-import				ancillarymanipulators
 git-fetch                               mainporcelain common
-- 
1.6.2.1.303.g63699
