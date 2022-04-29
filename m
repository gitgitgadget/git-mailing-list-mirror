Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED779C433F5
	for <git@archiver.kernel.org>; Fri, 29 Apr 2022 17:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbiD2R0J (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Apr 2022 13:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbiD2R0E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Apr 2022 13:26:04 -0400
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [IPv6:2a01:e0c:1:1599::15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2401562C3
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 10:22:44 -0700 (PDT)
Received: from aiailu.local (unknown [82.64.96.64])
        (Authenticated sender: thomas.koutcher@online.fr)
        by smtp6-g21.free.fr (Postfix) with ESMTPSA id EF1A37802CE;
        Fri, 29 Apr 2022 19:22:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=online.fr;
        s=smtp-20201210; t=1651252962;
        bh=UBDtNRkDljRqC71555lZJ4dpx0O1GIQUMZfUQr08obY=;
        h=Subject:References:From:To:Date:In-Reply-To:From;
        b=pGdw6EGcije86z82Cfg9k0sxSomaKWs/BMX1wrFCw3OVUTjLBNqwbldxK0mEDbrxb
         OLyJ72XgG4i3/tY9hYXUDGiaHaADa9j7ZnfKVUP8MYD2jCis0zNMf3BHNWvi4cnwDg
         NcHEvReFSHv72sk8S6yv37REuLFG23EjWsS3092f8DdNYUksR9wpPRvV7E7RJQu86T
         E+FJsDKM5YFLvhifqh4UetshnknOsRGKfzxUskrh5wJk0AOK1+IWr8ZmjLKhm410CR
         P1HuX6rQJD3NvCzUrvWrrrNSBVRTIo+a2KBV6tjFTmyaJNifyU+so/fVClXC+f/W10
         E6iec7Ey9KmNQ==
Subject: Re: [PATCH 0/2] diff- family --stat width
References: <pull.1256.git.git.1650572159.gitgitgadget@gmail.com>
 <xmqqczhaf7f7.fsf@gitster.g>
From:   Thomas Koutcher <thomas.koutcher@online.fr>
To:     git@vger.kernel.org
Message-ID: <4fa61676-976c-9337-4dcc-742e6fdeac99@online.fr>
Date:   Fri, 29 Apr 2022 19:22:40 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqczhaf7f7.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: fr
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano writes:
>
> I do not think it is a good move to change the output from these
> plumbing commands, whose purpose of existence is to give more
> predictable outcome, to be affected by dynamic elements like the
> width of the terminal the user happens to be using.
>
Thanks for your feedback Junio, I agree this is certainly the safest 
choice to leave them as they are. Man pages git-diff-files(1), 
git-diff-index(1), git-diff-tree(1) and git-config(1) 
[diff.statGraphWidth section] will need an update to reflect the current 
behaviour.



