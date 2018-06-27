Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 892D21F516
	for <e@80x24.org>; Wed, 27 Jun 2018 20:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966538AbeF0UHr (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 16:07:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58376 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965695AbeF0UHq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 16:07:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F568E863A;
        Wed, 27 Jun 2018 16:07:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=D/y6KC52evAtSGO+0pA+XslmgRQ=; b=c8raPzB
        TLsMxYCz8ms3jUvIC1vMMT+/UuyMufc4UUd5ixN9jkXftSPqcv03TGGD45QNZWSy
        NbEVc6Mt2jd1NtQyTDW1Xzyk335zGYU0PKKgLBrVP8AsdQBgcSrZSjdVNIFC9HxX
        RtCQJV/OXBFxyaWjsaFTtwZnEF2fDYC9VgUo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=dzWM7b97fBXnLu8dvZ37EzGaq+QmLDzoB
        +Y4M6IO1uyoQf6n2fg7lT+0gVG/r/0ltJEy4HmT/u5PdWtIsSDdZPJ6jYFZZm3tN
        tCgrgP9QsWRgzW/URsfE0HbFHV+TSIWp58CxVzcwWph65CrqFalEDj/RthgNIjJI
        tm8KAdUW8o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 36D2AE8639;
        Wed, 27 Jun 2018 16:07:46 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [98.111.125.125])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A316FE8638;
        Wed, 27 Jun 2018 16:07:45 -0400 (EDT)
Date:   Wed, 27 Jun 2018 16:07:43 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] gitignore.txt: clarify default core.excludesfile path
Message-ID: <20180627200743.GL20217@zaya.teonanacatl.net>
References: <20180627044652.12080-1-tmz@pobox.com>
 <xmqqvaa4dopx.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqvaa4dopx.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Pobox-Relay-ID: C1C5AB82-7A45-11E8-9FEA-0DFB1A68708C-09356542!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Todd Zullinger <tmz@pobox.com> writes:
> 
>> The default core.excludesfile path is $XDG_CONFIG_HOME/git/ignore.
>> $HOME/.config/git/ignore is used if XDG_CONFIG_HOME is empty or unset,
> 
> ... because $HOME/.config is the default value for XDG_CONFIG_HOME
> when it is unset, that is?  If so, the change makes sense.

Indeed, that's the fallback path.

Thanks,

-- 
Todd
