Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3F6D1FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 12:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757390AbeAHMqd (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 07:46:33 -0500
Received: from mout.gmx.net ([212.227.17.21]:50116 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756378AbeAHMqc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 07:46:32 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MIhDo-1eaigD2kp6-002Gr9; Mon, 08
 Jan 2018 13:46:25 +0100
Date:   Mon, 8 Jan 2018 13:46:24 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Anthony Ramine <n.oxyde@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH v4 8/7] wildmatch test: skip file creation tests on
 Windows proper
In-Reply-To: <87mv1raz9p.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1801081331540.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <nycvar.QRO.7.76.6.1801052133380.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet> <20180105221222.28867-1-avarab@gmail.com> <xmqqzi5raogu.fsf@gitster.mtv.corp.google.com> <nycvar.QRO.7.76.6.1801061337020.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
 <87mv1raz9p.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-483015967-1515415585=:31"
X-Provags-ID: V03:K0:NZWL8KVJj0eWKeZ2xG5M2Hqu3/ZXLD4XIfQSZUhJQJmk9KrKIOY
 Jsx1n5WsUB6GgbeH7tQtb5JiSSFdoZD0DTTjb1qW3gkQ7uI1fuYKna40pCsgCS2FaIziDbS
 JzvBLI1SsacT7Nmk2OGF18KEQkHEx1OBzi+JJe82vkuV3gY6tts+L9XWv8TaEMUd6wAO2MQ
 i4FGJryCUc/11tzNCJqeQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MAJ4lme7mOQ=:HNfNiS6NcwLtGn0I0WZiTq
 jlfisOUxL4kd5neR9NJFdKh4R1O+WYbNJHQkroeU/8YRdTUHWpvn6V456jV+zOaoH8DFxinFA
 j8IdQNGXINTxLSZc/TK7zziTj+8aR90gtFJN+4omtk+mPTQTZvdJFrPMJITydQEYgO/eLBs/o
 5piqMUQ6EII369gqX3B6Geoc+hl/DD8p/VzBS1wnXmAXgDCqJCtUBmjrElaGlNvZvaztxiiuD
 iFWDXgn6K6Odg9dwGQRRMOJYw3sFM7zprijRu1/AhEHAJ/n9/gKU41Yn0vQ6eVY8OazT7FDgA
 tljDH+ZeK1u4yfgUH0t1fdLsPsGPB0GCX6KBmK7mnyKQhc31WyBav/Nsl7difJn/xeC6Ixrfo
 CErSjjmZAtBNgWXoNcV9V12ttDmMbU/acCv5U4Az6SiSG5IFfiO+yYvkfmWkbElj66qegHJgc
 FqO46ZJ2+ZQM/tfcxAeR2s2SKID5ZRtc+1orVZ5QPyOR1bpJIRlrimwN14cLdtsb8Kc4DOWC9
 itWZBnKsB4nWsrntOojDBhMPO7rxz76yw/eKDq761+MqjqOcBg20r1IOjBPTAnRhVs2GqNMF4
 1OhN0+o3LZ8QAlWijoFriB5k0YnaNOf7asqS17EvI5SY4Shg5dM2cBFN0FodviJfbbaFNNFzZ
 5PvT1k4xZJIpha+2/4LBgGu/QS3/YLtts9/GtI4jNePt2QnDLhJoDddlaeqEDKzJrlI+WPnVh
 JHG53RAty4oO8Iw3kPAZB346a1ZZRvJ9SapqnW5jAyrHEvYtxmGiRTWeZE4cfIEPEETUJRurw
 iPzGQ3TKdbqJ8+HPT3wyaVMQ6K2c/dM6GrHGWLPTOk8wkFntIEEMWavdtlHBOuS/N3giBZ+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-483015967-1515415585=:31
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi =C3=86var,

On Sat, 6 Jan 2018, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Can you please provide me with the output of the test under -v -x -d
> from github.com:avar/git.git wildmatch-refactor-8 branch?

With -v -x -i:

-- snip --
[...]
expecting success:
                                printf '%s' '?a?b' >expect &&
                                git --glob-pathspecs ls-files -z -- '\??\?b=
' >actual.raw 2>actual.err &&

        tr -d '\0' <actual.raw >actual &&
        >expect.err &&
        test_cmp expect.err actual.err &&
        test_cmp expect actual

++ printf %s '?a?b'
++ git --glob-pathspecs ls-files -z -- '\??\?b'
+ test_eval_ret_=3D128
+ want_trace
+ test t =3D t
+ test t =3D t
+ set +x
error: last command exited with $?=3D128
not ok 734 - wildmatch(ls): match '\??\?b' '?a?b'
#
#                                       printf '%s' '?a?b' >expect &&
#                                       git --glob-pathspecs ls-files -z
#                                       -- '\??\?b' >actual.raw
#                                       2>actual.err &&
#
#               tr -d '\0' <actual.raw >actual &&
#               >expect.err &&
#               test_cmp expect.err actual.err &&
#               test_cmp expect actual
#

real    2m9.127s
user    0m10.026s
sys     1m0.617s
-- snap --

and

-- snip --
$ cat ./trash\ directory.t3070-wildmatch/actual.err
fatal: Invalid path '/??': No such file or directory
-- snap --

As to the speed:

-- snip --
# still have 144 known breakage(s)
# failed 28 among remaining 1746 test(s)
1..1890

real    5m55.162s
user    0m26.396s
sys     2m34.152s
-- snap --

=2E.. seems to be in the same ballpark. You are just leaning way too heavil=
y
on Unix shell scripting.

FWIW the breakages are:

-- snip --
not ok 734 - wildmatch(ls): match '\??\?b' '?a?b'
#
#                                       printf '%s' '?a?b' >expect &&
#                                       git --glob-pathspecs ls-files -z
#                                       -- '\??\?b' >actual.raw
#                                       2>actual.err &&
#
#               tr -d '\0' <actual.raw >actual &&
#               >expect.err &&
#               test_cmp expect.err actual.err &&
#               test_cmp expect actual
#
ok 735 - iwildmatch: match '?a?b' '\??\?b'
not ok 736 - iwildmatch(ls): match '\??\?b' '?a?b'
#
#                                       printf '%s' '?a?b' >expect &&
#                                       git --glob-pathspecs
#                                       --icase-pathspecs ls-files -z --
#                                       '\??\?b' >actual.raw 2>actual.err
#                                       &&
#
#               tr -d '\0' <actual.raw >actual &&
#               >expect.err &&
#               test_cmp expect.err actual.err &&
#               test_cmp expect actual
#
ok 737 - pathmatch: match '?a?b' '\??\?b'
not ok 738 - pathmatch(ls): match '\??\?b' '?a?b'
#
#                                       printf '%s' '?a?b' >expect &&
#                                       git ls-files -z -- '\??\?b'
#                                       >actual.raw 2>actual.err &&
#
#               tr -d '\0' <actual.raw >actual &&
#               >expect.err &&
#               test_cmp expect.err actual.err &&
#               test_cmp expect actual
#
ok 739 - ipathmatch: match '?a?b' '\??\?b'
not ok 740 - ipathmatch(ls): match '\??\?b' '?a?b'
#
#                                       printf '%s' '?a?b' >expect &&
#                                       git --icase-pathspecs ls-files -z
#                                       -- '\??\?b' >actual.raw
#                                       2>actual.err &&
#
#               tr -d '\0' <actual.raw >actual &&
#               >expect.err &&
#               test_cmp expect.err actual.err &&
#               test_cmp expect actual
#
ok 741 - cleanup after previous file test
ok 742 - setup wildtest file test for abc
ok 743 - wildmatch: match 'abc' '\a\b\c'
not ok 744 - wildmatch(ls): match '\a\b\c' 'abc'
#
#                                       printf '%s' 'abc' >expect &&
#                                       git --glob-pathspecs ls-files -z
#                                       -- '\a\b\c' >actual.raw
#                                       2>actual.err &&
#
#               tr -d '\0' <actual.raw >actual &&
#               >expect.err &&
#               test_cmp expect.err actual.err &&
#               test_cmp expect actual
#
ok 745 - iwildmatch: match 'abc' '\a\b\c'
not ok 746 - iwildmatch(ls): match '\a\b\c' 'abc'
#
#                                       printf '%s' 'abc' >expect &&
#                                       git --glob-pathspecs
#                                       --icase-pathspecs ls-files -z --
#                                       '\a\b\c' >actual.raw 2>actual.err
#                                       &&
#
#               tr -d '\0' <actual.raw >actual &&
#               >expect.err &&
#               test_cmp expect.err actual.err &&
#               test_cmp expect actual
#
ok 747 - pathmatch: match 'abc' '\a\b\c'
not ok 748 - pathmatch(ls): match '\a\b\c' 'abc'
#
#                                       printf '%s' 'abc' >expect &&
#                                       git ls-files -z -- '\a\b\c'
#                                       >actual.raw 2>actual.err &&
#
#               tr -d '\0' <actual.raw >actual &&
#               >expect.err &&
#               test_cmp expect.err actual.err &&
#               test_cmp expect actual
#
ok 749 - ipathmatch: match 'abc' '\a\b\c'
not ok 750 - ipathmatch(ls): match '\a\b\c' 'abc'
#
#                                       printf '%s' 'abc' >expect &&
#                                       git --icase-pathspecs ls-files -z
#                                       -- '\a\b\c' >actual.raw
#                                       2>actual.err &&
#
#               tr -d '\0' <actual.raw >actual &&
#               >expect.err &&
#               test_cmp expect.err actual.err &&
#               test_cmp expect actual
#
[...]
not ok 964 - wildmatch(ls): match '[\-_]' '-'
#
#                                       printf '%s' '-' >expect &&
#                                       git --glob-pathspecs ls-files -z
#                                       -- '[\-_]' >actual.raw
#                                       2>actual.err &&
#
#               tr -d '\0' <actual.raw >actual &&
#               >expect.err &&
#               test_cmp expect.err actual.err &&
#               test_cmp expect actual
#
ok 965 - iwildmatch: match '-' '[\-_]'
not ok 966 - iwildmatch(ls): match '[\-_]' '-'
#
#                                       printf '%s' '-' >expect &&
#                                       git --glob-pathspecs
#                                       --icase-pathspecs ls-files -z --
#                                       '[\-_]' >actual.raw 2>actual.err
#                                       &&
#
#               tr -d '\0' <actual.raw >actual &&
#               >expect.err &&
#               test_cmp expect.err actual.err &&
#               test_cmp expect actual
#
ok 967 - pathmatch: match '-' '[\-_]'
not ok 968 - pathmatch(ls): match '[\-_]' '-'
#
#                                       printf '%s' '-' >expect &&
#                                       git ls-files -z -- '[\-_]'
#                                       >actual.raw 2>actual.err &&
#
#               tr -d '\0' <actual.raw >actual &&
#               >expect.err &&
#               test_cmp expect.err actual.err &&
#               test_cmp expect actual
#
ok 969 - ipathmatch: match '-' '[\-_]'
not ok 970 - ipathmatch(ls): match '[\-_]' '-'
#
#                                       printf '%s' '-' >expect &&
#                                       git --icase-pathspecs ls-files -z
#                                       -- '[\-_]' >actual.raw
#                                       2>actual.err &&
#
#               tr -d '\0' <actual.raw >actual &&
#               >expect.err &&
#               test_cmp expect.err actual.err &&
#               test_cmp expect actual
#
ok 971 - cleanup after previous file test
ok 972 - setup wildtest file test for ]
ok 973 - wildmatch: match ']' '[\]]'
not ok 974 - wildmatch(ls): match '[\]]' ']'
#
#                                       printf '%s' ']' >expect &&
#                                       git --glob-pathspecs ls-files -z
#                                       -- '[\]]' >actual.raw 2>actual.err
#                                       &&
#
#               tr -d '\0' <actual.raw >actual &&
#               >expect.err &&
#               test_cmp expect.err actual.err &&
#               test_cmp expect actual
#
ok 975 - iwildmatch: match ']' '[\]]'
not ok 976 - iwildmatch(ls): match '[\]]' ']'
#
#                                       printf '%s' ']' >expect &&
#                                       git --glob-pathspecs
#                                       --icase-pathspecs ls-files -z --
#                                       '[\]]' >actual.raw 2>actual.err &&
#
#               tr -d '\0' <actual.raw >actual &&
#               >expect.err &&
#               test_cmp expect.err actual.err &&
#               test_cmp expect actual
#
ok 977 - pathmatch: match ']' '[\]]'
not ok 978 - pathmatch(ls): match '[\]]' ']'
#
#                                       printf '%s' ']' >expect &&
#                                       git ls-files -z -- '[\]]'
#                                       >actual.raw 2>actual.err &&
#
#               tr -d '\0' <actual.raw >actual &&
#               >expect.err &&
#               test_cmp expect.err actual.err &&
#               test_cmp expect actual
#
ok 979 - ipathmatch: match ']' '[\]]'
not ok 980 - ipathmatch(ls): match '[\]]' ']'
#
#                                       printf '%s' ']' >expect &&
#                                       git --icase-pathspecs ls-files -z
#                                       -- '[\]]' >actual.raw 2>actual.err
#                                       &&
#
#               tr -d '\0' <actual.raw >actual &&
#               >expect.err &&
#               test_cmp expect.err actual.err &&
#               test_cmp expect actual
#
[...]
not ok 1284 - wildmatch(ls): match '[A-\\]' 'G'
#
#                                       printf '%s' 'G' >expect &&
#                                       git --glob-pathspecs ls-files -z
#                                       -- '[A-\\]' >actual.raw
#                                       2>actual.err &&
#
#               tr -d '\0' <actual.raw >actual &&
#               >expect.err &&
#               test_cmp expect.err actual.err &&
#               test_cmp expect actual
#
ok 1285 - iwildmatch: match 'G' '[A-\\]'
not ok 1286 - iwildmatch(ls): match '[A-\\]' 'G'
#
#                                       printf '%s' 'G' >expect &&
#                                       git --glob-pathspecs
#                                       --icase-pathspecs ls-files -z --
#                                       '[A-\\]' >actual.raw 2>actual.err
#                                       &&
#
#               tr -d '\0' <actual.raw >actual &&
#               >expect.err &&
#               test_cmp expect.err actual.err &&
#               test_cmp expect actual
#
ok 1287 - pathmatch: match 'G' '[A-\\]'
not ok 1288 - pathmatch(ls): match '[A-\\]' 'G'
#
#                                       printf '%s' 'G' >expect &&
#                                       git ls-files -z -- '[A-\\]'
#                                       >actual.raw 2>actual.err &&
#
#               tr -d '\0' <actual.raw >actual &&
#               >expect.err &&
#               test_cmp expect.err actual.err &&
#               test_cmp expect actual
#
ok 1289 - ipathmatch: match 'G' '[A-\\]'
not ok 1290 - ipathmatch(ls): match '[A-\\]' 'G'
#
#                                       printf '%s' 'G' >expect &&
#                                       git --icase-pathspecs ls-files -z
#                                       -- '[A-\\]' >actual.raw
#                                       2>actual.err &&
#
#               tr -d '\0' <actual.raw >actual &&
#               >expect.err &&
#               test_cmp expect.err actual.err &&
#               test_cmp expect actual
#
[...]
not ok 1374 - wildmatch(ls): match '[\1-\3]' '2'
#
#                                       printf '%s' '2' >expect &&
#                                       git --glob-pathspecs ls-files -z
#                                       -- '[\1-\3]' >actual.raw
#                                       2>actual.err &&
#
#               tr -d '\0' <actual.raw >actual &&
#               >expect.err &&
#               test_cmp expect.err actual.err &&
#               test_cmp expect actual
#
ok 1375 - iwildmatch: match '2' '[\1-\3]'
not ok 1376 - iwildmatch(ls): match '[\1-\3]' '2'
#
#                                       printf '%s' '2' >expect &&
#                                       git --glob-pathspecs
#                                       --icase-pathspecs ls-files -z --
#                                       '[\1-\3]' >actual.raw 2>actual.err
#                                       &&
#
#               tr -d '\0' <actual.raw >actual &&
#               >expect.err &&
#               test_cmp expect.err actual.err &&
#               test_cmp expect actual
#
ok 1377 - pathmatch: match '2' '[\1-\3]'
not ok 1378 - pathmatch(ls): match '[\1-\3]' '2'
#
#                                       printf '%s' '2' >expect &&
#                                       git ls-files -z -- '[\1-\3]'
#                                       >actual.raw 2>actual.err &&
#
#               tr -d '\0' <actual.raw >actual &&
#               >expect.err &&
#               test_cmp expect.err actual.err &&
#               test_cmp expect actual
#
ok 1379 - ipathmatch: match '2' '[\1-\3]'
not ok 1380 - ipathmatch(ls): match '[\1-\3]' '2'
#
#                                       printf '%s' '2' >expect &&
#                                       git --icase-pathspecs ls-files -z
#                                       -- '[\1-\3]' >actual.raw
#                                       2>actual.err &&
#
#               tr -d '\0' <actual.raw >actual &&
#               >expect.err &&
#               test_cmp expect.err actual.err &&
#               test_cmp expect actual
#
[...]
not ok 1424 - wildmatch(ls): match '[[-\]]' ']'
#
#                                       printf '%s' ']' >expect &&
#                                       git --glob-pathspecs ls-files -z
#                                       -- '[[-\]]' >actual.raw
#                                       2>actual.err &&
#
#               tr -d '\0' <actual.raw >actual &&
#               >expect.err &&
#               test_cmp expect.err actual.err &&
#               test_cmp expect actual
#
ok 1425 - iwildmatch: match ']' '[[-\]]'
not ok 1426 - iwildmatch(ls): match '[[-\]]' ']'
#
#                                       printf '%s' ']' >expect &&
#                                       git --glob-pathspecs
#                                       --icase-pathspecs ls-files -z --
#                                       '[[-\]]' >actual.raw 2>actual.err
#                                       &&
#
#               tr -d '\0' <actual.raw >actual &&
#               >expect.err &&
#               test_cmp expect.err actual.err &&
#               test_cmp expect actual
#
ok 1427 - pathmatch: match ']' '[[-\]]'
not ok 1428 - pathmatch(ls): match '[[-\]]' ']'
#
#                                       printf '%s' ']' >expect &&
#                                       git ls-files -z -- '[[-\]]'
#                                       >actual.raw 2>actual.err &&
#
#               tr -d '\0' <actual.raw >actual &&
#               >expect.err &&
#               test_cmp expect.err actual.err &&
#               test_cmp expect actual
#
ok 1429 - ipathmatch: match ']' '[[-\]]'
not ok 1430 - ipathmatch(ls): match '[[-\]]' ']'
#
#                                       printf '%s' ']' >expect &&
#                                       git --icase-pathspecs ls-files -z
#                                       -- '[[-\]]' >actual.raw
#                                       2>actual.err &&
#
#               tr -d '\0' <actual.raw >actual &&
#               >expect.err &&
#               test_cmp expect.err actual.err &&
#               test_cmp expect actual
#
-- snap --

Ciao,
Dscho
--8323329-483015967-1515415585=:31--
