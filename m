Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CBC81F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 01:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbfJIBmC (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 21:42:02 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:37200 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729517AbfJIBmC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 21:42:02 -0400
Received: by mail-pg1-f182.google.com with SMTP id p1so347603pgi.4
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 18:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LroYrAc9yYlJIDNEB3vZiI8SrePRGWfcFKQHW1r+5E8=;
        b=b/NH29SSL7h1pagsXGDqZ37gCMtX+sGYNj5c1GjP2Q/IeNrCpteFi2YN1TPJVlSxld
         um3xLbrj1ePVsqmyLzwj+r0GAZSVsLAHMCJYP4gsilObr36fh3LkuK6hnZSgKSiKhcu9
         A+gn+53EIS+COT30ZZn/z9yLczJatCIx3RQX3TYTKA5zfxTavS7dRXNllpIfTWjulvAr
         RjlXDvowb+DiEr2nFe2+tXBJpMgVnkrnIboEyH+2qCdfmXiWcJSzrkPIV1nJlO5xy/V1
         3HeT+VnHUTimFrkuiqKX39P8fQJ24mWGMlDDnKduWopF+oUj1ZEevIVypi59drx8mPby
         6VIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LroYrAc9yYlJIDNEB3vZiI8SrePRGWfcFKQHW1r+5E8=;
        b=C/+SHsj4YkoT9bvDi+QPLxl82s7akp3LB5Fn8dx/S+EhWj9EDrp5XG/o9/VnAERnXF
         N2CpbOQ2W614sD/9tmWmLiGGsX5SXgCKyH316rBHStsBPxCzihYRALrCzGqi8QHA+Pvl
         iE6eunkE9KiR93g9v49OGLTnanDz0P8hgObfNVUbTGzoijly/q3G0X/tiPUdmGhu0tkj
         r7dbNBShqwxquWs8T5u48uMh4X1RwivlR0M1YZDQvsy+RY218jm+Bh/8xI2cdrnv7XUn
         J89C5S7USM8p+XTvCQh/at8I2Siv/f6fv6i3LvddjzVU5srMOsU6ptEoom7RTyyXASEZ
         kVZQ==
X-Gm-Message-State: APjAAAVRpzaSZUlecMmUh330yfLz0ftTXoG2Cq2bXMSFvqj6EQnHlBlW
        C6F9iikDlML+AIz38Hq8tQs+sA==
X-Google-Smtp-Source: APXvYqzJKhhAMi2/oni9o7O3PW+dBc/ZALZGoI57/Big/mtPfiifTUO7dSaoj3bqLgw+DIJa6EWm9A==
X-Received: by 2002:a17:90a:fa0d:: with SMTP id cm13mr1066518pjb.114.1570585320977;
        Tue, 08 Oct 2019 18:42:00 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id c125sm340526pfa.107.2019.10.08.18.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 18:42:00 -0700 (PDT)
Date:   Tue, 8 Oct 2019 18:41:56 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Raise your hand to Ack jk/code-of-conduct if your Ack fell thru
 cracks
Message-ID: <20191009014156.GA143120@google.com>
References: <xmqq36g5444k.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1910082111220.46@tvgsbejvaqbjf.bet>
 <xmqqd0f6n5a4.fsf_-_@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd0f6n5a4.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 09, 2019 at 09:14:59AM +0900, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > In other words, the commit message can be augmented by this:
> >
> > Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > Acked-by: Derrick Stolee <stolee@gmail.com>
> > Acked-by: Garima Singh <garimasigit@gmail.com>
> > Acked-by: Jonathan Tan <jonathantanmy@google.com>
> > Acked-by: Thomas Gummerer <t.gummerer@gmail.com>
> > Acked-by: brian m. carlson <sandals@crustytoothpaste.net>
> > Acked-by: Elijah Newren <newren@gmail.com>
> >
> > Junio, would you mind picking it up, please?

Yes, I'd like to join too - I was missed by the scan.

Acked-by: Emily Shaffer <emilyshaffer@google.com>

I'm very excited for us to adopt this document.

 - Emily
