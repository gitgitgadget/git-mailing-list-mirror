Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5A8C761AF
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 19:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjDETsM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 15:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbjDETsE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 15:48:04 -0400
X-Greylist: delayed 33582 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 05 Apr 2023 12:47:58 PDT
Received: from mail.zombino.com (c2.zombino.com [IPv6:2a01:4f9:c010:1e4d::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACE165A9
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 12:47:58 -0700 (PDT)
Received: from [192.168.1.208] (port-92-195-131-225.dynamic.as20676.net [92.195.131.225])
        by mail.zombino.com (Postfix) with ESMTPS id 5FA863E9D7;
        Wed,  5 Apr 2023 19:47:56 +0000 (UTC)
Message-ID: <d04c430e-b609-b0a1-fd0f-0f3734d5c3b1@zombino.com>
Date:   Wed, 5 Apr 2023 21:47:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: git clone of empty repositories doesn't preserve hash
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <e7a8957e-6251-39f1-5109-87d4dd382e81@zombino.com>
 <xmqqr0syw3pe.fsf@gitster.g>
Content-Language: en-US
From:   Adam Majer <adamm@zombino.com>
In-Reply-To: <xmqqr0syw3pe.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/5/23 21:04, Junio C Hamano wrote:
> Does such a clone copy the name of the primary branch from the
> remote repository to the newly created repository?

Yes it does.

# git init -b maestro --object-format=sha256 a
# git clone a b
# cat b/.git/HEAD
ref: refs/heads/maestro

- Adam

