Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 190201F463
	for <e@80x24.org>; Fri, 20 Sep 2019 17:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391680AbfITRAq (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 13:00:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52435 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391425AbfITRAo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 13:00:44 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F115A2D4DC;
        Fri, 20 Sep 2019 13:00:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BqOv7aLy5AyINXNbSyZevdu2PJU=; b=MApl5X
        qD8pMgzznd5MIKnEQZ42260oYMAxqGLR6fo1Xhtyz7Y5NCxslcjJPhxZsv6ca6CP
        NbuF39u4NYgNkum0mA67Z1LFih98REWyz1UF1XVZ91ovbLyG05eqtaC8agN0NDKb
        eYP/ccJfJtl0n3ZIthbDGGffTlhcoOXy1JY/o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=V6tJ/B/O7TiQ1zTIOhcxMNc6JCdcIk4H
        7TfxlHXwcnW9C8dhT47mUD2U00bDrRYVlYPMEBJRsKrEWFN9/q0LPUJHYLWPS/XM
        L4jJH7Hijh5qufiOCdvRIqMK+8mpTe6JQBpY6yV1i7kiotQ0DWUZ6LwegygEEeX8
        oAS8PZ10U4c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E79552D4DB;
        Fri, 20 Sep 2019 13:00:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BE5482D4DA;
        Fri, 20 Sep 2019 13:00:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Sep 2019, #02; Wed, 18)
References: <xmqqy2yl44lw.fsf@gitster-ct.c.googlers.com>
        <20190919213944.GA29614@cat>
Date:   Fri, 20 Sep 2019 10:00:37 -0700
In-Reply-To: <20190919213944.GA29614@cat> (Thomas Gummerer's message of "Thu,
        19 Sep 2019 22:39:44 +0100")
Message-ID: <xmqq4l16x5qi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C7F605A-DBC8-11E9-9A69-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> I have sent an updated version of this, that integrates the changes
> the js/builtin-add-i topic needs in [*1*].  I think it would be ok to
> pick up that version and keep js/builtin-add-i out of pu until it's
> rebased on top of that.

Thanks, will replace after looking it over once again.


> Dscho: to help reduce the amount of work you (and to double check that
> my series works well with the builtin-add-i series) I have rebased
> js/builtin-add-i on top of my series, and pushed the result to
> https://github.com/tgummerer/git js/builtin-add-i.  Feel free to use
> that if it helps :)
>
> *1*: https://public-inbox.org/git/20190911182027.41284-1-t.gummerer@gmail.com/.
