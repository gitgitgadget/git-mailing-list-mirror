Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2451E1F576
	for <e@80x24.org>; Tue,  6 Mar 2018 08:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753236AbeCFIea (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 03:34:30 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:47101 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753075AbeCFIe3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 03:34:29 -0500
Received: by mail-io0-f176.google.com with SMTP id p78so21151415iod.13
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 00:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UraLVB0dKSiHfhCVLfkPY3Yyy0ntuSFRHnZ4/EklUeI=;
        b=MXHDHG4qKiPZCjJMxF6Tquu7sPETPDhrIXYZz5Pa/kN2teWWcmgOLGWwI/VQ/TnhF9
         VYsc2UMOmhnL328GBpup8wKQs3sWISAazGSo806zYlwCsfUlexjD2qIaSSj+cwy7Q9wE
         edhReZ/RS0MoKPkzMAePZay4+pqJiea984wmoESvkevAJKiZYPTAoPdtTMax1H3xnc4N
         kfOtyjIIXkrHU1NkIYXbEbXHeQH7c/uhGE9bsXK+tVo3tDyS+msWEAMMUiop/cVZ/5Oi
         OlYFgN6BeFt3+O4HRbms2erZEwd2//zma/XH1VUgyvocU2/VAY7KSBC94wh22QFR6fVL
         eXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UraLVB0dKSiHfhCVLfkPY3Yyy0ntuSFRHnZ4/EklUeI=;
        b=RM7s6fbOUf+0bHCw2TC8DzZNDwfcpwisnSGA7N4RB/iJVwmWPt00Z/BeO00o8EZwCz
         bsXVlMMuaWTuCMN1unwlcCNaSOIm9SGbem6hiV2wgTiPKbHL+V2qElKtjDtoxmh9tFPu
         +VCoMmhbSvhghMkIFE1j7pZO/AD/HYF/2D1znKoA69wK74McWTksbzyhA5Rjnm84qA35
         jC+7g1RNhk1xXm7McNt55MXhBfcK7CTBXd0km2jvCL/LMhiQc+h87uJkkifMdiP5GSB4
         fMT4ix3chrbMtzqAG1zq5ctsQ5p5Gc/INPKPcd6sd5qmGFXLOrws6m71hNaBct0Jp89R
         chbg==
X-Gm-Message-State: AElRT7E++cfRvxv+jxtCCaUa/f9A+NSaQPcrqWJH8EJs5fU5DT+vnxOR
        kLagPyrxsjOm87xhQwfh4hX+GnGueBRj86OgJE6YUg==
X-Google-Smtp-Source: AG47ELs1yg+sZXwzJcFsgWAo1kCEuUhWS2iaUJSk5vTFlkBVPI55nSo1QfRNZmEp3uOfnB3De2RRN8YDZynlg0aiuxc=
X-Received: by 10.107.97.21 with SMTP id v21mr20082117iob.22.1520325269358;
 Tue, 06 Mar 2018 00:34:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.63.6 with HTTP; Tue, 6 Mar 2018 00:34:28 -0800 (PST)
In-Reply-To: <xmqqpo4i6lj0.fsf@gitster-ct.c.googlers.com>
References: <20180305200400.3769-1-sidm1999@gmail.com> <xmqqpo4i6lj0.fsf@gitster-ct.c.googlers.com>
From:   Siddhartha Mishra <sidm1999@gmail.com>
Date:   Tue, 6 Mar 2018 14:04:28 +0530
Message-ID: <CAMOtk6BafDOX6PkOs=KVPp5rf1wF3Zq9ZWMAiKgw+EN2KTsndg@mail.gmail.com>
Subject: Re: [GSoC] [PATCH] travis-ci: added clang static analysis
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 6, 2018 at 6:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
> SiddharthaMishra <sidm1999@gmail.com> writes:
>
>> Added a job to run clang static code analysis on the master and maint branch
>>
>> Signed-off-by: SiddharthaMishra <sidm1999@gmail.com>
>> ---
>
> Why on 'master' and 'maint' and not others?  Quite frankly, I find
> this choice of branches rather odd, as these two branches are not
> where the real development happens.  If we do not want to increase
> the number of jobs and limit the test only to a single branch, I
> would probably pick 'next', and if we can afford two, probably
> 'pu' and 'next'.

I might have been misinterpreting it, but I did so because that's what
it said in the microproject description. Thinking about it, I guess it
does makes more sense to work on the other two branches instead. Are
there any other glaring issues you see in the code?
