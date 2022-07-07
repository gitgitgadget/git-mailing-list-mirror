Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A55C433EF
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 21:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236700AbiGGVDz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 17:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236705AbiGGVDv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 17:03:51 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7DC2A428
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 14:03:51 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B55D21B9371;
        Thu,  7 Jul 2022 17:03:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=P5eX+Yc5yix2Ewk6HFyI5UZXWnu5f2bXDhinQ9
        X95YQ=; b=VPfVrUHh8F95YUJI7YvhDUY0oFCVgvM4/Bp3RGhVBtBXbfQuKYDmvj
        ZxWNG/qpjeZqnHondoqvk7BCy4X/AF0kDyFKWbgGQolaAScSbD+0rJ6r4pY3eD9g
        EroeIf4HsioLe4dLGbtUiUHYSP9inqWj5tnVV5CSzXvA9lTaOwVl8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AE8751B9370;
        Thu,  7 Jul 2022 17:03:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 35FE81B936C;
        Thu,  7 Jul 2022 17:03:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonas Aschenbrenner <jonas.aschenbrenner@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Suggestion to rename "blame" of the "git blame" command to
 something more neutral
References: <CADS2hGpnkiPzivVDyN-PnGsQCTafqx68PxigXvBK1bv4O=p4kg@mail.gmail.com>
Date:   Thu, 07 Jul 2022 14:03:46 -0700
In-Reply-To: <CADS2hGpnkiPzivVDyN-PnGsQCTafqx68PxigXvBK1bv4O=p4kg@mail.gmail.com>
        (Jonas Aschenbrenner's message of "Thu, 7 Jul 2022 17:35:41 +0200")
Message-ID: <xmqq8rp4zlcd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4B0C1E4C-FE38-11EC-A569-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonas Aschenbrenner <jonas.aschenbrenner@gmail.com> writes:

> Similar to the change of the default branch name from "master" to
> "main" to use a word which has less negative associations,
> I suggest to replace the word "blame" with something more neutral.
> Maybe "annotate". That word seems to already be used at some places
> for this Git feature.

We can help you to match the tool for your personal preference, e.g.

    $ git config --global alias.praise blame
    $ git praise COPYING

Changing what has been known for one name for a long time for other
people takes a lot more than "I do not like the word with negative
connotations".
