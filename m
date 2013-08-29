From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/9] diff: document --staged
Date: Thu, 29 Aug 2013 13:14:32 -0500
Message-ID: <1377800080-5309-2-git-send-email-felipe.contreras@gmail.com>
References: <20130829180129.GA4880@nysa>
 <1377800080-5309-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 29 20:19:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF6or-0004Q7-4H
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756448Ab3H2STl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:19:41 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:38848 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756250Ab3H2STk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 14:19:40 -0400
Received: by mail-oa0-f51.google.com with SMTP id h1so1050547oag.24
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 11:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EWfoQi8P8ohugkgg06gXz2exYefLgNIxdOBiUilIm04=;
        b=BNzkJJW4ziXGKs+PbD5CrcnAUWrlqI9weuRKpuQ8Jf6mByxQHbmzKctqQeJXuVKxfX
         0NSBYFWasGnveRf//UBxyTiyJR3/V8FVSZXs2y1BjVtyPe2NoSxZvu7KJhrOPybuui6U
         vo5cafHPyKvpHbwWOr85NyFYWxmk36iCgeHWFdml0dxXgASF1G9bkdIaNfbhtu2OSVQg
         DikTJKTRC1hzNTJqmcPBJpfVrZmAXK44doUoxYXFIxy5aUyfd9c3aOYNkfHV20RCLtMB
         NNA4Yz+I46qjcljWSWsBbqLLnFtL1E6iPDrPkEEg6wff5XW8GRwyU/i+AQxa2UfP8b8P
         cE9g==
X-Received: by 10.182.28.98 with SMTP id a2mr3476803obh.36.1377800380039;
        Thu, 29 Aug 2013 11:19:40 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s9sm29396313obu.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 11:19:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377800080-5309-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233310>

Synonym for --cached.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-diff.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 78d6d50..646e5cd 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git diff' [options] [<commit>] [--] [<path>...]
-'git diff' [options] --cached [<commit>] [--] [<path>...]
+'git diff' [options] [--cached|--staged] [<commit>] [--] [<path>...]
 'git diff' [options] <commit> <commit> [--] [<path>...]
 'git diff' [options] <blob> <blob>
 'git diff' [options] [--no-index] [--] <path> <path>
@@ -33,7 +33,7 @@ If exactly two paths are given and at least one points outside
 the current repository, 'git diff' will compare the two files /
 directories. This behavior can be forced by --no-index.
 
-'git diff' [--options] --cached [<commit>] [--] [<path>...]::
+'git diff' [--options] [--cached|--staged] [<commit>] [--] [<path>...]::
 
 	This form is to view the changes you staged for the next
 	commit relative to the named <commit>.  Typically you
-- 
1.8.4-fc
