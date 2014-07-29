From: Karsten Blees <karsten.blees@gmail.com>
Subject: [RFC/PATCH] Windows tests: let $TRASH_DIRECTORY point to
 native Windows path
Date: Tue, 29 Jul 2014 21:43:55 +0200
Message-ID: <53D7F97B.7060607@gmail.com>
References: <xmqq4my9f4qw.fsf@gitster.dls.corp.google.com> <53CFC414.1010601@gmail.com> <CACsJy8DqdTWqVimK0o4rcBXL==iZCsu1OgX2W9ZbgebcSDaKxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, 
 Git Mailing List <git@vger.kernel.org>,
 msysGit <msysgit@googlegroups.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: msysgit+bncBCH3XYXLXQDBB7HS36PAKGQEITS7EOI@googlegroups.com Tue Jul 29 21:43:59 2014
Return-path: <msysgit+bncBCH3XYXLXQDBB7HS36PAKGQEITS7EOI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f185.google.com ([209.85.212.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBB7HS36PAKGQEITS7EOI@googlegroups.com>)
	id 1XCDJV-0006f8-W1
	for gcvm-msysgit@m.gmane.org; Tue, 29 Jul 2014 21:43:58 +0200
Received: by mail-wi0-f185.google.com with SMTP id f8sf69917wiw.12
        for <gcvm-msysgit@m.gmane.org>; Tue, 29 Jul 2014 12:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=jtnAGz5CYnzM3CmzgK7Tj5feWqUlKrU/MiQfkDSVZc0=;
        b=H447kJ2cs1icrCavLAklYzI7+Vy8SxbQvrSVgbY4tr6I+l5Ah+XCedm3Nvs+1Zg5Gl
         DMjRCBK8FMJxS8EtBWF/nnWcvEGrCpvY4PrZ43z0J909X5eYdPgGI1yIA8KuCq40aX0S
         vsHI4RuV4/rZCEY4X+ZdiidDgSqqzZjGwiS85ReBd/SRQDwdHKo/rIbGU7iqQJdZlbfh
         aXypYVgiPQlpU1iVbSG0x9Dq3UIVQXqknLYCgem5XzxP/WTB14a5KOKzh1fJfWQ0BlZ4
         36QJTLBXEl+PXwLGlrefTiaWTXKOm39l0gBDqVLj7bYJ9sTLsUUvGwjCVTA5czvvBcya
         rkfQ==
X-Received: by 10.152.22.132 with SMTP id d4mr20694laf.29.1406663037723;
        Tue, 29 Jul 2014 12:43:57 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.44.227 with SMTP id h3ls78267lam.49.gmail; Tue, 29 Jul
 2014 12:43:55 -0700 (PDT)
X-Received: by 10.152.7.71 with SMTP id h7mr498258laa.2.1406663035947;
        Tue, 29 Jul 2014 12:43:55 -0700 (PDT)
Received: from mail-wg0-x231.google.com (mail-wg0-x231.google.com [2a00:1450:400c:c00::231])
        by gmr-mx.google.com with ESMTPS id o6si753821wij.1.2014.07.29.12.43.55
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 29 Jul 2014 12:43:55 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::231 as permitted sender) client-ip=2a00:1450:400c:c00::231;
Received: by mail-wg0-f49.google.com with SMTP id k14so141884wgh.20
        for <msysgit@googlegroups.com>; Tue, 29 Jul 2014 12:43:55 -0700 (PDT)
X-Received: by 10.194.3.74 with SMTP id a10mr6499842wja.85.1406663035800;
        Tue, 29 Jul 2014 12:43:55 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id gi15sm59748594wjc.20.2014.07.29.12.43.54
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 29 Jul 2014 12:43:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CACsJy8DqdTWqVimK0o4rcBXL==iZCsu1OgX2W9ZbgebcSDaKxg@mail.gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::231
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254463>

MSYS programs typically understand native Windows paths (e.g C:/git), but
native Windows programs (including MinGW) don't understand MSYS paths (e.g.
/c/git).

On Windows, set TRASH_DIRECTORY to the absolute native path so that it can
be used more easily in tests.

MSYS 'tar -f' interprets everything before ':' as hostname, not as drive
letter. Change respective tests to use stdin / stdout instead of '-f'. Also
use $TAR from GIT-BUILD-OPTIONS rather than hardcoded tar.

