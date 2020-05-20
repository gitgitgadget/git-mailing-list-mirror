Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FF8C433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 21:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE25E207F9
	for <git@archiver.kernel.org>; Wed, 20 May 2020 21:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="n81Cy2zz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgETV1r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 17:27:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53558 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgETV1r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 17:27:47 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0514960C3F;
        Wed, 20 May 2020 17:27:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UUe2IwRN2bTF9p6k9BaQV9QhmF8=; b=n81Cy2
        zz0NG0e/OaHM329LjbItmXlkup6AkN45uvoHZxpSJeKN0kSWJJA7cahrm5GJx5RL
        kCgtW7N3hP8ws9sCVkvbn8PiZGbvAIQ0Exd8KxIgmsgo/OtNXjz/fR7tJZdhRfyU
        i6R/tdHfELd6JuP7pitiZZsmAIhxeIDK846qk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XG13JFup70XGShknSwtiPo0T2xDD5xud
        FUHs19dPnPZv8phTwndCeoSVxW+bg9aegY3F12MHG7N9pGd5qsTRdVXW1k3/Oql4
        /o7JuC8VEQgOLOPi0P276H2K2/htqsWZdpjB8TdigMnjJscnRnGhwe6wd7GJOt/J
        a8MyENlBVv4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F271860C3E;
        Wed, 20 May 2020 17:27:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 86DA560C3D;
        Wed, 20 May 2020 17:27:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: How do Git on Linux users launch/read the user-manual?
References: <8142f64b-9b5e-3637-21a2-3671dd65a42e@iee.email>
Date:   Wed, 20 May 2020 14:27:26 -0700
In-Reply-To: <8142f64b-9b5e-3637-21a2-3671dd65a42e@iee.email> (Philip Oakley's
        message of "Wed, 20 May 2020 21:58:12 +0100")
Message-ID: <xmqqtv0athz5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B3A7EF02-9AE0-11EA-96CF-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> I can then browse that directory to find user-manual.html and open it
> from there (because I know it is there!).
>
> How do Git on Linux users launch/read the user-manual?

Start from the same starting point

$ git help -w git

and then navigate to the link to "Git User Manual"?

