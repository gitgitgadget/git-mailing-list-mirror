Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C84B1F463
	for <e@80x24.org>; Tue, 24 Sep 2019 14:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441316AbfIXO0M (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 10:26:12 -0400
Received: from mout.gmx.net ([212.227.17.22]:37863 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727359AbfIXO0M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 10:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569335161;
        bh=1XSLUD91H/NiyNbgVa51DDZG2lgknWyy2rIwf7DmhtQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=diciT1KNmrfxjGBvgG8xuOPWybWNUww8taqg0c/lqRc3uaz4eCRM1wrPkijSqsmPb
         fMklrg77O5lqRY4wuwtvHHmjBWl18ko6drrwqEe9lTlLi6t7D+/cUIX6GXFvKww7yh
         ckbBNBLtqyx6omJbLB8jHJ23UeNDzD24xIWwXKxA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTRQq-1ic6dQ43Ia-00TntQ; Tue, 24
 Sep 2019 16:26:01 +0200
Date:   Tue, 24 Sep 2019 16:25:45 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: Git in Outreachy December 2019?
In-Reply-To: <20190923180751.GA21344@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1909241624300.15067@tvgsbejvaqbjf.bet>
References: <20190827051756.GA12795@sigill.intra.peff.net> <20190913200317.68440-1-jonathantanmy@google.com> <20190913205148.GA8799@sigill.intra.peff.net> <20190916184208.GB17913@google.com> <nycvar.QRO.7.76.6.1909171158090.15067@tvgsbejvaqbjf.bet>
 <20190923180751.GA21344@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cbYN923SSaKSctaydUj77IyM/cNcqiFjKp6RfhsLtU9qPye0Zm7
 SIdOF2tWRiPIbaLzLPH8GMhmDcX+Buc0YZwZIQAqGcWCKYOtoE9vqxRewdOPLWxENZ7eaE+
 ufc8vGyvA+us0fi7pemtziRQnstcknSoGMTa9d/uv7+p4gY5F4Tabbe1cpNr9TlF8OEfAc1
 V7F8KGBVhsldXCS9g/cmQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FImkk52KdRs=:omzGv0GWMlGIG16dNpBgpO
 xRzddTeh/tmBM/8YRmSW1rhBQ2GpT6UiF8rHqSi/f3hMt5rCE8Qx53J/WbqmsoGCoVGukE49w
 4EhkdVMSQbNSwTy/Ded8URXlAGM+QUb3dxf3ltkUwhnv48PD6XaJXjse4dLUhhc63WILxMJ/J
 rPRm680xIwFIpIFN6t4XZgCkG4GI0KvKmSVm+UiRLbRfEVGCBpQdjS0un4e53tcM5IivP2Xqk
 chpnOtK8LqRZ+SCS+vvo5VBUanC+zc88ggZKh5f+6yZmWwZ5se3EBShSVS7ynBSp7Z3CSDtin
 R41Q5YPRaFWyJUaRu3+r83AjD51ellhV+dYZIpwmu94cwAidMIbQ5X9HKg+0B9VCL6xB1XFci
 2CMA19H3BdHAzyPv/q97A1SgaJTNxrvtnzwC+J1PAbAT03AZ0FGWLSMjoe3SBP7LELSbZyvpL
 l+zgEwDuvc1FuB+42pY7udDvbQcMOuGg5CShrukGlEEOWEdziPshl8BN/TlykMaLQc8i2UgT0
 C44HS5W7iou1bpw0l1WBWxmqq2sTSb8xc3HvToPp+CNjyr1L9gBQGw+TIFnFkEA4hjRwSQ+dQ
 MciccnBGktMNklT+zca/AmbItQ3dGCRD6fm/ABQ/gBR6FoeyxnwB/1emRtZQmOJ/4/g/83S3l
 UItnuWDFbL3muCIwuKnf9tIzfxmj4hWIkL193YDYM++jIFUv78qYUuO7s9D1mrcQJcRqlS40v
 BR+6QIPSDqqA2OKsH9EhxUigmxBtiTPxl30VrYmEkNoYZS0VCMrQniPgpqh6nOx38VcZMw7c/
 edai/Al4vGYqhjItiGCXH3XlQ6+JKHnD9eiJ3qPYoidELfK2HkfSjrdM7d1k1hKHpizhPtaou
 2cVW1t31vkKz39EYeZH7NiWsBWhNUqxE+EzPwBD0oq7/o0dinzusNo4mgRe4AlqsZVIsbqH4a
 0C1euVWLgD8n8qnzstx4F/l2/FIfj56+KtSLGxXwlPYBSR7eeDsTMn1nEpuqPHN8hZefJnzcA
 +S1MOylLGih+Dpu2q1NCVmvZ4AMqqlhNYokhSW2Ka7214meSPajukHGsswHMRlqgZyYZCLdYl
 G/aLL7rdwPkKvzRcXflC9RKWHA5AAjrKDAlWnPNTAKdd0pWkVaL7lDHDBai46OCzBVu/9f1hh
 zR306FjUI0DU0gjESkcMcfQSFNBY+YREhLM365D2QkKXWU0tmReEClRgiRNRuDmm+CjvOSEVX
 bddiklF7BLyEz/3FRDyQgyBDttuJsszNKsfmqEpVOYzV3tXAEPFWQWBv8l0g=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, 23 Sep 2019, Jeff King wrote:

> On Tue, Sep 17, 2019 at 01:23:18PM +0200, Johannes Schindelin wrote:
>
> > The only slightly challenging aspect might be that `merge-one-file` is
> > actually not a merge strategy, but it is used as helper to be passed t=
o
> > `git merge-index` via the `-o <helper>` option, which makes it slightl=
y
> > awkward to be implemented as a built-in. A better approach would
> > therefore be to special-case this value in `merge-index` and execute t=
he
> > C code directly, without the detour of spawning a built-in.
>
> I think it could make sense for merge-index to be able to directly run
> the merge-one-file code[1]. But I think we'd want to keep its ability to
> run an arbitrary script, and for people to call merge-one-file
> separately, since right now you can do:
>
>   git merge-index my-script
>
> and have "my-script" do some processing of its own, then hand off more
> work to merge-one-file.

Oh, sorry, I did not mean to say that we should do away with this at
all! Rather, I meant to say that `merge-index` could detect when it was
asked to run `git-merge-one-file` and re-route to internal code instead
of spawning a process. If any other script/program was specified, it
should be spawned off, just like it is done today.

Thanks,
Dscho

> So the weird calling convention is actually a user-visible and
> potentially useful interface. So it would need a deprecation period
> before being removed.
>
> -Peff
>
> [1] Certainly doing it in-process would be faster for the common case of
>     "git merge-index git-merge-one-file", but I wonder if anybody really
>     does that. These days most people would just merge-recursive anyway.
>
