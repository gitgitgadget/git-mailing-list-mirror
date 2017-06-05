Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 167E41F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 21:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751225AbdFEVFr (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 17:05:47 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:36102 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbdFEVFq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 17:05:46 -0400
Received: by mail-it0-f48.google.com with SMTP id m47so75105351iti.1
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 14:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/dInB2ko8WcvPRiMRPMbk1eC/en+QdhxOpsjO+4LhYA=;
        b=q8ohxsiCnF9FVfJzF0hU8nruNKdUhdbq5pgIrQZ9sgZCFpMcZhIarMUzPDspEMEooT
         V6wWlPE83SaSIF8tvOrr4lN0a5RP5T3cD3SshYmSdxeMBFwKQOfdv7VYeSJChUYtWOWx
         0sVGNS7fi771zB/SDOyqu5XW1aS1vWq6UCSrLrxmfMI9GJvn3Ngr4IWE7ISe5lNcAFzd
         MpCiRtHWcoo3eF4AkatI+j4pnQs7g4ayBIE9lHeP3gxX30JUkdpRtlc3KlXtFRmEVN0J
         DRMxIrZL+yNXebT2e9ec8EbGJci/WhgyR+KttArNaOgmmXJ4spe8z+V5I5Yr/xGc/P49
         ncsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/dInB2ko8WcvPRiMRPMbk1eC/en+QdhxOpsjO+4LhYA=;
        b=uj8ZrW2pFd1bptTmXp/RvBmVUgoWRQTGhLAcaqojEwOhepmk9wpiOIqZNzLhT+/Arb
         bXDM0P3N9dTJTuXBMfWqnP7pI0wjsAgose6E50MIesnyd+fh1Mb0DlgcmE20e0hbldQz
         6VTXUv6fMGQaHqNZGi4EKTKZafeTqPbxNdTLBwz9yc1RA6dnWP9ff7Gux3Midnoa/SC8
         KFRI2u4YtIzw/3jGjie2usgCMYyIghdj35BvfsfJIvvNFRDaFkbhorWJTCYjL9VHlXEc
         QiSmM0uoyMHzzSN4PMKA/CAB1Uefmm1XDNRVHS3w2igTQ+x2Xf9JtvdWtlp6V1cU5RaR
         K36Q==
X-Gm-Message-State: AODbwcBuYUMBjoueRWUYeYU8uurQAXiBXeey3qNDs3paUJHSPzhPF5as
        gX3KdkJbF1x8f05xvrOn/yyOUClCVMTvr/A=
X-Received: by 10.107.173.9 with SMTP id w9mr3068993ioe.80.1496696745262; Mon,
 05 Jun 2017 14:05:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Mon, 5 Jun 2017 14:05:24 -0700 (PDT)
In-Reply-To: <20170605203409.GB25777@dinwoodie.org>
References: <20170605203409.GB25777@dinwoodie.org>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 5 Jun 2017 23:05:24 +0200
Message-ID: <CACBZZX6vOr+ZjUaAf8i1xdjEFfY_Exj+_Xn2-1u0RcWoLy+X1g@mail.gmail.com>
Subject: Re: Git v2.13.1 SHA1 very broken
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 5, 2017 at 10:34 PM, Adam Dinwoodie <adam@dinwoodie.org> wrote:
> I'm trying to compile Git v2.13.1 to release for Cygwin, but it appears
> a010391 ("sha1dc: update from upstream", 2017-05-20) is breaking a very
> significant number of test cases in both 32-bit and 64-bit Cygwin
> builds.
>
> The first failure is t0000.46 "validate object ID of a known tree"; output with
> -x and -v is below, although it's not very interesting:
>
>     expecting success:
>             test "$tree" = 7bb943559a305bdd6bdee2cef6e5df2413c3d30a
>
>     ++ test ceb282701536fe61bea01075664405caa7d6343f = 7bb943559a305bdd6bdee2cef6e5df2413c3d30a
>     + test_eval_ret_=1
>     + want_trace
>     + test t = t
>     + test t = t
>     + set +x
>     error: last command exited with $?=1
>     not ok 46 - validate object ID of a known tree
>     #
>     #               test "$tree" = 7bb943559a305bdd6bdee2cef6e5df2413c3d30a
>     #
>
> I have no idea where to even begin debugging this, but I'm happy to take
> pointers / try things out on my box.

That looks scary, can you please comment out this:

    #define SHA1DC_ALLOW_UNALIGNED_ACCESS

In sha1dc/sha1.c and see if that helps, alternatively comment out the
ifdefs guarded by "#ifdef _MSC_VER" calls in sha1dc/sha1.c

The functional differences between 2.13.0 and 2.13.1 on that platform
should be none aside from possibly those changes, unless I've missed
something.
