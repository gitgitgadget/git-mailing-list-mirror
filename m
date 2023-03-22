Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0814FC6FD1D
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 01:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjCVBY6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 21:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjCVBYw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 21:24:52 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B7026C0B
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 18:24:50 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BADF71F12E4;
        Tue, 21 Mar 2023 21:24:47 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=v+M94Cj1f8/zF2u6TMbUV1xeuq37J+Bwbztp03h
        q1Yc=; b=ptcxCvpmZ7/ZckQHJUNIEG/3IdZTz/mEuksfN76gOEVAcqVr7k4qKtu
        AF8AK8aCutiIzm1Ae0mhmd1trv6zyxOZnWQLAOzD0AOsXnBZP1qaDNpwipPS8xev
        rMahQ8HZ5rVro3l1jizq67x5AIVWtkVTjmtIOGWWwNP5D2ycUWFI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B2ABE1F12E3;
        Tue, 21 Mar 2023 21:24:47 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [108.15.224.39])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BD9C01F12E2;
        Tue, 21 Mar 2023 21:24:43 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Tue, 21 Mar 2023 21:24:40 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH] doc: remove manpage-base-url workaround
Message-ID: <ZBpY2LcoRMDYVJVw@pobox.com>
References: <20230322000815.132128-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322000815.132128-1-felipe.contreras@gmail.com>
X-Pobox-Relay-ID: 536179E2-C850-11ED-B689-B31D44D1D7AA-09356542!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras wrote:
> Commit 50d9bbba92 (Documentation: Avoid use of xmlto --stringparam,
> 2009-12-04) introduced manpage-base-url.xsl because ancient versions of
> xmlto did not have --stringparam.
> 
> However, that was more than ten years ago, no need for that complexity
> anymore, we can just use --stringparam.

Sounds good.  The issue at the time was with xmlto older
than ~ 0.20.  It was known that 0.18 didn't work, which
affected both openSUSE 11.2 and CentOS 5, as reported in
https://lore.kernel.org/git/m2hbs85koj.fsf@igel.home/ and
the following messages).

I wish I'd have included the details on which xmlto versions
were affected in the commit message.  The project was
managed in SVN at the time and I can't (easily) find the
source older than it's import to git around 0.21.

Not that it's important.  It was already rather old versions
of xmlto which were affected -- in 2009.

Thanks,

-- 
Todd