Signed-off-by: Karsten Blees <blees@dcon.de>
---

Am 25.07.2014 14:30, schrieb Duy Nguyen:
> On Wed, Jul 23, 2014 at 9:17 PM, Karsten Blees <karsten.blees@gmail.com> wrote:
>> With the version in pu, three tests fail. t7001 is fixed with a newer 'cp'.
>> The other two are unrelated (introduced by nd/multiple-work-trees topic).
>>
>> * t1501-worktree: failed 1
>>   As of 5bbcb072 "setup.c: support multi-checkout repo setup"
>>   Using $TRASH_DIRECTORY doesn't work on Windows.
>>
>> * t2026-prune-linked-checkouts: failed 1
>>   As of 404a45f1 "prune: strategies for linked checkouts"
>>   Dito.
> 
> I need your help here. Would saving $(pwd) to a variable and using it
> instead of $TRASH_DIRECTORY work? Some tests "cd" around and $(pwd)
> may not be the same as $TRASH_DIRECTORY.
> 

Yes, that would work.

(Actually, you'd only need to change 'echo "$TRASH_DIR..."' in two places (both
before cd'ing away). The other instances are parameters to non-msys programs and
are thus automatically mangled by msys.dll.)

However, I wonder why we don't set up TRASH_DIRECTORY to the native Windows path.
I believe we'd get much fewer 'special' cases that way. Ideally, you shouldn't
have to worry about the intricacies of MSYS path mangling when writing tests...

[CCing msysgit for opinions]


 t/t3513-revert-submodule.sh | 4 ++--
 t/t6041-bisect-submodule.sh | 4 ++--
 t/test-lib.sh               | 1 +
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/t3513-revert-submodule.sh b/t/t3513-revert-submodule.sh
index a1c4e02..4a44dd6 100755
--- a/t/t3513-revert-submodule.sh
+++ b/t/t3513-revert-submodule.sh
@@ -14,11 +14,11 @@ test_description='revert can handle submodules'
 git_revert () {
 	git status -su >expect &&
 	ls -1pR * >>expect &&
-	tar czf "$TRASH_DIRECTORY/tmp.tgz" * &&
+	"$TAR" cz * >"$TRASH_DIRECTORY/tmp.tgz" &&
 	git checkout "$1" &&
 	git revert HEAD &&
 	rm -rf * &&
-	tar xzf "$TRASH_DIRECTORY/tmp.tgz" &&
+	"$TAR" xz <"$TRASH_DIRECTORY/tmp.tgz" &&
 	git status -su >actual &&
 	ls -1pR * >>actual &&
 	test_cmp expect actual &&
diff --git a/t/t6041-bisect-submodule.sh b/t/t6041-bisect-submodule.sh
index c6b7aa6..0de614f 100755
--- a/t/t6041-bisect-submodule.sh
+++ b/t/t6041-bisect-submodule.sh
@@ -8,7 +8,7 @@ test_description='bisect can handle submodules'
 git_bisect () {
 	git status -su >expect &&
 	ls -1pR * >>expect &&
-	tar czf "$TRASH_DIRECTORY/tmp.tgz" * &&
+	"$TAR" cz * > "$TRASH_DIRECTORY/tmp.tgz" &&
 	GOOD=$(git rev-parse --verify HEAD) &&
 	git checkout "$1" &&
 	echo "foo" >bar &&
@@ -20,7 +20,7 @@ git_bisect () {
 	git bisect start &&
 	git bisect good $GOOD &&
 	rm -rf * &&
-	tar xzf "$TRASH_DIRECTORY/tmp.tgz" &&
+	"$TAR" xz <"$TRASH_DIRECTORY/tmp.tgz" &&
 	git status -su >actual &&
 	ls -1pR * >>actual &&
 	test_cmp expect actual &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 5102340..5f6397b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -868,6 +868,7 @@ case $(uname -s) in
 		md5sum "$@"
 	}
 	# git sees Windows-style pwd
+	TRASH_DIRECTORY=$(pwd -W)
 	pwd () {
 		builtin pwd -W
 	}
-- 
2.0.2.897.g7f80809.dirty

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
