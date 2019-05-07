Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A5671F45F
	for <e@80x24.org>; Tue,  7 May 2019 15:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfEGPQQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 11:16:16 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63071 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbfEGPQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 11:16:16 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E960B663AE;
        Tue,  7 May 2019 11:16:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=20ZSrPHCg1J9uKAAiISmEGE+uHk=; b=bG39fz
        GHAaR8H5Ucq78yhu18jw4XI7vT2zhoI5x6nAIKBwOW2ZSzRidMpbOKhPYtnvs7eb
        rWQekTobyPVbmqsG8X+6Q0zqw+CFNEAlnb+8oU1zdeNgUNMPRChkoY2g8j+AWgcm
        BH2eSh9HJy+zZDPhPnCR7hEePvdY8oqkKb2vs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=flf7N7e3xb3EtOg7bf/fQHt5E2NClLZg
        XE4fyEXlDM1aXoebDwB+oayTyXY+TWzaTwNHJl4/LbSCxhfelawFWK4pf16B1L5/
        yxe8btL1ArvRj8n8ZTWk8L5NbfjiEsU6Fs3JUXE0c2H/u8oL5jKC+QWrs0b2kXfu
        KoNe6H/hXlo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E1484663AD;
        Tue,  7 May 2019 11:16:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1A50F663AB;
        Tue,  7 May 2019 11:16:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Andreas Heiduk <asheiduk@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 0/4] cleanup revisions.txt
References: <cover.1557071877.git.liu.denton@gmail.com>
        <cover.1557072286.git.liu.denton@gmail.com>
        <20190507142938.GA3769@archbookpro.localdomain>
Date:   Wed, 08 May 2019 00:16:08 +0900
In-Reply-To: <20190507142938.GA3769@archbookpro.localdomain> (Denton Liu's
        message of "Tue, 7 May 2019 10:29:38 -0400")
Message-ID: <xmqqv9ymjnwn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0BE58D2C-70DB-11E9-9689-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> I noticed that there are both `dl/rev-tilde-doc-clarify` and
> `dl/revisions-doc-update` branches. The latter comes from this patchset
> and is a complete replacement for the former.

Thanks for spotting.  Will replace the former with the updated
patches.

Thanks.
