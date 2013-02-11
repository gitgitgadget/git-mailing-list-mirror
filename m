From: Michal Nazarewicz <mpn@google.com>
Subject: [PATCHv3 2/5] Git.pm: fix example in command_close_bidi_pipe documentation
Date: Mon, 11 Feb 2013 17:23:36 +0100
Message-ID: <d8be058cc4c9a3baa68c166fd9f3333e93e3583e.1360599712.git.mina86@mina86.com>
References: <cover.1360599057.git.mina86@mina86.com>
Cc: git@vger.kernel.org, Michal Nazarewicz <mina86@mina86.com>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 11 17:24:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4wBD-00023e-9y
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 17:24:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757924Ab3BKQYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 11:24:07 -0500
Received: from mail-ea0-f173.google.com ([209.85.215.173]:38252 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757725Ab3BKQYB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 11:24:01 -0500
Received: by mail-ea0-f173.google.com with SMTP id i1so2855276eaa.32
        for <git@vger.kernel.org>; Mon, 11 Feb 2013 08:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=F7s5GOPHkQPzFd2inVdZ8fQlvgr/NONQafO0P7rdsMU=;
        b=GmAjdP2zgYmRKNtXmaMHUJibtdaJmiHfLquUqTrI7nU/XpyKKQGoS/qpVyirz1JbXw
         u9pBlttEDWNnjcohKHJmLJnLK2HrrNRjLHXKOSSFhmZJLFEFWA3pQmXNY+1yKL0+L+18
         kfI03l6UCy2E1G4vcD5c3jQx9DzKpV/gFj/US5Gtjadt79ZbejoE1ZM56+winyTIP7i7
         o9pxFpdk+Omo/IGLUrxqjKxa4SZTrZ8LpoLmhPTbIEQHu4Uj9QsYGlfNOp7SCoPwmVcr
         vGdTZrnGUMcrIkjN+DULf+yyKbmQLC52xoTOmlzgvc6NbSHnothhmy5miPPU9KIwonhE
         sCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:x-gm-message-state;
        bh=F7s5GOPHkQPzFd2inVdZ8fQlvgr/NONQafO0P7rdsMU=;
        b=TfD7qxN1ARZvy8dAz9eb8luqkIF3MmCBJimLoRrl0d1IG7CXAvL+FQSMYs4FQ/M+H/
         2Cmp4YuN13iOXr+GkoxU0Q9Krh2CEgn9lBQNJowLxNbzU5scSJ3+jX2CR1MHfn9gBUx4
         WfmTYQurxTwHpGdqB6t5tL2YCaClRkI/9yzD6ywaHwmh0W74qPHCJgH5jYh6S56agGeH
         4j0TobJA5pgyu/e418sRdFQlqvg6648q+GhJE0eb3G4rwy9q2SjU1FzpFLXtRsPtAFVh
         c3w4ZiZgfSuCFv8uPnwnSVuJR6SSUqhYkh5S+sCkzFnmy/5YBudH6oAym8JmzKp8zMlW
         ncyg==
X-Received: by 10.14.194.8 with SMTP id l8mr51799969een.31.1360599839768;
        Mon, 11 Feb 2013 08:23:59 -0800 (PST)
Received: from mpn-glaptop.corp.google.com ([2620:0:105f:5:1d0a:8048:51b4:44a9])
        by mx.google.com with ESMTPS id 3sm63347527eej.6.2013.02.11.08.23.58
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 11 Feb 2013 08:23:59 -0800 (PST)
X-Mailer: git-send-email 1.8.1.3.571.g3f8bed7.dirty
In-Reply-To: <cover.1360599057.git.mina86@mina86.com>
In-Reply-To: <cover.1360599057.git.mina86@mina86.com>
References: <cover.1360599057.git.mina86@mina86.com>
X-Gm-Message-State: ALoCoQl5/DQOPw2T4ILRfo65znBQlHxC88XbQfOsc41vDNeAaZFKdz5X6OLwU1Ol5JAnRdhWy9rhH9sUC10eVWW8iDXIP+dCzhTlNHc+QbeoJLKzbFoLFtKD28YDn0x+DNWpWxINPdcPvLsA9L1xKqCOtA0wZQrdK67A6qy0AkZ89497sWq8LaXfgYb+nI3vexylr8adiTHY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216042>

From: Michal Nazarewicz <mina86@mina86.com>


Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
---
 perl/Git.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index bbb753a..11f310a 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -418,7 +418,7 @@ and it is the fourth value returned by C<command_bidi_pipe()>.  The call idiom
 is:
 
 	my ($pid, $in, $out, $ctx) = $r->command_bidi_pipe('cat-file --batch-check');
-	print "000000000\n" $out;
+	print $out "000000000\n";
 	while (<$in>) { ... }
 	$r->command_close_bidi_pipe($pid, $in, $out, $ctx);
 
-- 
1.8.1.3.571.g3f8bed7.dirty
