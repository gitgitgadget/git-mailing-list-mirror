Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 782E71F516
	for <e@80x24.org>; Tue, 26 Jun 2018 12:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965234AbeFZM54 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 08:57:56 -0400
Received: from mout.gmx.net ([212.227.17.20]:58549 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965117AbeFZM5n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 08:57:43 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MQRZw-1fjvY60nVc-00Thff; Tue, 26
 Jun 2018 14:57:38 +0200
Date:   Tue, 26 Jun 2018 14:57:37 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH 1/1] sequencer: print an error message if
 append_todo_help() fails
In-Reply-To: <20180626100429.10169-2-alban.gruin@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1806261455510.21419@tvgsbejvaqbjf.bet>
References: <20180626100429.10169-1-alban.gruin@gmail.com> <20180626100429.10169-2-alban.gruin@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:l1EL86HRKNKFZX7ZFxgqiaWh500pXyKtGFuXAE3JZoUkSugug40
 9OfGfFSBN4H5upUm+kyuRwt8F9PJOjqHlZDT49F9VXA+dcahqL0sM46Rq65L1ia11udjI97
 gKrYMKFloJWQL+BcVrTgmVdzcxPemcYooVGQpSU0gQBDAj4KQzRa3hFVuhi2/4j+HQyYeb+
 sxf/xm0FIr8DuFiF0NdSw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zUiE9/10dmg=:LyXHl4t+hEwm4uHErgvlLt
 /DvWrJKTDjfEKrqK9GeXsjHmQHj+Ibbc50e4TLV30HMu1JIFNNn+mWgDkH418nLjcMv1/n4ZA
 xoqgrqn6azaVJLnqfyJnA2UuA14GAcJB7y2tMv7MKgxDc4QL/F66/d1vWEWGl8zpYLu0+g/Cz
 eQUrw5BjmINp+kRc1RbuDhji+RD4z7W/eh0Q/03TDAAiYGsLcbxcoqKRxkH1fCJ7o0pWcZpny
 sUqt/dlaKI2OssEEzxgbBDXcGyXB+TBnWvHCuIN4FSy1YoPBERd5otrmcijvN5yC4p1i9Lkwz
 oolHU5k7JqKZ6s2RPvRirjMG36Df8lGGzwBEImvcWn7ESTCRfeP/EKy+VQTEQyaNEMuMnhJaf
 fn9gkMayqfcOPswvcgsiUbLpeNS1s2WBh6wOj/o/Bdw9dxlGEmDCUGKTiytV4kS7UwtWdOCyj
 KVtDpvyUxscMwcb02cceqH9sx8mTeaiQwz9TAQs9uLIeo3olplurN4gNDYzb3UZkmaLh2r8YA
 9mCBVJUYX6ax5yZmyCYLyKvyHvvPT4bfJWVR4FnrwBE5UcPxij2iiW+II0HOZv94IVWKHqXbB
 t4kU+Fuk6TEt18mTbj6F9u5rqQYdniWvl1he5aCAfYeuRzKgQ5L4M1NscCyU7xEFewq2zS5kV
 PDq9hcGzriTLLEDSJsyZT43nWLGlUSECedEeao7hPQ0q2te5hAcUbKvXxXdZRYE6Bsy2gzwRQ
 aM/g4Vs8KRBQY1IRr669VH5ou5GpKmfEg0oK8nMa42/dvJWht+DYUeglLL17x/WhNZ3OlW8qp
 f4eS3+b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban,

On Tue, 26 Jun 2018, Alban Gruin wrote:

> This adds an error when append_todo_help() fails to write its message to
> the todo file.
> 
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>

ACK.

We *may* want to fold that into the commit that adds `append_todo_help()`.
And, as I mentioned previously, I would love for that function to be used
as an excuse to introduce the long-overdue `interactive-rebase.c`
(`sequencer.c` is supposed to be the backend for cherry-pick and revert
and interactive rebase, but not a catch-all for *all* of those things, it
is already way too long to be readable, and I take blame for a large part
of that.)

Ciao,
Dscho
