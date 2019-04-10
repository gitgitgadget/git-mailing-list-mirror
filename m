Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26D0220248
	for <e@80x24.org>; Wed, 10 Apr 2019 00:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfDJArD (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 20:47:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64430 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfDJArC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 20:47:02 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C1DD413DDF0;
        Tue,  9 Apr 2019 20:47:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=JOuSQmEfaW1DJyCW2gi5ZEHljAw=; b=YtlUO0P
        m5eddt1fDfx/iFfntv2l0NRcSpP6juPdpTUAfj4tumAJpUNNE7pNw6ubmVaMp1X/
        V16Yug6U/nvCBgPdlqPZfrrsIOWrCIrzZmIapi4E6BSBBoe2cqWoxkcQJ0+0fksi
        kJ7wjX/571griu4Ct+iPAM3dvpoqvyARnYno=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=ZE0pYWTmPWhoiVpH5X/uT6QFmOLb4iVdd
        f09VHgOKJ10JsM/4K/KbPsrT+XVwYQmOfkStu9gDe/ms0vEpkhb84jTk4LynvslA
        k0fdyWAb5IV/G9y7JFjH0l950LYOfBNAH2ET44F/6dNeUZMKF6ar90DiNxrkWm8Q
        jsDrRDuH4o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9236613DDEF;
        Tue,  9 Apr 2019 20:47:00 -0400 (EDT)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EE4F213DDEE;
        Tue,  9 Apr 2019 20:46:59 -0400 (EDT)
Date:   Tue, 9 Apr 2019 20:46:58 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2019, #02; Wed, 10)
Message-ID: <20190410004658.GN3654@pobox.com>
References: <xmqqr2ab2gs6.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr2ab2gs6.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: 2641C940-5B2A-11E9-BDE7-1646B3964D18-09356542!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:
> * tz/doc-apostrophe-no-longer-needed (2019-04-08) 1 commit
>  - Documentation/git-show-branch: drop last use of {apostrophe}
> 
>  Doc formatting fix.
> 
>  Will merge to 'next'.
> 
> 
> * tz/git-svn-doc-markup-fix (2019-04-08) 1 commit
>  - Documentation/git-svn: improve asciidoctor compatibility
> 
>  Doc formatting fix.
> 
>  Needs a better description.
>  cf. <CAN0heSpL_pQMtDaEdDgcsC_Sso45owHjRttrdp7cQdYOb7i9BA@mail.gmail.com>

I sent a v2 as <20190410003734.17124-1-tmz@pobox.com> which
(I hope) improves upon both commit messages.

Thanks,

-- 
Todd
