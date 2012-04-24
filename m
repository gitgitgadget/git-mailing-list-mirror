From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7 v4] push.default upcomming change
Date: Tue, 24 Apr 2012 12:28:10 -0700
Message-ID: <xmqq1undgcad.fsf@junio.mtv.corp.google.com>
References: <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
	<1335253806-9059-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Apr 24 21:28:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMlPO-0007fj-Jt
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 21:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757111Ab2DXT2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 15:28:14 -0400
Received: from mail-bk0-f74.google.com ([209.85.214.74]:50338 "EHLO
	mail-bk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757006Ab2DXT2N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 15:28:13 -0400
Received: by bkcjk7 with SMTP id jk7so53416bkc.1
        for <git@vger.kernel.org>; Tue, 24 Apr 2012 12:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=DFr4XF2CWHz5SZ3IDMKgOQV3mC+nhoPvcJDsliCg/Wc=;
        b=H3goMghBSCKTyBJUfnYqmcWPckMjU/ZxR7egkmt2jfViaJP1lM6ivSrjI7wkoQH1TA
         ZhsLypDpCgBPRDphKoh4ras4L/X6oBwBu5zX/KoKfhu+1XZKBA6mCPbc1887twGpwf7K
         4tclNUfNCm1FqFxqNpuq8qzB/h9Hs+o8uBDpaUIraIx6kzLoihEjHPSEqYwzdncHPC5Z
         GmwB5LX8njS3Y0XCDf7CJRirbds4Rv/YmSelhKBPLJ4GxlUmcMqSsvF5syvHskArcaUv
         9uoBvcEW+31sDC0YExOpFwi+GmNbZ886UvCM44/zPNaAAqnT8N/L+OVabYeulaksHuXx
         7gow==
Received: by 10.213.21.203 with SMTP id k11mr19955ebb.24.1335295692085;
        Tue, 24 Apr 2012 12:28:12 -0700 (PDT)
Received: by 10.213.21.203 with SMTP id k11mr19937ebb.24.1335295691908;
        Tue, 24 Apr 2012 12:28:11 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id y52si18639090eef.2.2012.04.24.12.28.11
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Tue, 24 Apr 2012 12:28:11 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id B435420004E;
	Tue, 24 Apr 2012 12:28:11 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 0DD68E125C; Tue, 24 Apr 2012 12:28:10 -0700 (PDT)
In-Reply-To: <1335253806-9059-1-git-send-email-Matthieu.Moy@imag.fr> (Matthieu
	Moy's message of "Tue, 24 Apr 2012 09:49:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQkCaeYJvSOtMvcI9gXfrvpj/JT0xk12OXMdBXcBWsBJBitBjdRvQ08zvRTgnAf8wNl55ivnHOl9ioiLkTtF1FWtSmeErPRE6xqZKDdUnA0WogUmXmEhYvg5JaJ/Wge6JCwpLEXveWB8hwcjD0aTy+pa4LozhJVkpnpMSv1WS9iQ07xSlcU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196239>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> This version should address all the comments from Junio, except that I
> went for my simple one-argument test_push_failure (we don't need the
> complex one for now, and I'm not sure the complex one will be good
> enough when we want to test 'matching'---for example, we may want to
> parse the output of 'git push').

Fine by me, and the result looks good.

I'll queue everything before the final one, with a single readability
update (attached below) on top, on mm/simple-push topic. And then the
final one will be queued on a separate mm/push/default-switch-warning
topic that is forked from the former.

Thanks for working on this.  With acks from others I'm hoping that we
can merge the "simple" to 'next' soonish.

-- >8 --
Subject: [PATCH] push.default doc: explain simple after upstream

As the "simple" mode is described in terms of what "upstream" does,
swap the order of these two entries so that the reader sees "upstream"
first and then reads "simple" with the knowledge of what "upstream"
does.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f724fc6..6a4c130 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1689,14 +1689,14 @@ push.default::
   +
   This is currently the default, but Git 2.0 will change the default
   to `simple`.
-* `simple` - like `upstream`, but refuses to push if the upstream
-  branch's name is different from the local one. This is the safest
-  option and is well-suited for beginners. It will become the default
-  in Git 2.0.
 * `upstream` - push the current branch to its upstream branch.
   With this, `git push` will update the same remote ref as the one which
   is merged by `git pull`, making `push` and `pull` symmetrical.
   See "branch.<name>.merge" for how to configure the upstream branch.
+* `simple` - like `upstream`, but refuses to push if the upstream
+  branch's name is different from the local one. This is the safest
+  option and is well-suited for beginners. It will become the default
+  in Git 2.0.
 * `current` - push the current branch to a branch of the same name.
   +
   The `simple`, `current` and `upstream` modes are for those who want to
-- 
1.7.10.433.g8de07
