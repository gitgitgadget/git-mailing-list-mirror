Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5D6B202A0
	for <e@80x24.org>; Mon, 30 Oct 2017 02:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751486AbdJ3COe (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 22:14:34 -0400
Received: from marcos.anarc.at ([206.248.172.91]:59804 "EHLO marcos.anarc.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751310AbdJ3COd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 22:14:33 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])      (Authenticated sender: anarcat) with ESMTPSA id 9A4CD1A00AA
From:   =?utf-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
To:     kevin@ki-ai.org, Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/4] remote-mediawiki: add namespace support
In-Reply-To: <6ed0d8d4-243a-7afc-bd37-a6f71004e195@ki-ai.org>
Organization: Debian
References: <20171029160857.29460-1-anarcat@debian.org> <20171029160857.29460-2-anarcat@debian.org> <CAPig+cSmfJ2Uv21Q4DgJNoy6Ywj7GWPJa6qq0YL9Kar6Q74a_Q@mail.gmail.com> <87a809959p.fsf@curie.anarc.at> <CAPig+cTySXEWGxSUTxQXmHz7rR_nTbf+ALciZahJ2Ks6EmSqzg@mail.gmail.com> <6ed0d8d4-243a-7afc-bd37-a6f71004e195@ki-ai.org>
Date:   Sun, 29 Oct 2017 22:14:32 -0400
Message-ID: <871sll8jqv.fsf@curie.anarc.at>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-10-29 23:08:00, Kevin wrote:
> So I shared the patch some time ago (~2 years). Surprisingly its just
> now getting attention. I guess some renewed interest in using mediawiki
> with git.

I think what's happening is that someone (ie. me :p) figured it was
about frigging time to actually send those patches to the git mailing
list. ;) And I'm glad we're seeing such good reviews, so thanks Eric for
that... 

> Myself, however, am no longer using mediawiki. Nor am I
> completely clear on what the reasons were for using some variable or
> another a couple of years ago. So... the best of luck, sorry I couldn't
> be more helpful.

That's too bad, but thanks for the feedback anyways. :)

Frankly, I'm tempted to just completely remove the
get_mw_namespace_id_for_page hunk - it's completely unrelated to the
rest of the patch.

Could that be a bugfix for a separate issue that crept up in your
patchset? For example this?

https://github.com/Git-Mediawiki/Git-Mediawiki/issues/43

A.
-- 
That's one of the remarkable things about life: it's never so bad that
it can't get worse.
                        - Calvin
