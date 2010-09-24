From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 21/24] t9300 (fast-import), series O: re-indent
Date: Fri, 24 Sep 2010 02:27:07 -0500
Message-ID: <20100924072707.GV4666@burratino>
References: <20100701031819.GA12524@burratino>
 <20100701054849.GA14972@burratino>
 <20100817170216.GA14491@kytes>
 <20100905031528.GA2344@burratino>
 <20100905032253.GB2344@burratino>
 <20100924065900.GA4666@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 09:30:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz2jP-0003eL-Mh
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 09:30:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755229Ab0IXH35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 03:29:57 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39589 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755176Ab0IXH34 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 03:29:56 -0400
Received: by iwn5 with SMTP id 5so2167278iwn.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 00:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ST/XZyxWecShi7QLw07HPgKjNFhg01ma3vbvdxhj+0E=;
        b=KHqlWVClSExdJZjXhQkX+2INEIkyt8pJjdAoTK1uPkLEqa6SWo+d+FksS4zvWf9Jrv
         h3H7akIaYA/Qw7ghIFduOAOLwOQW8TxZ/8yJJDxd+qFf+n3uJVreL0h3czgJGhGnJesu
         XP1AX+Ympnh+remfGXGImUYetNtEWhPMOdwgY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=cxj39q9G2O9uHnpe0+LXs4Z3Nq6T71TG3qqKOpWyOWIZ/eRFvrMuXJOtcr4zID5jK/
         Ho6AsWKk7lQ8zrJVT3AO9eFD4DhQY/ljSlSMDg+Smoyfs4qA5yMKdjWl8u64Lyy+SMe4
         eKqx9owMr0Tcb8BUkTuG3PMsAyGPNThxLKLIA=
Received: by 10.231.182.204 with SMTP id cd12mr3536002ibb.101.1285313393724;
        Fri, 24 Sep 2010 00:29:53 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r3sm1968326ibk.13.2010.09.24.00.29.53
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 00:29:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100924065900.GA4666@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156957>

See "t9300 (fast-import), series A: re-indent".

Cc: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9300-fast-import.sh |   46 +++++++++++++++++++++++-----------------------
 1 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 7bd2bd0..04e4f6d 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -998,10 +998,10 @@ D file2/file5
 
 INPUT_END
 
-test_expect_success \
-	'O: comments are all skipped' \
-	'git fast-import <input &&
-	 test `git rev-parse N3` = `git rev-parse O1`'
+test_expect_success 'O: comments are all skipped' '
+	git fast-import <input &&
+	test `git rev-parse N3` = `git rev-parse O1`
+'
 
 cat >input <<INPUT_END
 commit refs/heads/O2
@@ -1019,14 +1019,14 @@ D file2/file5
 
 INPUT_END
 
-test_expect_success \
-	'O: blank lines not necessary after data commands' \
-	'git fast-import <input &&
-	 test `git rev-parse N3` = `git rev-parse O2`'
+test_expect_success 'O: blank lines not necessary after data commands' '
+	git fast-import <input &&
+	test `git rev-parse N3` = `git rev-parse O2`
+'
 
-test_expect_success \
-	'O: repack before next test' \
-	'git repack -a -d'
+test_expect_success 'O: repack before next test' '
+	git repack -a -d
+'
 
 cat >input <<INPUT_END
 commit refs/heads/O3
@@ -1064,13 +1064,13 @@ of
 empty
 commits
 INPUT_END
-test_expect_success \
-	'O: blank lines not necessary after other commands' \
-	'git fast-import <input &&
-	 test 8 = `find .git/objects/pack -type f | wc -l` &&
-	 test `git rev-parse refs/tags/O3-2nd` = `git rev-parse O3^` &&
-	 git log --reverse --pretty=oneline O3 | sed s/^.*z// >actual &&
-	 test_cmp expect actual'
+test_expect_success 'O: blank lines not necessary after other commands' '
+	git fast-import <input &&
+	test 8 = `find .git/objects/pack -type f | wc -l` &&
+	test `git rev-parse refs/tags/O3-2nd` = `git rev-parse O3^` &&
+	git log --reverse --pretty=oneline O3 | sed s/^.*z// >actual &&
+	test_cmp expect actual
+'
 
 cat >input <<INPUT_END
 commit refs/heads/O4
@@ -1097,11 +1097,11 @@ zcommits
 COMMIT
 progress I'm done!
 INPUT_END
-test_expect_success \
-	'O: progress outputs as requested by input' \
-	'git fast-import <input >actual &&
-	 grep "progress " <input >expect &&
-	 test_cmp expect actual'
+test_expect_success 'O: progress outputs as requested by input' '
+	git fast-import <input >actual &&
+	grep "progress " <input >expect &&
+	test_cmp expect actual
+'
 
 ###
 ### series P (gitlinks)
-- 
1.7.2.3
