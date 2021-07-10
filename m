Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919A0C07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 15:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EDB460E0B
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 15:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbhGJPdn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 11:33:43 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:50256 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229805AbhGJPdn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 11:33:43 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1m2EwR-0005h7-6D; Sat, 10 Jul 2021 16:30:56 +0100
Subject: Re: [PATCH 5/5] config: add default aliases
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'martin' <test2@mfriebe.de>,
        'Felipe Contreras' <felipe.contreras@gmail.com>,
        =?UTF-8?B?J8OGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uJw==?= 
        <avarab@gmail.com>
Cc:     git@vger.kernel.org, 'Junio C Hamano' <gitster@pobox.com>
References: <20210702100506.1422429-1-felipe.contreras@gmail.com>
 <20210702100506.1422429-6-felipe.contreras@gmail.com>
 <8735sxaqln.fsf@evledraar.gmail.com> <60df8c20e8518_28bb20846@natae.notmuch>
 <5cbb845f-b8a6-939e-cf37-a3b375438616@mfriebe.de>
 <044e01d771a6$7c8cefc0$75a6cf40$@nexbridge.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <fac9cb8b-90e2-d6fc-2382-629e3a345756@iee.email>
Date:   Sat, 10 Jul 2021 16:30:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <044e01d771a6$7c8cefc0$75a6cf40$@nexbridge.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/07/2021 15:02, Randall S. Becker wrote:
> I do not want anything helping out the use of rebase, which we  in our shop - except for rebase --autosquash to fix up topic branches for delivery.

I was wondering what the background/context to the 'actively discourage'
is? 

I'd have expected that some in-place rework (i.e. rebase) could happen
before code review, with possible further rework beyond simple
fixup/squash commits being possible after review (if demanded), but with
the same fork-point (rather than following movements in the 'upstream'),
rather similar to Git's development. i.e. Is it that the fork-point
shouldn't be moved without good reason and permission, or something else?

just wondering...

--
Philip
