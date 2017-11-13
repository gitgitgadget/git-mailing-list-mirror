Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCBFE1F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 18:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754484AbdKMS4N (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 13:56:13 -0500
Received: from mail-qt0-f169.google.com ([209.85.216.169]:47905 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754179AbdKMS4M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 13:56:12 -0500
Received: by mail-qt0-f169.google.com with SMTP id y5so4564793qtk.4
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 10:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/FzlhrChxwsmZcAh5qS08j4OPzW4YGuf73OH70T6UDI=;
        b=F3lMkhL85dKfzcz5MNkZIDVKfxze3wMwrmnfvPUJlGpyzgakrzxPQCAyjq7RBaGKLZ
         D4o1W0Pztw6ms9Ka/gFgSqkORQ3IiuxiPqNAlhdk9H8mn9aCuercvqEWEXK9gVzSRAj6
         9ehPL/R0nC6NWbWX9lNsROKgY8Bx/AwVwX4jB6p1Biy0qd7pXIA0v1wyLI9BZKqYRfD3
         N1+BnMSThR8xL5F7ncB774ulfcWz/W1OrP6JGTY1LqAr3b/ZYsg+ORpwqCSJ9Vw26XUr
         kvfQB9XiropmnT7PLREdFKN7xb6uo3WSWfVJOAJx3nt3ZZqwpOwXZVEdhTythm8RoJNL
         Wmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/FzlhrChxwsmZcAh5qS08j4OPzW4YGuf73OH70T6UDI=;
        b=jjzUjvi61Xmk5YEoxtoEkkZMAEBSdTnttdvNlgOw9t5WeAbiurcbJqdxGkFxNq2HmG
         JKYu/momb/2HtBG6qSTpr+dC3/wmVAtGi8zXwCioZZPh8OOcaWZBLC3G7em+VbeS9N90
         eE5Hmq+LLg9wxILRplbuF76tvNLXSocQrP3e4ldiBnRzh3+4KzM8oao7BcBSQn27oFtp
         P0lo+E70sPMDmNb0hkVVI+PRz0CgJvEPlEaLcIuMITyxxsBH2Sv+3jrOwE/jn1GENv8X
         nVrotyvuxak/bmfCrEaPrxIy9220ouyZaTpEOdC2oy2AlAOC1Pm736Vdyz45E2yVQPqq
         YodQ==
X-Gm-Message-State: AJaThX4mmKQnrOT+Izv6OKQyHELUXjUfs5f/4sRI43i+NahqpdhcW0uJ
        RrnPMAY03RouZRiMAeDFBXMo+AD30KVriGFaDFgKyUJiRHg=
X-Google-Smtp-Source: AGs4zMbXATpq4iSMQ/7nSDeqey8dxliu8d8FcViIgO9fCJvXlaaFNcUlNorR04EOqDbFLDFB6tAdJ4ccGbaTnrP0JjE=
X-Received: by 10.200.55.75 with SMTP id p11mr15690434qtb.298.1510599372092;
 Mon, 13 Nov 2017 10:56:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 13 Nov 2017 10:56:11 -0800 (PST)
In-Reply-To: <230e768792941861fca03ec4f3422541@unimetic.com>
References: <230e768792941861fca03ec4f3422541@unimetic.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Nov 2017 10:56:11 -0800
Message-ID: <CAGZ79kY5a9-wqk80Ogc_5jkzG=+4hi5030NABWx6=o55y0ZJsg@mail.gmail.com>
Subject: Re:
To:     hsed@unimetic.com
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To subscribe to the git mailing list, send the email to
majordomo@vger.kernel.org, not the mailing list itself.

On Sat, Nov 11, 2017 at 6:21 PM,  <hsed@unimetic.com> wrote:
> subscribe git
