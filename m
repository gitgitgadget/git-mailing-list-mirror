Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C494C4332F
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 18:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbiKBSvK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 14:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiKBSvI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 14:51:08 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Nov 2022 11:51:04 PDT
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746D7E28
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 11:51:04 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D31A31CD4AE;
        Wed,  2 Nov 2022 14:49:56 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=gdlKiQG0JBntN6VI1XC/YbQJPprSBfwnGMxRAqB
        AfwU=; b=HfHMIsYFFa1WI96rVI0Q+X2o3RC/3Q21qL1Pm7WeR1h1j+TJnxjuqFQ
        vhQMmO1rg9SEyNODpD+qMZOs2PJ9lVKIqNutqEoGeP/E1FfhBmzmMyeJ4cUvthTq
        MFFa5XTQRszP4sKoKAuPqqBYD/GuequCM7G8IGVfpq7gCXsVrC9g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CB8C71CD4AD;
        Wed,  2 Nov 2022 14:49:56 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [108.15.224.39])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DB52D1CD4AC;
        Wed,  2 Nov 2022 14:49:52 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Wed, 2 Nov 2022 14:49:49 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Sarah Julia Kriesch <sarah.kriesch@opensuse.org>
Cc:     git@vger.kernel.org, andreas.stieger@gmx.de
Subject: Re: git can not be built for s390x since update to git-2.38.0
Message-ID: <Y2K7zXDLfJhf/i4y@pobox.com>
References: <f1a5f758-d81f-5985-9b5d-2f0dbfaac071@opensuse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1a5f758-d81f-5985-9b5d-2f0dbfaac071@opensuse.org>
X-Pobox-Relay-ID: 23191882-5ADF-11ED-B473-C2DA088D43B2-09356542!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sarah Julia Kriesch wrote:
> I am one of the zsystems Maintainers (s390x architecture) at openSUSE and
> git can not be built any more since the update from 2.37.3 to 2.38.0, and
> with 2.38.1 afterwards. We have tried to debug it.

I don't know if it's of much help, but for what it's worth
2.38.0 and 2.38.1 been built in Fedora for s390x without
issue.  Build logs and artifacts for 2.38.1 can be found
here:

    https://koji.fedoraproject.org/koji/buildinfo?buildID=2077983

-- 
Todd
