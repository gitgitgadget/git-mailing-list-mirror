Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 608A31F406
	for <e@80x24.org>; Mon, 14 May 2018 18:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbeENSNv (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 14:13:51 -0400
Received: from mout.web.de ([212.227.17.11]:34675 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750750AbeENSNu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 14:13:50 -0400
Received: from [192.168.209.20] ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MCqsR-1f9nfb0UJH-009h1T; Mon, 14
 May 2018 20:13:48 +0200
Subject: Re: git diff: meaning of ^M at line ends ?
To:     =?UTF-8?Q?Frank_Sch=c3=a4fer?= <fschaefer.oss@googlemail.com>,
        git@vger.kernel.org
References: <6c23ed9e-4a14-12e4-20ca-3ac6f80cf9ec@googlemail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <8d7e4807-9a79-e357-8265-95f22ab716e0@web.de>
Date:   Mon, 14 May 2018 20:13:43 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <6c23ed9e-4a14-12e4-20ca-3ac6f80cf9ec@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6yN92ObvPkwl53ot2dSgogtHlXOowLkfcWZo4Ros1hbknMd7swY
 tFw9phQQYTXlSnsKF9ROcmj06ZhHXaNChbubG8g09NkXBf8btoexfY08RYBVVJPTnXB53qR
 aQ63b3TlLf/MGAErMcLb7IE78wHJR/cmXCKdLTUwNI+Hhla3RD8G540uwxyisDRyjlrJ+wN
 pJLHaRWgfkkWwldVovpjg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KXy2artDz9k=:wBiP/oMGt1CgFPvQXmW0Jn
 EwrRHXZef/ZobimBv8XQ3PhqAo0yqxNt9Ta5dmoDGURX7EI6DDL+OeeHJHTdnbaE6BcAJeBQU
 X2s5zVSL7hXjvvex63a9qK70wYXMc4fHxTzXadoepWP2y6XviWHaat5puire6rENUd1oFqAMk
 Fh2bYilMpQE/uk0T9BfiTgrWYLLxA3llSW+R1FZ2IsCg6dWH4XstgNYOmSqmKR+OMcYQbvHTl
 ot0TjgXktXIoPi3VGnEvGssF5rMyhHgr+ABckCRVclSBMcAhA8RYb7Z0W/+4J83IQmP9edk9i
 KasSAUENbpyJsM+iX4Asg/5Boeoztms8fME8iDl3ZuhgVLhHsRnTLPL9qElGuu/BS8ktfwzcP
 nLhYzoKwOtuBgmcWAhO0s0SC3Jty63WXaJ5zHY/gKzQJaloQLNb1tp3sY67jY14k2qQNfN+Pv
 1bGYGii9M5IPnPunIPAeq8Fhc1q1tW9L3MkN8UsOMAn3dIX91ODQk6jBJEkH5xCqOlo75L2iu
 sozKnk4ddqqyu+oehNvzCxAxHy2uWkEYAfmCQsaPXsOLSd14uHEvz6vgyfauko8dh3P8zraGW
 XVDkJ1bSsD/QKDHP/SGzR2dfMXxt5VaCHyQYA0SdOHoxvkyDI/8g/sFzY0ptNKIDpfRcI4D+u
 xkXLwNoCSZoDCkZuz/yhKsGlOKtZeAlvPHfzW/PYhtswJnQyGfPwPU6HTKTH6atZQzjM1dUY0
 9l6BgN1q9n99V4ZgHIKVxS1wveuwXVXEibNTVlgzTp6/xb2y2FWFUgyV6TzSWIQzxJixm937u
 5pezGabngQytinG58wo9sUqMYUX8g1Ox5NHr8bZF+9L0vNsBF+yWlnZ0naL9z1sjXQQyxYq1M
 iCs5bXBLsynW4EVRwmpQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14.05.18 18:08, Frank Schäfer wrote:
> What does ^M at the end of lines in the output of 'git diff' mean ?
> 
> Thanks,
> Frank
> 

^M is the representation of a "Carriage Return" or CR.
Under Linux/Unix/Mac OS X a line is terminated with a single
"line feed", LF.

Windows typically uses CRLF at the end of the line.
"git diff" uses the LF to detect the end of line,
leaving the CR alone.

Nothing to worry about.

If you want, you can commit those files with
CRLF in the working tree, and LF in the repo.

More information may be found here:

https://git-scm.com/docs/gitattributes

(Or ask more questions here, if needed)
