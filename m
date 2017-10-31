Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 782C02055E
	for <e@80x24.org>; Tue, 31 Oct 2017 17:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753868AbdJaRMx (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 13:12:53 -0400
Received: from mout.gmx.net ([212.227.15.15]:52773 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753744AbdJaRMv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 13:12:51 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MPV69-1e5TMV41bt-004irk; Tue, 31
 Oct 2017 18:12:47 +0100
Date:   Tue, 31 Oct 2017 18:12:46 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] mingw: introduce a way to avoid std handle
 inheritance
In-Reply-To: <20171030205522.hur26cumwusk7wwa@aiede.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1710311809570.6482@virtualbox>
References: <cover.1509382976.git.johannes.schindelin@gmx.de> <20171030205522.hur26cumwusk7wwa@aiede.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:p4sm1Y2QELb7gzqNxkVIFqNCPFv7XXKyu0PofJbe0uh/5r5VM/Q
 Zl3h80nXIxDQpucs4EPN2sBo0RAU9FFOBD6e2nNTLUfN+UHE3X+4MO5mGBEB9BntVLULZLR
 6+TvjEAZZlT0Llvz5L+Ggf8dNQcRku5mlzHROoFgFLH2lv3Wp+gkp1oRNKp/8YX6mdcu1WA
 maxe89U4cdX2ENx8iUktA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZDiMydaBypQ=:vj7Fkvi7XNA8+kj3El8V9n
 c3l+Q0y8ZsQVSRhwkt5uh65F3gSQ0aXMEWmMseXobL63EhbpbCnskMQpO1LQd2pDVhLkZH8Lr
 py7tlQwvEWdxZVvwUkf381IgPPMtNrwyBR+GzHAmhUrLVazTH0Om2x8wZm/WiiBMF2IpjpjPh
 UmfAeUdSaRfh4+npRa7KNUbblU6tpXYoqDy2I87nSbcPeSAyKap9GmAZ4qcnu0yZFffo0KFIy
 0QhCPFfyCO8dF54/0bGsYEMUl8M9YcBskN/UmXhwTVPTLM+xyKw+3+zq+o1xsCLw9ZjfqE8/Z
 bi48AZZQZmCBpKtCtjKipnEoondwKmP2oitjUqmseGvrubrGly18vXCajjdLAaFpQxUWk3F7N
 6Oza5VAsHjWWpO2VO8HN4KOHxmONjCDCDuQUWM+kAGzz34o25KyxNk791tnx7l0gWBQaGxkyI
 6E8k5gmWJffHj+KPbRf8pFRxRpZQ0gRhMcCcrQiNO6DqGdlBx4+Jzv1jNlvWar72UdwqTgMXW
 Ib682al1MwnOYYY1n1M8wVoEJLlc7666nAKVDFrbcZAcdF2xB/P4SDfQ46Lr9Wcvgs0lJfphu
 DKUczGLhU9XHTMa9+mFnE7xqX9OuJHmlippFq0nQKE52Sv548Ee/hdnyx9ZzpP0dU31Ygtjsm
 HFabnIEVsPUdYE0EdCxRAIZfPLxLz/zVMIclaIfOvmurtBn0j75u2CMghAjB2sMuHxqJlhpKQ
 KxFR8oVECGcGvW81DSsua7U1X6IvMBjWu4KI28yZ6DB/vuZm4T5fer7JGhEQEwmxDYX8HGguQ
 Ug6HF7tEGmQOKUi/KLfCVu6bzHSbzGDbHVo8vy2AMKRiClytcuJ2GGEt0/s1Q9yJZBHO/x5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Mon, 30 Oct 2017, Jonathan Nieder wrote:

> Johannes Schindelin wrote:
> 
> > Particularly when calling Git from applications, such as Visual Studio,
> > it is important that stdin/stdout/stderr are closed properly. However,
> > when spawning processes on Windows, those handles must be marked as
> > inheritable if we want to use them, but that flag is a global flag and
> > may very well be used by other spawned processes which then do not know
> > to close those handles.
> >
> > As a workaround, introduce handling for the environment variables
> > GIT_REDIRECT_STD* to read/write from/to named pipes instead
> > (conceptually similar to Unix sockets, for you Linux folks). These do
> > not need to be marked as inheritable, as the process can simply open the
> > named pipe. No global flags. No problems.
> >
> > This feature was introduced as an experimental feature into Git for
> > Windows v2.11.0(2) and has been tested ever since. I feel it is
> > well-tested enough that it can be integrated into core Git.
> 
> Can this rationale go in the commit messages?

I thought I had done exactly that in 1/3...

> Actually I wouldn't mind if this were all a single patch, with such a
> rationale in the commit message.

Quite honestly, I'd rather not. There is a logical structure to the three
patches (and I left a Duck in 3/3, to see who bothers to actually read
what I wrote).

The redirection, for example, is a very special thing that I would like to
keep in a separate commit, for clarity.

> The patches' concept seems sane.  I haven't looked closely at the
> implementation.

Thanks,
Dscho
