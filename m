Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D49A1F404
	for <e@80x24.org>; Thu,  5 Apr 2018 16:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751332AbeDEQmS (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 12:42:18 -0400
Received: from mout.web.de ([212.227.17.12]:56541 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751251AbeDEQmR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 12:42:17 -0400
Received: from [192.168.209.21] ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LfAoO-1ekUWw1ByC-00ooIQ; Thu, 05
 Apr 2018 18:42:02 +0200
Subject: Re: [PATCH v11 06/10] convert: add 'working-tree-encoding' attribute
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org,
        gitster@pobox.com, j6t@kdbg.org, sunshine@sunshineco.com,
        peff@peff.net, ramsay@ramsayjones.plus.com,
        Johannes.Schindelin@gmx.de, pclouds@gmail.com
References: <20180309173536.62012-1-lars.schneider@autodesk.com>
 <20180309173536.62012-7-lars.schneider@autodesk.com>
 <20180318072435.GA24190@tor.lan>
 <0FEBEFB2-46D6-4688-AF07-654B56FFF9D8@gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <583f9ec3-3aef-d823-9fd6-3cc126ac47f6@web.de>
Date:   Thu, 5 Apr 2018 18:41:55 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <0FEBEFB2-46D6-4688-AF07-654B56FFF9D8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:RdDmC5nH8W9BxNd3qklUiby65ZwycZyPf9LJg3QHjpUOWxuVhij
 fp10gyRNKxe24OtBKgz3cogNdQoR/riRvG5SBARISpNetuk2Chzz2tcQ2eBk/6P/ocmJpdq
 tMCyeN3FRiRWMM07HOZiBV3BqvhxR/MuBj0ok2Io+/dr/KxX5z3ofzRqUgdU4YgLpA8UnQq
 JaLW1BMhe9QydIjIBiVsw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mlN4DlbkeTU=:UYnaSJz7zJXnCu+g8248mc
 aofgBXEPEZUlBAv3/JYkYiQsqCaX3UIR6ehtqGcf7imdOzsyCk9yUqVoBFbXL1EUirCUqkOdJ
 tFVSBDOxN+WdFkBLvy5+IVFtPZKZLg3MfqVpZLLtmTNMzCzKdXgq35JLUwQiittZuL4oJAffb
 D+9n01KH36j2hGOr3y18zvkc/0QWA9gPKaHJFvFQS+aUlfWxg1AtOiydDzasS2Le032xZC0fs
 GNB6oaMd2b9hO60BueCuhrMyiWSeSTGOLE9xBkU/cW/anBwoUhOk5GRTk7UfiivKAn8TawAdT
 dn6W8Np/9cxV+LS0/fwhVQrWkUcWOBGPdTD1z7s3i3RhZcMBVSlGllcnmGAO68i7IiHbK382+
 hIdurXTRtUzXnom/YSCnTr6TywGECB/tacXZTr1YoxCyWTyTNUsM6/kdHpjgMHxOj80DL3LiQ
 ImBnnsTKn8sWzv09HLOtTTn+h0bzJRz6sMVv2AFWNkxCzM1ZWn1moTLrgKTWkGrUGQL0ijXRq
 Buk187zgAT1PsLqSu+N+Ba+dOobIVyYWTE2PZflgvwZnBsj0s7r2Bu3z9dhHJ2tA4mvI8cxvX
 ue+s+aTwchAfTxRVUqy8+Dncb6jYHoc7vR4qmfhOHFFsqnq+rq/NIOhV172W8cqfMie5snf+P
 d45CL/kJaZuZ7WuAg0c33xzkpLv5Y360K/fkEbsIbc5v2+B00aNSgPU+Yz8W0fw1roIUI8N87
 ER/IC/ACYvK+llPTGpAL/kRBnqMW30d5uM2P4SuI41/LhPgGgy/iNiFsz1jTBihOBjd2Jsr9w
 0YiWO2CJT61vuAA4GRfnXrhbuLrK4VRSIB6c2taByUC7fTP7qI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01.04.18 15:24, Lars Schneider wrote:
>> TRUE or false are values, but just wrong ones.
>> If this test is removed, the user will see "failed to encode "TRUE" to "UTF-8",
>> which should give enough information to fix it.
> 
> I see your point. However, I would like to stop the processing right
> there for these invalid values. How about 
> 
>   error(_("true/false are no valid working-tree-encodings"));
> 
> I think that is the most straight forward/helpful error message
> for the enduser (I consider the term "boolean" but dismissed it
> as potentially confusing to folks not familiar with the term).
> 
> OK with you?

Yes.

Another thing that came up recently, independent of your series:

What should happen if a user specifies "UTF-8" and the file
has an UTF-8 encoded BOM ?
I ask because I stumbled over such a file coming from a Windows
which the java compiler under Linux didn't accept.

And because some tools love to put an UTF-8 encoded BOM
into text files.

The clearest thing would be to extend the BOM check in 5/9
to cover UTF-32, UTF-16 and UTF-8.

Are there any plans to do so?

And thanks for the work.
