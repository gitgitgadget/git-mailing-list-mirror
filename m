Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AC911F859
	for <e@80x24.org>; Mon, 15 Aug 2016 14:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030AbcHON72 (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 09:59:28 -0400
Received: from mout.web.de ([212.227.17.12]:58986 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752635AbcHON7R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 09:59:17 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MgwZQ-1bmRag0Gno-00M7Pk; Mon, 15 Aug 2016 15:59:10
 +0200
Subject: Re: [ANNOUNCE] Git v2.10.0-rc0
To:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqfuq7j7cw.fsf@gitster.mtv.corp.google.com>
Cc:	Linux Kernel <linux-kernel@vger.kernel.org>
From:	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <bb0e4f6b-a85a-550e-a971-2a9fabb2f87f@web.de>
Date:	Mon, 15 Aug 2016 15:59:03 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqfuq7j7cw.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:9NTSdw42/zB2Ioz7DhiLp+0IB/tRtlsHDZckeMtGGmQvYX0BzvK
 LZM13QC5gc4zmy6zWv5oiBEJD7TqxtEZd8L2zpkbrrw5Ma6dIT5KyPpCfkaxveSzB7J9ooc
 W1tOtiKrEvD0x6s6/rLp99z3PB2YugEREsVjxwxDIm5stMB9F3pqkovBe7R1zGXJzF08ZlI
 Nv0z8AXYcrzAZ5aHAHqlA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:lYfGurkmyLI=:f4ZmH1cZBzescxqs9e3cI5
 8+b4/nZuauawrb9T+9kNQFK1/yTz5PbPt3yohkmLmhLl3GgFzHVZXjOfcNSRmp5bJAtwSDwvn
 Ru2t3u3l87+V6xMo4Goc8p0gYjly669dUkVcCAArKDuLGBnMH5XEG2vmDEqUDBXI13HwkbBZM
 RFZVZ+fQwnSfb0iCDpdFlyzAw04swGdZ9h60LmvYLkHy3eLP8uNj/iYotJFlZdCHwxnPx1SMz
 /dekcsfWDjdVPxfGDJKY37P/JprjJ/wtef9Mkod1P2KKLmiJdUUMwtnz18Vtp1YarY2SbYipQ
 mHC6VByCg6MdWHkly2JYl+aI1mPzq+3z2Fx6uKD/PHXGiqaWKtx8mfk5Llx/T89lIrqSYED+S
 Q5O2JnG3iCKJC5afbWvCPcyi0oeZjiBQyx+XGPA3TsxrjOcXiFcQSVOKj7RCeMSS4ikiu7xbw
 x3PFtKSFL/V/zthb2FfYCVY/+Pfwm2GaQKGyuYzWun+Wq5XxVV+NaiPO4UEPYxAKpuS/Tkap0
 3kdaprzvr12P85uzfreHTuJbkS7paTswt9VHvSo6O+hWaq1NycLm49pqPN0TXqd1623t0bVK+
 fHnC1CH9FQTk3eCFGCU5qpngxi/jZvM1paiROWrKV7/kred3uIjRrnsABqVIV/8hJi/z2qP1c
 OtoXBB7NB7Nd3jUDBDNnKuBy6ExaKsCIpimUM6GzHrViZfGgAeHuoVhnARjnbHCBsJUBeIp0A
 vMCMfoDFgSpl4iw4KBIL4ovsU4M1h8pKBPeIDOmHU+BtF4ZihpX7K84sLLJURq9v5D35tJq/5
 T2Lou2T
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 15.08.16 00:47, Junio C Hamano wrote:
> Torsten Bögershausen (1):
>       convert: unify the "auto" handling of CRLF

Should we mention this change in the release notes?

The handling of "*.text = auto" was changed, and now

    $ echo "* text=auto eol=crlf" >.gitattributes
    has the same effect as
    $ git config core.autocrlf true


