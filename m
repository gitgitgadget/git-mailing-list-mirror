Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B75992023D
	for <e@80x24.org>; Sat,  4 Mar 2017 20:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752250AbdCDUrE (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Mar 2017 15:47:04 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34078 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752056AbdCDUrD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2017 15:47:03 -0500
Received: by mail-pf0-f195.google.com with SMTP id x66so13274947pfb.1
        for <git@vger.kernel.org>; Sat, 04 Mar 2017 12:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5f6h7F8N6aZPqQu/zPS3SwUUoZKSd2d8aG6lJ9DeW1U=;
        b=lPtWaZnpzrQFXUB1Ms8jTcHFtZ4CQdLNzp43UQ9NB3Koy+0t4Kxba4nJv7OwtoQKLE
         bEQQqQ2FGb5JeOMQDeNGgjNX001MkdRca7ocfJXwu7OunSViXzYbYnEDrfonXKXLC94f
         Fau/r4OYeaowNvEkoBE8v+yrmHTcil60Yn+KyJfcjK+LiNabqolnMk6mObGrOPFbsPnu
         GeOA2ysuDT5HVxx986S1n9IpZUDSDKrQTbSNiX48ps/4I02Fa4JRsCuZ5PPbUpB4tHXg
         pPx77Zvb4+b7Dcpwn8GG16kR+Hkxmg3HNV1VNqpK6VA0e8dQ4uZ3QVKg6WZPqj+ZscIC
         /VVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5f6h7F8N6aZPqQu/zPS3SwUUoZKSd2d8aG6lJ9DeW1U=;
        b=RgEtM3xJJ/keXkOeGM+MFRv1QhV7jwob7/NSOxC8yIKqucXJ6Twy9ylUb3AgCqSexG
         W821jmn0EkknTey3a3xHUlHu+bNSmlrSHaiYy8+twLL/1kLjFiJK0h7J0OFPfrPxPLfz
         C+vzkQX/zqZVuuRrVjIAmk24nFe0ZJ45y37iBSAD0wocpG4/H5SmJRMs3xXifbBi5MXj
         YacfmCOwqCnmjCFoIbTPJ0z6M43XB1NemBHi7lM+RuTa/cyZ1R3tMTjJs30n/ZYTRGAE
         Cp7w3Xme7ZdKc5AC1KhHkAcI3WfyBTXqXHENN4DF9Z2V0OAuY0OQYlgQ/i1rKa1xqAY5
         Irxw==
X-Gm-Message-State: AMke39n1055kg2Zdo8NqxLQHGf8oYAcE8ZFD3ghmdsFH+mYD5RM5TP+PSjGzPLb9HAjGFw==
X-Received: by 10.98.83.197 with SMTP id h188mr11526555pfb.106.1488660422451;
        Sat, 04 Mar 2017 12:47:02 -0800 (PST)
Received: from gmail.com (50-1-201-252.dsl.static.fusionbroadband.com. [50.1.201.252])
        by smtp.gmail.com with ESMTPSA id d66sm30756432pfe.90.2017.03.04.12.47.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Mar 2017 12:47:00 -0800 (PST)
Date:   Sat, 4 Mar 2017 12:46:58 -0800
From:   David Aguilar <davvid@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] Remove outdated info in difftool manpage
Message-ID: <20170304204658.a3xo2j2aggf22rd5@gmail.com>
References: <20170303115751.GA13225@arch-attack.localdomain>
 <alpine.DEB.2.20.1703031645470.3767@virtualbox>
 <20170303212836.GB13790@arch-attack.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170303212836.GB13790@arch-attack.localdomain>
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2017 at 01:28:36PM -0800, Denton Liu wrote:
> On Fri, Mar 03, 2017 at 04:46:36PM +0100, Johannes Schindelin wrote:
> > Hi Denton (or should I address you as Liu?),
> Denton is fine, thanks.
> > 
> > On Fri, 3 Mar 2017, Denton Liu wrote:
> > 
> > > When difftool was rewritten in C, it removed the capability to read
> > > fallback configs from mergetool. This changes the documentation to
> > > reflect this.
> > 
> > Thanks for pointing that out. But that is probably an oversight on my
> > part, not an intentional change...
> Do you expect to be submitting a patch for this soon? Or, if not, would
> it be fine if I went ahead and did it?

Thanks for spotting this.  It'd be good to fix this so
I'm sure no one would mind if you submitted a patch ;-)

I'd be happy to test your patch if you have one.
-- 
David
