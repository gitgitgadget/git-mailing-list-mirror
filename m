Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8290F202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 04:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751168AbdJBEXv (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 00:23:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59480 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751120AbdJBEXu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 00:23:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CAFA4A381E;
        Mon,  2 Oct 2017 00:23:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=h43b/DxoiXUPhJMO0UfyTt2/aoM=; b=yTw3YZ
        kIO/cmAhFk33f09bfHAfdaaEf9qToZjKDgo2WkJOZMyqa7wTwVeDuwxETpkQfpev
        aVdZevO2JustmuSC7AFHmTwKvF/zTJFNjLPn1bI/PfQDqRoKIVqwX/5Vt0Jbnm7f
        7BefgQjvK6w4xUnWIjnjfGdxEbb6vbtTAl/oI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wAzGzNTXwLYTBRde+YYGtf/xUL3AMK0O
        2Q2NR6ndPwMIc2eMEB0tbGZw29sQCuT6yotYhHuBUtbJMlqH/aK1UmSY8UrW9IEB
        13T6TdB2uaubOq0GLghd5sAL5r2v2zIZNBiAXVv1wwLVfqHS6XJA/MhGx5akEdqy
        58LOpbzy3P4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C34A3A381D;
        Mon,  2 Oct 2017 00:23:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 49072A381C;
        Mon,  2 Oct 2017 00:23:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, peartben@gmail.com,
        christian.couder@gmail.com
Subject: Re: [PATCH 00/18] Partial clone (from clone to lazy fetch in 18 patches)
References: <cover.1506714999.git.jonathantanmy@google.com>
Date:   Mon, 02 Oct 2017 13:23:48 +0900
In-Reply-To: <cover.1506714999.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Fri, 29 Sep 2017 13:11:36 -0700")
Message-ID: <xmqqshf2p48b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D24A6B2-A729-11E7-9FE2-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Jeff Hostetler has sent out some object-filtering patches [1] that is a
> superset of the object-filtering functionality that I have (in the
> pack-objects patches). I have gone for the minimal approach here, but if
> his patches are merged, I'll update my patch set to use those.
>
> [1] https://public-inbox.org/git/20170922203017.53986-6-git@jeffhostetler.com/

Sounds good.  Or perhaps rebasing the other way around, if we feel
that the "fsck with known-missing object" part of your series is
with a better done-ness than Jeff's series (which is my impression
but I has an obvious bias that I happened to have reviewed your
series with finer toothed comb before I saw Jeff's series).

Thanks for working well together ;-).
