Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87250207EC
	for <e@80x24.org>; Sun,  9 Oct 2016 17:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbcJIRvq (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 13:51:46 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:33470 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751991AbcJIRvp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2016 13:51:45 -0400
Received: by mail-lf0-f42.google.com with SMTP id x79so84993087lff.0
        for <git@vger.kernel.org>; Sun, 09 Oct 2016 10:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JGN2OFAtZT/yi0kaN9pLL0P6Mh4VQvVLiq6ldRaC+Qk=;
        b=kRZ5FZh8Svwxy8EVkhaYegTOvpd++z+YztwwRiv9SMbQv2T8Q5tT9hp704dCLKqJ4R
         kY7DhAE/Rv7vaAEhAvCCchuAP2AOLVRSiA113wbRILnn9f9HyET26v8dzEFCahWBE15W
         6JewKe2CZ1FICmkctKSjkOx78n3n6WdHAT7Y397FDIzu0h/ObNZcE9pn7UmDkzGnIo/V
         nPo4sTyLH8eq4OlqIGQix/nI4ueA5TJINNf50FHEvt4GrRmMaljNbciKekRr5Zs6Jw+a
         8rJ3pxmCmMhhqzvSXaIjfG/4up2U303Og3umtYRlluur1Oykr8r/Mz+XMJ3Aep4U3ADa
         qi/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JGN2OFAtZT/yi0kaN9pLL0P6Mh4VQvVLiq6ldRaC+Qk=;
        b=C8le+UWKoHbFovjrBLprnorUzsXi5m90CWEQ6hKqRM3R6f3LJq2weirMW6vxKJWOQ0
         2I1/sSSY8uEmDErsprLQepbGquxGbG3kMffMPaZ7acR43SLC15vpzXP3/wjio4Wo9rrx
         LGtYEPVf37uap4XRQ11ecJtvhDboEruMxh5u4vodRYUY82GP+9cA37nvS1knLuj0gr41
         mWfbM4hT7Rr8lRBGTYPUqhq23ge+mazDyjG5IT/rJT3afzc6gjcC5m631p+grDhX8vxD
         vQSXDmi180r+JornhhDE8Y3fqL8uW8+mGAYhl8IMwL4zXKmnZhKjvSfKY0Oqo/7ubX39
         2ruw==
X-Gm-Message-State: AA6/9RmGYePfnz1GU6JSH50MEzhrITDL83Yi6/avp4rZ6gwpQk1ufsJ59s7zhAotvfIJ8g==
X-Received: by 10.194.5.2 with SMTP id o2mr993418wjo.229.1476035503740;
        Sun, 09 Oct 2016 10:51:43 -0700 (PDT)
Received: from hurricane.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id ce6sm32377656wjc.27.2016.10.09.10.51.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Oct 2016 10:51:42 -0700 (PDT)
Message-ID: <1476035501.26041.1.camel@kaarsemaker.net>
Subject: Re: Problem with submodules
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     "venv21@gmail.com" <venv21@gmail.com>, git@vger.kernel.org
Date:   Sun, 09 Oct 2016 19:51:41 +0200
In-Reply-To: <CAL4SumgJbrirymt5+iyNbpo++xXfzJZRiHDm8=0+eCArpCX=DA@mail.gmail.com>
References: <CAL4SumgJbrirymt5+iyNbpo++xXfzJZRiHDm8=0+eCArpCX=DA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.0-2ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2016-10-09 at 16:41 +0200, venv21@gmail.com wrote:
> Hi, I want to report a regression.
> 
> After cloning for example https://git.gnome.org/browse/epiphany with
> git 2.10 and running ./autogen.sh I get the following errors:
> http://pastebin.com/93AunRhu
> 
> The developer told me that it is probably not an issue caused by
> epiphany and I should try an older git version. I installed 2.7.2 and
> it works perfectly. So I think theres a bug in git 2.10.

I can't reproduce the problem with git 2.10.1

Can you share the .git/config file in your clone of epiphany please.

D.
