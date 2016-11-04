Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1408A2022D
	for <e@80x24.org>; Fri,  4 Nov 2016 23:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751441AbcKDXh4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 19:37:56 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:35225 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750833AbcKDXh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 19:37:56 -0400
Received: by mail-yw0-f182.google.com with SMTP id i145so6024584ywg.2
        for <git@vger.kernel.org>; Fri, 04 Nov 2016 16:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DW4rpI4U2UGwoIj7FVzgYCTbov7WW6pF21DMRJXoLHk=;
        b=XX2zGe58dUoLjCceXCweU/kAR9+InkHwPnEzMSBu0kVUQhI8i5XDja9ixp/Hk5Y6w0
         FClSKcMnQVflwXq7laNVrLYUxUAD/mwAJliqCAY4rYhNhC4LhZepVJx6lA5QK8GiEZbG
         hFNrsTbbqOgcnYyoTHHwhuzCX3gHAm7/wL9WpjUiYUCrj4f21j8/FhZOPt+N7u/ky1ky
         jheT/SVsrMDcJXjLgBGAjZf9/BnsD7D+XRzxSVuCSN83wpPyFxYzFiLN4LxQa34tGsc/
         p8nzviiCi6+O/BLe4DpbbcFQHGIV5HpBDYnfQiRQmcgrh4xeEK+qALsd8ozpY/DvwPWS
         kErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DW4rpI4U2UGwoIj7FVzgYCTbov7WW6pF21DMRJXoLHk=;
        b=FZ/61kNzAjBaC4mZrKtUxH8WNonhIHx3YOAy7KvzfA0bCraIlMYhPj4UuKs6NVX3dU
         QQDNZgH9KCvA56K4jOGSzlc1MdMG9DuSitLn48e3IhuccsW/oTrGgRwUT3pIVxMpo+Rn
         +MRNKnyhhF8wok5lsCLRadMcTmUN+Tbe8ZiR52P5jnoiDqkPoUplMs0RtceDa70f6Y0M
         i+7fY6DLUmOe3lZKxj+u5fBxFkpUkaXY2ozKnsVdo2M0GA7A+lzPKZtzKI6bsdeRLaGJ
         RtTI3MmlDlpDvJn4pm7MBPbF3OiGC0O7hPce7/YNUWxKpW8400xSky4CRfPUnFsHgHLg
         omRA==
X-Gm-Message-State: ABUngvcaFVlcyqPecB6qZPqtpNhQ1JDEXD8QBrLi1OjcAjwIdAMrMoY9SW0mF2PHVY4YyyXMMFkbX5aLwJGSVg==
X-Received: by 10.13.244.69 with SMTP id d66mr6603782ywf.318.1478302675228;
 Fri, 04 Nov 2016 16:37:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Fri, 4 Nov 2016 16:37:34 -0700 (PDT)
In-Reply-To: <20161104215538.xmpth6qfuou6nde6@x>
References: <xmqqa8dfdt6y.fsf@gitster.mtv.corp.google.com> <CA+P7+xq0LLFBJRNNvCMQ4QR7XBg9H7NSsifiqOYqr+PUBqYRGQ@mail.gmail.com>
 <20161104194907.3yxu2rkayfyic4dr@sigill.intra.peff.net> <20161104215538.xmpth6qfuou6nde6@x>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 4 Nov 2016 16:37:34 -0700
Message-ID: <CA+P7+xoKORo6hC2n-E-gHG2OYg3h-m3ZnUQbdopS7S3-5AWoPQ@mail.gmail.com>
Subject: Re: Regarding "git log" on "git series" metadata
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 4, 2016 at 2:55 PM, Josh Triplett <josh@joshtriplett.org> wrote:
> That said, I'd *love* to have gitrefs available, for a wide variety of
> applications, and I can see an argument for introducing them and waiting
> a few years for them to become universally available, similar to the
> process gitlinks went through.
>
> But I'd also love to have a backward-compatible solution.
>
> - Josh Triplett

I think that you won't really find a backwards compatible solution
other than something like automatically generating refs for each point
of history. I know that gerrit does something like this by storing
each version in "refs/changes/id/version" or something along those
lines. I think this might actually be cleaner than your parent links
hack, and could be used as a fallback for when gitrefs don't work,
though you'd have to code exactly how to tell what to push to a
repository when pushing a series?

Thanks,
Jake
