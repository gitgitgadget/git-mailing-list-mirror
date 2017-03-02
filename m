Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86DDF20133
	for <e@80x24.org>; Thu,  2 Mar 2017 11:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750986AbdCBLGT convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 2 Mar 2017 06:06:19 -0500
Received: from mailout4.w1.samsung.com ([210.118.77.14]:35523 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750867AbdCBLGS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 06:06:18 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OM60093KP00SP00@mailout4.w1.samsung.com> for
 git@vger.kernel.org; Thu, 02 Mar 2017 10:55:12 +0000 (GMT)
Received: from eusmges5.samsung.com (unknown [203.254.199.245])
 by     eucas1p2.samsung.com (KnoxPortal)
 with ESMTP id  20170302105511eucas1p2362a875492b7f0d4f7a19967b98d314c~oC09IjFLt0586005860eucas1p2_
        for <git@vger.kernel.org>; Thu,  2 Mar 2017 10:55:11 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207])
 by     eusmges5.samsung.com (EUCPMTA) with SMTP id 7E.5F.17477.F0AF7B85; Thu,
 2      Mar 2017 10:55:11 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179])
 by     eucas1p2.samsung.com (KnoxPortal)
 with ESMTP id  20170302105511eucas1p2c40bbbb719c8fb15cc7a6cb9424a92e4~oC08f_6s30937909379eucas1p2j
        for <git@vger.kernel.org>; Thu,  2 Mar 2017 10:55:11 +0000 (GMT)
X-AuditID: cbfec7f5-f79d06d000004445-ba-58b7fa0facaf
Received: from eusync1.samsung.com ( [203.254.199.211])
 by     eusmgms1.samsung.com (EUCPMTA) with SMTP id 95.6F.06687.B6AF7B85; Thu,
 2      Mar 2017 10:56:43 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local ([106.1.227.71])
 by     eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit  (built May  5 2014))
 with ESMTPA id <0OM600J2WOZZQIA0@eusync1.samsung.com>  for git@vger.kernel.org;
 Thu, 02 Mar 2017 10:55:11 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
 by     CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
 with Microsoft SMTP    Server (TLS) id 15.0.1130.7; Thu, 2 Mar 2017 10:55:10 +0000
Received: from CAMSVWEXC02.scsc.local ([fe80::3c08:6c51:fa0a:6384])
 by     CAMSVWEXC02.scsc.local ([fe80::3c08:6c51:fa0a:6384%14])
 with mapi id   15.00.1130.005; Thu, 2 Mar 2017 10:55:09 +0000
From:   Mark Phillips <mark.phil@samsung.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: BUG Report: v12.0.0 "git difftool -d" fails with
 "fatal: cannot create directory at '': No such file or directory"
Thread-topic: BUG Report: v12.0.0 "git difftool -d" fails with
 "fatal: cannot create directory at '': No such file or directory"
