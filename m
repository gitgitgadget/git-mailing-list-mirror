Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 645311F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 19:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938503AbcIVTBv (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 15:01:51 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:38178 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965039AbcIVTBs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 15:01:48 -0400
Received: by mail-it0-f48.google.com with SMTP id n143so91149155ita.1
        for <git@vger.kernel.org>; Thu, 22 Sep 2016 12:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CDCVhnxnSeFNRS58h9SzmdvuWmtgBElE8L8qZ9Tfu64=;
        b=U7QiOpnwuxkiWJBHJFgHrStBcELxvwLQktcpqprupVc/aLR30H7OFgv4tC9tP6d3GI
         asnGbJTXucnzuBEIcOXnzcfSg+mooLdLqA2/vw/MNkzUgFdBgq1iskBkxFzRWH21zHgE
         t8Ka5IN0o9pl8N4sLN0QOUUQpxQ5OF+vswhIDMn6HZazjIk+/9LGeUTuIVFNIbvWN6o9
         7gZNiQkHO4y8JNvO1/hboYuyaAga9Jq0vk+5JeZWyRjzFwNHDVHQ0vdTdhvWTjtwjp9I
         +q4LRM4hdSrpVZ5pmnF44iqkQvT9CAWsOPI+hID9T+0RcC/ll3bnNAOdkKyjVPQeIzca
         5ivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CDCVhnxnSeFNRS58h9SzmdvuWmtgBElE8L8qZ9Tfu64=;
        b=JCMHFzzWlT+nEWCIFOSxu42MUxTVRCF9jMiHfTpWNR8jEiemMYcPm/pn4/vIv4pusR
         DEaLnIh4ibWMdV1NgYUkrbPlWdddzqw2ykuWLSe3QOfdgxzW8X55A+AyDhdsOaNWOnT6
         PPUIqV2ffA7Q9s9gYZbVDrq/5ROjX09o6uPPmfnjSTE2jUHoeRNkv+r20en82KWAc5u0
         yb88stYvIZ0ZvRjP536Q4LnQLQIoHqLxeizZC5kWyqTIHpdQ1F2EV/NWWL4uh3N2Ohs3
         0ElwSbSD6IRV4s51zX+z+Y7tm7GZM5t7u9iz/XBhN7IyHOV4B6uqjjcu1muM94GeHu5J
         1TSg==
X-Gm-Message-State: AE9vXwNzGanJ2KGML00EaR9p+YBq1emiQItpizaMgHtZeDEd9DSFUpbBstJw4hTfJ+aghrQrgkPSWvYzi0qnRviZ
X-Received: by 10.36.134.194 with SMTP id u185mr4792069itd.23.1474570906619;
 Thu, 22 Sep 2016 12:01:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Thu, 22 Sep 2016 12:01:46 -0700 (PDT)
In-Reply-To: <20160922185317.349-1-santiago@nyu.edu>
References: <20160922185317.349-1-santiago@nyu.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 22 Sep 2016 12:01:46 -0700
Message-ID: <CAGZ79kZ+eETHm2xuorRqP9OPKdETZSOuuY+SWPR_=J6MwJedRg@mail.gmail.com>
Subject: Re: [RFC/PATCH 0/6] Add --format to tag verification
To:     Santiago Torres <santiago@nyu.edu>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>, walters@verbum.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 22, 2016 at 11:53 AM,  <santiago@nyu.edu> wrote:

>
> P.S. Gmane seems to be broken for git after it was rebooted. Should we ping
> them about it?

I think most of the git developers have moved on and reference emails by
message id. An archive of all messages of the mailing list is found at

    public-inbox.org/git/

(You can git-clone it to have a distributed copy of the whole archive)

    public-inbox.org/git/<message-id>/
    public-inbox.org/git/<message-id>/raw

is a good point to link to.

However, feel free to ping gmane. :)

Thanks,
Stefan
