Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C643320279
	for <e@80x24.org>; Sat,  4 Mar 2017 17:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbdCDR0q (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Mar 2017 12:26:46 -0500
Received: from mail-wr0-f169.google.com ([209.85.128.169]:36072 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751970AbdCDR0q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2017 12:26:46 -0500
Received: by mail-wr0-f169.google.com with SMTP id u108so91819158wrb.3
        for <git@vger.kernel.org>; Sat, 04 Mar 2017 09:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KIVyilYLX6t4WDvLQ/2zP3juvz8pE3mdzMjNXhUrFk4=;
        b=KzV5QJrKMa4nxoo0g2w9+dObLib61H7e32NBMJY/rMlKDIodk8hGNWpTDeJlGwnNrS
         T5FZLcF9UbEwYyafB7Vmbi6100kV0ZFfMR8IIO0D8v073P+r+Ofe/Tu/lFkmwvGJ0UHO
         o88DbKOt9LzmFvaIcn+LudKRvCmd7Tof0dLJe89MhnrQsTzZDiN03xnKmkOy3ME44maY
         7BLtZMj+cqJdPtIcxY7XpJd9qcmoVq43PqNkRojJL3UWb7szATIkc220FB5YJuH8iwaZ
         /4vzFocXvZ3EUgcw+bJ8aFynwRQ4cB+8zREokFMt/Ym3RZjXdlTYhbg9gkrhqJ4GYP/d
         WwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KIVyilYLX6t4WDvLQ/2zP3juvz8pE3mdzMjNXhUrFk4=;
        b=RgXuDrpkagpH52XA1vrCdf8hGfheg5+wyxUCWikRl5cJOJzO5awsTbtPql4OmuP+Ss
         VXZQb52DFf8IKSvQL0vX7ZjzFQ0o9at5kS0fNDcIc60hCGaGnfHRdc98WoAZkOuFkqP0
         G/PrSytLSWtfNvEs05SV78nJY0D3c1AH4CffcZ3F4HERt/TcrwR1R2585SBJT+qpwNOa
         yYkVKUdS49N4je7Gvcfxq6ytpHWkciKjLYYe93/G8pR8Dlk28Lpwy85SEi1eOyp0vnlJ
         Jim+3nu5KtZ7MPR//g/sSnrp376gn7W3JO9uj2pfBjshCsyiviXwVuU/Gb9CTX4psTKj
         Pk8A==
X-Gm-Message-State: AMke39nITPWt1u+LyL57IZUlpLqwEEPvIV1RLdSgQtxdKjZxKynD9j6nSdT1TKXTOEBhrw==
X-Received: by 10.223.132.37 with SMTP id 34mr7029823wrf.45.1488648404147;
        Sat, 04 Mar 2017 09:26:44 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id k8sm19767263wre.19.2017.03.04.09.26.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Mar 2017 09:26:43 -0800 (PST)
Date:   Sat, 4 Mar 2017 17:26:49 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Valery Tolstov <me@vtolstov.org>
Cc:     git <git@vger.kernel.org>
Subject: Re: GSoC 2017
Message-ID: <20170304172648.GB27158@hank>
References: <5334661488625223@web28h.yandex.ru>
 <20170304114504.GA27158@hank>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170304114504.GA27158@hank>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/04, Thomas Gummerer wrote:
> Hi,
> 
> On 03/04, Valery Tolstov wrote:
> > Hi.
> > 
> > Want to participate in GSoC 2017 with Git.
> > Can I choose "Make 'git tag --contains <id>' less chatty" as my microproject?
> 
> Feel free to choose any microproject from the list.  A good way to
> start is to check whether other students already attempted the same
> microproject before starting with it so you don't duplicate any
> work. You can check for that in the mailing list archives, available
> at [1].

And I meant to say, if nobody started working on the micro-project yet
(and I don't recall anything doing so, but better double check), feel
free to just pick it up.

If somebody was already working on it might be better to try and find
a micro-project that nobody is working on yet, as that is going to
be a better learning experience for you, and allows us to get to know
you better.

> [1]: https://public-inbox.org/git/
> 
> > Thanks.
> 
> Good luck!
