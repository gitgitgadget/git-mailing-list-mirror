Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563D9C001B0
	for <git@archiver.kernel.org>; Wed, 19 Jul 2023 21:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjGSVfM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jul 2023 17:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGSVfL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2023 17:35:11 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21311FD7
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 14:35:10 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4F6D231AAB;
        Wed, 19 Jul 2023 17:35:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AQr3sG9ubLPFx+PYOig9mtiEUk6fWdsgK790SH
        XKGck=; b=MwdDyaRLQKyDEerUbDfmHXV4XoF+LbsJs1jtXg4BnLJGQdETp8BlIw
        ViJMqyUbCIKmkEsT4IWvmO791wxH9/Wcdihtp1rez3O2PTgOd+w1kpYGUeGW1RI/
        8lJkcKkv8cZ5+qpy0tVwYbNkxubk8mZZVlFfTSCiTtvNAx4VrChOY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4A00431AAA;
        Wed, 19 Jul 2023 17:35:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B2F3A31AA9;
        Wed, 19 Jul 2023 17:35:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Herrmann <aherrmann@suse.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] configure.ac: misc configure fixes
References: <20230719145211.17854-2-aherrmann@suse.de>
Date:   Wed, 19 Jul 2023 14:35:04 -0700
In-Reply-To: <20230719145211.17854-2-aherrmann@suse.de> (Andreas Herrmann's
        message of "Wed, 19 Jul 2023 16:29:52 +0200")
Message-ID: <xmqqy1jb8u0n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 210EB826-267C-11EE-8CC5-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Herrmann <aherrmann@suse.de> writes:

> Andreas Herrmann (3):
>   configure.ac: don't overwrite NO_EXPAT option
>   configure.ac: don't overwrite NO_CURL option
>   configure.ac: always save NO_ICONV to config.status

All patches look good.

Thanks, will queue.
