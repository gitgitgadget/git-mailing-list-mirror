Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD47C433F5
	for <git@archiver.kernel.org>; Thu,  5 May 2022 15:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381457AbiEEQAH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 12:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242926AbiEEQAF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 12:00:05 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED36F1AF27
        for <git@vger.kernel.org>; Thu,  5 May 2022 08:56:24 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CF063125D90;
        Thu,  5 May 2022 11:56:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K7i/TpeEzWBwRQPjoXxbyHssinq98FsLkPz+0v
        jO60g=; b=JGy63SJ0dW/3G/OMbmShneUAuFRxfc5ZNbMyG8+1T0xWYQAJDd3sLg
        8OmnunQcEIS6DoDTPiM6krOusa0qDa7Tqc2UqUe3assKZ0SnmgIMVqcWzyNk56TA
        LrgJF9SgrsEdg5eJO4jbB76E1jBqH2hQxDaVkLS7LQBIg2Hc/x+m8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C5354125D8F;
        Thu,  5 May 2022 11:56:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 31EDF125D8D;
        Thu,  5 May 2022 11:56:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>
Subject: Re: What's cooking in git.git (May 2022, #01; Mon, 2)
References: <xmqqilqnvacd.fsf@gitster.g>
        <0facc01f-ee36-333a-eb25-9c98d616700e@github.com>
        <xmqqy1zhmftk.fsf@gitster.g>
        <CABPp-BHDKRX4sW_Jjqw5j7Voas0X_xkFZgg5Jqk0TkNZOd7k1g@mail.gmail.com>
Date:   Thu, 05 May 2022 08:56:22 -0700
In-Reply-To: <CABPp-BHDKRX4sW_Jjqw5j7Voas0X_xkFZgg5Jqk0TkNZOd7k1g@mail.gmail.com>
        (Elijah Newren's message of "Thu, 5 May 2022 08:04:49 -0700")
Message-ID: <xmqqmtfwezx5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E989591A-CC8B-11EC-A157-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On v2 you said, "There are a few things that I found questionable, but
> they were mostly documentation issues".  You brought up several points
> in v2 where my wording in the Documentation was admittedly suboptimal,
> though I think I addressed all of those in v3.

Correct.  The above is all assuming that "cone is the future" is
what is shared by the population that depends on sparse-checkout.  I
do not have strong opinions to declare that, but to help the topic
move forward, I was giving reviews under the condition, i.e. "If
there is such a concensus, here are the things in your current
iteration that would need to be addressed".

I vaguely recall there were folks who didn't like the change of
default the last time you brought this topic up.  Convincing them is
not my job---it is yours.  Mine has been to help prepare the code
ready for public consumption when that happens.
