Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90E5820989
	for <e@80x24.org>; Tue, 11 Oct 2016 03:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753150AbcJKDlm (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 23:41:42 -0400
Received: from mout.web.de ([212.227.17.11]:51368 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753028AbcJKDll (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 23:41:41 -0400
Received: from [192.168.178.36] ([79.197.211.11]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0LqDUa-1bGKOe2Lsu-00dox8; Tue, 11 Oct 2016 05:41:28
 +0200
Subject: [PATCH v2] pretty: fix document link for color specification
References: <cb81631e-9623-9020-f955-ec215b493a50@hale.ee>
 <f35965e9-2901-b9b5-92e5-9bc7fe673637@web.de>
 <65d8def3-df62-6c45-7d8f-79b6a8769bf5@hale.ee>
 <25c17e16-2456-7da3-ae22-2dc812a3aa0d@web.de>
 <20161009234617.y6xfjyv6xjkf2afi@sigill.intra.peff.net>
 <6689ae49-6095-7bb4-ea06-1aaded174811@web.de>
 <20161010205521.vxpwjrlelig3ilpe@sigill.intra.peff.net>
Cc:     Jeff King <peff@peff.net>, Tom Hale <tom@hale.ee>,
        git <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <e0d64654-1562-2e71-8d42-3fc549a98d12@web.de>
Date:   Tue, 11 Oct 2016 05:41:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161010205521.vxpwjrlelig3ilpe@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:1RnlMEhLWeGpvtoXx3xHQavWyK3dOXBPlzgeTHKoZkpQW+ZTa99
 3GJB+0VzJwJM6JiApidfl/GhSmZeclVcQT4GgNVExziU796+wGOUeCjkWKk0ixzH0fREj2s
 Cileywf6vdO4NzwaNjUEePwDYw4sTfKB2ALqrGdA1aOXLkYJ2JFdtMAvPzrl1jXaI6vaBZS
 mz497eVjpqZIFDHs6OgCg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Chtdpc95GuU=:FUa8nzHJSUutukejc1NxRx
 VsGFpIxR7/K/ciO0bGIvUNlEx4FVQwcdQbnoiPN4iuWN1p1mQo6FU05upJu3ZMsHcHZZzRxvf
 iy7tnLpPe1WJ/ZGNPdrjq7wE6yX3yW6IariJFfz0yiZ2RfPp0wGwkcwtMPdCtdXcjhBKVI8BQ
 RlkO25ihe92OmadrFmGKXdQh9RJv0q4iD/OmFSpOyumWlyhWEHb80BY/OK9upMDEaW3TV3vOc
 JAxv5/8h6Btd6RoDkljq2wpzFH41ND9SI40azfpgK2OtYCAZYYHcFEi8OPoWk00DYs5jGrknO
 sgVQgNiGaOWRMpSgVMWs847XjkAd1lPfkcw0FGitfRsm1aNZGzFTl+IyObE1vdEuxDUgac8Uo
 Bly5uKuTRR2eqiKFhH4SpahiV9OkTtKHee7xxzwA3/xCjJDlO7NGg5mqRh75U9TYy9bHgw9oF
 EvUCjC0dVIzz5OcWjmU02W0qvYFkkLDXd4zPPAJMpR0cYtq8SVmJQiPzSviOkkrcxBCqXhgeP
 Wh1Kq0gws0QOIPDRAfLaSINTyIcuBjKq1y8qw1i5sAQIVGEdmmFcHsZtF7SJuDFJMOwTeV/2R
 BcKIBUBQToFhDURplQXMl+cyYZ2+eNkNx4Gd/YHN+lnF93+89x+xVw55qGfBRUeUo7VnZJZNO
 sM2ZAa84IKOkwwbOGqq2imSdWSviENCAoIXsbD1yBVuctnydvKW1lMriGmqnjw97/dXcYQ0a7
 V2DG49XtrAFIzHwzDovtW0ySpFUxsek71MShp+Cki9cBlPac2alOplVsfn48U00JqEJglAT0X
 OCZU1nJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
Removed confusing and unnecessary reference to the "colors" paragraph.

 Documentation/pretty-formats.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index a942d57..89e3bc6 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -166,7 +166,8 @@ endif::git-rev-list[]
 - '%Cgreen': switch color to green
 - '%Cblue': switch color to blue
 - '%Creset': reset color
-- '%C(...)': color specification, as described in color.branch.* config option;
+- '%C(...)': color specification, as described under Values in the
+  "CONFIGURATION FILE" section of linkgit:git-config[1];
   adding `auto,` at the beginning will emit color only when colors are
   enabled for log output (by `color.diff`, `color.ui`, or `--color`, and
   respecting the `auto` settings of the former if we are going to a
-- 
2.10.1

