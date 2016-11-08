Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE3622022A
	for <e@80x24.org>; Tue,  8 Nov 2016 03:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752225AbcKHDdG (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 22:33:06 -0500
Received: from mail-yw0-f176.google.com ([209.85.161.176]:35900 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751081AbcKHDdF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 22:33:05 -0500
Received: by mail-yw0-f176.google.com with SMTP id l124so161496160ywb.3
        for <git@vger.kernel.org>; Mon, 07 Nov 2016 19:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lXRPKOSZ0GaZDO9hSZsjLy8Q9dHvr8u1hKPCBg8iwfI=;
        b=STMinILlgUyR7jGbgxTVAuq0XXVab+Gu3y9CXb7AJ9/UTZ2rAyBjIobMXCjdyZFP0L
         sz1owdScpnvlDUdfInVm/fuTXUWpcsOjK7QS8taEAk28ItiKzzjdvxxCQxCoCCi3EB7R
         /IJqZjUPtwM8TkoEfUsy7XxpoxH/3I1K+EjXWZXSuJkOxWdARa1jcznpnSNAElYlrV85
         N4O+sYOxtm0582s5Nd26xD+dZifSlD9I1bXTaSzYjeVDIgO0aSTQSpXIc9OZE3t9g5J5
         GaIu35VkqsAjWDr41qgm/fTvP9sjG2wM0jCqAFGiX1JO6bVrJ1gTXFl5vV5UdO/IqKh4
         KT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lXRPKOSZ0GaZDO9hSZsjLy8Q9dHvr8u1hKPCBg8iwfI=;
        b=iXIuCcJUsQ3TFgv962iDcyKKowfnchG8VrE7KwZLRmmMSut0TuXibqbQ05VsjMI8ip
         b0AOJdMBQzjEfcWfOE6XlfVu7Gxbsn2QLNXoeB7XUv8Yt1EEb/rTtmyCLK/+y+tI+Bhr
         QeGVyu5w07DhX9IIlsNPVfs1JXKD7oaW84cFQSdbOgGXmJ51WGJMSJLH/3+Wtggjqytn
         JQYqL1yFFtgMr/AXuLQtY9elxnUbrnNNWljVIYnSCIOpejboZBglfKaEPeGDfSaqio//
         Gx/3ZPl/+AJim2DL/pyGaNLv5YNLUDadM/u8VebaBMkMTiHncYe07SccrQF7Tg9S+soh
         r7wA==
X-Gm-Message-State: ABUngveEc5m4L3tZUbE2WcTtE2/KhBdU7b4VEcYhAZOPSNo8omhi3419skwxZM9g+CwydZp5JsVUmrbDIDW0dA==
X-Received: by 10.13.234.213 with SMTP id t204mr10386413ywe.204.1478575985007;
 Mon, 07 Nov 2016 19:33:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Mon, 7 Nov 2016 19:32:44 -0800 (PST)
In-Reply-To: <20161107204838.xm463zdimiw7fx77@sigill.intra.peff.net>
References: <1478292933-7873-1-git-send-email-bmwill@google.com>
 <1478547323-47332-1-git-send-email-bmwill@google.com> <20161107202637.ooaddlkfntw37xg3@sigill.intra.peff.net>
 <20161107204028.GC143723@google.com> <20161107204838.xm463zdimiw7fx77@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 7 Nov 2016 19:32:44 -0800
Message-ID: <CA+P7+xohFeWb1hsOg1_T1kWenc=AKrt1TNcx=TrVYQ+w3+c63Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] lib-proto-disable: variable name fix
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>,
        Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, bburky@bburky.com,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 7, 2016 at 12:48 PM, Jeff King <peff@peff.net> wrote:
> It's possible that I'm overly picky about my commit messages, but that
> does not stop me from trying to train an army of picky-commit-message
> clones. :)
>
> -Peff

You're not the only one ;)

Regards,
Jake
