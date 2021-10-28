Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6561C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 22:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A34FF608FE
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 22:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhJ1WbF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 18:31:05 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57814 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbhJ1WbE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 18:31:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5901C156117;
        Thu, 28 Oct 2021 18:28:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4nUVNilZATbeHtmORH4Lbvpfw7pJoiR5nqzAYD
        Gmluk=; b=d/J/xM1MXIAHDK3H2M+gTSoFj+3KCISuT2uED4IpWYbfIyHo93ocN9
        lEBI3HSwZ6bh+PwG6qGWN3xavIbO4Kbi3chdjHhGb18qQdb0dDDPPVr9PbhlgMx0
        gkc3YUXQkVG3KtghehREcPvirjairKUDOVynCTsskSAAO9N61MhRE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5114F156116;
        Thu, 28 Oct 2021 18:28:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9FA35156115;
        Thu, 28 Oct 2021 18:28:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nicholas Bransby-Williams <nbransby@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: conflict markers in markdown files
References: <CAGyLXMBWyfcBVFDRbYJMk+-RjjNBQDvoDeaBtEPiXpUDDTqfOA@mail.gmail.com>
        <xmqq5ytgrkku.fsf@gitster.g>
        <CAGyLXMA93qQw_h97bMd14O26hSxn4xn+AzemVyrf6pn53qO3UQ@mail.gmail.com>
Date:   Thu, 28 Oct 2021 15:28:32 -0700
In-Reply-To: <CAGyLXMA93qQw_h97bMd14O26hSxn4xn+AzemVyrf6pn53qO3UQ@mail.gmail.com>
        (Nicholas Bransby-Williams's message of "Thu, 28 Oct 2021 21:33:45
        +0100")
Message-ID: <xmqqilxgpywf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 62B33DFC-383E-11EC-9616-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicholas Bransby-Williams <nbransby@gmail.com> writes:

> I guess using such a long marker makes it less likely but there no
> reason you wouldn't have a 32 character long title in markdown
>
> Example.... :)
>
> An important heading in markdown
> ================================

You probably missed the part that I said .gitattributes is under
control of those who are editing the files the entry refers to.  So
when you edit the file and add such a line, you can easily edit the
attributes file and pick an appropriate number.
