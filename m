From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 24/24] git-status.txt: advertisement for untracked cache
Date: Sun,  8 Feb 2015 15:55:48 +0700
Message-ID: <1423385748-19825-25-git-send-email-pclouds@gmail.com>
References: <1423385748-19825-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 09:58:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKNgz-0003bk-4v
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 09:58:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755314AbbBHI6I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2015 03:58:08 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:62440 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755188AbbBHI6G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 03:58:06 -0500
Received: by mail-pa0-f46.google.com with SMTP id lj1so26943879pab.5
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 00:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=IGWnE91P7pP8wVOOP90EZqWyzUGhFgt3iXzX/Fn5W5g=;
        b=Efuq2iEBsHZrfeE5sHjHCDHtGjbOFFXgUmZq/Fe4EB88gTl1xhcnKQH4fx2ZbQ5f9y
         fsAp+KJH43aYZD2zTFWVcWiUj8rEUmoRkghE6MdGFVgYWtlh53mUNz/0FZdg+r8wf4Xl
         sssMnSGzARTKgobBjP1TEfEiOwDADuipaA2Z6QpIWGnXyc8cDFGRIyNoErRQaFLlHJy/
         nj0PujZPbG2wEDCnn45pF5hD1KXG++KNqYWpgrMwjfgMKQ1dQSh9EleafBiokas8JX5Q
         e5iKIZROIrkSAnsyfLyH6cuKXV7jQ8+piHFrRx0fPb9fc4JDULmDrRgt76XnTN7zbUxC
         sWog==
X-Received: by 10.67.5.200 with SMTP id co8mr17478799pad.136.1423385886048;
        Sun, 08 Feb 2015 00:58:06 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id df7sm2654195pdb.14.2015.02.08.00.58.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2015 00:58:05 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Feb 2015 15:58:13 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1423385748-19825-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263486>

When a good user sees the "too long, consider -uno" advice when
running `git status`, they should check out the man page to find out
more. This change suggests they try untracked cache before -uno.

Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-status.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.tx=
t
index def635f..4dcad4e 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -58,7 +58,10 @@ When `-u` option is not used, untracked files and di=
rectories are
 shown (i.e. the same as specifying `normal`), to help you avoid
 forgetting to add newly created files.  Because it takes extra work
 to find untracked files in the filesystem, this mode may take some
-time in a large working tree.  You can use `no` to have `git status`
+time in a large working tree.
+Consider enabling untracked cache and split index if supported (see
+`git update-index --untracked-cache` and `git update-index
+--split-index`), Otherwise you can use `no` to have `git status`
 return more quickly without showing untracked files.
 +
 The default can be changed using the status.showUntrackedFiles
--=20
2.3.0.rc1.137.g477eb31
