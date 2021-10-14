Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805AAC433EF
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 11:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FD1860295
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 11:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbhJNLqE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 07:46:04 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:11438 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229984AbhJNLqD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 07:46:03 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1maz9R-0006Fx-9p; Thu, 14 Oct 2021 12:43:57 +0100
Subject: Re: [BUG] credential wildcard does not match hostnames containing an
 underscore
To:     Alex Waite <alex@waite.eu>, Aaron Schrab <aaron@schrab.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
References: <28ff3572-1819-4e27-a46d-358eddd46e45@www.fastmail.com>
 <xmqqk0ii3zl6.fsf@gitster.g> <YWXzGeiUSMeq5Key@coredump.intra.peff.net>
 <YWX8d/VTrkOz5tga@camp.crustytoothpaste.net>
 <YWX+6OgzN4CDzomO@coredump.intra.peff.net>
 <YWYCh3+37d27QNjW@camp.crustytoothpaste.net>
 <YWYE2LZp/EfoBpN/@camp.crustytoothpaste.net> <YWYLRvUEkoudH5n0@pug.qqx.org>
 <c84ef8d0-0ed7-4267-9952-d9a2bc053ad6@www.fastmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <6ea198bf-6013-6cdf-3e56-7574975b1d7a@iee.email>
Date:   Thu, 14 Oct 2021 12:43:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <c84ef8d0-0ed7-4267-9952-d9a2bc053ad6@www.fastmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/10/2021 17:21, Alex Waite wrote:
> In my view, the primary bug is how difficult it was to debug what was going wrong. This is most easily solved by improving the git docs to specify which characters will be matched. Even better if GIT_TRACE (or something similar) can inform/warn the user about matching.
It did sound to me that the documentation route was a way out of the
confusing situation.
--
Philip
