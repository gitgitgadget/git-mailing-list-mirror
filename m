Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B220C433F5
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 21:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347885AbiDDVzn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358180AbiDDVpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 17:45:09 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870602DABA
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 14:38:10 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 45EF711D438;
        Mon,  4 Apr 2022 17:38:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=M7rdEvgTZwntjT+2Fs44MFjUUnBDyAHCtYRjLS
        HHb48=; b=d6wjGgoDlM8rSWXkEMPkjUQSdy2xsYC4y6FUri9yYt4zydJLsUzs0y
        NHtYoJBMtaYlJMIwAUTpHJVPwTxjJJTmZCfE2Wb+bVRWfR/c86wmZAs6qJJc9G0r
        /8pmJS4oqio5qk31/lcuYBcQeCprm6mvajtc3gJxNyb5WMss8ekKY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3CDB411D437;
        Mon,  4 Apr 2022 17:38:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9C7C511D434;
        Mon,  4 Apr 2022 17:38:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        git@vger.kernel.org, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, rogi@skylittlesystem.org, bagasdotme@gmail.com
Subject: Re: [PATCH v9 3/4] vimdiff: add tool documentation
References: <20220329224439.290948-1-greenfoo@u92.eu>
        <20220330191909.294610-1-greenfoo@u92.eu>
        <20220330191909.294610-4-greenfoo@u92.eu>
        <d01710e1-8a42-e4d1-5034-f6796372587e@gmail.com>
        <xmqq1qydu6r1.fsf@gitster.g> <YktOTyBq/O9Myev6@zacax395.localdomain>
Date:   Mon, 04 Apr 2022 14:38:07 -0700
In-Reply-To: <YktOTyBq/O9Myev6@zacax395.localdomain> (Fernando Ramos's message
        of "Mon, 4 Apr 2022 22:00:15 +0200")
Message-ID: <xmqqilro34xs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84EBCA54-B45F-11EC-9E75-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fernando Ramos <greenfoo@u92.eu> writes:

>> > typo here: implementation (by bad!)
>> >
>> > Maybe Junio will correct it before merging to next ?
>> 
>> Thanks.
>> 
>> $ git range-diff @{1}...
>> 1:  7efd9fdf62 ! 1:  7b5cf8be18 vimdiff: add tool documentation
>>     @@ Commit message
>>          take configuration options not explained anywhere else (as it is the
>>          case with the 'vimdiff' tool and the new 'layout' option)
>>      
>>     -    Note that the function 'show_tool_names', used in the implmentation of
>>     +    Note that the function 'show_tool_names', used in the implementation of
>>          'git mergetool --tool-help', is also used in Documentation/Makefile to
>>          generate the list of allowed values for the configuration variables
>>          '{diff,merge}.{gui,}tool'. Adjust the rule so its output is an Asciidoc
>> 2:  3e7aa9c425 = 2:  980145f747 mergetools: add description to all diff/merge tools
>
> Thanks! No need to roll out a v10, then?

Correct.  Thanks.
