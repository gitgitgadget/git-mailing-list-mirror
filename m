Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50D9B1F404
	for <e@80x24.org>; Fri,  5 Jan 2018 05:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbeAEFMl (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 00:12:41 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:45291 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751065AbeAEFMk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 00:12:40 -0500
Received: by mail-wm0-f54.google.com with SMTP id 9so384564wme.4
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 21:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shabtay.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vesxsqbir+sRaCSPUUfRukl9bkthp7CZ0mydugZ+qlI=;
        b=ZvhxrJAcotBNRO72pT44ugiNaE8JzsY9Tsdjo3AtzAmOEELrYlj7Rf9nSb32AQrHcj
         IIP115VopsklO09Y/Fit+GA5eOPQD7Hr+HMY2lzQF6mIDLCRNTzd0RfxQmoOgjmRzDDH
         5mdkFjdjJGjDl0KMMsvhTNCZR3K/ojBmCUrJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vesxsqbir+sRaCSPUUfRukl9bkthp7CZ0mydugZ+qlI=;
        b=giF80cm2+qvOXzjWAFkqulywe/u7j1skQs4c4ISIOwJIJmeDeyaPMFrwy/jnb7yIk3
         knU5Jy0PAhLcNwqBvfkDYA5RPJaFgcmuqK5+xmilA/sK8YNqLxUzhBLCYTUHQcv998xg
         nMYfCxjeCHa9ZPWeo5N2D30xYx7hgZwbVIsRUmFatrT+GscDs+Ign5YiJFRNeQvKncFm
         6aD/saz70DWdXU2O4d55Jwhsi2vImG+BZZOis8WqdxQGpLmEN1yurncE16Mm7EkKzB8j
         2rAZ7eIIP4GUT6xABU+UTpF+qdMxD3yPYUIjrOiOz4d0+EtApToMZT3piKQgqkrYCalU
         wnPA==
X-Gm-Message-State: AKGB3mIVSbpuFEpDapLgRxEsbVAMFXMfNZttSjpsmxHAuuUIUTJQZnol
        tC+WgumUu5iURMPHK0E6vvVmmRgRDhjQYBlGT+7nMw==
X-Google-Smtp-Source: ACJfBovNDjsKCq8Z9cj3C0IjRyhHZDzXFEf4+Mv92yNcVmRyLU+oZkPQ4v78lM75sKi1G7xLXQLKr+NjVpFGVPXf9b4=
X-Received: by 10.80.204.212 with SMTP id b20mr2499170edj.201.1515129159070;
 Thu, 04 Jan 2018 21:12:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.170.203 with HTTP; Thu, 4 Jan 2018 21:11:58 -0800 (PST)
In-Reply-To: <alpine.DEB.2.21.1.1801050019250.32@MININT-6BKU6QN.europe.corp.microsoft.com>
References: <CAK2k7nSsygwRj_Hhrz7-qXZ8UBB=O+deOeC2FFTkrGmWSUpKqA@mail.gmail.com>
 <20180103222821.GA32287@sigill.intra.peff.net> <CAK2k7nRdk5qBp6Xzud-GS7YeSpchrQoOdqRd-3uXVeWZ1xsnVg@mail.gmail.com>
 <alpine.DEB.2.21.1.1801050019250.32@MININT-6BKU6QN.europe.corp.microsoft.com>
From:   Isaac Shabtay <isaac@shabtay.com>
Date:   Thu, 4 Jan 2018 21:11:58 -0800
Message-ID: <CAK2k7nTRAqQKFGi0OfVgub3vWZAkdML5p786L7UyhVDFtsk7Xg@mail.gmail.com>
Subject: Re: Bug report: git clone with dest
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Johannes, Jeff,

I cloned git's codebase, applied the four patches on master, built and
tested on Ubuntu Trusty. (After verifying that master indeed exhibits
this behaviour on Linux as well. Just checking).
Seems to work fine.
I also looked at the code. Most of the patched lines relate to tests,
and the one for clone.c seems reasonable to me. Added tests seem to
have very good coverage too.

I qualify everything I had written above by saying that it's my first
time ever looking at Git's source code.

On 4 January 2018 at 15:20, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Isaac,
>
> On Wed, 3 Jan 2018, Isaac Shabtay wrote:
>
>> Indeed interesting... this one's for the books...
>> Thanks for the patches. Any idea when these are going to make it to
>> the official Git client builds? (specifically the Windows one)
>
> If you help them getting reviewed, tested, and validated, I could be
> talked into taking them into Git for Windows early so that they'll be in
> Git for Windows v2.16.0. It will require your effort, though.
>
> Ciao,
> Johannes
