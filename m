From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] test prerequisites: enumerate with commas
Date: Mon, 21 Jul 2014 15:30:05 -0700
Message-ID: <xmqqwqb6gxaq.fsf_-_@gitster.dls.corp.google.com>
References: <20140716092959.GA378@ucw.cz>
	<1405611425-10009-1-git-send-email-kasal@ucw.cz>
	<1405611425-10009-5-git-send-email-kasal@ucw.cz>
	<CABPQNSaiogqGryK8YOzQXs_z_syvXMBqvOpvGfMNdbLkNzRq_w@mail.gmail.com>
	<xmqqvbqqk5qu.fsf@gitster.dls.corp.google.com>
	<xmqqoawiiigz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stepan Kasal <kasal@ucw.cz>,  Karsten Blees <karsten.blees@gmail.com>,  Johannes Sixt <j6t@kdbg.org>,  GIT Mailing-list <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>,  Pat Thoyts <patthoyts@users.sourceforge.net>
To: kusmabite@gmail.com
X-From: msysgit+bncBCG77UMM3EJRB6NIW2PAKGQER7MK7WY@googlegroups.com Tue Jul 22 00:30:19 2014
Return-path: <msysgit+bncBCG77UMM3EJRB6NIW2PAKGQER7MK7WY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-oa0-f61.google.com ([209.85.219.61])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRB6NIW2PAKGQER7MK7WY@googlegroups.com>)
	id 1X9M66-0001a2-O8
	for gcvm-msysgit@m.gmane.org; Tue, 22 Jul 2014 00:30:19 +0200
Received: by mail-oa0-f61.google.com with SMTP id eb12sf1813741oac.16
        for <gcvm-msysgit@m.gmane.org>; Mon, 21 Jul 2014 15:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=ywm2sUM/h++ubUZiMDtO2LYfcasw4/m42NKSGK9Zy+A=;
        b=Pk286nG1AVdXqoKAHYbuDeOk5RRBx2FO0Z7ZAFKzprVKowY44e5NmqFXVHnI8zl1PI
         VRwSKZ+UKwhFaWm1I/gCSsacJU1ldE/ejBtZ4vmzwxdBPDUJrB+dzvxNDTIhhUroHZH+
         y8qlBLYp3F9gW0+GMKlW9oCz2ddHX8Yt4aRLOX8VHxT08RspZL7N411h3yN0P85qc7g2
         tPOLhpKblKUYV9kK4fHF9wSy+xTfug7k3c318LscjUGGKcZ8sPTwRXGjs/lLXLNgF8Hz
         xqRR50oPO8S3pu4hVVPdv18H1Q6shww7viRXvH8Wd3WBLDC5t2lMuu4SmRIE5KEKkEY+
         YQkA==
X-Received: by 10.50.39.16 with SMTP id l16mr147012igk.7.1405981817818;
        Mon, 21 Jul 2014 15:30:17 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.129.99 with SMTP id nv3ls1932447igb.24.gmail; Mon, 21 Jul
 2014 15:30:17 -0700 (PDT)
X-Received: by 10.68.195.9 with SMTP id ia9mr8841640pbc.7.1405981817263;
        Mon, 21 Jul 2014 15:30:17 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id p3si1151211yho.7.2014.07.21.15.30.17
        for <msysgit@googlegroups.com>;
        Mon, 21 Jul 2014 15:30:17 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 311122BC46;
	Mon, 21 Jul 2014 18:30:16 -0400 (EDT)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A9A242BC42;
	Mon, 21 Jul 2014 18:30:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 378E12BC31;
	Mon, 21 Jul 2014 18:30:07 -0400 (EDT)
In-Reply-To: <xmqqoawiiigz.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 21 Jul 2014 13:07:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 915AC964-1126-11E4-BE35-9903E9FBB39C-77302942!pb-smtp0.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted
 sender) smtp.mail=junio@pobox.com;       dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253999>

test_have_prereq does understand multiple predicates given as
separate arguments, but that is by accident.  We should list the
prerequisites just like we use them as the (first) optional
parameter for test_expect_success, concatenated with commas, for
consistency.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9809-git-p4-client-view.sh |  4 ++--
 t/t9812-git-p4-wildcards.sh   | 14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t9809-git-p4-client-view.sh b/t/t9809-git-p4-client-view.sh
