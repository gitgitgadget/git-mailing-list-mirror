Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255C1C2BA2B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 12:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA30720769
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 12:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="YksIUT2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgDJMxg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 08:53:36 -0400
Received: from st43p00im-ztdg10073201.me.com ([17.58.63.177]:55572 "EHLO
        st43p00im-ztdg10073201.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726080AbgDJMxg (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Apr 2020 08:53:36 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Apr 2020 08:53:35 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1586522815;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        h=Content-Type:From:Date:Subject:Message-Id:To;
        b=YksIUT2rAOmT7qkaCr8WoZjcYszVVKhG1GwU5yqIyAGzyu1mNoZR9HfEK39Gum4u6
         yZshO1O8GGoZo9TF9wu1RyZiYftFmOSNewJG0CHLPXQpOMLXTARfL2W1fUD3U4RIEm
         MMUwHrKivtMA3mgMSfWEADwr9P8KDYkO+OFM37jF3szzyRLmiHz0+LnB15ll4oEg1m
         A7uZIJidBi9xLPAFeVhNWkunHt0JHP8Vkh90HMz8qxRr33AenV0H/ib2dIRVZ4ESac
         V5OUhXL1mdrrvBoygrw0utZhrRCtkZkyoi9vDKmc1VIS6oWBCqt4Qg/jb8I48dJFfa
         K5e7NFg30ZZnQ==
Received: from [192.0.2.1] (unknown [8.21.10.21])
        by st43p00im-ztdg10073201.me.com (Postfix) with ESMTPSA id A73CF2224F3;
        Fri, 10 Apr 2020 12:46:55 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Lia Rosas <rosaslia360@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Fri, 10 Apr 2020 08:46:54 -0400
Subject: Re: [PATCH v2 0/2] Explicitly fflush stdout in git clean
Message-Id: <79600DED-D486-43D9-BB4A-5D109C50C0CB@icloud.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de, peff@peff.net
To:     gitgitgadget@gmail.com
X-Mailer: iPhone Mail (17D50)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-04-10_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=240 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2004100106
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Sent from my iPhone
