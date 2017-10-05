Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB3CF20370
	for <e@80x24.org>; Thu,  5 Oct 2017 19:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbdJETll (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 15:41:41 -0400
Received: from mout.web.de ([217.72.192.78]:56043 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751953AbdJETlk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 15:41:40 -0400
Received: from [192.168.178.36] ([91.20.57.42]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MTh2S-1drUpL3SKm-00QPVc; Thu, 05
 Oct 2017 21:41:35 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: =?UTF-8?Q?[PATCH]_.mailmap:_normalize_name_for_Ren=c3=a9_Scharfe?=
Message-ID: <101cfcb6-3475-f055-24b8-3f7296ad05fc@web.de>
Date:   Thu, 5 Oct 2017 21:41:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:yDvw53JK4ZGtAOqBXeIFechoEvmhqPKFR7CW4CHw7t05n6lWOck
 HDa1kWlgaegtsDEOSEoDHowr82lkEf1VGtpS4DIcKfN/8oDUM0bd4k2cIJ1VRkSoT09IdEb
 REFjgIsmz5bpfbL7LCF6NV3ByMl0o1QHyWe1jfH66VJrLwheCByq8hnQfv6CL1FRtbDjOvb
 rSTQxMuDKIU8T5kJVnd3Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xxEowpHSlhE=:alRlmahq2Bzz9RApTB5aP+
 Eb03+O9NVugTn1JrDZfT3yLMZfv8ZXxv+I3VZWk6yKpgXOqV6MSy45I8zyWWUKwnVIBA1otVf
 StrpWtt9Utl04UmkzqC6EOdYHInui0yptYBGAzOs1MnFf0kC3AYeQvbvBzirQSJsl0/2yQ4/2
 H/7XtpTsY15kJU7YpkogdG1rceeTvCS1kOPL8ifP4rSCmzRkH0RDCynnuSobt3uLW8yzjdgKK
 tHH7TWxCdeQ4vjjkah6y/oCZlZyfm5UpAN+nJm21YmYdn450BCVLy8N5SsRmfWftR3sfkUfJy
 IYTacg1ha/U5z3aWJnRHhMYgyWrw2gRXukUzxbRNL40DRVDEC0c1Hhtw+EnBFhg1i1c8Y5zMj
 JJataRJqB3ra/tohNhwy5EHCuaFmCWVY4BVvcnOQ5tl+y51dcDgyTX2WOf8M5AnZaDdoouiWS
 cdz97yz7TsZDrTmn40McNvVYlwwNyb8rysT7CaS6hf9UZccpnDimqrgj7oGXTCQMuc8YlG5zP
 nKy4BjnqfkWfWy8rinHjdwWGQLkJdB6P5m1WFkS8eZ6j2dSqwHS7eYP0STuHNCpWnBApsN0Kr
 YCMu/FQzMJT7J61E3F86MDfboDwShJFcY3/arTpjm7VDZTTqjbe18yi4qHqZRgaLevbImtYpS
 nqgdfRznx80IImQZBInGdu2eG3LK60xyAHdwHOCWvTeCfNNmSHGfl2T7rIPlmrgr9GdHxu8+w
 OIr49dYHA3+mOookAHm7o4U3/zfemUUqDJOOxlgFetqnKmj8KCRugv6TWCIWnwApnXXo94qEl
 +w48ddkzEAjqySUQGDK1FlbBBlpgyE5gwvWx49/8ubdJOpOIH4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reported-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Reported-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index ab85e0d16d..224db83887 100644
--- a/.mailmap
+++ b/.mailmap
@@ -194,6 +194,7 @@ Philippe Bruhat <book@cpan.org>
 Ralf Thielow <ralf.thielow@gmail.com> <ralf.thielow@googlemail.com>
 Ramsay Jones <ramsay@ramsayjones.plus.com> <ramsay@ramsay1.demon.co.uk>
 René Scharfe <l.s.r@web.de> <rene.scharfe@lsrfire.ath.cx>
+René Scharfe <l.s.r@web.de> Rene Scharfe
 Richard Hansen <rhansen@rhansen.org> <hansenr@google.com>
 Richard Hansen <rhansen@rhansen.org> <rhansen@bbn.com>
 Robert Fitzsimons <robfitz@273k.net>
-- 
2.14.2