index e80db7a..897b3c3 100755
--- a/t/t9809-git-p4-client-view.sh
+++ b/t/t9809-git-p4-client-view.sh
@@ -365,7 +365,7 @@ test_expect_success 'wildcard files submit back to p4, client-spec case' '
 	(
 		cd "$git" &&
 		echo git-wild-hash >dir1/git-wild#hash &&
-		if test_have_prereq !MINGW !CYGWIN
+		if test_have_prereq !MINGW,!CYGWIN
 		then
 			echo git-wild-star >dir1/git-wild\*star
 		fi &&
@@ -379,7 +379,7 @@ test_expect_success 'wildcard files submit back to p4, client-spec case' '
 	(
 		cd "$cli" &&
 		test_path_is_file dir1/git-wild#hash &&
-		if test_have_prereq !MINGW !CYGWIN
+		if test_have_prereq !MINGW,!CYGWIN
 		then
 			test_path_is_file dir1/git-wild\*star
 		fi &&
diff --git a/t/t9812-git-p4-wildcards.sh b/t/t9812-git-p4-wildcards.sh
index ed4b488..0206771 100755
--- a/t/t9812-git-p4-wildcards.sh
+++ b/t/t9812-git-p4-wildcards.sh
@@ -14,7 +14,7 @@ test_expect_success 'add p4 files with wildcards in the names' '
 		printf "file2\nhas\nsome\nrandom\ntext\n" >file2 &&
 		p4 add file2 &&
 		echo file-wild-hash >file-wild#hash &&
-		if test_have_prereq !MINGW !CYGWIN
+		if test_have_prereq !MINGW,!CYGWIN
 		then
 			echo file-wild-star >file-wild\*star
 		fi &&
@@ -31,7 +31,7 @@ test_expect_success 'wildcard files git p4 clone' '
 	(
 		cd "$git" &&
 		test -f file-wild#hash &&
-		if test_have_prereq !MINGW !CYGWIN
+		if test_have_prereq !MINGW,!CYGWIN
 		then
 			test -f file-wild\*star
 		fi &&
@@ -46,7 +46,7 @@ test_expect_success 'wildcard files submit back to p4, add' '
 	(
 		cd "$git" &&
 		echo git-wild-hash >git-wild#hash &&
-		if test_have_prereq !MINGW !CYGWIN
+		if test_have_prereq !MINGW,!CYGWIN
 		then
 			echo git-wild-star >git-wild\*star
 		fi &&
@@ -60,7 +60,7 @@ test_expect_success 'wildcard files submit back to p4, add' '
 	(
 		cd "$cli" &&
 		test_path_is_file git-wild#hash &&
-		if test_have_prereq !MINGW !CYGWIN
+		if test_have_prereq !MINGW,!CYGWIN
 		then
 			test_path_is_file git-wild\*star
 		fi &&
@@ -75,7 +75,7 @@ test_expect_success 'wildcard files submit back to p4, modify' '
 	(
 		cd "$git" &&
 		echo new-line >>git-wild#hash &&
-		if test_have_prereq !MINGW !CYGWIN
+		if test_have_prereq !MINGW,!CYGWIN
 		then
 			echo new-line >>git-wild\*star
 		fi &&
@@ -89,7 +89,7 @@ test_expect_success 'wildcard files submit back to p4, modify' '
 	(
 		cd "$cli" &&
 		test_line_count = 2 git-wild#hash &&
-		if test_have_prereq !MINGW !CYGWIN
+		if test_have_prereq !MINGW,!CYGWIN
 		then
 			test_line_count = 2 git-wild\*star
 		fi &&
@@ -152,7 +152,7 @@ test_expect_success 'wildcard files submit back to p4, delete' '
 	(
 		cd "$cli" &&
 		test_path_is_missing git-wild#hash &&
-		if test_have_prereq !MINGW !CYGWIN
+		if test_have_prereq !MINGW,!CYGWIN
 		then
 			test_path_is_missing git-wild\*star
 		fi &&
-- 
2.0.2-870-g9e2e527

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
