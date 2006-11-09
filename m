X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Kirill Shutemov" <k.shutemov@gmail.com>
Subject: Deleting binary file
Date: Thu, 9 Nov 2006 11:47:54 +0200
Message-ID: <1d592d70611090147p6f10f921s740e3cc19cb67c09@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 9 Nov 2006 09:48:17 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Vo50sZaOS5K/tlXS6khISme7EMhDsnS/GTjvwGldckxXTlc6zMpSoOpfykuD5kT0lWGXVmpxUgiZxHYqBXcSeLszV6XeoLrf7NPRjOnPmcEnOJN+OdzWwS7v2vP0scm4Eq1DBA4MeoW4spc65LpPGLjTenforPqXJHMKe8tpnhc=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31186>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gi6Vt-0005L4-K5 for gcvg-git@gmane.org; Thu, 09 Nov
 2006 10:48:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754822AbWKIJr5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 9 Nov 2006
 04:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754823AbWKIJr4
 (ORCPT <rfc822;git-outgoing>); Thu, 9 Nov 2006 04:47:56 -0500
Received: from wr-out-0506.google.com ([64.233.184.238]:37543 "EHLO
 wr-out-0506.google.com") by vger.kernel.org with ESMTP id S1754822AbWKIJrz
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Nov 2006 04:47:55 -0500
Received: by wr-out-0506.google.com with SMTP id i5so51457wra for
 <git@vger.kernel.org>; Thu, 09 Nov 2006 01:47:55 -0800 (PST)
Received: by 10.65.242.10 with SMTP id u10mr901368qbr.1163065674941; Thu, 09
 Nov 2006 01:47:54 -0800 (PST)
Received: by 10.65.183.18 with HTTP; Thu, 9 Nov 2006 01:47:54 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Why can't I delete binary file via patch?

> git-init-db
defaulting to local storage area
> cp /bin/sh .
> git-add sh
> git-commit -m 'test'
Committing initial tree efa3b1f9fdc4cdb8aab5bf869f580664a52ac04c
> git-rm sh
rm 'sh'
> rm sh
> git-commit -m 'test'
> git-format-patch HEAD^
0001-test.txt
> git-reset --hard HEAD^1
> git-applymbox 0001-test.txt
1 patch(es) to process.

Applying 'test'

error: No changes
> cat 0001-test.txt
From 9fd9a46e5404e7c389cfb48026b68d46faa47081 Mon Sep 17 00:00:00 2001
From: Kirill A. Shutemov <k.shutemov@gmail.com>
Date: Wed, 8 Nov 2006 11:19:35 +0200
Subject: [PATCH] test

---
sh |  Bin
1 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/sh b/sh
deleted file mode 100755
index a57a92a..0000000
Binary files a/sh and /dev/null differ
-- 
