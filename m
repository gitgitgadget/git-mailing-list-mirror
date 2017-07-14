Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAAE220357
	for <e@80x24.org>; Fri, 14 Jul 2017 15:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754595AbdGNPP2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 11:15:28 -0400
Received: from gproxy6-pub.mail.unifiedlayer.com ([67.222.39.168]:60150 "EHLO
        gproxy6.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754575AbdGNPPW (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Jul 2017 11:15:22 -0400
Received: from cmgw2 (unknown [10.0.90.83])
        by gproxy6.mail.unifiedlayer.com (Postfix) with ESMTP id 28F221E41B3
        for <git@vger.kernel.org>; Fri, 14 Jul 2017 09:03:17 -0600 (MDT)
Received: from box5008.bluehost.com ([50.116.64.19])
        by cmgw2 with 
        id kf3D1v01Q0QvKlu01f3Gn1; Fri, 14 Jul 2017 09:03:17 -0600
X-Authority-Analysis: v=2.2 cv=UvYTD64B c=1 sm=1 tr=0
 a=gch/BGY/Gm5DEW28s2kmlQ==:117 a=gch/BGY/Gm5DEW28s2kmlQ==:17
 a=IkcTkHD0fZMA:10 a=G3gG6ho9WtcA:10 a=WsYW0WPVLPCSxBESKZwA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.net; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:Reply-To:From:Subject:
        Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6gFpvJx6E00xCGt9Jq7Ysqv7FKnOo9+56z8zhlWe6Q0=; b=hUGsHJl06oc2yq1EKg0knhGTgc
        yQNVTB8CwwcbMUK5TV4gCYXwdPRRvQpYx579ZioSITRqa0jGgwxYakFdRIG5JONxJ3fqT2RVKp4SS
        jQck0XkhNY2HBZ9kdVggQ2izc;
Received: from [50.226.24.42] (port=46046 helo=pdsdesk)
        by box5008.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.87)
        (envelope-from <paul@mad-scientist.net>)
        id 1dW27d-001b9H-KD; Fri, 14 Jul 2017 09:03:13 -0600
Message-ID: <1500044588.25789.109.camel@mad-scientist.net>
Subject: Re: Git Bash Bug
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Kavita Desai <kvdesai2@illinois.edu>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Date:   Fri, 14 Jul 2017 11:03:08 -0400
In-Reply-To: <CAAu0pLdjvcxda0rip8JOzt1q0HNuu4dBNHvEzJbeey6yRSyCCQ@mail.gmail.com>
References: <CAAu0pLedy5xqUgF7drMf=tQgMJD4rXq+JvKaiE54EdRFZWuTkQ@mail.gmail.com>
         <alpine.DEB.2.21.1.1707141625150.4193@virtualbox>
         <CAAu0pLdmGc_kq_w0Fm6W4XDqOe=iKSyAyLct+yH6y+7FPUHtnA@mail.gmail.com>
         <1500043024.25789.105.camel@mad-scientist.net>
         <CAAu0pLdjvcxda0rip8JOzt1q0HNuu4dBNHvEzJbeey6yRSyCCQ@mail.gmail.com>
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
X-Source-IP: 50.226.24.42
X-Exim-ID: 1dW27d-001b9H-KD
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (pdsdesk) [50.226.24.42]:46046
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTAwOC5ibHVlaG9zdC5jb20=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2017-07-14 at 09:59 -0500, Kavita Desai wrote:
> What does "echo $PATH" show?
> /c/Users/Kavita/

Well, there you go.  That's clearly wrong.

You absolutely have to have /bin and /usr/bin on your PATH, _at least_
if you want to be able to run standard UNIX tools.  And most likely
you'll have a ton of other directories on your PATH as well.

I would investigate the shell configuration files etc. and see where
you've messed up resetting your PATH variable.

> What does "type -a ls" show?
> ls is aliased to `ls -F --color=auto --show-control-chars'

Yep.  There is no ls binary found.
