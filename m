Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D50FA20248
	for <e@80x24.org>; Sat,  9 Mar 2019 16:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfCIQKG (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Mar 2019 11:10:06 -0500
Received: from mout.web.de ([212.227.15.4]:57089 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbfCIQKG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Mar 2019 11:10:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1552147804;
        bh=Qro7aQtMs0q8NKdlPBiSr2a9IGDdiZzXXzlA4P9Ablg=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=hwdhspLlpjz1tPaTM9b4d3AQVRhebl2jWClqmmGxf7bwUnpJE4LTeh/MAhWQb/Z6b
         hMr8Wf3a0LcZqpwpD/2WvtSJjdkghYZ6NsKUMq4en7o3cPJyv2L945JvBHPp63Bwuu
         T/A5TFH5Ajnj6SZggeNudlNu5Qz5N/2htqSCkn90=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M5Omd-1grkGJ0c5H-00zUCL; Sat, 09
 Mar 2019 17:10:04 +0100
Date:   Sat, 9 Mar 2019 16:10:03 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: t0028-working-tree-encoding.sh test #3 data
Message-ID: <20190309161003.55t4irdwd76asnuf@tb-raspi4>
References: <CAH8yC8kSakS807d4jc_BtcUJOrcVT4No37AXSz=jePxhw-o9Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH8yC8kSakS807d4jc_BtcUJOrcVT4No37AXSz=jePxhw-o9Dg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:POFFEPOSK40tHzAnO/YLxaeTWMUHTiN8Y1EWnKWHrrJFFsAXDDR
 j3Vai3UFz46G/h8v9oBdTm69KzxmmHdEhpKb1HjObSRD9oPU6UycyFi2Xt8lG3JsGTj9j9/
 7wbPKT3U7PxNmOLejOOQOd1ztyOVe/YkHSLqO+icnqSMpus2wMrDSCZte5wgcQJRGK0N8kQ
 iavUUgKej6JIqDQ379Zlw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ae5yG4PMx+w=:1n8AqyqtaZi46bMwdAxS5z
 dUw+h+HRjfDQDdQojW6fPtQ0VICq+0TAU3Wz2w18PDkAB+dxfbK07zRw/AH10Pgx9ZFdz4Vde
 rCtjXx+rhfWfMLvjHhoLGdDEHHdGTNxlm5nBHC/YeWC/po6AIWvQMqWh352pa+DLhMJbMQg/d
 i8q0o9IOwKkwEmfM1CoYo7qOxatAW1tVAWzMxyMT41I97mGGrNIoViQEjU9SRjHFZE47jYUFE
 N787Eu6X+7Yg7r8+lFJc14VPGxF5LChI6xrXeW2eLs8/sfY/qcDNK+WEc/VpBDBPPC9k/7CUi
 Qh2WUtbI72fM7z1u76gHsnUb+jyLboSt4QkO2x07E8+qMbjFtqWFOP8J4t0HJDUqc2PjCZRSl
 Vf3jO2o2T0WJDeh3wk5Fso8jhA4ChETZ85PtJMZCYe30PB4y2PBOxKKBOhm/Ysiv90YqBW1GJ
 eOfW0oAoNpwlFeNdQrPse5hCAOUM2JRiLWMhXFQvWUOECXs4dgEHrbeJFFWNXGHZ3ayhfdsO3
 auhY7O7OAh340cnrIMxitnbFV+iSr4LVE7cuB4akN9wBE81FBirIkYS628VBdYfEJmJV5VLFm
 7ak+F4vky9o0LUhGH4XLbH8yrH2dryHWz36JiIDLG6/tLLm5HIPLceMqkClb6URwZ7mpl8ACS
 P3p3Yv0NGkpcEaMMlkiJ3fOxQqKrSPASMdzF6A7qbId/1vrMYPHeE57kLu+LYFIj+n/O+kk10
 p6sOsJ5z+G8A6RoTHZIi9JX69wB9tlg74CTJ6+xTHLwJYuGsc60L0JVzivomn05vDE/5nffuj
 tvcPBbzlX175nC5ygG3m8I8h+cVSopcEPD7up9kEX7Ngy1AQmViRE0i2CVyKk9GCog6OVc5bb
 2yhV41ZFyl9OCpuBauoh2PPvnZS3zdQTPJQoLINqq4TfjNHvNP/llsGdJ0mJ8d
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 09, 2019 at 09:36:34AM -0500, Jeffrey Walton wrote:
> Hi Everyone,
>
> I'm experiencing a failure in t0028-working-tree-encoding.sh. The
> first failure is test #3. The source states "source (test.utf16lebom,
> considered UTF-16LE-BOM)" but it looks like a UTF16-LE BOM followed by
> a UTF32-LE stream.
>
> Am I misunderstanding the data presentation?

Thanks for the report.

I think you understand it right.

May be you can help us: Which OS are you using ?

And what does
echo "hallo" | iconv -f UTF-8 -t UTF-16 | xxd
give ?

We may need some more debugging, may be you can send the whole log file ?
Even if there is are a lot of ESC-sequences...



>
> $ ./t0028-working-tree-encoding.sh -v -i
> ...
> ok 2 - ensure UTF-8 is stored in Git
>
> expecting success:
>         test_when_finished "rm -f test.utf16.raw" &&
>
>         rm test.utf16 &&
>         git checkout test.utf16 &&
>         test_cmp_bin test.utf16.raw test.utf16
>
> Updated 1 path from the index
> source (test.utf16lebom, considered UTF-16LE-BOM):
> |  0: ff   |  1: fe   |  2: 68 h |  3:  0   |  4:  0   |  5:  0   |
> 6: 61 a |  7:  0
> |  8:  0   |  9:  0   | 10: 6c l | 11:  0   | 12:  0   | 13:  0   |
> 14: 6c l | 15:  0
> | 16:  0   | 17:  0   | 18: 6f o | 19:  0   | 20:  0   | 21:  0   |
> 22: 20   | 23:  0
> | 24:  0   | 25:  0   | 26: 74 t | 27:  0   | 28:  0   | 29:  0   |
> 30: 68 h | 31:  0
> | 32:  0   | 33:  0   | 34: 65 e | 35:  0   | 36:  0   | 37:  0   |
> 38: 72 r | 39:  0
> | 40:  0   | 41:  0   | 42: 65 e | 43:  0   | 44:  0   | 45:  0   |
> 46: 21 ! | 47:  0
> | 48:  0   | 49:  0   | 50:  a   | 51:  0   | 52:  0   | 53:  0   |
> 54: 63 c | 55:  0
> | 56:  0   | 57:  0   | 58: 61 a | 59:  0   | 60:  0   | 61:  0   |
> 62: 6e n | 63:  0
> | 64:  0   | 65:  0   | 66: 20   | 67:  0   | 68:  0   | 69:  0   |
> 70: 79 y | 71:  0
> | 72:  0   | 73:  0   | 74: 6f o | 75:  0   | 76:  0   | 77:  0   |
> 78: 75 u | 79:  0
> | 80:  0   | 81:  0   | 82: 20   | 83:  0   | 84:  0   | 85:  0   |
> 86: 72 r | 87:  0
> | 88:  0   | 89:  0   | 90: 65 e | 91:  0   | 92:  0   | 93:  0   |
> 94: 61 a | 95:  0
> | 96:  0   | 97:  0   | 98: 64 d | 99:  0   | 100:  0   | 101:  0   |
> 102: 20   | 103:  0
> | 104:  0   | 105:  0   | 106: 6d m | 107:  0   | 108:  0   | 109:  0
>  | 110: 65 e | 111:  0
> | 112:  0   | 113:  0   | 114: 3f ? | 115:  0   | 116:  0   | 117:  0
>
> destination (test.utf16lebom, considered UTF-8):
> |  0: 68 h |  1:  0   |  2: 61 a |  3:  0   |  4: 6c l |  5:  0   |
> 6: 6c l |  7:  0
> |  8: 6f o |  9:  0   | 10: 20   | 11:  0   | 12: 74 t | 13:  0   |
> 14: 68 h | 15:  0
> | 16: 65 e | 17:  0   | 18: 72 r | 19:  0   | 20: 65 e | 21:  0   |
> 22: 21 ! | 23:  0
> | 24:  a   | 25:  0   | 26: 63 c | 27:  0   | 28: 61 a | 29:  0   |
> 30: 6e n | 31:  0
> | 32: 20   | 33:  0   | 34: 79 y | 35:  0   | 36: 6f o | 37:  0   |
> 38: 75 u | 39:  0
> | 40: 20   | 41:  0   | 42: 72 r | 43:  0   | 44: 65 e | 45:  0   |
> 46: 61 a | 47:  0
> | 48: 64 d | 49:  0   | 50: 20   | 51:  0   | 52: 6d m | 53:  0   |
> 54: 65 e | 55:  0
> | 56: 3f ? | 57:  0
>
> test.utf16.raw test.utf16 differ: char 1, line 1
> not ok 3 - re-encode to UTF-16 on checkout
> #
> #               test_when_finished "rm -f test.utf16.raw" &&
> #
> #               rm test.utf16 &&
> #               git checkout test.utf16 &&
> #               test_cmp_bin test.utf16.raw test.utf16
> #
