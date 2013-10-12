From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH try2 03/14] diff: document --staged
Date: Sat, 12 Oct 2013 02:04:41 -0500
Message-ID: <1381561488-20294-8-git-send-email-felipe.contreras@gmail.com>
References: <1381561488-20294-1-git-send-email-felipe.contreras@gmail.com>
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:15:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtPu-0006ia-1R
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754914Ab3JLHPG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:15:06 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:54131 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550Ab3JLHLK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:11:10 -0400
Received: by mail-ob0-f179.google.com with SMTP id wp18so3452005obc.38
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EWfoQi8P8ohugkgg06gXz2exYefLgNIxdOBiUilIm04=;
        b=dWxoQuHg98VS0rTr0Nfb+K1O+HLJiLII1DxtdtLRXn0PfKbt2yBZnzaI/t/RZ5Rlae
         WSTIgyb+vd4H3xQkwBE4L9OOapw7pi7QBojV7CjWNMy/yDYYYj143pOQ3E1heDc15MSm
         QBjoMwgbYR5WxVwe5HreupQq5q8jDebE0TmFyoSpa+cZxTv8eR6WXMB2gKWC/Oxbg3lW
         un8NqPgoKsCjleL5WUu61gKUntB6Scz/CbV9N1WT+rlpXNKKF8Q18ByDo+d3GOL59LEU
         sZpVPywgDLV+G2Z3AMvrM4FsECB4nDY570KxznUOBGHHxF4826y6J5WznFK3V/P0XuSE
         iy1Q==
X-Received: by 10.182.16.201 with SMTP id i9mr17808067obd.21.1381561870160;
        Sat, 12 Oct 2013 00:11:10 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id rr6sm101369714oeb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:11:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561488-20294-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236039>

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
