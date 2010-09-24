From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 23/24] t9300 (fast-import), series Q: re-indent
Date: Fri, 24 Sep 2010 02:28:05 -0500
Message-ID: <20100924072805.GX4666@burratino>
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
X-From: git-owner@vger.kernel.org Fri Sep 24 09:32:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz2lF-0004bV-M3
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 09:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078Ab0IXHax (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 03:30:53 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39589 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753178Ab0IXHaw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 03:30:52 -0400
Received: by mail-iw0-f174.google.com with SMTP id 5so2167278iwn.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 00:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=tMtRhwLcpAJhXFyufa0cVEKZyfJ79WZq1+On/jtyT0Q=;
        b=CWQsv0XqqG1sIE9QETr2+9pLdy1mytmDTgcmTQkVqrQteH0kJk5tiq7qnwg+FvoJyc
         w+VWUE2+fzB1/6d4b3ahPG64lDrftOluE6PZPFT7znfzDUTF14kdTMseya+Pc6uw9FKN
         mnTEbHWK6C8yHcU1085ieJ5Qyqh1sIMSrnCG0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GH36dMCIzx5daiYRsuTdlE9Tw9mhNKl/m7xnReDmyj3k2cj5McCag7dJrFSOdi+yWF
         X+9CwHPUwlMEoK2IvlsbxmGXVQPuiopbclHx2eE1hs5Zxh3YsEDbIsMiJoJO7OZXWZDU
         F0xN6J4kJM9o60dei9TZiCfxG1ufVYJTjGEb4=
Received: by 10.231.10.141 with SMTP id p13mr3176874ibp.183.1285313451970;
        Fri, 24 Sep 2010 00:30:51 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id h8sm1968639ibk.15.2010.09.24.00.30.51
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 00:30:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100924065900.GA4666@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156959>

See "t9300 (fast-import), series A: re-indent".

Cc: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9300-fast-import.sh |  158 +++++++++++++++++++++++++-----------------------
 1 files changed, 83 insertions(+), 75 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index ef432e7..970f594 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1379,13 +1379,13 @@ EOF
 
 INPUT_END
 
-test_expect_success \
-	'Q: commit notes' \
-	'git fast-import <input &&
-	 git whatchanged notes-test'
-test_expect_success \
-	'Q: verify pack' \
-	'verify_packs'
+test_expect_success 'Q: commit notes' '
+	git fast-import <input &&
+	git whatchanged notes-test
+'
+test_expect_success 'Q: verify pack' '
+	verify_packs
+'
 
 commit1=$(git rev-parse notes-test~2)
 commit2=$(git rev-parse notes-test^)
@@ -1397,10 +1397,10 @@ committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
 first (:3)
 EOF
-test_expect_success \
-	'Q: verify first commit' \
-	'git cat-file commit notes-test~2 | sed 1d >actual &&
-	test_cmp expect actual'
+test_expect_success 'Q: verify first commit' '
+	git cat-file commit notes-test~2 | sed 1d >actual &&
+	test_cmp expect actual
+'
 
 cat >expect <<EOF
 parent $commit1
@@ -1409,10 +1409,10 @@ committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
 second (:5)
 EOF
-test_expect_success \
-	'Q: verify second commit' \
-	'git cat-file commit notes-test^ | sed 1d >actual &&
-	test_cmp expect actual'
+test_expect_success 'Q: verify second commit' '
+	git cat-file commit notes-test^ | sed 1d >actual &&
+	test_cmp expect actual
+'
 
 cat >expect <<EOF
 parent $commit2
@@ -1421,10 +1421,10 @@ committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
 third (:6)
 EOF
-test_expect_success \
-	'Q: verify third commit' \
-	'git cat-file commit notes-test | sed 1d >actual &&
-	test_cmp expect actual'
+test_expect_success 'Q: verify third commit' '
+	git cat-file commit notes-test | sed 1d >actual &&
+	test_cmp expect actual
+'
 
 cat >expect <<EOF
 author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
@@ -1432,10 +1432,10 @@ committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
 notes (:9)
 EOF
-test_expect_success \
-	'Q: verify first notes commit' \
-	'git cat-file commit refs/notes/foobar~2 | sed 1d >actual &&
-	test_cmp expect actual'
+test_expect_success 'Q: verify first notes commit' '
+	git cat-file commit refs/notes/foobar~2 | sed 1d >actual &&
+	test_cmp expect actual
+'
 
 cat >expect.unsorted <<EOF
 100644 blob $commit1
@@ -1443,25 +1443,28 @@ cat >expect.unsorted <<EOF
 100644 blob $commit3
 EOF
 cat expect.unsorted | sort >expect
-test_expect_success \
-	'Q: verify first notes tree' \
-	'git cat-file -p refs/notes/foobar~2^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
-	 test_cmp expect actual'
+test_expect_success 'Q: verify first notes tree' '
+	git cat-file -p refs/notes/foobar~2^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
+	test_cmp expect actual
+'
 
 echo "$note1_data" >expect
-test_expect_success \
-	'Q: verify first note for first commit' \
-	'git cat-file blob refs/notes/foobar~2:$commit1 >actual && test_cmp expect actual'
+test_expect_success 'Q: verify first note for first commit' '
+	git cat-file blob refs/notes/foobar~2:$commit1 >actual &&
+	test_cmp expect actual
+'
 
 echo "$note2_data" >expect
-test_expect_success \
-	'Q: verify first note for second commit' \
-	'git cat-file blob refs/notes/foobar~2:$commit2 >actual && test_cmp expect actual'
+test_expect_success 'Q: verify first note for second commit' '
+	git cat-file blob refs/notes/foobar~2:$commit2 >actual &&
+	test_cmp expect actual
+'
 
 echo "$note3_data" >expect
-test_expect_success \
-	'Q: verify first note for third commit' \
-	'git cat-file blob refs/notes/foobar~2:$commit3 >actual && test_cmp expect actual'
+test_expect_success 'Q: verify first note for third commit' '
+	git cat-file blob refs/notes/foobar~2:$commit3 >actual &&
+	test_cmp expect actual
+'
 
 cat >expect <<EOF
 parent `git rev-parse --verify refs/notes/foobar~2`
@@ -1470,10 +1473,10 @@ committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
 notes (:10)
 EOF
-test_expect_success \
-	'Q: verify second notes commit' \
-	'git cat-file commit refs/notes/foobar^ | sed 1d >actual &&
-	test_cmp expect actual'
+test_expect_success 'Q: verify second notes commit' '
+	git cat-file commit refs/notes/foobar^ | sed 1d >actual &&
+	test_cmp expect actual
+'
 
 cat >expect.unsorted <<EOF
 100644 blob $commit1
@@ -1481,25 +1484,28 @@ cat >expect.unsorted <<EOF
 100644 blob $commit3
 EOF
 cat expect.unsorted | sort >expect
-test_expect_success \
-	'Q: verify second notes tree' \
-	'git cat-file -p refs/notes/foobar^^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
-	 test_cmp expect actual'
+test_expect_success 'Q: verify second notes tree' '
+	git cat-file -p refs/notes/foobar^^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
+	test_cmp expect actual
+'
 
 echo "$note1b_data" >expect
-test_expect_success \
-	'Q: verify second note for first commit' \
-	'git cat-file blob refs/notes/foobar^:$commit1 >actual && test_cmp expect actual'
+test_expect_success 'Q: verify second note for first commit' '
+	git cat-file blob refs/notes/foobar^:$commit1 >actual &&
+	test_cmp expect actual
+'
 
 echo "$note2_data" >expect
-test_expect_success \
-	'Q: verify first note for second commit' \
-	'git cat-file blob refs/notes/foobar^:$commit2 >actual && test_cmp expect actual'
+test_expect_success 'Q: verify first note for second commit' '
+	git cat-file blob refs/notes/foobar^:$commit2 >actual &&
+	test_cmp expect actual
+'
 
 echo "$note3_data" >expect
-test_expect_success \
-	'Q: verify first note for third commit' \
-	'git cat-file blob refs/notes/foobar^:$commit3 >actual && test_cmp expect actual'
+test_expect_success 'Q: verify first note for third commit' '
+	git cat-file blob refs/notes/foobar^:$commit3 >actual &&
+	test_cmp expect actual
+'
 
 cat >expect <<EOF
 author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
@@ -1507,24 +1513,25 @@ committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
 notes (:11)
 EOF
-test_expect_success \
-	'Q: verify third notes commit' \
-	'git cat-file commit refs/notes/foobar2 | sed 1d >actual &&
-	test_cmp expect actual'
+test_expect_success 'Q: verify third notes commit' '
+	git cat-file commit refs/notes/foobar2 | sed 1d >actual &&
+	test_cmp expect actual
+'
 
 cat >expect.unsorted <<EOF
 100644 blob $commit1
 EOF
 cat expect.unsorted | sort >expect
-test_expect_success \
-	'Q: verify third notes tree' \
-	'git cat-file -p refs/notes/foobar2^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
-	 test_cmp expect actual'
+test_expect_success 'Q: verify third notes tree' '
+	git cat-file -p refs/notes/foobar2^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
+	test_cmp expect actual
+'
 
 echo "$note1c_data" >expect
-test_expect_success \
-	'Q: verify third note for first commit' \
-	'git cat-file blob refs/notes/foobar2:$commit1 >actual && test_cmp expect actual'
+test_expect_success 'Q: verify third note for first commit' '
+	git cat-file blob refs/notes/foobar2:$commit1 >actual &&
+	test_cmp expect actual
+'
 
 cat >expect <<EOF
 parent `git rev-parse --verify refs/notes/foobar^`
@@ -1533,24 +1540,25 @@ committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
 notes (:12)
 EOF
-test_expect_success \
-	'Q: verify fourth notes commit' \
-	'git cat-file commit refs/notes/foobar | sed 1d >actual &&
-	test_cmp expect actual'
+test_expect_success 'Q: verify fourth notes commit' '
+	git cat-file commit refs/notes/foobar | sed 1d >actual &&
+	test_cmp expect actual
+'
 
 cat >expect.unsorted <<EOF
 100644 blob $commit2
 EOF
 cat expect.unsorted | sort >expect
-test_expect_success \
-	'Q: verify fourth notes tree' \
-	'git cat-file -p refs/notes/foobar^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
-	 test_cmp expect actual'
+test_expect_success 'Q: verify fourth notes tree' '
+	git cat-file -p refs/notes/foobar^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
+	test_cmp expect actual
+'
 
 echo "$note2b_data" >expect
-test_expect_success \
-	'Q: verify second note for second commit' \
-	'git cat-file blob refs/notes/foobar:$commit2 >actual && test_cmp expect actual'
+test_expect_success 'Q: verify second note for second commit' '
+	git cat-file blob refs/notes/foobar:$commit2 >actual &&
+	test_cmp expect actual
+'
 
 ###
 ### series R (feature and option)
-- 
1.7.2.3
