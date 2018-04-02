Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D414B1F404
	for <e@80x24.org>; Mon,  2 Apr 2018 20:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756757AbeDBUBu (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 16:01:50 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34421 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756562AbeDBUBs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 16:01:48 -0400
Received: by mail-yw0-f194.google.com with SMTP id e17so5380699ywa.1
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 13:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MkM9szih94qCYID3FI1/wGpnIFfP9Wyvr1W6QYdNAT0=;
        b=pXGkdKX37TpqB22+1Kmm3dVTV3v6SK+6J44/MlIYvH8PC7EuvbWRTpwVQQkH6gqdn/
         4G8FuQc/OwvqZ6QueSoM/kOpjW32+Xr8yzmBmOsW58HyphJSXtbsV/LFBbT0+b+y/Qy2
         zRpzD1ocaiRNgno+BnoUGdVmfJzBiEM03EADT3Vib8bu/nMIiKh7FzZEPt3PATtTPSjK
         Pbb4Iw9nTDSmg7vwCHareIoQMnscbX78NlpRXJ9FRn6+jQDbVVlAI2o05xrU80DbeHn7
         riom/sZoiHDw3mrPywEtDZTxIVRUP8tJu1GiCXZclZGLEvUhXvPwyUQ76ezVRZ9s9Kjp
         AFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MkM9szih94qCYID3FI1/wGpnIFfP9Wyvr1W6QYdNAT0=;
        b=tbzJJLdhw+K0VjwRedAgHUqEYaeRPv4vci3OeftBVG84mhh9Gq/RZxHzVq6lA6i9mB
         jSyYCPxzNqDAd2pWbuMFXx5XYE/jgFQs5vS6h2MxRrNNM2QaKzi1Y3uxf1FY8u4PBuYy
         Uc9tQVZIduliCi06c5scR7YGm7YL9GdWI96MiKob33mUy3VftkEnf2lUGX7BFIH9VMBb
         M7cbL0DsL9MJ3pMcKFjqdNANCPOmbGCaNJqYBKYZl7MCFmj/fxBBM/Rt5e2jvm85VdPM
         QXir1WeY2T7M+VztGvi6q8wQPxXD5iGnUP0fPpREgSZU0je2PZgH/RcFD+DMBxYmDN//
         U8zg==
X-Gm-Message-State: AElRT7FBLq+K1NkCDu7Z5TktQv4vW2XvGii7LzcJCxgLX4UXOhHUo7Ha
        AtiodTUIeM4P6WHEq2iY7eUwNBLERIBDAPqiwNRl7Q==
X-Google-Smtp-Source: AIpwx4+ODr+btGD8h2fUM9/TCSOLFTk7wzfCMYkxBNxTYBXOcpO+3vLbAA0thEXIXLQIhI9GNj9wMiWxvMRX/+Dj1ms=
X-Received: by 10.129.108.67 with SMTP id h64mr6285103ywc.500.1522699307497;
 Mon, 02 Apr 2018 13:01:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Mon, 2 Apr 2018 13:01:46 -0700 (PDT)
In-Reply-To: <014501d3cabc$e5f22370$b1d66a50$@nexbridge.com>
References: <xmqq6059z9kz.fsf@gitster-ct.c.googlers.com> <014501d3cabc$e5f22370$b1d66a50$@nexbridge.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 2 Apr 2018 13:01:46 -0700
Message-ID: <CAGZ79kZOpwQFFf7CM1Msjat_bQXcuPb6eym7z28iU=8UYjfvDg@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.17.0
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 2, 2018 at 12:57 PM, Randall S. Becker
<rsbecker@nexbridge.com> wrote:
> On April 2, 2018 3:34 PM, Junio C Hamano wrote:
>> The latest feature release Git v2.17.0 is now available at the usual places.  It is
>> comprised of 516 non-merge commits since v2.16.0, contributed by 71
>> people, 20 of which are new faces.
>
> Just a heads up. I think this one might have gotten missed at some point a few months back. I think it was submitted back in January. Not sure where it fell off or whether it was just dropped.
>
> diff --git a/transport-helper.c b/transport-helper.c
> index 3f380d87d..5ee7007f6 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -1212,7 +1212,7 @@ static int udt_do_read(struct unidirectional_transfer *t)
>                 return 0;       /* No space for more. */
>
>         transfer_debug("%s is readable", t->src_name);
> -       bytes = read(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
> +       bytes = xread(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
>         if (bytes < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
>                 errno != EINTR) {
>                 error_errno("read(%s) failed", t->src_name);

Patch at https://public-inbox.org/git/010f01d38a9e$a5c4f290$f14ed7b0$@nexbridge.com/
