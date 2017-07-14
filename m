Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2A7420357
	for <e@80x24.org>; Fri, 14 Jul 2017 14:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754076AbdGNOhK (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 10:37:10 -0400
Received: from gproxy9-pub.mail.unifiedlayer.com ([69.89.20.122]:58634 "EHLO
        gproxy9.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754026AbdGNOhK (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Jul 2017 10:37:10 -0400
Received: from CMOut01 (unknown [10.0.90.82])
        by gproxy9.mail.unifiedlayer.com (Postfix) with ESMTP id 5EF401E0812
        for <git@vger.kernel.org>; Fri, 14 Jul 2017 08:37:09 -0600 (MDT)
Received: from box5008.bluehost.com ([50.116.64.19])
        by CMOut01 with 
        id ked61v0060QvKlu01ed91N; Fri, 14 Jul 2017 08:37:09 -0600
X-Authority-Analysis: v=2.2 cv=FvB1xyjq c=1 sm=1 tr=0
 a=gch/BGY/Gm5DEW28s2kmlQ==:117 a=gch/BGY/Gm5DEW28s2kmlQ==:17
 a=IkcTkHD0fZMA:10 a=G3gG6ho9WtcA:10 a=3vy_hqDwxLy2yP-djEgA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.net; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:Reply-To:From:Subject:
        Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=L/V+P6ynl9hplpGhPhy1WZb54TTHLLVOF7u4prYDkrI=; b=cptEnTsuin9cOETnvZQ/KFX6tz
        HaAejEzx8bhgbAkvM9bjR2lbVahTCRoecPlWP1cOrGmdoD1gOwh+uI3n3bLsQZESZrQ46UAU3FBKn
        NXn06ca6aAB7UFhLH/k3tKfQW;
Received: from [65.112.16.22] (port=45754 helo=pdsdesk)
        by box5008.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.87)
        (envelope-from <paul@mad-scientist.net>)
        id 1dW1iL-001OwK-Ss; Fri, 14 Jul 2017 08:37:05 -0600
Message-ID: <1500043024.25789.105.camel@mad-scientist.net>
Subject: Re: Git Bash Bug
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Kavita Desai <kvdesai2@illinois.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Date:   Fri, 14 Jul 2017 10:37:04 -0400
In-Reply-To: <CAAu0pLdmGc_kq_w0Fm6W4XDqOe=iKSyAyLct+yH6y+7FPUHtnA@mail.gmail.com>
References: <CAAu0pLedy5xqUgF7drMf=tQgMJD4rXq+JvKaiE54EdRFZWuTkQ@mail.gmail.com>
         <alpine.DEB.2.21.1.1707141625150.4193@virtualbox>
         <CAAu0pLdmGc_kq_w0Fm6W4XDqOe=iKSyAyLct+yH6y+7FPUHtnA@mail.gmail.com>
Organization: GNU's Not UNIX!
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5008.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 65.112.16.22
X-Exim-ID: 1dW1iL-001OwK-Ss
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (pdsdesk) [65.112.16.22]:45754
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTAwOC5ibHVlaG9zdC5jb20=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2017-07-14 at 09:34 -0500, Kavita Desai wrote:
> Sorry for not being specific. What I meant by not working was that the
> bash commands are not found.
> Here is an example
> 
> $ ls
> bash: ls: command not found

The most obvious issue is your PATH is wrong.

What does "echo $PATH" show?

What does "type -a ls" show?
