Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314B2C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 15:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AD0060F56
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 15:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhJ1PwR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 11:52:17 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:50977 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhJ1PwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 11:52:16 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N4vFE-1mpqV23AFo-010spV; Thu, 28 Oct 2021 17:49:12 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 46F2C1E01E7;
        Thu, 28 Oct 2021 15:49:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id l69wWCesi-j3; Thu, 28 Oct 2021 17:49:11 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (24-usr-pf-main.vpn.it.cetitec.com [10.8.5.24])
        by mail.cetitecgmbh.com (Postfix) with ESMTPSA id C2B721E01E6;
        Thu, 28 Oct 2021 17:49:11 +0200 (CEST)
Received: by pflmari.corp.cetitec.com (Postfix, from local account)
Date:   Thu, 28 Oct 2021 17:49:11 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] Remove negation from the commit and merge option
 "--no-verify"
Message-ID: <YXrGd9ZF9E+lApZY@pflmari>
References: <YXfwanz3MynCLDmn@pflmari>
 <YXhwGQOTfD+ypbo8@coredump.intra.peff.net>
 <YXlBhmfXl3wFQ5Bj@pflmari>
 <YXlD5ecNSdeBSMoS@coredump.intra.peff.net>
 <YXlTpzrY7KFqRlno@pflmari>
 <xmqq4k92w7do.fsf@gitster.g>
 <YXpFTJTo0pKhM7xG@pflmari>
 <YXpZddOixrJDd//s@pflmari>
 <edca7f6b-e89c-7efa-c6f5-2c3aaaea54f9@gmail.com>
 <YXrFaJXbuSuwfhQ7@pflmari>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXrFaJXbuSuwfhQ7@pflmari>
X-Provags-ID: V03:K1:kurdR4j//FUskR/6ENMWlG7fgxw+JogG6fL/3KsNI5c4saq/Q8h
 koQAlbZ0q7WOMf24UxxzDvROZB6TqFVVDygwH0x2Z+LRvXLW73zTeXU5uC8vJBgEZFiG47+
 xktQy6F3Cpsy9T2q0+Xjn57mGvp0u1QV3YuGBVy9clkv/Gp1Mv7c2tvMaAiB1fyTCfMhgK8
 Zb2ebhik/5AWXQy84vRcw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QOeawKA9pBU=:0A9IZJ7KFepfSsXdh8ABCi
 wEg9tPq6Z1xFFhS0UBrSn/bCvbHWFsoVaOEW0lqEYBUShQsg7Crq1wpLZ/8mgK0nzcMNN9HVE
 EiIPsP/HovkuCnARWl0RMdgPl1mPYYcoUK28kYFlUcse0mWaSPO7U6lwVQ6sR+fZn9nrY8aNL
 Bc/H6iem3hrl/YXhDFX67beN2cI22rZEU0wU9NKpjLWqhoPOuq/T5SvLtWh4pchb8ovAKS5Xy
 mLfDYhIydZtvhilAdbv4udY8THELuIceOtO3/66X6blVMJSipDNSdKhHmU7eKatQtiIaOVYDI
 j8myn7+85+ojr2oShs/ampgm1SLxt9eE76gz6q80Gzaj+ulLtIGNc4McFh/hucSbW94gbfBYK
 8WLPsdkU+huxEBL6UqFGZc17vEkX+aVyYPUoNXQ6zXt21Q6NURFNHmacF+m1bmeegjEArhUXH
 Hjmr0h+gIl9d5KKt1TEIWDWPCiZdxfffIBIBbBo9gK6UpOFHY1miFHecY3XsXYwtW+YOTRIa2
 9zf6Z298TZNT+5lz8Zou5dia+zBFugYoWk6UQ2nl9CYR/yl74FME9KeYYoNZJNJ0Gid1Yj5xa
 0Zm30N2QNhQh6oWH4PCoYOjLBh7E6B99awXUeFWN3Toc1rvtkW64XIHqa1KXC4JWfMMjHMSCE
 J+7swck/gRbevTCtneMxLndsDw6grY3+DLFx35ceEme/tEqW6fbrufkHNAKIdauu82W2gq1zw
 HjMjBt3aI10kyqrm
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Subject of this messages was supposed to be

    Document positive variant of commit and merge option "--no-verify"

But I hand-edited it beyond all repair :-(
