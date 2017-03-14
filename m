Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 687AD20373
	for <e@80x24.org>; Tue, 14 Mar 2017 00:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753449AbdCNACW (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 20:02:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50298 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752099AbdCNACU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 20:02:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C792784F46;
        Mon, 13 Mar 2017 20:02:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EbzyNyfmYPK1fZytkZUNV49080U=; b=CSmvJj
        ScY97qrv8J/mQlPLr0IKpcOq2ocOKZbqG4/3U8R+Fz+rAHnU6eMAIDuuDqC0AXGR
        VEtGslQktYZQT5oo64pYInlNumcOhgDC9qvvUcUhCxfYmrtNOpXJUIJOoJ5WxwFw
        CV9uFoeJhFTt6jto7cwTo4Ho9qSt5/NYlIEAE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IBc8IwipJvGjLtvhqgj97PhtAnL8K2uM
        YQg0BJLeB57PqM2XU1Bpzzbzb9veq4cUVmQc3RNCKaSF8hSte0DXw58xOoj61281
        XuLvLV5UNkYfQ+7X3O/m1/nMGPRGoDMz7gj3II3BeRuP2vxInI+MdkBX6gNsg9O9
        5qfcEDv3UBQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BF3E284F45;
        Mon, 13 Mar 2017 20:02:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 383FB84F44;
        Mon, 13 Mar 2017 20:02:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Mar 2017, #05; Mon, 13)
References: <xmqq37egn6fs.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaXnHhKA=XumfxHFUbuEs3AGz2h65Jf8ufcOWqp3Mu20g@mail.gmail.com>
Date:   Mon, 13 Mar 2017 17:02:17 -0700
In-Reply-To: <CAGZ79kaXnHhKA=XumfxHFUbuEs3AGz2h65Jf8ufcOWqp3Mu20g@mail.gmail.com>
        (Stefan Beller's message of "Mon, 13 Mar 2017 16:01:24 -0700")
Message-ID: <xmqqh92wlo8m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D17D646-0849-11E7-A06F-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>>
>> * sb/rev-parse-show-superproject-root (2017-03-08) 1 commit
>>  - rev-parse: add --show-superproject-working-tree
>>
>>  From a working tree of a repository, a new option of "rev-parse"
>>  lets you ask if the repository is used as a submodule of another
>>  project, and where the root level of the working tree of that
>>  project (i.e. your superproject) is.
>>
>>  Almost there, but documentation needs a bit more work.
>
> Care to clarify what parts of docs you mean?
> https://public-inbox.org/git/xmqqr327z5rn.fsf@gitster.mtv.corp.google.com/
> sounded like the topic is done.

Thanks for spotting a leftover comment I wrote about v3; what is
queued is v4 that addresses the issues I found in that version.

Will update its status to "Will merge to 'next'", which means
reviewers (including me) are encouraged to take another look for the
last time with fresh eyes.

Thanks.
