Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C306DEE3F3F
	for <git@archiver.kernel.org>; Wed, 13 Sep 2023 00:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237936AbjIMAZd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 20:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjIMAZc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 20:25:32 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C55210CC
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 17:25:28 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C8BF41B6CBE;
        Tue, 12 Sep 2023 20:25:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=klw6T1nY94hd++oyyOM+zltG9azxstfs3mvz7V
        0BeHM=; b=tdG5J2/fPf4DZGpZ+wz1aa7E27kctyWmY+LCeBEhCwz2SFd/3dkBo2
        n6du3t9i3yBtsr5kYaWP6Cm6eegq5s17CtU6kceouUyCOba2MUmPp1cEqhRQJX7c
        GLkq3jy+kE4cK4ifHsAEe/7ITomuJEVsts4KNYmtJDU6AukZvkpfk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BF85F1B6CBD;
        Tue, 12 Sep 2023 20:25:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 39B221B6CBC;
        Tue, 12 Sep 2023 20:25:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2] t3404-rebase-interactive.sh: fix typos in title of a
 rewording test
In-Reply-To: <76c36744-b821-450b-9817-e0cd8811de65@gmail.com> (Phillip Wood's
        message of "Tue, 12 Sep 2023 14:26:36 +0100")
References: <45ee4ad1-f7a3-43d8-99ef-329efc9fcdba@gmail.com>
        <20230912104237.271616-1-oswald.buddenhagen@gmx.de>
        <76c36744-b821-450b-9817-e0cd8811de65@gmail.com>
Date:   Tue, 12 Sep 2023 17:25:26 -0700
Message-ID: <xmqq8r9aly15.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 09ABE1B0-51CC-11EE-BEB8-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 12/09/2023 11:42, Oswald Buddenhagen wrote:
>> This test was introduced by commit 0c164ae7a ("rebase -i: add another
>> reword test", 2021-08-20). I didn't quite get what it was meant to do,
>> so here's an explanation from Phillip:
>> The purpose of the test is to ensure that
>>    (i) There are no uncommited changes when the editor runs. I.e.,
>> we
>>        commit without running the editor and then reword by amending
>>        that commit. This ensures that we have the same user experience
>>        whether or not the commit was fast-forwarded [1].
>>   (ii) That the todo list is re-read after the commit has been
>> reworded.
>>        This is to allow the user to update the todo list while the rebase
>>        is paused for editing the commit message.
>> [1] https://lore.kernel.org/git/20190812175046.GM20404@szeder.dev/
>> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
>
> This looks good to me, Thanks
>
> Phillip

Thanks, both.  Will queue.
