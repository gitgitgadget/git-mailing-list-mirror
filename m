Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20206C433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 10:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0790D60EBD
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 10:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbhJYKqb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 06:46:31 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:57742 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232789AbhJYKqb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 06:46:31 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mexSZ-0004hP-Az; Mon, 25 Oct 2021 11:44:07 +0100
Message-ID: <48d2b707-3337-8232-af19-dc6170e12313@iee.email>
Date:   Mon, 25 Oct 2021 11:44:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 1/4] gitfaq: add advice on monorepos
Content-Language: en-GB
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20211020010624.675562-1-sandals@crustytoothpaste.net>
 <20211020010624.675562-2-sandals@crustytoothpaste.net>
 <557fe5b8-36b4-a760-d2dd-02137746a37b@iee.email>
 <YXCWigr6TovYXgbb@camp.crustytoothpaste.net>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <YXCWigr6TovYXgbb@camp.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian,
On 20/10/2021 23:22, brian m. carlson wrote:
> On 2021-10-20 at 14:11:09, Philip Oakley wrote:
>> Does this need some comparison, or link, with sub-module methods and
>> issues? Such as the nested sub-module problem, the distinction between
>> active sub-modules and quiescent sub-modules (e.g. libraries Vx.y.z)?
> I don't think it does.  Some projects choose to use many repositories
> with submodules, and some use many repositories without submodules.  At
> work, we do the latter, and it tends to work just fine.

To clarify, my comment was with regard to the complementary discussions
about _choice_ of repo types, rather than mono-repo and other
post-choice issues. Possibly, part of such a discussion on choice of
repo-type, could include the potential slippery slope between the
different uses of sub-modules.

I feel a lot of the difficult sub-module discussion are because we don't
have a common terminology for the different (mental) models of
sub-module use, their benefits and problems.
--
Philip
