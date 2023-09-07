Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA13EC8758
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 20:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238584AbjIGUeE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 16:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236878AbjIGUeD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 16:34:03 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263DA1703
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 13:34:00 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8DB9331E8F;
        Thu,  7 Sep 2023 16:33:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=9Hwc3NfbAH78Pk2iva0thMXrbfVIQvu+cCyAIg
        uEXg8=; b=C0lromtSk5BYT3kNWmBhCdhfIZ8FM5AlgqW4q67DSbOIcvYMpkAdFs
        SvRIFC/59fGzg2xg3hOp9beuJcaR+IxHPekp4KvkMAHJSv931XsW70yptlwGdgpR
        N9tO91AZdf6Kh0KZJeqce4ecn5uz1vwj8WPcLAnr8YWG3qKc07zPk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8594431E8E;
        Thu,  7 Sep 2023 16:33:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 097CA31E8D;
        Thu,  7 Sep 2023 16:33:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 0/7] rebase -i: impove handling of failed commands
In-Reply-To: <6b927687-cf6e-d73e-78fb-bd4f46736928@gmx.de> (Johannes
        Schindelin's message of "Thu, 7 Sep 2023 11:56:39 +0200 (CEST)")
References: <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
        <pull.1492.v4.git.1694013771.gitgitgadget@gmail.com>
        <6b927687-cf6e-d73e-78fb-bd4f46736928@gmx.de>
Date:   Thu, 07 Sep 2023 13:33:54 -0700
Message-ID: <xmqqledhk9jh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DDCF3130-4DBD-11EE-92B5-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> ...
>>  6:  2ed7cbe5fff = 6:  0ca5fccca17 rebase --continue: refuse to commit after failed command
>>  7:  bbe0afde512 = 7:  8d5f6d51e19 rebase -i: fix adding failed command to the todo list
>
> Thank you for indulging me. This iteration looks good to me!

Thanks, all.  Let's merge it down to 'next'.