Thread-index: AdKTQ09lfB6GHbT3TlSbuBQTDXvGdw==
Date:   Thu, 02 Mar 2017 10:55:09 +0000
Message-id: <f2a8495f22854a749e615fb642d5655d@CAMSVWEXC02.scsc.local>
Accept-Language: en-GB, en-US
Content-language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
X-Originating-IP: [106.1.223.195]
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 8BIT
MIME-version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsWy7djP87r8v7ZHGPzarWvRdaWbyYHR4/Mm
        uQDGKC6blNSczLLUIn27BK6MRc82sxUc4ajYtXYnawPjA7YuRk4OCQETiXtvzjJC2GISF+6t
        B4pzcQgJLGWUmHnxHFiRkEAvk0TzI02Yhq0f9jFDFC1jlHi1AsQBKZrGJLHslj5E4jSjxLyH
        L1kgnH2MEjufzQNyODjYBLQl3jYZgJgiAvoSfRdEQXqFBWolWn6+YgUpFxFoYpS4vWgCO0hC
        REBPYlVHJxOIzSKgKnG18TPYqbwCrhKtT06AxRkFZCW+NK4GO4JZQFyiufUmC8SlghKLZu9h
        hnnt366HUC8bSGxdug+qRlHic8tdNoheHYmzx9YxQtjaEk/eXWCF2CUo8WPyPbBfJAQWsUts
        e3uGEeQBCaDFmw5AzXeRWHj+I9R8YYlXx7ewQ9gyEp0dB5kgeqczSux92MsK4axnlPjxvptp
        AqPaLCSHz0JyyCwkh8xCcsgCRpZVjCKppcW56anFpnrFibnFpXnpesn5uZsYgenh9L/jX3cw
        Lj1mdYhRgINRiYf3ANP2CCHWxLLiytxDjBIczEoivAafgUK8KYmVValF+fFFpTmpxYcYpTlY
        lMR59yy4Ei4kkJ5YkpqdmlqQWgSTZeLglGpglNnSXzDzDP92S21PcSH/9T0tU0oKI1SSg/dl
        PD5b4JbNqzpfMvT4m7DMi3/eLL8j0Hsr4/nGX1wpJ2y02P7+i3lVXsfc9rbzpHJl8mYhy2UH
        /2Xr+DC/d0g6N3XGxgKBvyeX32Zd93z++5+6l18J9zpv2tHSeNTvxHeDZxbVl4u2yZ7cZ7mc
        U4mlOCPRUIu5qDgRABCOi2cLAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xy7rZv7ZHGHQdY7HoutLN5MDo8XmT
        XABjlJtNRmpiSmqRQmpecn5KZl66rVJoiJuuhZJCXmJuqq1ShK5vSJCSQlliTimQZ2SABhyc
        A9yDlfTtEtwyFj3bzFZwhKNi19qdrA2MD9i6GDk5JARMJLZ+2McMYYtJXLi3HijOxSEksIRR
        YldjPxOEM4NJYumE6awQzmlGid9LbrJDOPsYJdo29gM5HBxsAtoSb5sMQEwRAX2JvguiIFOF
        BWolWn6+AusVEWhilJhwdRsTSEJEQE9iVUcnmM0ioCpxtfEzI4jNK+Aq0frkBFicUUBW4kvj
        arDzmAXEJZpbb7JAnCogsWTPeaizRSVePv7HCmEbSGxdug+qRlHic8tdNoheLYn1O48zQdja
        Ek/eXWCF2CUo8WPyPZYJjGKzkKyYhaRlFpKWWUhaFjCyrGIUSS0tzk3PLTbUK07MLS7NS9dL
        zs/dxAiM0W3Hfm7ewXhpY/AhRgEORiUe3gNM2yOEWBPLiitzDzFKcDArifAafAYK8aYkVlal
        FuXHF5XmpBYfYjQFBsZEZinR5Hxg+sgriTc0MTS3NDQytrAwNzJSEuct+XAlXEggPbEkNTs1
        tSC1CKaPiYNTqoHRLHeq7jaW6DwlgWNqMoIrhHf5pRu0zZintr2rZfW3YxEJtyMqjmjdmHRr
        ht4SbaOmU0pepkrdPy/zXONffJ6jMTJk6v5uW/503k08pQZs/X1B0p+qDuX3zf7Eb8h0KEfk
        5VKHue/WJtYcOF/4g//wB7d4l3mrqpSD4hdOPWC82Ey8Tt/S6ZMSS3FGoqEWc1FxIgAoxBCF
        5wIAAA==
X-MTR:  20000000000000000@CPGS
X-CMS-MailID: 20170302105511eucas1p2c40bbbb719c8fb15cc7a6cb9424a92e4
X-Msg-Generator: CA
X-Sender-IP: 182.198.249.179
X-Local-Sender: =?UTF-8?B?TWFyayBQaGlsbGlwcxtTQ1NDLVJhZGlvIEZpcm13YXJlGw==?=
        =?UTF-8?B?7IK87ISx7KCE7J6QG1NlbmlvciBTdGFmZiBFbmdpbmVlciwgU29mdHdhcmU=?=
X-Global-Sender: =?UTF-8?B?TWFyayBQaGlsbGlwcxtTQ1NDLVJhZGlvIEZpcm13YXJlG1Nh?=
        =?UTF-8?B?bXN1bmcgRWxlY3Ryb25pY3MbU2VuaW9yIFN0YWZmIEVuZ2luZWVyLCBTb2Z0?=
        =?UTF-8?B?d2FyZQ==?=
X-Sender-Code: =?UTF-8?B?QzEwG0VIURtDMTBDRDA1Q0QwNTAwNTA=?=
CMS-TYPE: 201P
X-HopCount: 7
X-CMS-RootMailID: 20170302105511eucas1p2c40bbbb719c8fb15cc7a6cb9424a92e4
X-RootMTR: 20170302105511eucas1p2c40bbbb719c8fb15cc7a6cb9424a92e4
References: <CGME20170302105511eucas1p2c40bbbb719c8fb15cc7a6cb9424a92e4@eucas1p2.samsung.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am building git from source using gcc 4.8.5 on 64 bit linux.

I am sorry the log info is not very helpful, please tell me how to get more information about what is going wrong and I will collect the info for you!


V2.12.0 Broken log
==============

Export GIT_TRACE=1
git difftool -d HEAD~ 
09:11:27.797674 git.c:371               trace: built-in: git 'difftool' '-d' 'HEAD~'
09:11:27.798255 run-command.c:369       trace: run_command: 'diff' '--raw' '--no-abbrev' '-z' 'HEAD~'
09:11:27.798484 exec_cmd.c:118          trace: exec: 'git' 'diff' '--raw' '--no-abbrev' '-z' 'HEAD~'
09:11:27.800156 git.c:371               trace: built-in: git 'diff' '--raw' '--no-abbrev' '-z' 'HEAD~'
fatal: cannot create directory at '': No such file or directory
	

Running make check gives
fixed   0
success 14475
failed  0
broken  184
total   14804


Also broken in v2.12.0-rc0, v2.12.0-rc1 and v2.12.0-rc2
-----------------------------------------------------------------

V 2.11.1 works
===========

