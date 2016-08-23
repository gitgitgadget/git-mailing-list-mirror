Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5B851FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 22:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758214AbcHWWEv (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 18:04:51 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:35273 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757571AbcHWWEs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 18:04:48 -0400
Received: by mail-yw0-f181.google.com with SMTP id j12so80832793ywb.2
        for <git@vger.kernel.org>; Tue, 23 Aug 2016 15:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=G+HMqLVLzGs1ds0iKNKLKXjrAo/gCeUmOfEKWBsFqYY=;
        b=bxqErkc5FKoEuocmOzMAWD3Nue5rEdL/XPUv9oAdSxGV0cXlm2zLyOtpG1tmE7jlvx
         u1MQXu9MYHz5eUTZi3SSKwFn2CQbXf5sJvlT0uMlX2PnDRqAgG9I1gCw101yhwi4vr4Y
         p2vFj1gxzpknT1z6jA9MCRrBy6IpP7YcJzamopwZNUmP/jHghiuHUtxNX89lvR+O1Egs
         8qb3owbJ8AkgRdlwU64Ajqc4EJk3IzR0G6/yi3htPoZUAKW1HZ1B7cBkiGeL5H2noALW
         obtwZt3/pMD5N1EB4cE21Sc2bdUctlBF7RjSa0QQpCP7ZNlxA/rMYI8rCFdHaUQgmjRM
         kOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=G+HMqLVLzGs1ds0iKNKLKXjrAo/gCeUmOfEKWBsFqYY=;
        b=UnYb0pKL8Tu8ToujD0DTM4W3IRGck4XNJ78NFLU4SENBCamMzZwin05OYZ03bQ9fO9
         21+V8UCdkBJp5ty3ZElXTecrsMJLIk4i2h+/U32sRaaHWHJZY48XF9T17PTeNDRbQlnN
         X7n/GwGyenXUoJ1q1lWcNTLnDKg5dEffRjHGWi2j677PTgLNJ0Nk0Xq26hUpQlHWztmv
         AmxtRO2WO8BZxcf2ZfYvcw5NbF4VqZkJ8v2XxIQlE1L9v1Vvnuox0Q8iSq65c/JJvMBO
         3ema7fJPhz13/0bQghIQNaCMFcm03Qd9/vzJVf5luXR78X4ZiWlyx3J1YVs0T+uriFka
         gIRg==
X-Gm-Message-State: AEkoouvS+UpX67b2GOE1rfnvgIQxYzeQRugmu1cPSvpVIP9t1+2Ttzuzzr8Sp+hGXrFSEylm9+IGDiYP7xvygA==
X-Received: by 10.129.135.2 with SMTP id x2mr23735200ywf.310.1471989887701;
 Tue, 23 Aug 2016 15:04:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.199 with HTTP; Tue, 23 Aug 2016 15:04:27 -0700 (PDT)
In-Reply-To: <20160815215327.15682-2-sbeller@google.com>
References: <20160815215327.15682-1-sbeller@google.com> <20160815215327.15682-2-sbeller@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 23 Aug 2016 15:04:27 -0700
Message-ID: <CA+P7+xrm0ujjydLFzD2joGi=Gbg9ie__21qYrpfHM9g5hqm=EQ@mail.gmail.com>
Subject: Re: [PATCHv5 1/8] t7408: modernize style
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 15, 2016 at 2:53 PM, Stefan Beller <sbeller@google.com> wrote:
> No functional change intended. This commit only changes formatting
> to the style we recently use, e.g. starting the body of a test with a
> single quote on the same line as the header, and then having the test
> indented in the following lines.
>
> Whenever we change directories, we do that in subshells.
>

I looked this over using -w to ignore whitespace changes, and it
appears to have no functional changes. Much cleaner style overall, and
easier to read the new file as it is now. The tests pass fine both
before and after this commit, and I don't see anything that should
functionally change the results.

Thanks,
Jake
