Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8C3C433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 12:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46B70611F2
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 12:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbhKJMDf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 07:03:35 -0500
Received: from mout01.posteo.de ([185.67.36.65]:51867 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231837AbhKJMD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 07:03:29 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 04C2B240029
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 13:00:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1636545641; bh=9/BQdn9HjneMCcSX/e4/5agJLmzv+bBXknVJlq99LV0=;
        h=Date:From:To:Subject:From;
        b=p4mZPwDXMo11yFUTA/lof/I2JN63rnPGUCCPjT6HDawQ+UP2K6X8rhJd/AbghppzW
         dmFgsTWkw1Hd/vX4MqcLQ4U0Mpyq1clffZIIr850Z9GvFocYp1vUap0Z0wMkQ1oe8k
         IRQu3dERGGLC8hoXgmJr0iXZ0sRLgo/hWv692uy66Las8/U40UD6k6Cmw5bsLBi8R0
         XG1AVVeBhmBvCWoOAzYpwDV1fqscdv6ftYo4bcwKzl8FKVmUGiRi/55wX4gNKSzk0D
         rIsqoZFAuVcYYr+whnzW+r5iIwxEsXwRnVMdtsVMeCM9MhEf0PjjTdqNJk5S13Esuz
         7RE2L2zb/0FIg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Hq3MX44d1z6tn1
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 13:00:40 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 10 Nov 2021 12:00:40 +0000
From:   andre_pohlmann@posteo.de
To:     git@vger.kernel.org
Subject: bug or a general misunderstanding
Message-ID: <0bb0056a59cda294d416762d7f8a9c47@posteo.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello there

I'm not sure if I'm in the right place here.
Maybe it's a bug or a general misunderstanding of how GIT works.

The following situation: I wanted to create a branch from a commit. From=20
there on the work should be continued.

The possible bug:
The newly created branch is missing commits in the history. Not only are=20
they not displayed, the code changes are not present.
It doesn't matter if the branch is created by Visual Studio or GIT for=20
Windows.
Only in a branch created by GitHub Desktop the commits are present, as I=20
would expect.

Is this a bug or do I not understand how GIT works?

Best regards and thank you for the effort
Andr=C3=A9 Pohlmann
