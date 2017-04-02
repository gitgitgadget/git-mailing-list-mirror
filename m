Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7899220964
	for <e@80x24.org>; Sun,  2 Apr 2017 05:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750807AbdDBFr3 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 2 Apr 2017 01:47:29 -0400
Received: from aserp1040.oracle.com ([141.146.126.69]:34524 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbdDBFr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2017 01:47:29 -0400
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v325lRJU007678
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <git@vger.kernel.org>; Sun, 2 Apr 2017 05:47:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v325lRLJ018375
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
        for <git@vger.kernel.org>; Sun, 2 Apr 2017 05:47:27 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id v325lP9V015318
        for <git@vger.kernel.org>; Sun, 2 Apr 2017 05:47:26 GMT
Received: from ori.omang.mine.nu (/80.203.111.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 01 Apr 2017 22:47:25 -0700
Message-ID: <1491112043.5830.11.camel@oracle.com>
Subject: Bug: 'git config --local user.email=<alt.email>' fails silently?
From:   Knut Omang <knut.omang@oracle.com>
To:     git@vger.kernel.org
Date:   Sun, 02 Apr 2017 07:47:23 +0200
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Source-IP: aserv0022.oracle.com [141.146.126.234]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

From the documentation I would have expected 

git config --local user.email=alt.email@alt.domain

to create a section 

[user]
	email=alt.email@alt.domain

in the local .git/config.

Instead it returns status 1 with no error message.

Is this intentional?

If I add the [user] section manually, it works as expected/desired:
my commits in that tree uses the alternate mail address.

git --version
git version 2.7.4

Thanks,
Knut Omang

-- 
Knut Omang, Ph.D
Principal Software Engineer
Oracle Linux and Virtualization Engineering
ORACLE Norway | Olaf Helsets vei 6 | 0694 Oslo
Email: knut.omang@oracle.com | Phone:  +47 41 46 22 10

