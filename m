Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B14F11F424
	for <e@80x24.org>; Tue, 10 Apr 2018 08:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeDJI0l (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 04:26:41 -0400
Received: from mout.gmx.net ([212.227.17.21]:37009 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751836AbeDJI0j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 04:26:39 -0400
Received: from MININT-AIVCFQ2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MQNFY-1etcKv3gaa-00TpaA; Tue, 10 Apr 2018 10:26:38 +0200
Date:   Tue, 10 Apr 2018 10:26:37 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Elijah Newren <newren@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2] Make running git under other debugger-like programs
 easy
In-Reply-To: <CABPp-BF4x-ppjptq1TBj+VicvGeWGbfj4e3f5ne_13AEKmvSQQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804101023100.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180405174935.598-1-newren@gmail.com> <20180409185136.4880-1-newren@gmail.com> <nycvar.QRO.7.76.6.1804092316280.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CABPp-BF4x-ppjptq1TBj+VicvGeWGbfj4e3f5ne_13AEKmvSQQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+b02n66SkWRNsfzJwwcPBUrmv4B6nirsRsGx/fJNda/3e0DQ5d2
 8NYv+D7V0GKv1nqL09Vfp1rFLfDqMMQUdNsBxajOykN3WVpESDwFG3Ca1UoHL9Tc4EU1MNZ
 iuRLBpHAYCDlkA6vxfufyqH5B0t9v9tT3L0OU1kfOLTYewTuy5kjBy2GWwWE9JVTXzGohcX
 hP0ls9bBDOlo1oViDnsEw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:anQ3D2xsRrA=:xxxyp8ZYQwvvtiUKl9ICMU
 iO+tybzKNu4XhNZhxSptZ0Rw6uH54X42bLF3LhNCJv0jqvIJThQzYcYjxjCoH1rRcKKPp+fEO
 MMCivvBt2HtTzZi1RTPCTwqnybxo4tsZfIvBYjuo9WUrmPOAIfbAUy8V4e5KVD+3lnd3bzykl
 d8fh6w3gXadERFhIlaYJ5LLfMqHmdqlgSI8y6rvqEQ7IvQw+Tvv+xboF0Sdz+maN2QjHVd27I
 EAegw9/dXpe6oXMkpe0Eoi5naAr7oqluqSNvYOHQFWdK6uBD/Xml61m7dII7GkUdbKXCmeg2v
 i5T3AeI/NegGbqESP/Q295qpwxxz05Sl0rXrOnREKkQp3hCL58uqai7EUsq/2Bo1iGwtQg+rO
 ajADq7qWGRtR/7cHe3t4Td7BylZdGr2WACmvnWBFZ6XYwNZxOjbcK2p37kTL7ilkI+v+ff4kZ
 juTKU8YAjzQgyHNRMicPVwq9eoMnVgnU8ehFPhV0EcA8ari12LHa+yOFMXPjJ6Hg0OI+6Lc3h
 yr/SvLt/f48kZc6QqgnfoaAVCAQHrwjKNJzaljbSdC+kFRwW57+RbNO/QBDbkGnp/lsiyUsXN
 pkFJf4/taG1taTj76uYxWELS+SwuznVjK+EFUSbsa6FEf5Giu7TnvwjtIENGPzpTQuO3GjSN/
 IpV7rh6M/Npcb7v+LRanTAH+7iA9GIJ8mAoxUgg1E6acZYqEMVZCWAutguNvwEqCREhxlSh9O
 Thc2iqeQMwt+fN5Qs0YlLpssXaPBV3Lj5+x69pPQDczsZMMSxJLK/OJ3r6oQKHoxomOPzWsFv
 PbjH+SJXO9Bbv6Mx93eF89wyJ/0cQqGLgL7pBaBwV8t4OKDhsw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Mon, 9 Apr 2018, Elijah Newren wrote:

> On Mon, Apr 9, 2018 at 2:19 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Mon, 9 Apr 2018, Elijah Newren wrote:
> >
> >>  debug () {
> >> -      GIT_TEST_GDB=1 "$@" <&6 >&5 2>&7
> >> +     case "$1" in
> >> +     -d)
> >> +             DBG_FLAGS="$2" &&
> >
> > Maybe we can find a way that does not require setting a variable other
> > than GIT_DEBUGGER? After all, DBG_FLAGS will be visible to the script
> > calling `debug`...
> 
> I guess we could instead do a
>    export GIT_DEBUGGER="$2"
> here.  Short of explicitly using 'export', I think we'd need another
> environment variable.

I suppose so. The GIT_DEBUGGER variable has to be exported *anyway*,
otherwise the bin-wrappers/* won't see it.

> I would have stuck with your original suggestion, except that by running:
>     GIT_DEBUGGER="$1" debug_aux "$@"
> GIT_DEBUGGER would be set within the debug_aux function and would NOT
> be set once bin-wrappers/git was called, making git not run under the
> debugger as desired.

Oh, so in debug_aux, you'd have to do some funny

	GIT_DEBUGGER="$GIT_DEBUGGER" "$@"

to export that variable to the process... Ugly.

> >> +*)
> >> +     GIT_DEBUGGER_ARGS="$GIT_DEBUGGER"
> >> +     unset GIT_DEBUGGER
> >> +     exec ${GIT_DEBUGGER_ARGS} "${GIT_EXEC_PATH}/@@PROG@@" "$@"
> >
> > It may not be a big deal, bug GIT_DEBUGGER_ARGS (if it was exported e.g.
> > by the user calling the script) is now visible by the called process... (I
> > thought I had tried my best to avoid such a leaking variable in my
> > patch...)
> 
> You had a separate, per-process variable:
> GIT_DEBUGGER_$$="$GIT_DEBUGGER"

Right. And I guess it does not work because the _$$ is not expanded, you'd
have to eval it, and then you'd have to quote the right side
appropriately, and it's all not worth it.

> The problem with that line is that the $$ apparently makes bash treat
> it as a command to run rather than as a variable and a value with the
> desire to set one to the other.  Prepending the line with 'declare' or
> 'local' or perhaps 'readonly' would fix that, but those aren't posix
> and my reading suggested that while some other shells did support some
> of those builtins, the support was somewhat spotty.  Since
> wrap-for-bin.sh runs under /bin/sh, not /bin/bash, I didn't have a way
> of making the per-process piece work and just fell back to a separate
> variable.  Maybe we want to change that script to /bin/bash?
> 
> Do you see any alternatives I'm missing?

No, not really.

Well, let's stick with your patch (with s/DBG_FLAGS/GIT_DEBUGGER/).

Thanks,
Dscho
