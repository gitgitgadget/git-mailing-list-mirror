From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 try2 03/14] diff: document --staged
Date: Fri, 25 Apr 2014 13:12:36 -0500
Message-ID: <1398449567-16314-4-git-send-email-felipe.contreras@gmail.com>
References: <1398449567-16314-1-git-send-email-felipe.contreras@gmail.com>
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 20:23:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wdkmm-0006WE-Sg
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 20:23:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162AbaDYSXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 14:23:33 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:38076 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110AbaDYSXa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 14:23:30 -0400
Received: by mail-ob0-f175.google.com with SMTP id wp4so4656625obc.34
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 11:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BtYSu8tRU+gmcbd2SHdkHkabVEm5+PHmXRDbwQS0SJk=;
        b=rq9r7ugChQEiygS3B09jD7QdigywH1XqB4TnGRRvgUbIKgwjxU/DiE1rr4/4REyGg6
         y4e/+lwKegnip6qpAYEe5uwQv9ae+MpP9fsCNJvnSBhJVPbzJTQq6Q8SsJu8JY5lTELv
         +gieOzu5GsFwYPXXvvfe/uSDxFfDPDRFeHzNx8/D3zNZ06MWp7k0kXrgUE6gYdTxpcif
         D8AXo2t9LKX5bKAr6lhoaZDOaiVjlkwkJDCujF26yYhqZ6qReHLCusSZn1yLQhjSiY7R
         U7zBVvDODNlDJ4q/bF3gxo+x0DaNWI70FzkYo4o7DTyxsNH8WhjjHf149raIETyRH0D7
         J7zw==
X-Received: by 10.60.142.229 with SMTP id rz5mr8110278oeb.1.1398450210214;
        Fri, 25 Apr 2014 11:23:30 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id pt8sm13253700obb.5.2014.04.25.11.23.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Apr 2014 11:23:28 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.2.gfbaae8c
In-Reply-To: <1398449567-16314-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247077>

Synonym for --cached.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-diff.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 56fb7e5..ca2a0ed 100644
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
@@ -38,7 +38,7 @@ two blob objects, or changes between two files on disk.
 	or when running the command outside a working tree
 	controlled by Git.
 
-'git diff' [--options] --cached [<commit>] [--] [<path>...]::
+'git diff' [--options] [--cached|--staged] [<commit>] [--] [<path>...]::
 
 	This form is to view the changes you staged for the next
 	commit relative to the named <commit>.  Typically you
-- 
1.9.2+fc1.2.gfbaae8c
