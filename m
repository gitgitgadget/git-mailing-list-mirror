From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 03/14] diff: document --staged
Date: Mon, 14 Oct 2013 17:29:22 -0500
Message-ID: <1381789769-9893-8-git-send-email-felipe.contreras@gmail.com>
References: <1381789769-9893-1-git-send-email-felipe.contreras@gmail.com>
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 15 00:36:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVqkI-0007HQ-P6
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 00:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189Ab3JNWgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 18:36:05 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:50079 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932150Ab3JNWgE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 18:36:04 -0400
Received: by mail-oa0-f46.google.com with SMTP id g12so770450oah.5
        for <git@vger.kernel.org>; Mon, 14 Oct 2013 15:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EWfoQi8P8ohugkgg06gXz2exYefLgNIxdOBiUilIm04=;
        b=gqnX4c4aqqC2zl5ov4tERK1iXCwy+x+NR07ZnVBRAQsRTiD4OITLANP7lyiSm3ZWcS
         PxmkePRTuN6o4nhRBTSUlgZg2+OYyZj1RGPIxboXLPKzqXEPSNEtoLatYyF1x6qrlRYu
         2YsEyY4WHogofjmo4tuqlzqvmGhdtXuV2pxe33ecoVVglJKLdOxDooktndkyD/3wl7ed
         UCJFIQ76Zls7DSZH8Jce9sbWejSNBmA5rq50twW8D+G/M9ILZfqAdM7j/C5H0vhkqukT
         aZHpePfMkOYZCu5HkdTcpVY0h2NgbG0A/7tp4OAIVsv8IXmHvImt+LbNk88eIFrEDvir
         33Kg==
X-Received: by 10.182.214.98 with SMTP id nz2mr8386320obc.37.1381790163683;
        Mon, 14 Oct 2013 15:36:03 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id r6sm44564297obi.14.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 14 Oct 2013 15:36:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381789769-9893-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236135>

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
