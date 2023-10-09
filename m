Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BBCCD612F
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 20:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378507AbjJIUCf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 16:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378490AbjJIUCe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 16:02:34 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C35E4
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 13:02:30 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C13F1A12A6;
        Mon,  9 Oct 2023 16:02:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=KBg2pLCoDJ+2Bg/AiD2J0zWZtEftqnRCf1U+2i
        bM02k=; b=jCStXBnho2n9R/5y04HwgllogUElrfPHSY8d/1zfW/81isNzse8puu
        /xJWrvLgrayyygZThpH6av6OtrIWqziiH72aLys0o+eyqXgmBqtCbvAV+4G2u1av
        8ez5NctSBvQ2WwKU2u0XNR5G3UIlYbsYemEjDmN0zr1HP7ZqpxU9g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 129041A12A5;
        Mon,  9 Oct 2023 16:02:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 70C421A12A4;
        Mon,  9 Oct 2023 16:02:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 0/3] diff-merges: introduce '--dd' option
In-Reply-To: <20231009160535.236523-1-sorganov@gmail.com> (Sergey Organov's
        message of "Mon, 9 Oct 2023 19:05:32 +0300")
References: <20230909125446.142715-1-sorganov@gmail.com>
        <20231009160535.236523-1-sorganov@gmail.com>
Date:   Mon, 09 Oct 2023 13:02:28 -0700
Message-ID: <xmqqmswry36z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C68A27F2-66DE-11EE-9E8F-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Updates in v4:
>
>   * Removed "(which see)" reference from documentation that caused
>     confusion.
>
>   * Removed explanation why it's --dd and not simply -d from commit
>     message.
>
>   * Refined --remerge-diff short description according to Junio and
>     Elijah comments.
>
>   * Added explanation of --dd purpose.
>
>   * Fixed style and syntax of "on,m::" description.

Will replace.  Thanks.

