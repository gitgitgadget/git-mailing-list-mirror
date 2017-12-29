Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 608551F404
	for <e@80x24.org>; Fri, 29 Dec 2017 17:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751582AbdL2RNj (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Dec 2017 12:13:39 -0500
Received: from gproxy1-pub.mail.unifiedlayer.com ([69.89.25.95]:46459 "EHLO
        outbound-ss-1812.hostmonster.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751414AbdL2RNi (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 29 Dec 2017 12:13:38 -0500
Received: from cmgw2 (cmgw3 [10.0.90.83])
        by gproxy1.mail.unifiedlayer.com (Postfix) with ESMTP id 67F63175C7E
        for <git@vger.kernel.org>; Fri, 29 Dec 2017 10:13:38 -0700 (MST)
Received: from box5008.bluehost.com ([50.116.64.19])
        by cmgw2 with 
        id rtDa1w00v0QvKlu01tDdVt; Fri, 29 Dec 2017 10:13:38 -0700
X-Authority-Analysis: v=2.2 cv=doKrMxo4 c=1 sm=1 tr=0
 a=gch/BGY/Gm5DEW28s2kmlQ==:117 a=gch/BGY/Gm5DEW28s2kmlQ==:17
 a=IkcTkHD0fZMA:10 a=ocR9PWop10UA:10 a=rhCWqrB0jcXF9yD5NosA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.net; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:To:Reply-To:From:Subject:Message-ID:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wYGDe/EVcJd205h2bGFx+CbNsSM4wgckaaZXTfYlbfU=; b=bdeHp1q5PvmoXDfdA1DVAJTOJL
        G9cnQozhy8AebGkThXiNTG9o+kmShP4XFDsK+aUUa8iT1r4XrPCWOmeYY2RPKGbhSD/Tlp191PgES
        1/ySFH9qxkj65xly29vI1fn93;
Received: from cpe-67-240-122-107.nycap.res.rr.com ([67.240.122.107]:50648 helo=pdsmac)
        by box5008.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <paul@mad-scientist.net>)
        id 1eUyDu-000Rfu-Ew
        for git@vger.kernel.org; Fri, 29 Dec 2017 10:13:34 -0700
Message-ID: <1514567611.3270.28.camel@mad-scientist.net>
Subject: Re: [ANNOUNCE] Git v2.16.0-rc0
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     git@vger.kernel.org
Date:   Fri, 29 Dec 2017 12:13:31 -0500
In-Reply-To: <xmqqfu7ui2af.fsf@gitster.mtv.corp.google.com>
References: <xmqqfu7ui2af.fsf@gitster.mtv.corp.google.com>
Organization: Please remain calm--I may be mad, but I am a professional!
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5008.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 67.240.122.107
X-Exim-ID: 1eUyDu-000Rfu-Ew
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cpe-67-240-122-107.nycap.res.rr.com (pdsmac) [67.240.122.107]:50648
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTAwOC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2017-12-28 at 20:30 -0800, Junio C Hamano wrote:
>  * The way "git worktree add" determines what branch to create from
>    where and checkout in the new worktree has been updated a bit.

Does this include the enhancements published a few weeks ago to allow
worktrees to be created directly from remote branches without first
checking out the branch locally? I'm really looking forward to that
change...

Thanks!
