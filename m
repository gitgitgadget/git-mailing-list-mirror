Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E531C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 14:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFD60610C8
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 14:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351761AbhIHOOe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 10:14:34 -0400
Received: from verein.lst.de ([213.95.11.211]:39346 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229600AbhIHOOd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 10:14:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 20BD567373; Wed,  8 Sep 2021 16:13:23 +0200 (CEST)
Date:   Wed, 8 Sep 2021 16:13:22 +0200
From:   'Christoph Hellwig' <hch@lst.de>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Christoph Hellwig' <hch@lst.de>,
        'Junio C Hamano' <gitster@pobox.com>,
        'Neeraj Singh' <nksingh85@gmail.com>,
        "'Neeraj K. Singh via GitGitGadget'" <gitgitgadget@gmail.com>,
        'Git List' <git@vger.kernel.org>,
        'Johannes Schindelin' <Johannes.Schindelin@gmx.de>,
        'Jeff King' <peff@peff.net>,
        'Jeff Hostetler' <jeffhost@microsoft.com>,
        =?iso-8859-1?Q?'=C6var_Arnfj=F6r=F0?= Bjarmason' 
        <avarab@gmail.com>, "'Neeraj K. Singh'" <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 0/6] Implement a batched fsync option for
 core.fsyncObjectFiles
Message-ID: <20210908141322.GA27146@lst.de>
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com> <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com> <CANQDOdeEic1ktyGU=dLEPi=FkU84Oqv9hDUEkfAXcS0WTwRJtQ@mail.gmail.com> <CANQDOdeX-SoWnh5DJ9ZdNLfPdAW-wtp_fo99r0Rwe1DQqx4W5Q@mail.gmail.com> <xmqqmton7ehn.fsf@gitster.g> <20210908064958.GA29073@lst.de> <006d01d7a4b9$7cea64c0$76bf2e40$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006d01d7a4b9$7cea64c0$76bf2e40$@nexbridge.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 08, 2021 at 09:57:34AM -0400, Randall S. Becker wrote:
> possible. I know of at least 3 operating systems where that is a bad plan, and if you did, you would take the test suite down while
> you were at it.

I've just mentioned a good way to write a test for this feature on a
specific platform.  This is absolutely no judgement if that is a good
plan on other platforms.
