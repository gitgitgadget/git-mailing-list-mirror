Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 953D61F463
	for <e@80x24.org>; Thu, 19 Sep 2019 21:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403858AbfISVjt (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 17:39:49 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33830 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390087AbfISVjs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 17:39:48 -0400
Received: by mail-qt1-f196.google.com with SMTP id 3so3759548qta.1
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 14:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2CLMk21rjS+lCKE+FOq3LOTz6PgjQJh+fzcG4QcG7N0=;
        b=dTEcGqNVx+sfkG/xVk4+5+VY8uoPlnhwFDDRkqJ+NYZsZzI6O7X5IegMADcBt5NQB2
         b+XkSg3cFmysDOLdj+b1GuXhAWkTGWRWp69mo6h168E926aIzPz5qPc1MBPLVpDpHDQe
         pZ1tL8apDnmbqyeon+n1mNuW4ZAumccjBh3sqkba819zCRu7yoHxRV0bFkk+50HA71qh
         w7rQkqybXfuOO9kXzdlresPu6qTIoFBPE+liPbKFJYj6QSMQnXSiL5kAhFHHVvyg6acE
         oniKdQRyL2dyrArKVbDgOHpC8j7R/4C/dFk/ewW0p70xjJKeyj86yaJ9v/j+Ed6SYRmU
         YdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2CLMk21rjS+lCKE+FOq3LOTz6PgjQJh+fzcG4QcG7N0=;
        b=GMUxJZKh4ITpc3lx6jDtHmzc+FR68LY49GYyjTuGsK6+kHrIcuBF+jikglmPiTIWQV
         D66Nb6v+vj/mcKa2IcxVLVxW0p5M22GTQJ4undLbfP8vWJtrRgUgHQOT30qvprwfM9T0
         hFQpMLIIEVVTVza2KeqLSzo2t4ZqDWiC+CQMUjlc4i9P+ZB0BgAGpGz89DcrWUZ2sEBs
         ZqXDrYsXimbSFwQWQIbXKeWo97JPpce45ZMphLEeXmD9RaqEM5UD7pPeMNBm0RQ4tGoh
         82+T5XLA7pNiG2RGAToDco3sZRBj7pxmco+n38q+5AyHqUhn9c2RWvg5EofrSlRD4kDt
         vPxA==
X-Gm-Message-State: APjAAAXKg1KGGHo9GuLE1xypXe4fBfyG5/31KyoaKA0Vpf45wqiJRprx
        hWELIk+CrLIQRlQxJn0EHANGAGksPb4=
X-Google-Smtp-Source: APXvYqyQgAb1wYNR+QJbMjyhRGE4QEsxNrp/pH8yUgh3K9IxGiwjgzmXOZkR47DiYuWFPImC61JcvQ==
X-Received: by 2002:aed:2381:: with SMTP id j1mr5697321qtc.373.1568929186421;
        Thu, 19 Sep 2019 14:39:46 -0700 (PDT)
Received: from localhost (adamsmorganips06.a.subnet.rcn.com. [66.44.93.133])
        by smtp.gmail.com with ESMTPSA id x55sm6570095qta.74.2019.09.19.14.39.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Sep 2019 14:39:45 -0700 (PDT)
Date:   Thu, 19 Sep 2019 22:39:44 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Sep 2019, #02; Wed, 18)
Message-ID: <20190919213944.GA29614@cat>
References: <xmqqy2yl44lw.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy2yl44lw.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/18, Junio C Hamano wrote:
> * tg/stash-refresh-index (2019-09-05) 3 commits
>  - stash: make sure to write refreshed cache
>  - merge: use refresh_and_write_cache
>  - factor out refresh_and_write_cache function
> 
>  "git stash" learned to write refreshed index back to disk.
> 
>  Needs coordination with js/builtin-add-i topic, as they both wants
>  the same kind of enhancement to the same API function.

I have sent an updated version of this, that integrates the changes
the js/builtin-add-i topic needs in [*1*].  I think it would be ok to
pick up that version and keep js/builtin-add-i out of pu until it's
rebased on top of that.

Dscho: to help reduce the amount of work you (and to double check that
my series works well with the builtin-add-i series) I have rebased
js/builtin-add-i on top of my series, and pushed the result to
https://github.com/tgummerer/git js/builtin-add-i.  Feel free to use
that if it helps :)

*1*: https://public-inbox.org/git/20190911182027.41284-1-t.gummerer@gmail.com/.
