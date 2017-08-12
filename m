Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2EEB20899
	for <e@80x24.org>; Sat, 12 Aug 2017 05:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750860AbdHLFxn (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Aug 2017 01:53:43 -0400
Received: from mout.web.de ([212.227.15.14]:61074 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750793AbdHLFxm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Aug 2017 01:53:42 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LZeou-1dCbvX3V9Q-00lWzd; Sat, 12
 Aug 2017 07:53:35 +0200
Date:   Sat, 12 Aug 2017 07:53:35 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Anthony Sottile <asottile@umich.edu>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: core.autocrlf=true causes `git apply` to fail on patch generated
 with `git diff-index HEAD --patch`
Message-ID: <20170812055335.GB21232@tor.lan>
References: <CA+dzEBmsgUjmf5fUmeiwS=Q81OgpL6K5p=8dBuTjuZ4XE1V5SA@mail.gmail.com>
 <287407ac-b0d0-ef24-4950-0982a2db9bed@web.de>
 <CA+dzEB=3OMw_YM4K_a8dyDG_FwGavU382stXrEOkbYoyM4DSZQ@mail.gmail.com>
 <cceaf377-73e0-e733-20ba-c4e547226382@web.de>
 <xmqq4ltpsn42.fsf@gitster.mtv.corp.google.com>
 <20170812053944.GA21232@tor.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170812053944.GA21232@tor.lan>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:MdmJfm4kVc+CmE/4QOl3mlh60P31mDJi5bcGmhinMIysED8V19t
 uFGriqyCdctUg+LwXtqkkVhzjs6hitfio/YQwGx4eAX5IuPGlNZu69eeg/4dt4wyJFwPPSJ
 bM635aYgWPwrvhYKLcP3UVXcgXf6ZNj/y5ovpSUbigCVzuPCMfwMUXsau3QX66IVbv/jpkD
 jM/IhLxfPqIvbsHLwvq5A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fYxsKjfQWRo=:WBsDzn5h2e37BMtRSnmmoa
 zaDt1CfUyLx86f0lBjIA1eM5Qvsi3TbED8EWwRG97v/zFtTWoebcxALWt2KKN0fouOZqvrDlX
 cUOm/4Es7UGBScB74wOT+Vo11z4JYQPTx9Uhwn2Xn/VxoP9JrutQoFTGZ5WxUxjiLxCuTyou7
 KneES17Hb8J7Oq6tqa+1ljUzmj+fEGgFTxdYSEpiyLUEWNv2t6YG6o9zuDGdqzf7x6jVWEODl
 zuu/ouT6i3CD5XuqqGAM58cpsFYEbIMGpP0YU7b7+0Ta6mm13cWuGBw94WAZGU2lCjUTcEwc/
 2rY8gslNxv/tINFj9r2z04dqgzZKM7AMLrP610jl16ARDieyGPxMpGfdcvTU+jBj4GVjwZphT
 QM65uqO78tuF0Xy8hU6raxDZOof0kyNJ6jmGfqv4iN2J8iKqU/wbQd/7dPQRifdK3y60VYJTC
 j0/xrLJO2d4X3oSnNgmvb0rw6tRWu5LCmmIIv64BOzIGZiB/qCftq6yRyjfHizYDnUDuOmKXi
 1F3CbzOZKFZAWeMpqHUQZDcWWbkSlIEmMlGqVAkrwT1c6pM3+ANMoTHsEiYkdZlromjJYHnrt
 6cDUvSsjmHNwGmoDUSDCBUeO9sA8D7Z098f1c/48h9bdaffwihUjMAyjsd8NYV8+PIKRcTPFy
 5OHz5K8wQrJ2ry7GuQPTZ3xW9Vo1UMz5PHmTSpwJi9tjIpnbmufYb3+Yqe4y0HL6ZYnC7JI/D
 SY6uMBIbBBQiwwHieo3i6mqK6SRRMB6/fI2KyQyXlSxWmj7vD8Sf0C82lvzSNw/3uGYbP2AgW
 jqLE8XJFXHzyEUNwrLNuB8hjQ58YQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


>I left it unsaid by mistake, but I think the right thing to use as
>the "previous" to take hint from in the context of "git apply" is
>what is in the working tree, i.e. the result of applying patch in
>step (4) to create a file F in the sample scenario.

>While applying patch in step (5), convert_to_git() should "imagine"
>adding the file F currently in the working tree (i.e. the result of
>step (4)) to the index---if the resulting object in the index would
>have CR, then the safe CRLF logic should refrain from doing CRLF->LF
>conversion.  And it should do so without actually adding neither the
>preimage or the postimage to the index, of course.

(Sorry for the test mail)

What I wanted to say is that this long explanation convinced me to write
a patch and send it out the next days,

>When we are doing "git apply --index", then we _require_ that the
>indexed contents and what is in the working tree matches before
>applying the patch, so it is perfectly fine to let convert_to_git()
>to look at the current index---that is the "previous" one we want to
>take hint from while using the safe CRLF logic.
