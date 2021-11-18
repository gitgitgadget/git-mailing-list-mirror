Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3435CC433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 06:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E0E661B3D
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 06:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242816AbhKRGJr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 01:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241659AbhKRGJo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 01:09:44 -0500
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [IPv6:2a01:e0c:1:1599::12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965D6C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 22:06:44 -0800 (PST)
Received: from aiailu.local (unknown [82.64.96.64])
        (Authenticated sender: thomas.koutcher@online.fr)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 5B13C13F838;
        Thu, 18 Nov 2021 07:06:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=online.fr;
        s=smtp-20201210; t=1637215602;
        bh=M9eIY+I9xuEP6sqig1OfZRlB2MJorg8IifwE7nlBYXc=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=Xu6g0sTTbRM3YwG50VoY1GkeDKAgjgOxq64lnu50v9Pz9AYRFy4FYK++SLZlIEJvZ
         +Y0X3fgaVaebknnU6QLlwKCpke61tuczm+RQ9mVSVKVVcJe6069AQ7wBrk5nhKZTG9
         1xhofx0kvKeazJ8nB8rZpq3h9U745Szj5sox0zsVl5uaoq2bJXNMunJWvahP7g2nsh
         zB1H8vNOaKG0EAVMjfuiU+2jdf7vqrWSpZYsA5E/LxhapcjLtqNlAnZsNRPPHcG+cI
         nvzGsALwykasBXli4mB4ZqTQJS6KJ8L5uZb3XQxGk+dJxo5RwBtV3K1QU70YDYrg3Z
         Er3B1h43e194A==
Subject: Re: [PATCH v2] subtree: force merge commit
To:     git@vger.kernel.org
References: <pull.1139.git.git.1636902454370.gitgitgadget@gmail.com>
 <pull.1139.v2.git.git.1636926322423.gitgitgadget@gmail.com>
 <xmqqpmqy12u0.fsf@gitster.g>
From:   Thomas Koutcher <thomas.koutcher@online.fr>
Message-ID: <0ef32d3e-7b0c-3458-7edd-1eb6a3067a83@online.fr>
Date:   Thu, 18 Nov 2021 07:06:38 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqpmqy12u0.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 18/11/2021 à 05:53, Junio C Hamano a écrit :

> Reviewed-by: is a bit tricky.  If you are sending a corrected
> version after other people just took a look at a previous iteration,
> you cannot generally have them for two reasons.  First of all, they
> haven't said that you can have Reviewed-by: under there name (which
> means that they are completely satisfied after giving a thorough
> analysis).  Also, the version you are sending is different from what
> they reviewed, so even if they were happy with the previous iteration,
> it does not mean they would be with this version.

Thanks for the clarification and sorry for the confusion I created.


