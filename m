Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DA9C4361B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 14:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18BA423D20
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 14:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389701AbgLJORA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 09:17:00 -0500
Received: from mout.gmx.net ([212.227.17.20]:44287 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389288AbgLJOQp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 09:16:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607609709;
        bh=C24pwoev+27oTQll+RI3XWh3jQQYG9ihqRoczc9/qSo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=YkuNtQuvv+7akZBE4kFfnQ5x9LnM7r6KUIGDPV6eK0Mb0jmSZcVgtpEBK+LjN+0gG
         nhcWvKFvXaWd6r62Jh7doAT66amSmSGsxOswqRP0/pjnc3dTQxv1V6JVvsvSO2nUOf
         6T8zqA+f+2S8fIRKfIAXERmQTfpcoMed8rT5s3jw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.88.62] ([89.1.212.111]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvsEx-1jxb5836ql-00sz3p; Thu, 10
 Dec 2020 15:15:09 +0100
Date:   Thu, 10 Dec 2020 04:56:45 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: bc/rev-parse-path-format, was Re: What's cooking in git.git (Dec
 2020, #01; Tue, 8)
In-Reply-To: <xmqqpn3j4ved.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2012100454120.25979@tvgsbejvaqbjf.bet>
References: <xmqqpn3j4ved.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cDHUIxASUHuBDaM67olrdwz48Fn/v22knmqAk5u5b8NzKC3zy4Y
 7w7upzAEU/nzdC1xUCWFEymvHZNUfi+0Ro4CxYQkZ1UykwDbP3CqtSeWWR+qvpVhDfMSQlt
 0+k9aZt7Hdk/MHi1j39i2Y2uAZATy4kK3flV9Ca8kl7tKfdCGxqlTaXGqynzjtSVS0mLj1y
 gZlrN0dYUn3133kRAWqCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wkpAoHyENcI=:sqLmdxwl/0+SBCTHlIsJTR
 tJYRaS6KT3n3CQqb9YmNpj7d+fUY1SSSF5IXy0/GLTk8rjmBOOdZjSlYGbYYJQjDTxiaDEe7P
 EEguekEjuH6IW4mqrwDcqvXAO+9GOo6cOxe1G3HfIjrFGiPkBx94Bk9Kj8YZ7c2YafqEQqBsS
 3EvbN48THz0b/DoL61nqe3mLztARzRU78cf633Z/Wf115OzriRyhtzvbLqKEGYVVMw/TNY7Ab
 hFwCmYbKqdj5FpK1MzYrcdyGgPMTZLmwwJd0UgpJvwtI+oIw1H/9g797WwZRnudrThpNNauiR
 wNSGjeKcCaiQPNOSPZLJ28EL62YhESxvuyDg0o62M7fQ/OEUuWAf2l5mqOtmfMopaNRd6t+WR
 Btzz6TEtQQ3s0MsmBbJX2ScEuDB5o2/o1P7pXXH43PDXDbeNLrlm8RksXNA2wGwIOk5XsaJln
 pWfxOBSaswl3y0tFOVL0TjCuN0h4fpIP/A51NSthxwj4+v9c02MlBDSrhKbN62vRgPM1mLeiF
 EZrSGnYUQYoKd2ZRkWI4q0yZYf/pfex//VsC7XjuuiijhcM/H94BZIxTksop832fsuymS+ssQ
 GhJ/d6bWeOqBAKynGueLaxdBpyknXAnKVfLQwW4yzhA+fNVG2rSOYJkdF5bR3dMIwvEQQ0ykt
 GigYqxhYvVaZtlXIG5z7CNWcpQDv10dOJCuZUKqSduTluDxRWPK9p5C1dWbGImJl8TD1nFNgB
 Ho7KnEU54DDoegDEo1njSEizJjt5uqxPeTqfrlw+Eoh5pNKHlgOZTfHP89MHj7gSrkpA7my+d
 AdK9/SPBPogRan9ysadNS6oubno+nd842k9QS26JzG7ch+2jqyjgV1XmwEQ5+eSqhrf9OwCWn
 nLi3F0RiO8+OrrBkW70UmEtqbHsZv6Wf9DOMUQa9o=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 8 Dec 2020, Junio C Hamano wrote:

> * bc/rev-parse-path-format (2020-10-09) 2 commits
>  - rev-parse: add option for absolute or relative path formatting
>  - abspath: add a function to resolve paths with missing components
>
>  "git rev-parse" can be explicitly told to give output as absolute
>  or relative path.

This is listed in the "Stalled" section, but v4 has been sent out this
past Sunday, and in the replies brian promised to work on a v5:
https://lore.kernel.org/git/20201206225349.3392790-1-sandals@crustytoothpa=
ste.net/

May I suggest to move the item to the "Cooking" section?

Ciao,
Dscho
