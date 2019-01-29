Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D8EE1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 14:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfA2ODh (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 09:03:37 -0500
Received: from mout.gmx.net ([212.227.17.20]:33097 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbfA2ODg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 09:03:36 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LmeGF-1hOe141rNb-00aIOA; Tue, 29
 Jan 2019 15:03:29 +0100
Date:   Tue, 29 Jan 2019 15:03:13 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: js/rebase-am, was Re: What's cooking in git.git (Jan 2019, #04; Mon,
 28)
In-Reply-To: <xmqq4l9s9zee.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901291501320.41@tvgsbejvaqbjf.bet>
References: <xmqq4l9s9zee.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:d0hjY4izqzXBzMdhngZ+8ray1BJWaIV6886axzgjdoUeQclY8E0
 AxQmMwTAJobeaJ5Qb3JxLs9kvUvY5+SNxv8sowmjzhiMF8Az4GcZ9Yo8+O58OTxXIW5fU3l
 HV5vHGzMSbGYefWUWxcVIcpWr249y/tkivADXy/DG1x1g4Z0oiFzRHOGmmls6UvlEcisCCn
 NEN6XtajCONRAv5D5aoXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pa5AkcDjgg0=:YSmR70+DXqAhmKGmAt7ax/
 OQ6YzvH6akOJh54JJtLsu9FpcOnU0PlHUf+rIyvAgU3IGJm7512F1MwLu/t5fW2Oe6BIlqKY4
 nR3q0EOFLAyfdAtkjDR6WWCOUaqF32d0DVftQYI6CJErHAgQ9OR9gz6H+mczLL4i3y9PQuetM
 0PA6QSPiSMSCbuANHjOyBFZTtKGarKYzU6gTTdk2R13J0VI5jMpyWQLkcN/xwq69Wy0FAbjSy
 2rzSZf/pK2Y8v0Uj3WDb/7iJk4F7CVH9AncbFMFHiZSufqV1uIi7L7VcB3h8fw0Y5BD5/7hxM
 Q8ANl/9ZwlwNp4Rcyq0jvx8mrfF+juyS+6Rfc6LnlNwFdg9GD0zE4SwQ7K/Zwc8KvbldQ2Frp
 ilaS1o2rpxfm9O/dTSMu3h0r7hEIgfETx+KLwXzl3lPtno9zTGOadbUZNHS+TWYdYZvoDaLee
 ObakUfsRuTIIN2zno3/2THt/LNp9HXWOnt/sq4H83lg8/HKImoIpBpR6Gl+E8v+HQADBCXwbE
 d/sYXzhyRqa+93fSFBtESwS2054oBTSw8e+RJUJwZoL9Oxb6mWB+oquCcnX2r2QbtgF9qVlT5
 Z76W/Ek9DONqgzl0qG40E9KabJrn38usO4aeOge45I/Ss7U9+j+CG3gVE7ncMzbJF12J8uy6n
 AmrSMKAuL63eCfSHQ0AIvXWcw1dSgH6c0s4vg/w/mmIVoMLZDqPQzRTnhQiBYzL2nJIpSR5Fp
 PdabG8hN2HC+fh9unmoGTc2GOMD5nOcHuW4PQlx66nqnovI+jp204fUJPWKBp/h/K1Nhih8pp
 I7cfAmilgYCmS+yIA/urGiFUm4iZ8kMajSOf2aZIqcTs8oESq2wo/mhvG9GxcHspnVmzsMjfH
 tgVV2JTJLp8tJiPBwE3r6kHDi+qj20euJtUer9lSPyH69n5aHNUFz8DF0KBPw6CBQ7klFFVWw
 1NUKnMziCSA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 28 Jan 2019, Junio C Hamano wrote:

> * js/rebase-am (2019-01-18) 4 commits
>  - built-in rebase: call `git am` directly
>  - rebase: teach `reset_head()` to optionally skip the worktree
>  - rebase: avoid double reflog entry when switching branches
>  - rebase: move `reset_head()` into a better spot
> 
>  Instead of going through "git-rebase--am" scriptlet to use the "am"
>  backend, the built-in version of "git rebase" learned to drive the
>  "am" backend directly.
> 
>  Waiting for a review response.
>  Looked almost ready.

I responded, clarifying that the code does not change the behavior
relative to the scripted version.

Ciao,
Dscho
