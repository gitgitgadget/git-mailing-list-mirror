Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2A5C433E7
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 21:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1AC122203
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 21:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NrfbIvWe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgJHVCE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 17:02:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54681 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgJHVCE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 17:02:04 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D093680687;
        Thu,  8 Oct 2020 17:02:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dDI2ceW7Xl2N08htXHYEB0lh74s=; b=NrfbIv
        WexHb+xcpjPUe0RKTjVWgouDxokKeNLdyZU7n3wnbU0cfnrd7CimyUEJB4vNrrHd
        Jf8HHiy5gmBfzPa2f2H8dQHvSXTApb9oJ8eqGsWSoKVWgefkG3T//nG4ys7MNhjb
        mHuxeYeUAXlmHjiJLTzukooasU7moWKKzRf4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gyifO7co1Vs0G70d1vjki02nUt+Vn+V/
        bTWXIEEGnAFGZZVnBlT7izCXNx10ZW33YlPuOXCUs+7UKb+MVW/Qg3sw4oG2n3ek
        r/MS4PqaV8bGwM1bG1cWCuoiD9xBT5i17N5VSXnvL5gVjQKaBqpHX8BCERd5DO3X
        TwUcC8CgJmQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7FAE380686;
        Thu,  8 Oct 2020 17:02:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 64FD280685;
        Thu,  8 Oct 2020 17:01:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/4] git-bisect-lk2009: make continuation of list indented
References: <20201008202357.15490-1-jn.avila@free.fr>
Date:   Thu, 08 Oct 2020 14:01:58 -0700
In-Reply-To: <20201008202357.15490-1-jn.avila@free.fr> (=?utf-8?Q?=22Jean-?=
 =?utf-8?Q?No=C3=ABl?= Avila"'s
        message of "Thu, 8 Oct 2020 22:23:54 +0200")
Message-ID: <xmqqft6owhx5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 81A8674C-09A9-11EB-B46C-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All four patches looked quite sensible.  Thanks, queueud.
