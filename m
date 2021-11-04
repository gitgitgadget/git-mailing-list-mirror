Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882ECC433F5
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 14:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6106761053
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 14:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhKDOcV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 10:32:21 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:9768 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230511AbhKDOcV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 10:32:21 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1midkK-0008Wd-7X; Thu, 04 Nov 2021 14:29:40 +0000
Message-ID: <45402a12-e08a-bb27-09cf-db1c64c76bba@iee.email>
Date:   Thu, 4 Nov 2021 14:29:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] Makefile: replace most hardcoded object lists with
 $(wildcard)
Content-Language: en-GB
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <patch-1.1-bbacbed5c95-20211030T223011Z-avarab@gmail.com>
 <YX5T+wt0hSkxkLHA@coredump.intra.peff.net>
 <211031.86a6ip47ib.gmgdl@evledraar.gmail.com>
 <YYJy4BuX6JI6p+aV@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2111040124430.56@tvgsbejvaqbjf.bet>
 <211104.86r1bwi6f7.gmgdl@evledraar.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <211104.86r1bwi6f7.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/11/2021 09:46, Ævar Arnfjörð Bjarmason wrote:
>> he entire point of the CMake configuration is to allow developers on
>> Windows to use the tools they are used to, to build Git. And believe it or
>> not, GNU make is not one of those tools! I know. Very hard to believe. :-)
> I believe that, the question is why it isn't a better trade-off to just
> ask those users to install that software. Our Windows CI is doing it
> on-the-fly, so clearly it's not that hard to do it.
Just to say that, while it is real easy to download and install the
Git-for-Windows SDK (https://gitforwindows.org/#download-sdk), for most
(Windows) users it's a foreign land, with few friends who understand
what things like `gdb` are all about. It's all doable, but the learning
curve can be hard. The CI doesn't need a learning curve ;-)

Being able to fire up a well 'trusted' tool like Visual Studio to
investigate the code does help contributors understand the code.

--
Philip
