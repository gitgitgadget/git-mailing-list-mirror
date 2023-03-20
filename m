Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA12C7618A
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 07:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjCTH32 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 03:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjCTH30 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 03:29:26 -0400
Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1A9C17E
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 00:29:25 -0700 (PDT)
Received: from [192.168.42.163] (8-99-142-46.pool.kielnet.net [46.142.99.8])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id 718FE3C135B;
        Mon, 20 Mar 2023 08:29:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
        s=kas202302241129; t=1679297363;
        bh=vYXeaBWoRrVCKFvDXKSoojGJ87Qr2muz/C59onM6f+0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bUMHhxh1CGSsMe4aSOKxKzY+7wstpxDZpgkzoj/Rj295l4ptffk0AQut+r0mfjzHD
         TpWGzVsikgavSTjLxJUif5FZaCn1UFUVwkPwuDDZ56PGL8CRAvusDEeKYhonWHUjZS
         k+58Is7f26Qpgiglms1wovRbs8CFB+RQYHWn5caxQ1b7qB0yz75Qyqd8CsyEgi+eOl
         qqVOtgoHV/aOILU+kchIRIe+tchi26qQYEgmnlSaxROj7OJ2qys+ZEjvlARlW28Y/9
         OaRXjehUWTQ3COm6vL8zYGVfX2hzAdBhj4MxLztkvcG+WASRKctD3naLNWtrVDa/Mr
         gTmRkqLN9f+/w==
Message-ID: <7917bb3f-d5cb-a691-6be3-ab453271d2e7@haller-berlin.de>
Date:   Mon, 20 Mar 2023 08:29:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH] rebase -i: do not update "done" when rescheduling command
Content-Language: de-DE, en-US
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
From:   Stefan Haller <lists@haller-berlin.de>
In-Reply-To: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19.03.23 15:48, Phillip Wood via GitGitGadget wrote:
>     Stefan - thanks for reporting this, hopefully it will be easy enough to
>     update lazygit to check the last command in the done file as well as the
>     second to last command for older versions of git.

Thanks for the fix. Yes, it should be easy to adapt lazygit to the new
behavior.

-Stefan
