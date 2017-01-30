Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 082F31FAAD
	for <e@80x24.org>; Mon, 30 Jan 2017 12:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753026AbdA3Maz (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 07:30:55 -0500
Received: from mout.gmx.net ([212.227.17.22]:65166 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751092AbdA3May (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 07:30:54 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M2tKM-1cF8md3Kli-00sdxN; Mon, 30
 Jan 2017 13:24:09 +0100
Date:   Mon, 30 Jan 2017 13:24:07 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
Subject: Re: [PATCH] fixup! worktree move: new command
In-Reply-To: <xmqqwpdgz8zq.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1701301317500.3469@virtualbox>
References: <4f4ae057cd4d72d5b945a856deacd921fb5e7977.1485349447.git.johannes.schindelin@gmx.de> <alpine.DEB.2.20.1701271150200.3469@virtualbox> <xmqqwpdgz8zq.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:yH08q3Ma9krjcRVETxU7If17DEtFN1ph3S+QVONCMJHhK1clocZ
 U4fuILJEO57aaFaJRdkX2DzwNdPHzwphYTqSozjqwqcSB+CGlRzmUxxUlNxeeqKvFXh4nPY
 /5Mb9nmDj+ZqKRqoueW3vvKZt4kfbzny1+uWqmNwktw/nGq20ftIitW4wLDIgeOlSekclTx
 /StPZi/9QKW8y9kO7HICQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Bh72cpgNens=:VG8JbNwKuna94TQTEd9EQ0
 UAHlkRh5Fj+mEyopxqli3Jlu9571X1osiIRjhWQCH2OmSYkELzhgkEDwaEcT4pzcgQcT8fK34
 IbcHW7mJ22mMDVuG3oE+8ZAaYoAn4IxBtzbDZIuRXvVe3QrNIxI40sCdQjuWDqxg3FV6FBaLH
 p+6Kec08ZRiELDUcIDu72uo6I9+gnyiH65283X/Pui0P3x2TV7ZS2HKJ29fim9RJhVqmjPQDh
 j80+2+U8MlXxDZjesekBpV09rGh00vP1B5L8rquerul1ATAPATpX3PrzKtrnes8tUm8Rj3395
 nQHz0blvDz2ik4dGSLfsFqxvQaoKmO8K7l1A/ZDhjLjSoXSGXnBYAAmUi+neh0qk9sHeVW36A
 uOFY2rlgk5i+/JuGvZj/PshgYC9fcZcyiLOCSke9tWQvXfD1mn5j1iCiOqov8HjgeBBLhCM8C
 MhjBNtdvrrc6oGWZJU2TPJojVZgNGFwuP3zGNh9V5dgpKD5U/r5QYbd9gvUc/h0a3SmT+xclm
 V+6yv4Q2TmW6K4GAOke5UQCY/PxkkeBwnTp3pE5xS4i0Ym1h/cRC5csi8aBaWtTUIb6sCkmYl
 00dtZsLpWh3TE/bFfw7QhGqUqDQjKB3VQCy1ms/d7aiiMZ+l+a4Aa1onTcNCZyjLkGHpi2bHZ
 5dgETwetp1Qq6zkNHLdcldeDXnoBtUEiXZZmrcupkRL0DHkKgDc9FwMAlOnPVvnCEU+t6SDw5
 wAmcZUQ97dEruSOobi/sYY5/Lj1dZJzK0gqhppxxiY+ZcnhIvZDfu1qYOr+u8Rl0rmU3VyjVH
 zJrp4Hwqiuy7DbDQf2LyqZMwSPsJTwnjv00lQxy1mT+OrRbj5CjeK0c8AG9LxHeNyE1tmbUlD
 XdLiaxWhzXn1XltKz/LM17XSknZqvMRVMVEV40wlwIwuSuDNVCGvq45sfSCdF0ykR8ANfxEAM
 sDQrbXuydF29e0cnt+YWc13T2YXMcj5brvqeQIVtfVVayN30iq1a5psTmNy+D939Je7e7RWwB
 w832VieIgSHbopffrp5ixmq3nnYd5C44FbtqTeMsY5fUC+Kvst5LgxdjujBNymmfHg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 27 Jan 2017, Junio C Hamano wrote:

> The tip of 'pu' (or anything beyond the tip of 'jch') is not always
> expected to pass test or even build, [...]

This makes `pu` a lot less useful than it could be.

And we could easily improve the situation simply by changing the rule ever
so slightly: when a build, or a test, fails in `pu` and there exists a
fix, this fix should go into `pu` ASAP.

As you point out later in your mail, the fixup! or SQUASH! commit is a
very convenient reminder that a particular branch is still "under
construction". That is, changing the rule as I proposed above will not
only help the Continuous Integration [*1*] to avoid reporting duplicates,
it will also help us improve the project faster.

Ciao,
Johannes

Footnote *1*: It appears that there may be the misconception floating
around that Continuous Integration is designed to annoy developers by
pointing out unportable or unbuildable code. Once you realize, though,
that it detects and reports code that is below our existing code's
quality, no doubt you will agree that it is a convenient tool to relieve
reviewers from tedious work that can be done by a machine as well.
