Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C08C04A94
	for <git@archiver.kernel.org>; Wed, 16 Aug 2023 04:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241756AbjHPEYe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Aug 2023 00:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241226AbjHPEYF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2023 00:24:05 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D222102
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 21:24:04 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2312C28CB3;
        Wed, 16 Aug 2023 00:24:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=2XG8zUoDNIZvZqsL0jepriK3ch14i+6Ap6lUNhTnItw=; b=SuRA
        UGJVRwBl2EJF0oZBWfeiA8/1ywWL5jcu3Rn/WfE89fXhpAQRcvqh3Czb/j3YIqHq
        7SFSQQMdvfdGC7NbSrKJWUS+W7Odr5vaJWSkR88iob7hmWGM2Oo9DcJe80Iv64nB
        cODkrd/Ei6+/93SQJKBn183otXVe0ElOvkNGqAg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0F16228CB1;
        Wed, 16 Aug 2023 00:24:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A270528CAE;
        Wed, 16 Aug 2023 00:24:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Andy Koppe <andy.koppe@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 1/7] pretty-formats: define "literal formatting code"
References: <20230715160730.4046-1-andy.koppe@gmail.com>
        <20230810211619.19055-1-andy.koppe@gmail.com>
Date:   Tue, 15 Aug 2023 21:23:59 -0700
Message-ID: <xmqq8rabhaxs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B992F4D8-3BEC-11EE-9497-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The v3 iteration of the series that begins at

  https://lore.kernel.org/git/20230810211619.19055-1-andy.koppe@gmail.com/

08-10 ` [PATCH v3 1/7] pretty-formats: define "literal formatting code"
08-10   ` [PATCH v3 2/7] pretty-formats: enclose options in angle brackets
08-10   ` [PATCH v3 3/7] decorate: refactor format_decorations()
08-10   ` [PATCH v3 4/7] decorate: avoid some unnecessary color overhead
08-10   ` [PATCH v3 5/7] decorate: color each token separately
08-10   ` [PATCH v3 6/7] pretty: add %(decorate[:<options>]) format
08-10   ` [PATCH v3 7/7] pretty: add pointer and tag options to %(decorate)

unfortunately did not see any discussion.  Any comments?
