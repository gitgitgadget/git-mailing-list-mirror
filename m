From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: push.default documented in "man git-push"?
Date: Tue, 2 Oct 2012 20:39:11 +0530
Message-ID: <CALkWK0mxLQNOE8kZUJrxYQMWXpzZW0uS+N2iGXxdRmCXTzYcBQ@mail.gmail.com>
References: <CAN7QDoK4WCuRMu+KV6ACo9miR9_eFEE510J5PDiPk+BXLyQG9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: David Glasser <glasser@davidglasser.net>
X-From: git-owner@vger.kernel.org Tue Oct 02 17:09:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ46R-0007VE-By
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 17:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753581Ab2JBPJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 11:09:33 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:39205 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753222Ab2JBPJc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 11:09:32 -0400
Received: by qaas11 with SMTP id s11so584341qaa.19
        for <git@vger.kernel.org>; Tue, 02 Oct 2012 08:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mwNjBa2nNRuCHQzhRZSGjxqW7OBGmajLJDYYw86g8+M=;
        b=WFsak3IUyYOmR8/onLbCCzc4kFubqCH+x4Sq6zz+LOjov0ZelT4L8C+nCSrwDD4w4I
         yNFukwqC4poHWJObjAD/546Kjx39ZPO7nsDFLlUAPJjd+5ep655MLJZSx+peepEBPu8g
         Tp/oemAxsNsRAN2t65E9c1y6N+lN+0OAUg1ffbEMTFpYZMkH7ezjsgk+US5uvaF/dsfC
         OaHcHfCE2B1nSdjdCbIGekg0RKphuOWmrrNzAFi0ngbvqEqaY9HK0d1Tkb2BRuWyecuC
         qH3yqdLUixK3l9JKplM1n2oZsbCNh4c6Dx566kIOLeiL/luzS6S2eS8C9RJw4jfOvHJE
         yAQw==
Received: by 10.224.213.10 with SMTP id gu10mr2762695qab.10.1349190572161;
 Tue, 02 Oct 2012 08:09:32 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Tue, 2 Oct 2012 08:09:11 -0700 (PDT)
In-Reply-To: <CAN7QDoK4WCuRMu+KV6ACo9miR9_eFEE510J5PDiPk+BXLyQG9Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206804>

David Glasser wrote:
> Is the newish push.default documented in the "git push" manpage
> anywhere? I don't see it mentioned (and there are several references
> to the "default" behavior), but maybe I'm missing something. Is it
> left out on purpose (ie, config values aren't supposed to be mentioned
> in command manpages)?

You're right.  It's documented in `man git-config`, but we should
probably mention it in the `git-push` manpage.

--8<--
From: Ramkumar Ramachandra <artagnon@gmail.com>
Date: Tue, 2 Oct 2012 20:37:13 +0530
Subject: [PATCH] Documentation: mention `push.default` in git-push.txt

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-push.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index cb97cc1..8751b38 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -37,7 +37,8 @@ OPTIONS[[OPTIONS]]
        `+`, followed by the source ref <src>, followed
        by a colon `:`, followed by the destination ref <dst>.
        It is used to specify with what <src> object the <dst> ref
-       in the remote repository is to be updated.
+       in the remote repository is to be updated.  If not specified,
+       the configuration variable `push.default` is used.
 +
 The <src> is often the name of the branch you would want to push, but
 it can be any arbitrary "SHA-1 expression", such as `master~4` or
-- 
1.7.12.1.428.g652398a.dirty
