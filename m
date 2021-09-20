Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_50,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60728C433F5
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 06:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46E836109E
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 06:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbhITG5X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 02:57:23 -0400
Received: from gproxy8-pub.mail.unifiedlayer.com ([67.222.33.93]:59097 "EHLO
        gproxy8-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229549AbhITG5W (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Sep 2021 02:57:22 -0400
X-Greylist: delayed 1289 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Sep 2021 02:57:22 EDT
Received: from cmgw12.mail.unifiedlayer.com (unknown [10.0.90.127])
        by gproxy8.mail.unifiedlayer.com (Postfix) with ESMTP id AEA0B8032478
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 06:34:25 +0000 (UTC)
Received: from md-in-48.webhostbox.net ([103.195.185.222])
        by cmsmtp with ESMTP
        id SCshme6KlEV4rSCsimy8d8; Mon, 20 Sep 2021 06:34:25 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=NJkQR22g c=1 sm=1 tr=0 ts=61482b71
 a=yTXSrzwfGdnBip3W5JPl4Q==:117 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=kj9zAlcOel0A:10:nop_charset_1 a=MKtGQD3n3ToA:10:nop_fastflux_from_domain_1
 a=1oJP67jkp3AA:10:nop_fastflux_mid_domain_1
 a=7QKq2e-ADPsA:10:nop_rcvd_month_year
 a=iyzZ41wQ9_kA:10:endurance_base64_authed_username_1
 a=dnp6A1d-wYIA:10:from_fastflux_domain1 a=ZZnuYtJkoWoA:10:nop_header_rescan
 a=7OqKTslT_l12RM_7n0QA:9 a=CjuIK1q_8ugA:10:nop_charset_2
 a=0iaRBTTaEecA:10:nop_sms_2fa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hexafair.in
        ; s=default; h=Content-Transfer-Encoding:Content-Type:Message-ID:Subject:To:
        From:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=m7s1AQoHjuARwH9kgEXOx+dJnCn7a69OZQ6IR3GrSTg=; b=lFmgoDQsvyHNkyk9RjKnbm3yOq
        SrcvUX29AHwdFS9SiX8LVOtqWo3PWhpFv0x7ghEm/CON6P7Rh3qlC2c4YAqtMBjvSdhXRVUI+zoye
        iOLxV6O7YK3byvDxFilXeBdEQ7nN32QLkz010TzsUukxJ4PoqMlSSKVY7W0uYXx7J7+i03uvQ1zZE
        KLn47RCEq3LcDG6vl3RDPeLH9bPWT5FL2mCdaX6JQ//XsLB2GgnxSKwxG3kGql5s71Bh9DY6VfhWA
        Pe+HFwlF/5lhKRSe3GswThoczrnf1vNlTcWw3U8ceqp/p0qWW8ijRkVV1Z8+iOAgLyUnyuXGIkEnu
        iKuc8etQ==;
Received: from md-in-48.webhostbox.net ([103.195.185.222]:58006)
        by md-in-48.webhostbox.net with esmtpa (Exim 4.94.2)
        (envelope-from <hariharan@hexafair.in>)
        id 1mSCsg-001xWQ-PP
        for git@vger.kernel.org; Mon, 20 Sep 2021 06:34:22 +0000
MIME-Version: 1.0
Date:   Mon, 20 Sep 2021 06:34:21 +0000
From:   hariharan@hexafair.in
To:     git@vger.kernel.org
Subject: Need IP Acccess Repo Details
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <8eebd20251631ea261179e0afc942d2d@hexafair.in>
X-Sender: hariharan@hexafair.in
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-48.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - hexafair.in
X-BWhitelist: no
X-Source-IP: 103.195.185.222
X-Source-L: Yes
X-Exim-ID: 1mSCsg-001xWQ-PP
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: md-in-48.webhostbox.net [103.195.185.222]:58006
X-Source-Auth: hariharan@hexafair.in
X-Email-Count: 1
X-Source-Cap: bWVyY3VoczY7bWVyY3VoczY7bWQtaW4tNDgud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,



     Am in need git repo only access IP how to do that in github free 
account.



Reg,
Hari
