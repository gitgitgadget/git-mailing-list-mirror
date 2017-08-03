Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CF991F991
	for <e@80x24.org>; Thu,  3 Aug 2017 20:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbdHCUrK (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 16:47:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58807 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751696AbdHCUrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 16:47:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 12DBBA7D2D;
        Thu,  3 Aug 2017 16:47:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OSSHJ0niKTiuNNeT1GA3QK82lt0=; b=Rfj3m6
        b04lSk2ag3MblNU5zgil+oStjmlVdCZ3SPVr/w5e6EqDwEOzyyOC6pV+0rDQ329d
        WQe6qfvHwMYizO3EDuZeTucjcbzJPeN9YHCgHPKG1P+zChAwRTVy2ZBoOPoOG9XA
        tw9gkJU0a5UwoYw7hKHTKiD1DmtjHum3Exa2w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GAQH5hBq7lGEIxMl8iWYuIFgNuU5Gfiq
        PEk2VWZnT7lJCEQiAiEC0wwAkEBE+cYgSBri7iSPB7ZjJQ++ZepINWNkTET8g0L1
        efyOu+HZdzL0aQ7ml8vCW9aln28nDL0GGC4DgGic3hpr4AXtt9BPumtl5uz7N9F0
        TOglMx0MAI4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A267A7D2C;
        Thu,  3 Aug 2017 16:47:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 53CAFA7D2A;
        Thu,  3 Aug 2017 16:47:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alejandro Aguila <aguilasainz@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Cloning an specific commit from the hash
References: <CA+kp=uoHiP8t_40yZvT7r9ziB4uSxgcc=NRY0+XzQJDkuJpx4A@mail.gmail.com>
        <xmqqtw1opnla.fsf@gitster.mtv.corp.google.com>
        <CA+kp=uq1L7TFjXMCoFaNxq5wCNtKWw48MXFX_Unh-QxDf587dg@mail.gmail.com>
Date:   Thu, 03 Aug 2017 13:47:07 -0700
In-Reply-To: <CA+kp=uq1L7TFjXMCoFaNxq5wCNtKWw48MXFX_Unh-QxDf587dg@mail.gmail.com>
        (Alejandro Aguila's message of "Thu, 3 Aug 2017 12:55:31 -0500")
Message-ID: <xmqqh8xowf90.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA87A400-788C-11E7-9F79-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alejandro Aguila <aguilasainz@gmail.com> writes:

> Thanks Junio!
>
> Is there any chance to find out what are the trees for the dependencies?

That's not a Git question, but a question to whatever project you
are working with, I would think.
