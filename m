Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E485C41513
	for <git@archiver.kernel.org>; Tue, 15 Aug 2023 18:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239018AbjHOSOR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Aug 2023 14:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238872AbjHOSOB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2023 14:14:01 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA081999
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 11:14:00 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9DB1C1915D3;
        Tue, 15 Aug 2023 14:13:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=esrYIoMSEEJvwxkxkxYn+4PJD+2rwh3a11TYGm
        SAQK0=; b=TiUCYnU47b+d6LewrCMwljl1h5K6hFYTyBsndh2jwegZCuF/uFA6LH
        J3J9nFTwSR5rFsxnDP95bJ8OG2cK3m8Y2nCtBb/XghaOv6WwPYNOo5YVCA2oa7ch
        qtqVCEfMVuscBLyLavCOBElmKUkHDvbd9DskRK+pDNUOl2+o1DNNU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 946F61915D2;
        Tue, 15 Aug 2023 14:13:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 06AEB1915D1;
        Tue, 15 Aug 2023 14:13:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andy Koppe <andy.koppe@gmail.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] pretty: add %(decorate[:<options>]) format
References: <20230715103758.3862-1-andy.koppe@gmail.com>
        <20230715160730.4046-1-andy.koppe@gmail.com>
        <kl6l351j22dr.fsf@chooglen-macbookpro.roam.corp.google.com>
        <CAHWeT-ZA8f-TGRwDHixAvi5kddVBbuK8LpVGJ9cjYZMsMk5ODw@mail.gmail.com>
Date:   Tue, 15 Aug 2023 11:13:54 -0700
In-Reply-To: <CAHWeT-ZA8f-TGRwDHixAvi5kddVBbuK8LpVGJ9cjYZMsMk5ODw@mail.gmail.com>
        (Andy Koppe's message of "Fri, 11 Aug 2023 19:59:29 +0100")
Message-ID: <xmqq7cpwjhr1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F82C0E8-3B97-11EE-9176-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andy Koppe <andy.koppe@gmail.com> writes:

> Done. I think I had started off main, wrongly assuming that it's the
> same as master.

If there is 'main' that is different from 'master', that sounds like
a problem to me.  This project predates the newer convention that
allows the primary branch to be named 'main', but many new folks of
course expect to see 'main', so while my primary working areas all
call the primary branch 'master', it is pushed out to both names.

Or at least I thought I arranged that to happen.

Thanks.


