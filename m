Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C67C001B2
	for <git@archiver.kernel.org>; Thu, 22 Dec 2022 10:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbiLVKsz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Dec 2022 05:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235322AbiLVKso (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2022 05:48:44 -0500
X-Greylist: delayed 434 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Dec 2022 02:48:42 PST
Received: from 7of9.schinagl.nl (7of9.connected.by.freedominter.net [185.238.129.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AC227906
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 02:48:42 -0800 (PST)
Received: from [10.2.12.6] (unknown [10.2.12.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 7of9.schinagl.nl (Postfix) with ESMTPSA id A2B881895845
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 11:41:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
        t=1671705686; bh=/MB2JdpLWK7yzqq4xJum28tRSieATN8cqZ0nKr9ZHY0=;
        h=Date:To:From:Subject;
        b=qygQg+U8QjD4vic3HbWXiqcjisSGOQ8qfvUg52yiLAQjDWlOibzSUz3p3kIk/dm5Q
         qaf5oefZ7RgKUCyYHiX7OXbNYZK1/ne+6LXfx5RFEt9yWzY1z+ppzObmg/3TZX47lc
         Abb4WgF7UBo7L5jRD/wpOudqmJcSEr192Vz62xrI=
Message-ID: <7bfd9ca1-43c0-6c2a-b220-5ad4bac82faf@schinagl.nl>
Date:   Thu, 22 Dec 2022 11:41:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
To:     git@vger.kernel.org
Content-Language: nl, en-US
From:   Olliver Schinagl <oliver@schinagl.nl>
Subject: git: The break command does not allow for comments
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When doing an interactive rebase, I'd like to leave notes to myself why 
I'm doing a break somewhere. Currently, the 'b' or 'break' command do 
not like any arguments.

It should however be quite alright  to add a (quoted) string after a 
break, without it causing to error out.


Olliver

