Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A05701F462
	for <e@80x24.org>; Tue, 21 May 2019 18:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfEUSc4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 14:32:56 -0400
Received: from mout.gmx.net ([212.227.15.19]:55755 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727969AbfEUSc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 14:32:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558463571;
        bh=FUHbuRjP9Tl+GUYJZDYmj0/c4roZjPlBDQtgT4ZVYo4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aOgIr2K+I3YWiFMw9ifgUaAWtJ/opXxdmZFyHD64VY761h559p5601pVztOsxpnS7
         r/q3BPvU8IIDpS1iLRfZzlwOODuPzxoAqNq6jdHBoD4KgMOaB+A4V1FhziXi6F+DfZ
         M+EK1UlfSKk5RBdtTODQMc0zDMWJ2rxTVjiPJKcs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LnfuZ-1h0RWG1Yo3-00hwaH; Tue, 21
 May 2019 20:32:51 +0200
Date:   Tue, 21 May 2019 20:32:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: js/rebase-cleanup, was Re: What's cooking in git.git (May 2019, #03;
 Sun, 19)
In-Reply-To: <xmqqv9y6zufi.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1905212028240.46@tvgsbejvaqbjf.bet>
References: <xmqqv9y6zufi.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2Y9ngb+PeUuT9BF4XnPAwFa1Cr3MnQs01nguGXS9EjKaEkiMdcF
 zExYCBVHhIKsPGaSDRoG/WKvThg+UzUKprgnL3d60Hjs6PlzYEb6ZQ/M9niz9Xmld1ZxoDf
 lxWwynx66eicIbrili3VWldKigyEK1tysKE204nLuGqm3stZsLGpfHFLp9rL1pDaiidbAjJ
 fLYKhkSI07zHRbQdhn21Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vU24PqpND0Y=:6QLNlCsXvO6izVjYYyQcHp
 BeOuFJt+2s7tIn7MYtgiZAsudygOoX7vxjJLmHIC7zNUV6HKMd72Y22WLwmBn1pBArrFp4iUg
 XjnBrqHl/vhUw5JHv4UB/eqBw7OfM+/tq/JV1NBeX3wtQa478iKCJ1wBguKiEE5Wl2Rz8UJkD
 kA2AWPozY+MLRZBmEzZmyks+jduihF7aqdD85xzZ3QjNXsmlUaC9cj4i9uq43u9wHH+zn1nvW
 NnKgVsAryDWKjc9bkSc+q2/h/SenRqchfR5dBSWLHdqJkwBPtA7P1ZzyoVyAZ4YXN9l1W+C56
 8O55X/z4VMiMAbGJc2EBL5mEgNLIxJPJt42Ig5CX5ZGyrgEj6AFRdtg95qyQWNhxm6CSZYBO/
 QWBoiLvebO6g887cBdms/EWB9K5BZH296E7MJjAVGDjV/f3GRTnn9bKUjG/ZuVw7OcmftzSFg
 /d+iJbGGaER6qt0vyg6yoH3m6JxO85X4niXsChXuXzVGgz5iR6RxTQdYPRXNWZ1Cauxl/A5fI
 BXDhos9M0L3fdxRtxKzkl1bbMXrrZgEZJJSIBNxjSI9OR5KpW0pEgjmzgMC0QWp/gaOL4TDSs
 tuVp3mcU2ZCO9pJxze+pN9PWxHh0mS67w9meIxxIRMTx9iVakRo1oIZMtiWLapBFOcCJx2+Qk
 8IexM5qJOJ+cVr849Ze6PH7/aFHPe4iY/wmI4jW8htfF1FDS9MaAz2WtRNLbm0HBwABzVM8WK
 xkr0xkeiJa1fqLYaKPFs9D5qSe8UnJxJa3aBvFulCiPF8BtBg22NnoUon/IJgo25uG6ooMOvf
 Ow4no85j+QR/x15xYcl7Tq6PWHEtb/xbiwURpLPnPmq6Khr6HBz77mvbI9OjeY4uHeVunC69U
 SYZXz/3eWOYymZ1pdC5Ktkms/F1BB3RUHI8Ebm8gW6Vr3pCElemzzqYW285tRkQjsB3eqziwe
 QZS4kSg5WLmhIvocjUuUjyhMeBJ5qWVV0yME9nx3yhL5rKb6MVcP/
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 19 May 2019, Junio C Hamano wrote:

> The first release candidate Git 2.22-rc1 has been tagged.  There
> still are a few topics from 'next' that need to go to 'master'
> before the final, but otherwise this should be pretty close to the
> final version.  Knock knock...

Fingers crossed!

> I'll be offline for a week or so and will tag -rc2 early next week
> when I get back to the US.

Enjoy your time off.

> * js/rebase-cleanup (2019-05-15) 5 commits
>   (merged to 'next' on 2019-05-16 at ccfed8f263)
>  + rebase: fold git-rebase--common into the -p backend
>  + sequencer: the `am` and `rebase--interactive` scripts are gone
>  + .gitignore: there is no longer a built-in `git-rebase--interactive`
>  + t3400: stop referring to the scripted rebase
>  + Drop unused git-rebase--am.sh
>
>  Update supporting parts of "git rebase" to remove code that should
>  no longer be used.
>
>  Will cook in 'next'.

I guess you're saying that this is *not* one of those branches you want to
still merge into `master` before v2.22.0... Is this reading correct?

I ask because I have one more patch in the queue that cleans up the
NEEDSWORK in git.c that we can now address, and I kept it out of the patch
series in order to make it easier to merge down before v2.22 final...

Ciao,
Dscho
