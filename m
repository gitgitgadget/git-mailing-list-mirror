From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 3/3] format-patch: migrate to parse-options API
Date: Sun, 17 May 2009 14:30:04 -0700
Message-ID: <4A1081DC.9030403@gmail.com>
References: <1242465886-31769-1-git-send-email-bebarino@gmail.com> <1242465886-31769-2-git-send-email-bebarino@gmail.com> <1242465886-31769-3-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 17 23:30:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5nw4-0006NM-1s
	for gcvg-git-2@gmane.org; Sun, 17 May 2009 23:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134AbZEQVaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2009 17:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754013AbZEQVaI
	(ORCPT <rfc822;git-outgoing>); Sun, 17 May 2009 17:30:08 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:59397 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753735AbZEQVaG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2009 17:30:06 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1724331wfd.4
        for <git@vger.kernel.org>; Sun, 17 May 2009 14:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Nhby/dX1rya/aK0E7Gkyn0ZFHoKNzihvBiGokuJ7p1Q=;
        b=ct0fmsAOqd/MDTSvSpDDdi0LsfPfWGKDn93IXmaefFzCb/LeYltLiupszA/EVxFHWm
         arPp718N0SwqW2k9H6x/r4SGy2Qv7U7fVErCCi+l+QqPWIsOgohbdTlEvqC8880wOmjN
         JvU4wplmoRzSyfkz2bOPXpgFBAA9bCxK//mGE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=TRkT1EfHHxurW2I4+8dDUZ97M1LodtxgHAWXVvkuXb8XM0ODQEuHeYtlTIK76rP+/V
         llLQWSXlIcnWZRWmh+yvH5vC7NRiJAlMT2PFvRXZlZMEj8oLncQ4JUMLNZgsUEbi9Tb1
         bGCD11mJ0gjsX9X0j19OzBi2+jrPOVpR99gcI=
Received: by 10.142.226.7 with SMTP id y7mr326571wfg.174.1242595807987;
        Sun, 17 May 2009 14:30:07 -0700 (PDT)
Received: from ?192.168.1.2? ([76.89.212.195])
        by mx.google.com with ESMTPS id 32sm7147625wfa.13.2009.05.17.14.30.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 May 2009 14:30:07 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090429)
In-Reply-To: <1242465886-31769-3-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119409>

Oops there's a typo. Junio, can you squash this in?

Thanks,
-Stephen

diff --git a/builtin-log.c b/builtin-log.c
index 3a8b9fa..d522b3d 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -868,7 +868,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
                            "use [PATCH n/m] even with a single patch",
                            PARSE_OPT_NOARG, numbered_callback },
                { OPTION_CALLBACK, 'N', "no-numbered", &numbered, NULL,
-                           "use [PATCH] even with a multiple patches",
+                           "use [PATCH] even with multiple patches",
                            PARSE_OPT_NOARG, no_numbered_callback },
                OPT_BOOLEAN('s', "signoff", &do_signoff, "add Signed-off-by:"),
                OPT_BOOLEAN(0, "stdout", &use_stdout,
