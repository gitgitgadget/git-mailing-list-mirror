Return-Path: <SRS0=+hCi=DN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2BCC4363A
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 00:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E5F6206F4
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 00:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="t6tRFIWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgJFAOD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 20:14:03 -0400
Received: from st43p00im-ztbu10063701.me.com ([17.58.63.178]:44013 "EHLO
        st43p00im-ztbu10063701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725865AbgJFAOC (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Oct 2020 20:14:02 -0400
X-Greylist: delayed 453 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Oct 2020 20:14:02 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1601942789;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:To;
        b=t6tRFIWndhcQgOmDO7uYKudPXgAmNVwY5sUzvBqEZGcWuuNzOQ5xsWqmjQy4RwYh/
         0iTqaQ4AbSJPOf/U5Xac5zww8NpfyWYuFcqvu/Op5M6MQZ884Q1Vli9W8oMSwjCP4/
         G5jhKrV79yemy+v+t3DIxEPByGbgEr4eUuNFjqXapc0dtChczwQbxI7FU8pQmYXrp+
         i3d+n4CXw2CEQqGUiPrUuh4qBcOb/bAVhioUq13xEhlGOqJyjDU1oVEihTW9aylWs0
         EWY5i2f1aRschdMZZ3W+yJHWE1A0nyW2tfMcfSWOSzjc1aRNeSYMaUrauhuJKv8Y2L
         7fbAaYcLljr1Q==
Received: from [172.16.30.1] (unknown [172.98.76.98])
        by st43p00im-ztbu10063701.me.com (Postfix) with ESMTPSA id F187A9A0347;
        Tue,  6 Oct 2020 00:06:28 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Luv MeZza <lovemizu55@icloud.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] unpack-trees: do not set SKIP_WORKTREE on submodules
Date:   Mon, 5 Oct 2020 20:06:27 -0400
Message-Id: <79226541-6B0D-4C54-A7F6-A7B276F5EC31@icloud.com>
Cc:     dstolee@microsoft.com, git@vger.kernel.org,
        matheus.bernardino@usp.br, newren@gmail.com
To:     gitgitgadget@gmail.com
X-Mailer: iPhone Mail (17C54)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-05_19:2020-10-05,2020-10-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=511 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2010050170
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Sent from my iPhone
