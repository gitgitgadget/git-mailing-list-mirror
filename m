From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/7] refs backend preamble
Date: Mon, 29 Jun 2015 13:31:36 -0700
Message-ID: <xmqq7fqm9ryv.fsf@gitster.dls.corp.google.com>
References: <1435609076-8592-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 22:31:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9fiS-0006lQ-QW
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 22:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbbF2Ubl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 16:31:41 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36251 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbbF2Ubj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 16:31:39 -0400
Received: by igrv9 with SMTP id v9so37384171igr.1
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 13:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=BvZfJjSvW66eKdsCGLhN9dNkKLKsW2HrYNdXwOjixAk=;
        b=Oiqo52vbxiw2pi4i/ZkwGezPLwlVn+gRoPSxepbEJvcZh1OL36380srpzS8ROncOfj
         dFarlwp2W4kQ1fIc9USJKTn9q26S47mYVFlV0AnginzLt1hA+WODD6SN+FOtPCGgDMZs
         85kbJMRan9sDIUzliqufp0TGDpVnjDTDxPAMnkHsEmbG+mp8x8qL3cSqRBrIpbm6syct
         KTfeARk6XBKEa1PjaEffKdniwew6Hkz0GU5Lv8rRNOeassAIyVoHdzuOKeiIJCLOngqV
         cnILE7Zbf1QF3xwbT38nxumnwncHIybUdm+ZXASdcDe0bZaWHwewWaAJ8EDWICo10Zz0
         Cziw==
X-Received: by 10.50.50.98 with SMTP id b2mr17960130igo.42.1435609899125;
        Mon, 29 Jun 2015 13:31:39 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:946c:210:22fc:378d])
        by mx.google.com with ESMTPSA id j20sm6208796igt.16.2015.06.29.13.31.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jun 2015 13:31:38 -0700 (PDT)
In-Reply-To: <1435609076-8592-1-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Mon, 29 Jun 2015 16:17:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273014>

David Turner <dturner@twopensource.com> writes:

> Minor formatting fixes from Junio Hamano.

There is another.

By the way, "unused variable" is not a formatting fix.


 git-bisect.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index dddcc89..2fd8ea6 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -210,7 +210,7 @@ check_expected_revs() {
 }
 
 bisect_head_exists() {
-    git rev-parse --quiet --verify "BISECT_HEAD" >/dev/null
+	git rev-parse --quiet --verify "BISECT_HEAD" >/dev/null
 }
 
 bisect_skip() {
