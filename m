Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10F401FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 21:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753081AbcHZVAR (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 17:00:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64327 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752158AbcHZVAR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 17:00:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A59B391DA;
        Fri, 26 Aug 2016 16:54:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Vl1GN4EfUv5O
        RFX57ndnc0rOqVA=; b=MQg9aj+AVf5jHvVqmlgtxIc89YSbq90h7NVn/F2sRP8a
        FSCYtdKaHICQ7e7tAqdLEJ8YLa08lMstD7eCmJNoyS0MS62OmUjnp7LhLcQ6WVlh
        Bauwrqin4L7fvEWmszroWocvp7X1R6vUQDNDQpL2Ni4npbbyLc9AhWFSENkQmsU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=nDg15F
        r8YZdpknj/qfJxFvYPy0EqQfCZWF1muWs3A5YO2ev9IbX2K7sZ/nAjbCk4ViYheU
        4E2pNV4Uq8hN08Oztbw+H614B7+kONrawiU1L2oIoaGymcfKLvrsrBmif3OypOMI
        q++mYlJRkdJ0Cu4SBTFyD0EPVtFZWt9JybalE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 23715391D9;
        Fri, 26 Aug 2016 16:54:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B3836391D8;
        Fri, 26 Aug 2016 16:54:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] gitattributes: Document the unified "auto" handling
References: <xmqqpoowlgpv.fsf@gitster.mtv.corp.google.com>
        <20160826201848.28381-1-tboegi@web.de>
Date:   Fri, 26 Aug 2016 13:53:59 -0700
In-Reply-To: <20160826201848.28381-1-tboegi@web.de> (tboegi@web.de's message
        of "Fri, 26 Aug 2016 22:18:48 +0200")
Message-ID: <xmqq7fb3fdzs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 37A6DBA0-6BCF-11E6-9E7B-51057B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> Update the documentation about text=3Dauto:
> text=3Dauto now follows the core.autocrlf handling when files are not
> normalized in the repository.
>
> For a cross platform project recommend the usage of attributes for
> line-ending conversions.
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  Documentation/gitattributes.txt | 58 +++++++++++++++++----------------=
--------
>  1 file changed, 24 insertions(+), 34 deletions(-)

Looks good.  Let me merge this to 'master' before cutting -rc2.

Thanks.
