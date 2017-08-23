Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC3DE1F4DD
	for <e@80x24.org>; Wed, 23 Aug 2017 21:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751003AbdHWViL (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 17:38:11 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:36277 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750715AbdHWViK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 17:38:10 -0400
Received: by mail-wr0-f172.google.com with SMTP id f8so4285648wrf.3
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 14:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qJPEi9gik/0yWOttuq5hnoHkQ13PGahdBqjAUWQB7t0=;
        b=sE1uC7weakBhmoeojjikRzaofNbIcpHShENFNyPxktzTAJqEFZ5SR1KsGkON7eFTjI
         zeH9Gla2wKK7Jhb5qoIJCnXdqd49djuGt0zSkceG9uGAd8hCXF+pNnXRMbluIbZzIPnj
         nhY00Ze7dKhPMp6xaBZ3kOoGJXL8Jb9mTKu/r8rOXCdpZcE0ZmGPO/WSdNOseYlH2/Hx
         hOz2RyBK1IBP5GmHeVPdrbZjvTrux7B/MdUaa779DzOwBgdzWT+kviF3VPKo0eF2Kku6
         +Py/6XTBmxdpwxXOpk/5QnsRTW89jL4oK0s7N3Qaa2NLEt2WlBfxaTFd7w/aKXIdpmf/
         E70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qJPEi9gik/0yWOttuq5hnoHkQ13PGahdBqjAUWQB7t0=;
        b=MkMplflFEF5xxVrMZZB8qBEFjRoz9J8u6uKFMd5+dGk5HNOow1UimSkzEQWwgdwFF8
         +Gb8KXKv1Krn+fSOJFvEdgBSQf3dHwp7s9rDBO5yDpkhWpt5dfesHSag/5z+6Iua0jWQ
         8Z8tzTYLf8zIJDzuB3WvzFEHQNJ1W8pbCZ7zlRYepJiDd5FYX04vzjJq2AWUX5davN8X
         EuI2d9s/bq5hfNCNJXYaUpNNwyy83zVCjMZAFEnbL4CA5oNdgt1x2XPaceqhuOJpgzJN
         17weXnKr0Bo9V6x6NN5j0lyPZtjlUkCKuqcrwuEeeN6t23+P5Ho6UfQP6BtZCHPSuRrZ
         KMhA==
X-Gm-Message-State: AHYfb5gm4xxId8I0oOyxwHKdQkww8OnGGHIbOg/1zT07K1pI0VvIbEwT
        AxE8Qe/cEXiWgiX6
X-Received: by 10.223.177.25 with SMTP id l25mr2189153wra.14.1503524289271;
        Wed, 23 Aug 2017 14:38:09 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB54ED.dip0.t-ipconnect.de. [93.219.84.237])
        by smtp.gmail.com with ESMTPSA id l131sm3655657wmb.5.2017.08.23.14.38.07
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Aug 2017 14:38:07 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: What's cooking in git.git (Aug 2017, #05; Tue, 22)
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqq4lsz2x6r.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 23 Aug 2017 23:38:06 +0200
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <7D99B245-4D22-4C9C-9C43-C8B8656F8E6D@gmail.com>
References: <xmqq4lsz2x6r.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 22 Aug 2017, at 21:56, Junio C Hamano <gitster@pobox.com> wrote:

> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
> 
> The second batch of topics are in.  This cycle is going a bit slower
> than the previous one (as of mid-week #3 of this cycle, we have
> about 200 patches on 'master' since v2.14, compared to about 300
> patches in the cycle towards v2.14 at a similar point in the cycle),
> but hopefully we can catch up eventually.  
> 
> I am planning to be offline most of the next week, by the way.
> 
> You can find the changes described here in the integration branches
> of the repositories listed at
> 
>    http://git-blame.blogspot.com/p/git-public-repositories.html
> 
> --------------------------------------------------
> [Graduated to "master"]
> 

Hi Junio,

just in case this got lost: I posted a patch with an improvement to 
2841e8f ("convert: add "status=delayed" to filter process protocol", 
2017-06-30) which was merged to master in the beginning of 2.15.

https://public-inbox.org/git/20170820154720.32259-1-larsxschneider@gmail.com/

Thanks,
Lars
