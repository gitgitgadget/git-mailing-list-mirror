Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06F4820899
	for <e@80x24.org>; Wed,  2 Aug 2017 15:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbdHBPpH (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 11:45:07 -0400
Received: from mout.web.de ([212.227.17.12]:65061 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751177AbdHBPpG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 11:45:06 -0400
Received: from [192.168.209.18] ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lu52Q-1dVXmX1m4s-011TEQ; Wed, 02
 Aug 2017 17:44:59 +0200
Subject: Re: core.autocrlf=true causes `git apply` to fail on patch generated
 with `git diff-index HEAD --patch`
To:     Anthony Sottile <asottile@umich.edu>
References: <CA+dzEBmsgUjmf5fUmeiwS=Q81OgpL6K5p=8dBuTjuZ4XE1V5SA@mail.gmail.com>
 <287407ac-b0d0-ef24-4950-0982a2db9bed@web.de>
 <CA+dzEB=3OMw_YM4K_a8dyDG_FwGavU382stXrEOkbYoyM4DSZQ@mail.gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <cceaf377-73e0-e733-20ba-c4e547226382@web.de>
Date:   Wed, 2 Aug 2017 17:44:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CA+dzEB=3OMw_YM4K_a8dyDG_FwGavU382stXrEOkbYoyM4DSZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:6ZpstacGJC6p8bt5PpmsD1GejjI6f01jQKbrV2++toKE/umWZTR
 CjBGZLLFM+1/3f5y3O5ZUUi8EcTpp85uZKfIuq3j+iIshEiMAYqff/i/qJm8dhIldsgcMcJ
 l6LovFOgu8fpyhEpVb2Zbi+yMsZYWz+kQ8E+mjHqcraELbzke9Y8y/0YLcwtOnzrVLQqqoV
 mi72GQYZjjbv1FeePWzdQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wqTfMgEQklE=:BwDV5LFKMaaDiQUQgxb8fx
 z6jIz9Jrr4btZ9W1VDgrEMgzfQCUquJScp6C7ITHm4G6Dno6SPF94F5VHSVM09dVxcJHkDkLM
 MqNocFT+y4kizLCaIIzBI/ntnSRodtLbq1sUwj2d9uNExg1Bh2d4oSnPvWes+CaM+l6XeL1Fs
 aL8/5FEOHC8/NEEloGMhOR8ASnMpUdWoxIwMObf5q0q25IO1jK4MFTUIRcOUHzsKRJpq5ZpN/
 IVvl21ZYUiWr0/649v6H7SDlbNlEyYkR5+So2aiUJqdlkwvaYkBhKJdKR4MbDMRJo7ULRVexB
 Ni9HGpKdsQotmA+9mzHWIZGwwUXF6UDTtHaYiIr2LNlngUg1oYCWqKmqRHCXB/UavdGqoudmm
 4gYFXlQ69jA9BWSdoz8x9fTaEyXtueqJelDfaTbqMwA8o8roq+k1AtQpAY4MmJlK5gpRm0YdD
 TN6Q7ZgUTEqK3z4pDa2kKbnZjR11bVbe5V2d+j61DyhLn3KzooeLlx7JqgOi5ift0RWky5iBd
 CyS0vr+KAaRx/NaEMduhro8URha6PjeHKU6qh/xi910m271AA2XwQVfYQ8kTBoQz/0xeqHuTw
 pmsC8zoSugWMTFFM4YHCWr7Nnn3vaTHQcwV3SMq3EUzc+Q6T7Rb/RhxiLXbDZCp/ag+5P5/Yc
 mlfqLMv23VopBUeHKwGOm5sSz6gChDDOojbPmM6AvB9YrysRwXKDXlz+wa2hCwvZo1wyzIZwI
 t7ZI2/inH5VP15YUwOeBvNKpdjUvEYHkwx2pMdwi6CQR+ydVXhboUydDgIgK8qWlKvRbFFJu6
 edjrJVaAqEa8v47XipLnZ6JdsnEVAI8+UVdiV68TA3NoAtsc6A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 08/01/2017 10:58 PM, Anthony Sottile wrote:
> Here's where I'm hitting the problem described:
> https://github.com/pre-commit/pre-commit/issues/570
>
> Note that `git -c core.autocrlf=false` apply patch fixes this
> situation, but breaks others.

[]
I wasn't thinking of that - and thanks for the detailed report.
I seems as there are 3 things to be done:
- Make a workaround in your scripts/tools. It seems as if that is 
already done.
- Fix Git.
   My very first investigation shows that a patch like this could fix 
the problem:

diff --git a/apply.c b/apply.c
index f2d599141d..66b8387360 100644
--- a/apply.c
+++ b/apply.c
@@ -2278,6 +2278,8 @@ static int read_old_data(struct stat *st, const 
char *path, struct strbuf *buf)
         case S_IFREG:
                 if (strbuf_read_file(buf, path, st->st_size) != 
st->st_size)
                         return error(_("unable to open or read %s"), path);
+               if (would_convert_to_git(&the_index, path))
+                       read_cache();
                 convert_to_git(&the_index, path, buf->buf, buf->len, 
buf, 0);
                 return 0;
         default:
----------------
   I will probably do some more investigations if this is the core 
problem, so it will take some days or weeks.

- Convince people to normalize their repos and convert all CRLF in the 
repo into LF.
    This may take even longer.


