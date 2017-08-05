Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BA3020899
	for <e@80x24.org>; Sat,  5 Aug 2017 23:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbdHEXaa (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Aug 2017 19:30:30 -0400
Received: from mout.gmx.net ([212.227.17.22]:50060 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751220AbdHEXa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2017 19:30:29 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LnPnu-1dA12G2zmQ-00hhnM; Sun, 06
 Aug 2017 01:30:22 +0200
Date:   Sun, 6 Aug 2017 01:30:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Michael Forney <mforney@mforney.org>, git@vger.kernel.org
Subject: Re: [PATCH] Drop some dashes from built-in invocations in scripts
In-Reply-To: <xmqqlgmxskm6.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1708060127330.4271@virtualbox>
References: <20170805064905.5948-1-mforney@mforney.org> <xmqqlgmxskm6.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:wFSV8RsQYgN2htqyA+elQ6t17ffMJZJhL4VbcBMM+I123cgVyiG
 p5jot8CXERbxP7/jBoC6CmpmAPz+MpkC1PIalDQuuslkmqy6tfrpZPJN8FPyhds/2QhHE8I
 Tgi+Zy1/MnUdkUaXCvvUZBv8+tqIklrfOHWVB7k1v4tpdZbfd7lU6VCxBf9d39PqqcBnA0C
 xjiVwFy1BsqhfnHd9fL3A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PSCPYURbQDM=:vx8Z341vmJOyXH5nKugjdG
 VX0OYGlDAbb4eFO0DAQdL44k3RZPtItuQlPn5pN7R1rlM0EHljz2UWtp6s17sNpfvpEGLWVA0
 3OFMXMD6BKbKPXmCNGaHYx9Dc7sTZpdQqzKZO/xaTB7YCTaPrp7gLcmKp1GyP1lAIllt5bPHd
 QU3P95lqhgzhmv2t23QKl6eHF4QartuSXD6oYMUXKE7C9lW37QP/oEe34atDlPL+uk8k3cyjE
 i+tNfsjt9qkZAOS/oQjrSYg5u8fReo4hIxeu0Eut97ArmtGdxAAggvjM+3wv5f7E3MxnH73oE
 05qzxCawgHfSM073oGULObs3xClXGg5Jj8rEuYTfUeCSSioPVXeFIw8JnlXXEF4vp/5FEeKcu
 NCYPA97qQB4zCUBrkIntXQQiwwNW/mpwodh/bJJ8ugl6layQsbcIHDaJmrNGKC1+NLi8CK7pn
 +fj/42dQvaORyGe9X46wnRryZo0l9usg7oK0eFjspwWGqC05e66UFLsNsV2+d8YfkaaDVZ9rs
 uJVKqQAHIDjYVEIrWKSTN7fQejoezzt+F5N+wVH9NDOcjIMhgeMfY+9yK+HNnxwepnBxbRyS8
 NyhQdnlDRocvvISnsEV1wLoI46+nIxkaEgNydr05Mbli036KAoxkKHIOW6VLRm+5S10Vhj7rY
 yYoaDE6Nvlz9F2Q9fXKtAtNEtt23z0Ij+oKQmGH/C7YeauOkoUdFPEQLJp1TFVhnEJTeYuVe6
 cRFjX42HqQVjeORgXZOu2rP9RhEKr4jqfw5AGLK/hjQaTPhosw+IRlbi2Sc3JY7EJ5XKoPPQV
 HLHeY7CXp7+f13kUbaMlVLeNVExc/l/aCFQ6rzQx9RpxPb1+kE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, 5 Aug 2017, Junio C Hamano wrote:

> Michael Forney <mforney@mforney.org> writes:
> 
> > This way, they still work even if the built-in symlinks aren't
> > installed.
> >
> > Signed-off-by: Michael Forney <mforney@mforney.org>
> > ---
> > It looks like there was an effort to do this a number of years ago (through
> > `make remove-dashes`). These are just a few I noticed were still left in the
> > .sh scripts.
> 
> Thanks for working on this.  
> 
> Have you made sure that all of these scripts, before calling
> 'git-foo' in the current code, update their PATH so that these found
> in the bog standard place (i.e. GIT_EXEC_PATH)?

The scripts do not update their PATH. `git` does, before they are called.

For example, if you call `git stash`, the `git` executable will first
figure out that `stash` is not a builtin (unless you run with the
experimental patch series that still has not seen much review, more is the
shame, including on myself), and then call the dashed form. At this point,
`git` will already have added the exec path to the PATH variable so that
`git-stash` is found. So then `git-stash` runs, and does not even need to
take pains to adjust the PATH variable again! Magic!

;-)

Ciao,
Dscho
