Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07C0C433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 05:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C37D22C9F
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 05:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbhAFF4H (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 00:56:07 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52152 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbhAFF4H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 00:56:07 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F201010C9D0;
        Wed,  6 Jan 2021 00:55:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=Z4Di8F9GCeTvWCJY8Qc3K9NIcS0=; b=LWXaFQKJu5+HmLuyRuIp
        +PWpU7hFD9HU7Snzm+PRWYQClvGP6XXDIjc8McRvrJcNfU6JndTER0R5vAxTH4pS
        Q2qJLZ2HRf4gE1Z0InwEaviXRFLmLFDBpF2z0tygkO3lZHliRH/6E/u5i/WG53nu
        t5UIVnBR0EdoNaJsBrcP0Ao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=GJGq6adN1hlbVXF63uGZfk+GxPS9dkGMRomXmQtRIiTWzX
        gwrOoxShpzUeBwDzRM+7gb7UIdr4hg60IDx6quxSbsNl7gJ27CxHPGP7phGRZixT
        /FkOcMpbYg2SLsEZRYugRzRt/kmq0upZrWmKttECUQqeuOjA7WpIQDw5F7e2g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EBEE310C9CF;
        Wed,  6 Jan 2021 00:55:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3F48810C9CE;
        Wed,  6 Jan 2021 00:55:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2020, #05; Mon, 28)
References: <xmqqeej9g325.fsf@gitster.c.googlers.com>
        <5fea87e816fff_23821208d4@natae.notmuch>
Date:   Tue, 05 Jan 2021 21:55:22 -0800
Message-ID: <xmqqv9cavcc5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C4CAA514-4FE3-11EB-8B2D-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> * fc/bash-completion-post-2.29 (2020-12-23) 4 commits
>>  . completion: bash: add correct suffix in variables
>>  . completion: bash: fix for multiple dash commands
>>  . completion: bash: fix for suboptions with value
>>  . completion: bash: fix prefix detection in branch.*
>> 
>>  Seems to break tests on Windows
>>  cf. https://github.com/git/git/runs/1597682180#step:5:35614
>
> This was addressed in v2 already:
>
> https://lore.kernel.org/git/20201223144845.143039-1-felipe.contreras@gmail.com/

OK.  The one that is queued on the topic branch is already that
version but hasn't been retested on 'seen' (notice those '.' dots in
front of the commits, not '-' dashes).  Let's include it in the
future push-outs.

