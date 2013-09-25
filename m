From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] git-grep.txt: add "git ack" alias to Examples section
Date: Wed, 25 Sep 2013 20:49:16 +0700
Message-ID: <1380116956-12091-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 25 15:46:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOpPl-0008Pt-UK
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 15:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755564Ab3IYNp5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Sep 2013 09:45:57 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:36002 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755548Ab3IYNp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 09:45:56 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so6104766pdj.31
        for <git@vger.kernel.org>; Wed, 25 Sep 2013 06:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=5oKHZOFT5rc0tj0+T7OP45pWJBx4c+TFpmyPNHrZwWI=;
        b=Rpi0xo+xYB3E05vpTvYOmiKvSCWcEbvmBSora960OGai7pxYGZ0YXEvQOwyIDd8Ijg
         /xnANMHiWW25UgSLAVRtGb5iaU7YhOGiKR9hbDJHpwW0MupzJC4kfbOswyGwOa62OF1h
         xogYoJ7C7s6VJADmn9PNhzD5fBMF81UwoMyWd/cM1J2geqPVorrcSls7nPEVg/ftJtpy
         w/hNWYqS3F3RRWizF+a3FvKsOrnG+Vc84oSBYd69wicc9LTHxFJ3WtPGky+KZAz4yHwD
         IyGr3ozXsCcq9ybp33Pa9xhyGur0mSHAskO7anNoJ77qMM5BEDeaE+Kkbr9mV5XQW2eA
         fRSQ==
X-Received: by 10.68.29.36 with SMTP id g4mr12372882pbh.145.1380116755615;
        Wed, 25 Sep 2013 06:45:55 -0700 (PDT)
Received: from lanh ([115.73.233.124])
        by mx.google.com with ESMTPSA id bb1sm47833996pbc.10.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 25 Sep 2013 06:45:54 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 25 Sep 2013 20:49:22 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235346>

The alias was from Ren=C3=A9 Scharfe's Google+ post [1]. For reference =
when
the Internet (or Google) is down:

    While grep is an indispensable tool if you're working with text
    files, some aspects of it could be improved. ack (or ack-grep, as
    it's called on Debian) has a few nice ideas in this regard. I
    especially like its presentation of search results from multiple
    files, which leaves more space for the actual file contents.

    And with the upcoming release 1.7.7 of git, its built-in grep
    command can dress up like ack and show search results in that
    nicer way, too. Run this (single line) command to add an alias
    that you can call as "git ack" ...

[1] https://plus.google.com/104164106444631459594/posts

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 One of the few things I like about Clearcase is the examples section
 in their man pages, which contain very practical and often used
 commands. So I'd like to do the same way to git: start adding
 examples that are useful, not just ones that demonstrate difficult
 concepts or use cases.
=20
 Those often used commands are likely popular aliases on the Internet.
 The next one that comes to mind after "git ack" is "git lol". We
 probably won't add them all. Certain concensus is needed to keep
 examples from becoming a encyclopedia.

 Good or bad move?

 Documentation/git-grep.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 8497aa4..a4881e5 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -269,6 +269,12 @@ Examples
 	Looks for a line that has `NODE` or `Unexpected` in
 	files that have lines that match both.
=20
+`git -c color.grep.filename=3D'bold green' -c color.grep.match=3D'blac=
k yellow' grep --break --heading -n pattern`::
+	Searches for `pattern` and produces output similar to ack(1).
+	Alternatively you could add an alias for frequent use:
++
+`git config --global --add alias.ack "-c color.grep.filename=3D'bold g=
reen' -c color.grep.match=3D'black yellow' grep --break --heading -n"`
+
 GIT
 ---
 Part of the linkgit:git[1] suite
--=20
1.8.2.83.gc99314b
