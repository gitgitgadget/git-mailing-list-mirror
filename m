From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Try an uppercase version of $prot_proxy env var
Date: Thu, 26 Apr 2012 08:18:58 -0700
Message-ID: <xmqqehraa5ct.fsf@junio.mtv.corp.google.com>
References: <xmqq8vhmhzpk.fsf@junio.mtv.corp.google.com>
	<4F966F0C.6090504@seap.minhap.es>
	<xmqqipgpgdpl.fsf@junio.mtv.corp.google.com>
	<4F994AC3.2070708@seap.minhap.es>
	<20120426130854.GC27785@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 26 17:19:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNQTL-0003Um-7q
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 17:19:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756981Ab2DZPTB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 11:19:01 -0400
Received: from mail-bk0-f74.google.com ([209.85.214.74]:47523 "EHLO
	mail-bk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756261Ab2DZPTA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 11:19:00 -0400
Received: by bkwj5 with SMTP id j5so45681bkw.1
        for <git@vger.kernel.org>; Thu, 26 Apr 2012 08:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=LY5bpOMhVYF9NXBUjjd2OY3lX12BcnAGt8FJVgbv46I=;
        b=aUxQqVffucEq4TnS0++1oIAqQujCf0bV/OdWBQz+1AnO947ZvUKh9FI7CMtxVmHqSl
         LR3RpZL22pcZFIiWP5pEH7PDZkGU3Rz0/tmXz6Y8zFee9At6/xI6IucnjgPW1a8dkExE
         KdPvNC8JOnxWLmesuafFuFHB10KRyO1KEThDwl+YhIZ41xARONeSaEJnZb0qY66HPtzi
         OfDf6j6kSpJy0tzaNZYhA2G+8KCMnAk8IDIMs16xKXgTxV+BrM4rGYfzMnqIs5Bj399I
         u4JYyL/Hld2KtgxQBlvleEUr/MFbo5itYvl+FzF/ZAILr0Msh/+062qDQqgJyymU0yk6
         NqJg==
Received: by 10.14.100.207 with SMTP id z55mr2091444eef.4.1335453539227;
        Thu, 26 Apr 2012 08:18:59 -0700 (PDT)
Received: by 10.14.100.207 with SMTP id z55mr2091429eef.4.1335453539098;
        Thu, 26 Apr 2012 08:18:59 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id s9si3154227eei.3.2012.04.26.08.18.59
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 26 Apr 2012 08:18:59 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id E219A5C0050;
	Thu, 26 Apr 2012 08:18:58 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 3DD96E125C; Thu, 26 Apr 2012 08:18:58 -0700 (PDT)
In-Reply-To: <20120426130854.GC27785@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 26 Apr 2012 09:08:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQk9ADGEZFfFIFDG5R8G1U2JTHVmolbLF/ybJWj0yudmdGrVrxXGKwMtbIpKJcA22YuXSGg1FuldOpWhuiF3MKj5LU8TSrVx/+gfbNyDnQ3AAyFhhlWIhC3xRoIiAkOajclQQ27ZtP8BQRL+m5QZQAtMXaFaSONT3JEl/TJ3FeBuWVE5tuI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196373>

Jeff King <peff@peff.net> writes:

> Don't we explicitly not want to do this when the protocol is http? Curl
> doesn't respect HTTP_PROXY.

Yes.  Here is what I'll queue.

-- >8 --
From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Date: Thu, 26 Apr 2012 15:16:51 +0200
Subject: [PATCH] http: try an uppercase version of $proto_proxy

Fall back to an uppercase version of $prot_proxy environment variable
when the lowercase version is not found (but do not do that for http).

Signed-off-by: Nelson Benitez Leon <nbenitezl@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 http.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/http.c b/http.c
index ad2dc36..262778b 100644
--- a/http.c
+++ b/http.c
@@ -320,6 +320,12 @@ static CURL *get_curl_handle(const char *url)
 		strbuf_addf(&buf, "%s_proxy", cre_url.protocol);
 		env_proxy_var = strbuf_detach(&buf, NULL);
 		env_proxy = getenv(env_proxy_var);
+		if (!env_proxy && strcmp("http_proxy", env_proxy_var)) {
+			char *p;
+			for (p = env_proxy_var; *p; p++)
+				*p = toupper(*p);
+			env_proxy = getenv(env_proxy_var);
+		}
 		if (env_proxy) {
 			read_http_proxy = 1;
 			no_proxy = getenv("no_proxy");
-- 
1.7.10.475.g8b959
