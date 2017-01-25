Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C9091F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 13:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751461AbdAYN32 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 08:29:28 -0500
Received: from mout.gmx.net ([212.227.15.19]:55998 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751385AbdAYN31 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 08:29:27 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LfCX2-1c81Ew1I1w-00opA7; Wed, 25
 Jan 2017 14:28:58 +0100
Date:   Wed, 25 Jan 2017 14:28:55 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/7] Macros for Asciidoctor support
In-Reply-To: <20170122024156.284180-1-sandals@crustytoothpaste.net>
Message-ID: <alpine.DEB.2.20.1701251425080.3469@virtualbox>
References: <20170122024156.284180-1-sandals@crustytoothpaste.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ZCJC9A065kYCbVtL/Swa8yoMh7CCju1im7shzEBTzJlsC1qgM5M
 TdlnABw8j+1Di5j7AxVQBrZ+fBkT6z97GdFvv9O/9Stixww8FitTLAoV4khUGIRZCvKGrL+
 3lo9+FnW/Jabg8JG0Fx3BqspUpmMpHtIdt83u+pL52vHQhlnzn0xzcF2IrF6+h4KLANfguq
 BO6Piuo330fQ3PEtQ2iTw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BGw2htFLxus=:/WE96pOlQ1WVJQ8sl3NbK+
 ts8MTJBpZvrS8c0wCuKAIuEC0XIek/B40sM44IMs3D0WXWv8ZbWLIsjLLWOXax8dXTf4UXx6M
 qL/q611TmLbOaiGhXc909NOEJc/yFaTxdDRRoFPDkF9TBugeT8bH8B8zt7ngpXX6HncGqJTkp
 FvYegUfikcsqlksUgGnarS0/BiOPBHHkq2PdZpWtxI1W5cMJlwzsXze7OC8zuXzyrS1gLzmAc
 f1+s/O75AKlgFtUWs+lkcp5hE9rCorhurmFSiSZMM4w98OJt7gOSCHSVXvVpvlWKwdjD2TesJ
 Jya91sU4v8UUIxuv7A0CRDhF25ZAuS2BERK8HjiVqpXPPteTa+eO7shcBlZnpht3m4gwSsHSg
 Dz9TYkN0NRueZUkGJBCMKcMaJGYu11UlJTSmsiFxr5T4lzWWno2slbl7WZVsITkFb8cSNa/0d
 zzU57w2VcYTFMpKPtW2AMj1s+MrjstERxCXcDGTa0yigZ5M88LAIlFjpuXZd3ZHNldb2CN/Mf
 gNrN33p0A1nOOkhXc0SxjVmyt+qcnhgRDiOfdF5XqYYrBWypbHfwDeFxJivWugBto1CKIk2wh
 zvRTYGTsrUymxX4UsI1h36akhoYnSYAXu2BsyJ483v9NZGMTSbk+ZdeBZB4/4CUMd1Syuw/Hs
 8HYcD32ihOD8xSNm5c3VtMLNO/GuXgoNhUGXZmR7fH+tX0E5fV1ESeeFxY1z+wM7jTaAVsHo+
 6wEDYPTlcwMjvQoz7yN0xDO06TOkT10us+yodaU0PcrGhQpju4MnW9xtMKZQR6wDDyJQOysVU
 4szp4I9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian,

On Sun, 22 Jan 2017, brian m. carlson wrote:

> There are two major processors of AsciiDoc: AsciiDoc itself, and
> Asciidoctor.  Both have advantages and disadvantages, but traditionally
> the documentation has been built with AsciiDoc, leading to some
> surprising breakage when building with Asciidoctor.  Partially, this is
> due to the need to specify a significant number of macros on the command
> line when building with Asciidoctor.
> 
> This series cleans up some issues building the documentation with
> Asciidoctor and provides two knobs, USE_ASCIIDOCTOR, which controls
> building with Asciidoctor, and ASCIIDOCTOR_EXTENSIONS_LAB, which
> controls the location of the Asciidoctor Extensions Lab, which is
> necessary to expand the linkgit macro.

I like it.

I reviewed all the patches and think they are good (except the XSLT patch,
which made me just feel incompetent because I do not know enough to have
an opinion about it).

> The need for the extensions could be replaced with a small amount of
> Ruby code, if that's considered desirable.  Previous opinions on doing
> so were negative, however.

Quite frankly, it is annoying to be forced to install the extensions. I
would much rather have the small amount of Ruby code in Git's repository.

Thanks,
Johannes
