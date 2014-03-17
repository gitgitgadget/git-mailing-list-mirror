From: Chris Packham <judge.packham@gmail.com>
Subject: [PATCH] fixup! Documentation/git-am: Document supported --patch-format options
Date: Mon, 17 Mar 2014 20:50:49 +1300
Message-ID: <1395042649-16040-1-git-send-email-judge.packham@gmail.com>
References: <5326A5DB.5070407@gmail.com>
Cc: gitster@pobox.com, Chris Packham <judge.packham@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 17 08:51:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPSKF-0003wA-9A
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 08:51:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbaCQHvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 03:51:01 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:48427 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932337AbaCQHvA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 03:51:00 -0400
Received: by mail-pa0-f41.google.com with SMTP id fa1so5418540pad.0
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 00:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fe6KMRCH22xz9cnRlNmTi6UiTukVizu8WWB3wZdcLQQ=;
        b=XViZ4TiEVqrLh9j1heJkxVJx2AahNZ8061GV/4yKaLtU/IfJei2+Rbow92r6s4c4Zv
         aCtLc511Uacw6iaPxx5O0DOEIYrmDaLVuFeyPqQQxmM0yivJkJ/4hNW1iAAESwf9eTOL
         TLub40ei4iveAcS8qT+ZRguVqZA9EojB0cPS4nx3vKsbV01I1MwQbgqtF70f01/1Ugff
         /wA740AXkZE7QY7NEPQySgKgXP2aDvHNw+gh0ta9VvylgeK/Evl7nMroxN3gmBsTI8Qx
         tVLg6kehxx1CKJOAPt8TlXgcyMfN+h8UPXz+hV/pwACk8lJCZrs8d/XjFgJ2NvRrdkxv
         HViQ==
X-Received: by 10.66.175.4 with SMTP id bw4mr24512387pac.56.1395042659617;
        Mon, 17 Mar 2014 00:50:59 -0700 (PDT)
Received: from chrisp3-dl.ws.atlnz.lc (2-163-36-202-static.alliedtelesis.co.nz. [202.36.163.2])
        by mx.google.com with ESMTPSA id j3sm40690666pbh.38.2014.03.17.00.50.57
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 17 Mar 2014 00:50:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <5326A5DB.5070407@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244229>

---
On 17/03/14 20:35, Chris Packham wrote:> On 17/03/14 19:39, Junio C Hamano wrote:
>> Chris Packham <judge.packham@gmail.com> writes:
>>
>>> Ping?
>>
>> Hasn't it been already cooking in 'next' for a few days?
>>
> 
> Indeed I think I missed a "What's cooking". Do you want me to submit a
> fixup for the spelling mistake?
> 

May as well just send it.

 Documentation/git-am.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 76bd359..f8a7d0c 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -101,7 +101,7 @@ default.   You can use `--no-utf8` to override this.
 	By default the command will try to detect the patch format
 	automatically. This option allows the user to bypass the automatic
 	detection and specify the patch format that the patch(es) should be
-	intepreted as. Valid formats are mbox, stgit, stgit-series and hg.
+	interpreted as. Valid formats are mbox, stgit, stgit-series and hg.
 
 -i::
 --interactive::
-- 
1.7.9.5
