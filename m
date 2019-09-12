Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A50C1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 08:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbfILIpg (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 04:45:36 -0400
Received: from mout.gmx.net ([212.227.17.21]:36173 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbfILIpg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 04:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568277933;
        bh=H4s0OcjJf42mdSawY9rCt3dphQmmGsllnboc57CbBQE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=URVyxNLMfmxSwYvGsUP9jpPt55tbggWY+6zhSoBregKeEryJ6q53rLn/HyNFfbYAe
         jQkiYY8c1/GnkD/k2r+nHZa6ymyOeO19RS2r7h5WmLTxGndSZjBu3sZGCT4L5SHEQs
         ha8n1+lYNafh3xZaInJye/UFZpxU+sL48lErH5yQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LvlWS-1iBtXl0hcS-017ZDA; Thu, 12
 Sep 2019 10:45:33 +0200
Date:   Thu, 12 Sep 2019 10:45:15 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "Castro Alvarez, Sebastian" <s.castro.alvarez@rug.nl>
cc:     git@vger.kernel.org
Subject: Re: could not fork child process rebasing required
In-Reply-To: <CAMr8YN58q94bnBkdfxrBR-Vw5Mk4akHzn4c1k2HjMQCXKWdWsA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1909121044250.47@tvgsbejvaqbjf.bet>
References: <CAMr8YN58q94bnBkdfxrBR-Vw5Mk4akHzn4c1k2HjMQCXKWdWsA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5Ba+M+Hk+6RL0dFX4Jr2b/sO2VrqhzDtO0N5Gw6dImXkym+DBd0
 EnXqgoq7GMf0PZ0odxQtXe/KPoHNdd95yN3JKD34DkIHuDPIbS6NWKkR3npz2EWv28pT/dG
 Fnkhc1pCGghOYU4ZA3mJZLzcirvtKTqzeH93qszWJ9GNmkyBixaHXZbRQOfAZ/TzYiPXiac
 b5HVFn48h93wk83g5oJiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Sifw1EgrcaU=:SQD6RHQAt/Ya8vEbLu+Ugx
 sH1SIu8MsoRk4hGjsPhm0TpLFaaqB6asMlTwsn/6twSuoJw9XGuHjoEM6FpJgYmxI8YwPlnTK
 TZW2TbXgvwArJC2ungjYaoPchyIC+PLX78eE15zVE2qVCe1zIihkT20eCHCQtXm+QsSdq89IH
 ORve5/DhsZ2qrhQuQZomMlH1NrY/mbxbZt0Rn0tNhHKxlu8uQiJ9Xbff6KdTqdNm77AgIWFDS
 4xo3Es/LITKuQCPUpfui9kjUhc2t9ZtJqwLuHwUIWfx27kGYBqTiLp2ZW3B/inmnDYDlj7TWp
 Ae5QqBRw/1qU4AJFGFIKvvDP/LLwh0Vtdf7y8z3xokedJSAEM14OEENkjE3r1znfkDWm7IefS
 QZDG1759TBo68xcVXYZKkB/Fz3Xh5hoAesXm8292MOdlqYSsnDjJMbIdP+R9biF+quYEwPVyv
 9qRES9umC1+3L5vOr4vmCmf7SvZer5TKa1uhujbdppIeBGmqZqr4Esb4dnVr98VSmHlIdCzBk
 1sTZXdVGlXryosSUwOlsgAFUKP38wejKUcTyfn0oXT19uml7WNnbdY/wo/PWWJ7K4SXsmy1/b
 o1U/eCO7qGDux7GZjmA1Q0ye8A4458DdTmK6lHUtiZFTOsqpxh0ikoHROZwI8+r78DCZL+wgQ
 SW5QKHdtNLBwXiB+BnTYP9W5dNDKrioisOeyreMxM5BJ9uopKtuKwj+IKl2H85prsvNzDTY/t
 4tguqIW0MeWMh+NquYP9hUwI5ZjpCpE75WHKKAqVIrJaccW+fCqlabuQpsbyJsim7YSZpwsOS
 WARKXfazq/T122frHs5uZdJN8Am2ncQOqdpBn4Ulvjpcl5zkbiEPkQ4ij8ki0pP+bkQs3SyZY
 u25hMtzx+L29bMm1OLhlE5swgpy0zT+TJ4H/gLiMOwzzx8WBFFkjuTQqULbhEx5jt7aUeUGIc
 HF1WbVjkKlWU1FkqI4B4yCTwk1wuAiynE4ux+HhKA22sEMWNXj6u+KmnowIEXXMtMr0XDtdab
 HuNWN7ubUTzhOTXwm8xaeQAP3U0cDVbLCFshj6599JBP4wIO52oeEPJpX6t+uy7tpqM1q6Ip/
 KjkvOU96+MCS8YI+21xlSeELWw9CiXY2U73sAOqx1mBdvkRW7Fmm3IdYhGr39v0uhVyyjbPnX
 OhlLpD622Z+SpVsj6EHH8P1BtwYU6/bXCLQ0NmUw7kamb9XpTph7LHE3Wb5lRhCY8vbIYFfe1
 SYhTILPeZKj/tLFsV
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sebastian,

On Wed, 11 Sep 2019, Castro Alvarez, Sebastian wrote:

> I have recently updated my computer to W10. So, I reinstalled the
> newest version of Git, and it is not working. It gives the following
> error:
>
> Error: Could not fork child process: Resource temporarily unavailable (-=
1).
> DLL rebasing may be required; see 'rebaseall / rebase --help'.

This sounds as if you tried to install the 32-bit version of Git for
Windows? If so, please install the 64-bit version instead.

Ciao,
Johannes
