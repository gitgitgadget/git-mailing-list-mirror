Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DABA41F462
	for <e@80x24.org>; Fri, 26 Jul 2019 03:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfGZDSn (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 23:18:43 -0400
Received: from mail-yb1-f182.google.com ([209.85.219.182]:35377 "EHLO
        mail-yb1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfGZDSn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 23:18:43 -0400
Received: by mail-yb1-f182.google.com with SMTP id p85so6523312yba.2
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 20:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=KFzEX3KyMpLch1BUwFGoqFjaJX5K9VUUMF+Mkdz73lw=;
        b=EIGyFMkGBPzzZ+Sf6Ho2SCuDEsNGxI05i6JEJHXRADbdAhvPNOTa8+12kJF/yU0dzF
         G0kww/it+rA61NsvfneSY0hU7ecyrIk7+QI+60poflMSMw36+SXCJD3s+MriV/FbJida
         LbHnKr6du1mUTX6rXhgsz5JPk7DA6RlIdPA9yCFvn9eHWzu9fAuymrMx9o9S1FQ6oiDu
         w4F2P4z/Lj1aCsiQH+UtZ5aI6kJf45sJauO8TMlJLalpEfHpqU3iXOG0IN28V++6hPdK
         OHqVNrsdwju2lNuSC6IQGV8GuJjAzNRhl7vGrQldJbAOdMvUMDR2GbZu/hZ/9ulLs5Da
         Z8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=KFzEX3KyMpLch1BUwFGoqFjaJX5K9VUUMF+Mkdz73lw=;
        b=CDbjHLYcIk2Kf+3UQXx2ioVX0QYzp48/NsvMrVIhYESO5XDoIl8pPJRWJAd5CQK+ez
         c20DK0H0ykA0TtVhtX/QV/zfazA03ruKyO4UkMNse3uLWQgZR0y3x4fikhKEi8PTcAos
         oBFVhZxqFiFJ/8VrYR0g7/HJLVsO9sFZ3rMwdhvJcFPkPEEGKIFl7pT/QasJ3T+uwc17
         /VozwVc6CMFXxbDEG9KA+qAxvxF/wZOAqybmSZ10HL7rXwV0OFuoH5hoKi0xfluV5FFv
         eJvOTEUwvVue9MCNYOjEtlAdPd8AHjrf7zr5cyOIPBWo5pbx40zyv5EqDvWVsLNrc1U1
         NqZA==
X-Gm-Message-State: APjAAAW6uKgiaIJc/zd2a9VpMzo4wSTa8SrL/xfAW58XjR/z3pOp/i4U
        DgHW/s+QjpIxyz16dGbvK56+qWMK1qc=
X-Google-Smtp-Source: APXvYqwkyOidge3GVBkeG8Iqf2knKeCpyMTR9wlT/2u46veANd+8QlekKIgan/7IR0Xw2dGUnKxHdw==
X-Received: by 2002:a25:9101:: with SMTP id v1mr55218498ybl.73.1564111122351;
        Thu, 25 Jul 2019 20:18:42 -0700 (PDT)
Received: from localhost ([2600:1700:6e90:7930:604d:9323:afcb:22b6])
        by smtp.gmail.com with ESMTPSA id r10sm12047959ywh.8.2019.07.25.20.18.41
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 20:18:41 -0700 (PDT)
Date:   Thu, 25 Jul 2019 22:18:40 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: Alternates advertisement on GitHub
Message-ID: <20190726031840.GB23056@TaylorsMBP9145.attlocal.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everybody,

Pushes to forks of git.git hosted on GitHub now advertise the tips of
git.git as well as branches from your fork.

You may recall that Peff and I have sent a handful of patches to allow
repositories to customize how they gather references to advertise from
an alternate, and then to use those alternate tips as part of the
connectivity check (in [1] and [2], respectively).

GitHub used to advertise '.have's on pushes to forked repositories, but
hasn't done so since 2012. We aggregate data from all forks into a
'network.git', and expose the tips of each fork as:

  refs/remotes/<fork-id>/<refname>

Each fork lists the 'network.git' as its alternate, and thus the
advertisement can get prohibitively large when there are many forks of a
repository.

Michael Haggerty's work on packed refs makes finding references
pertaining only to the root computationally efficient, and [1] makes it
possible to filter down when computing the set of references to
advertise. With [1], we can specify that computation exactly and only
advertise branch tips from the root of a fork network.

We've been slowly rolling this out to a handful of repository networks,
including forks of git.git hosted on GitHub. If you host your fork on
GitHub, you shouldn't notice anything. Hopefully, pushes to your fork
will result in smaller packfiles. In either case, nothing should break;
if it does, please feel free to email me, or support@github.com.

Thanks as well for reviewing both [1] and [2], and making this work
possible. Enjoy :-).

Thanks,
Taylor

[1]: https://public-inbox.org/git/cover.1537466087.git.me@ttaylorr.com/
[2]: https://public-inbox.org/git/20190628101131.GA22862@sigill.intra.peff.net/
