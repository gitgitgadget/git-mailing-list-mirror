Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BBDE74911
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 18:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjJBS6V (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Oct 2023 14:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjJBS6T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2023 14:58:19 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EE3AC
        for <git@vger.kernel.org>; Mon,  2 Oct 2023 11:58:17 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4F9B32874C;
        Mon,  2 Oct 2023 14:58:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=KnnKbALyTUQMkSdC9W/aaG6S5az7g0YVJSX8kq
        D2png=; b=RRCLjVm52EkrGINag7sAZuVrcd2/FyUl5wx512mWx4XXpVckA7xARc
        is/6mxhP67M8R07AvqB15ckTj3zBg7KDp4f/8gVIlx/Hg84aeVs8KxlNMQCr66fO
        VMfVGOrpsQMF8pBfi+7IJ+PMSW+A11u4nY+04kgBTGL2HoBuzkxys=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 47DC92874A;
        Mon,  2 Oct 2023 14:58:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7C18728748;
        Mon,  2 Oct 2023 14:58:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Javier Mora <cousteaulecommandant@gmail.com>
Cc:     cousteau via GitGitGadget <gitgitgadget@gmail.com>,
        Josh Soref <jsoref@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] git-status.txt: fix minor asciidoc format issue
In-Reply-To: <CAH1-q0g+xdb_mUi0sXrQjF4nkX1Nkpops_V1e86qACLxs1uPqg@mail.gmail.com>
        (Javier Mora's message of "Mon, 2 Oct 2023 00:51:53 +0100")
References: <pull.1591.git.1696193527923.gitgitgadget@gmail.com>
        <xmqq7co6f1le.fsf@gitster.g>
        <CAH1-q0g+xdb_mUi0sXrQjF4nkX1Nkpops_V1e86qACLxs1uPqg@mail.gmail.com>
Date:   Mon, 02 Oct 2023 11:58:09 -0700
Message-ID: <xmqqzg103l8e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A220F99C-6155-11EE-B050-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Javier Mora <cousteaulecommandant@gmail.com> writes:

> Only problem is that that patch doesn't use the same formatting as the
> rest of the document (uses a code block / preformatted text instead of
> a list as other options in the document do) so my version of the patch
> is just a minor cosmetic improvement now.

Either one is a minor cosmetic improvement ;-)  I do agree with you
that it is more appropriate to use the enumeration.  A patch on top
of 'master' (which now has Josh's fix) would be very much welcome.

Thanks.
