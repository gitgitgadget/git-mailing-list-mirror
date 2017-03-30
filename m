Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4930220969
	for <e@80x24.org>; Thu, 30 Mar 2017 20:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754587AbdC3UoG (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 16:44:06 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35967 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754372AbdC3UoF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 16:44:05 -0400
Received: by mail-wr0-f194.google.com with SMTP id k6so14035268wre.3
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 13:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YF54/Ydl6n0LeqqEqfFo9abrW6B4vfFlosg9QzN2EH4=;
        b=ZbftInstCimZIwDBUGNUYZgQHOANl9Qb/EZVZ8cXBBhqPb8UdhWu2NNWq8V5WkHtIP
         V9UqNG58RGj46vDpJwWt4dg5M/jelqRTugZ94mEm6/3Sd3rJNfwGYF+FdEaEktT8f3OM
         CtbX6DLOpbS760Fo6IzbAVmFTsOMkAGZAbdD1T/r/AnvDeYj0W3v+WddYRksPOKfRZ9T
         CeUiQUI9MyOgIF6plLfDZ2F9q59uAhMsuFulPtbvN+x3bRydrqwdJ5OxApFdFdRsNXq3
         UYGfRi+DBOFBNmr+c3rRdrK4rCq7K4QR9Uq5/2ljsuwQfbC5N9StdfPdluEPvRucwcWn
         AddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YF54/Ydl6n0LeqqEqfFo9abrW6B4vfFlosg9QzN2EH4=;
        b=Gh60BNVTm/qEwVtLCotiKoQZbFNHO4kWdoGhpR30UdkjkGqIb0JU9uOT6FXIoMlLnX
         RMbXu9jh/vueYp0ybtvGr1/po5pVpysJEotnl7dx0I9UinDH1i3NHRSQyVgRxO/SwmvC
         W0v78LDCq8rvhvrSnVHUbbgRjXi6WjGAesxc19L7IrGOmN+DPNCEs1G/umHmK5A4s5t5
         bJQ8olAqj3FQwWQeUBFKacRuziYWVPWTe4Y+WAS7lfArKZJ1hRBADQDout3JSzmCQAbC
         OhawlohrLQPv7NrMLHncMfl6u+Pik7XzS+Y2m+nNdM2UHwnbW63E6WZxzIIiCGE0G+y3
         RPkw==
X-Gm-Message-State: AFeK/H36c778hgY+r+RQRj6ynPGlRWL/Hl1Tr8iggeYoHDkeuY/rPstWDRd5Jdnl45FmIQ==
X-Received: by 10.28.168.150 with SMTP id r144mr100753wme.43.1490906642807;
        Thu, 30 Mar 2017 13:44:02 -0700 (PDT)
Received: from [192.168.1.80] ([145.129.9.233])
        by smtp.gmail.com with ESMTPSA id 68sm269198wme.7.2017.03.30.13.44.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Mar 2017 13:44:02 -0700 (PDT)
Message-ID: <1490906641.2546.1.camel@kaarsemaker.net>
Subject: Re: ttk error when starting git gui
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Peter van der Does <peter@avirtualhome.com>, git@vger.kernel.org
Date:   Thu, 30 Mar 2017 22:44:01 +0200
In-Reply-To: <4addfbdb-1289-7958-87e5-8d8caa9febfb@avirtualhome.com>
References: <0fc69c73-73aa-5355-264b-a7c55377eec2@lanl.gov>
         <4addfbdb-1289-7958-87e5-8d8caa9febfb@avirtualhome.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2017-03-30 at 15:54 -0400, Peter van der Does wrote:

> It looks like the git gui needs TCL/TK 8.6.0 or higher. Since that
> version the command 'ttk::style theme use' has been changed, which
> allows the command to be run without an argument and then returning the
> current theme used.
> I believe RHEL6 use Tk-8.5.7 but I can't be 100% sure.

It does.

$ rpm -q tk
tk-8.5.7-5.el6.x86_64

D.
