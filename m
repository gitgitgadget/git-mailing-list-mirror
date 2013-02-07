From: Michal Nazarewicz <mpn@google.com>
Subject: [PATCHv2 2/5] Git.pm: fix example in command_close_bidi_pipe documentation
Date: Thu,  7 Feb 2013 15:01:18 +0100
Message-ID: <21a7bae678adc80768193b62ec87742feaf97c44.1360242782.git.mina86@mina86.com>
References: <cover.1360242782.git.mina86@mina86.com>
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Feb 07 15:02:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3S3K-0005g7-V7
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 15:02:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758719Ab3BGOBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 09:01:39 -0500
Received: from mail-ee0-f52.google.com ([74.125.83.52]:63562 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753985Ab3BGOBg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 09:01:36 -0500
Received: by mail-ee0-f52.google.com with SMTP id b15so1321094eek.11
        for <git@vger.kernel.org>; Thu, 07 Feb 2013 06:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=aNtBMez5gSQ+/e3lMMRxtPliGjXNpm0ulUKeXgEoZ/0=;
        b=JIF7r7mMgeMZ31JOpOCX8fNKrzk8ypzatPOVWgOzhzCXecoKuIYmZaOZpywsJJcrFh
         4ICXqcPxJNeZp/fwAPKZy/wHL/vCUEU22UcqfGPBdyDvG+qHkNeK84OyYA1M10sviuYO
         rhc07gfHQaCidPJuvgCYKdzVq4RhVS5bPNCb3lAcb0Wq2d1QZTcdQ1KpUkwrU6H+Ivd7
         qO3bS0sJ1IKJjGjuK4g1321pnQTzvuL8LDNp16SeAWpWaow15aQhJaBalg+JI5xvHCUJ
         Z8TPgW2cUh1DVVgJhWZEoB/rP31LZQpaeKpX2dPvSVm36b7frOMV0RO0YyUu7L+o0NWv
         H+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:x-gm-message-state;
        bh=aNtBMez5gSQ+/e3lMMRxtPliGjXNpm0ulUKeXgEoZ/0=;
        b=PHIxcskl9HpSamw6MZ4JUvGhYl/XqeLlGs0bWZOotKe2IUc9nGkdvkLjy17MAzr/ie
         O5JUl1F+w6oTOckAI1m5DcSpPp8ur8EzPQnUKpAH7RiI12g+qtzZb+PXc+wnlkalhts1
         iOqXR5wg3JJGQtGjpfZ8pTjaptag7CsCHcJC3GZybk6DVGZC+mcsxkuQRW4cD4sh6iQb
         r0jL/BIUs1g9T9VjWIG1m4LfM+sJuHK3i+jl7d08w+FUx4ZwxA06l+e9cFINqZagNtcS
         XR4xXKMmlOfPoxfFK6LItZ8QKGFxp1NOx1qr96Ou8sK/SFVm148Y4J8PSJOZKaWSwDCQ
         Qhyg==
X-Received: by 10.14.206.132 with SMTP id l4mr4273167eeo.38.1360245695229;
        Thu, 07 Feb 2013 06:01:35 -0800 (PST)
Received: from mpn-glaptop.corp.google.com ([2620:0:105f:5:bdef:84b9:750e:31d0])
        by mx.google.com with ESMTPS id f6sm42214479eeo.7.2013.02.07.06.01.33
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Feb 2013 06:01:34 -0800 (PST)
X-Mailer: git-send-email 1.8.1.2.550.g0b3c9b6
In-Reply-To: <cover.1360242782.git.mina86@mina86.com>
In-Reply-To: <cover.1360242782.git.mina86@mina86.com>
References: <cover.1360242782.git.mina86@mina86.com>
X-Gm-Message-State: ALoCoQkafHxeGWx+nWNqerxPnt7luP+TBTfnto9I6YYxhkr/YUedUSL3MAcZsQ3p5kv2cNkFWnoH4WmGy/Fw+KbHErN0eKOTUbQOBhk5kWEHNFcVpG+sqM5JlMshgZ33qcbA/U3e10bs8313vu/zYwADghCfZhIVinPOEyrEfzsfA1BcUlMLPvtaotVroNf9oAm9wpz7Un9/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215694>

From: Michal Nazarewicz <mina86@mina86.com>

File handle goes as the first argument when calling print on it.

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
1.8.1.2.549.g1d13f9f
