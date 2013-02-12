From: Michal Nazarewicz <mpn@google.com>
Subject: [PATCHv4 2/6] Git.pm: fix example in command_close_bidi_pipe documentation
Date: Tue, 12 Feb 2013 15:02:29 +0100
Message-ID: <d8be058cc4c9a3baa68c166fd9f3333e93e3583e.1360677646.git.mina86@mina86.com>
References: <cover.1360677646.git.mina86@mina86.com>
Cc: git@vger.kernel.org
To: peff@peff.net, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Feb 12 15:04:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5GSz-0000kl-Vc
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 15:04:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933289Ab3BLODX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 09:03:23 -0500
Received: from mail-ee0-f42.google.com ([74.125.83.42]:43879 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933264Ab3BLODP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 09:03:15 -0500
Received: by mail-ee0-f42.google.com with SMTP id b47so56216eek.15
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 06:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=v8BonzkVryjmFgPV7fF5atBhyR2rTnOuvFScToe/0yQ=;
        b=ViN02bT6Qo6rIaVoY0hcxPdwk/gPU1MANwEU0kOASQhuy4kBV0Svj2/O12+VZxz8ps
         m+H8WY/9boyY/lXdnJO+6pwFKe6OLNRJ+c0BnX+WdL9XG35mBGmQ+PpgwF7IP2jq1xmU
         8xJHNyDbJEfWjENHbjeRSVRLGgGmXnVL1uQHw9fvRl/Tb8BZ9v81tMUUVrw5VV7mzpAc
         vHlsJznhuE4HiKfStsGdjQuVKSIY8QakCoJXiy8ln0C9TNEDffyOUyn+XVs6qm+jICrn
         8NkxSm+do1jLXF4FR7PisP9pQnlkzuyM3k7bEJU9/2O6B9m54ElNQQRh/HUbRQBpz6e0
         WxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:x-gm-message-state;
        bh=v8BonzkVryjmFgPV7fF5atBhyR2rTnOuvFScToe/0yQ=;
        b=KXKchN6fRE7ehIXJzWSrpMTo7jwmWcq4i78YF5hTo+PQPPqbY4l0yT8TO97S2Ur35F
         eyDNGmYMmWSyKcj3/kGaIJEWPv5KRlqGpC8JZrBLJZ7P4lCWCeKQRQitmwaJgxZnTzQd
         gmnX7AeSgEzzY0Ggq2D+8ho0Nj0IUosL4Z5In2doHlVktLXRTrcc0O0TvcY7cmXU5y6B
         a+WZPPzoGY+qzsgJ0z1tNf6ghgx4cduNeqd+UXUHhxemfYCRUbassISOYs/1hAIfHUSI
         9dIFE6N7PWScu6tl1E6PnLPd0bD3Fma1FIBVq5V+IAT/FKVfy1YUf+POSQ4r4+d2xeEW
         ZLOg==
X-Received: by 10.14.202.197 with SMTP id d45mr64207687eeo.1.1360677781248;
        Tue, 12 Feb 2013 06:03:01 -0800 (PST)
Received: from mpn-glaptop.corp.google.com ([2620:0:105f:5:6552:be17:7596:e60d])
        by mx.google.com with ESMTPS id 44sm68000941eek.5.2013.02.12.06.02.59
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 06:03:00 -0800 (PST)
X-Mailer: git-send-email 1.8.1.3.572.g32bae1f
In-Reply-To: <cover.1360677646.git.mina86@mina86.com>
In-Reply-To: <cover.1360677646.git.mina86@mina86.com>
References: <cover.1360677646.git.mina86@mina86.com>
X-Gm-Message-State: ALoCoQlrGtH0DNb59JBcvSG59b95uU2tgUL678nhXTKB/wLCwQYI9LbSbhy/aXlLKOlEq1cTImodl/vg8Wd1NcDtFkgJP9hfrcbQEpWyllM5htnO8io4F797LHEqqB5PhqFJsnguV9rwgYCsbp+NQ+cW/owggJmD87IJz5rYndFFdFogGR4kofbask6x+eUaE5zEBofMlWJ3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216154>

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
1.8.1.3.572.g32bae1f
