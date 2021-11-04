Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F997C433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 00:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B363611CE
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 00:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbhKDAQp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 20:16:45 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:46577 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231709AbhKDAQo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 20:16:44 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1miQOM-0008nA-3Z; Thu, 04 Nov 2021 00:14:06 +0000
Message-ID: <d716730b-6ba8-82dc-4e62-785978af2afd@iee.email>
Date:   Thu, 4 Nov 2021 00:14:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: Breakage in dockerized(pedantic, fedora); Fix in the works
Content-Language: en-GB
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
References: <nycvar.QRO.7.76.6.2111040007170.56@tvgsbejvaqbjf.bet>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <nycvar.QRO.7.76.6.2111040007170.56@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/11/2021 23:17, Johannes Schindelin wrote:
> Team,
>
> some of you might have noticed that the `dockerized(pedantic, fedora)` job
> started to fail, see e.g.
> https://github.com/git/git/runs/4098188917?check_suite_focus=true#step:5:232
>
> This also happened during the Git for Windows rebase onto -rc1 that
> Victoria Dye prepared, and together we investigated the problem. Victoria
> will send a fix later. (I'm saying this just in case anybody wondered
> whether they should investigate this breakage.)
>
> Thanks,
> Dscho
>
Thank you, I'd seen it on one of my runs, but I was hopeful it wasn't
because of my personal changes..
Philip
