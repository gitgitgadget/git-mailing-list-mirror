Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3401C1F42D
	for <e@80x24.org>; Sat, 26 May 2018 21:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032408AbeEZVHz (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 May 2018 17:07:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54563 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032377AbeEZVHz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 May 2018 17:07:55 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8E060EE9C9;
        Sat, 26 May 2018 17:07:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=spgO/ks6XPx+roUls4iHH6V1TbI=; b=KxowqnN
        zOSareguFtAWxWyaRjc5OWrv84z5kr/I7ir4U/ceDQSPjy7VyW+u7kyDiYfkJV8S
        Zmkfb6IjLHvfCs0QchoRmOHR5hk3BY0eWSvxFFyx4PPVCAW3XzmpRC9x1vTGVN6C
        f/sXqjMgQ+Z7MWmhtVMagbhVtb3I7+JxfSW0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=tEuwkJ4viw+d9Nw2PeMCCKKZkeI78Di2P
        ShWUMgDuFj3iz6cx7NGb/pMBLbxnU6CKoBSmcvJ6G5JkZBOC3RNlf/07b/Xewm+0
        gYkmMmHf8Lc0lCBReIdnsVueCaCrkDz4tNtgBhO63q6RpXpN9M33K2ljIfftDU+q
        as6F/5baWA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 86308EE9C8;
        Sat, 26 May 2018 17:07:54 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [98.111.125.125])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1A97CEE9C7;
        Sat, 26 May 2018 17:07:54 -0400 (EDT)
Date:   Sat, 26 May 2018 17:07:52 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Jeff Felchner <jfelchner1@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@talktalk.net>
Subject: Re: 2.17.0 Regression When Adding Patches Without Whitespace In
 Initial Column
Message-ID: <20180526210752.GA3094@zaya.teonanacatl.net>
References: <C6CF9BE4-FC46-4B39-A862-AEBB5CD600E2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C6CF9BE4-FC46-4B39-A862-AEBB5CD600E2@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Pobox-Relay-ID: DB5A82B0-6128-11E8-9037-67830C78B957-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

Jeff Felchner wrote:
> Ever since 2.17.0, when saving a patch (using add --patch
> but probably other ways as well), if the whitespace is
> removed from the initial column, the patch doesn't apply.

This sounds a bit like the issue discussed in this thread a
few weeks ago:

https://public-inbox.org/git/e8aedc6b-5b3e-cfb2-be9d-971bfd9adde8@talktalk.net/

But I didn't download or watch the video, so I'm not positive.

> Full walkthrough (including comparison with 2.16.3) in the
> video attached to this link:
> 
> https://www.dropbox.com/s/s1ophi4mwmf9ogv/git-add-patch-whitespace-bug.mp4?dl=1

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Everybody knows how to raise children, except the people who have
them.
    -- P.J. O'Rourke

