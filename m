Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FC0C77B7E
	for <git@archiver.kernel.org>; Thu, 25 May 2023 17:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbjEYRkL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 May 2023 13:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbjEYRju (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2023 13:39:50 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F39189
        for <git@vger.kernel.org>; Thu, 25 May 2023 10:39:45 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D68E418FB4C;
        Thu, 25 May 2023 13:39:44 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=JMb3rxFcf+52QzGZtDaIuW4R4q1B2L1DfhfhpWx
        rnmo=; b=LXKzTTsxQlz5PAimgptxlJWHu2o9LXuNzVhTXjAueIKhbYZlpELgjuB
        8iKDmgOtAig9VoEpLJsaAV0Au/+Fz9rWkpROI6/EhyGifXQEd+3gHOlLIsf3bPeh
        S6e6E6okXvtQ8cBqAeqPvh6xRVDNH7Z/ThZjO0F/TTfoIyocYPXU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D052D18FB4B;
        Thu, 25 May 2023 13:39:44 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [108.15.224.39])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 602D018FB4A;
        Thu, 25 May 2023 13:39:44 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Thu, 25 May 2023 13:39:42 -0400
From:   'Todd Zullinger' <tmz@pobox.com>
To:     rsbecker@nexbridge.com
Cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.41.0-rc2
Message-ID: <ZG-dXsQpLrAoNVSD@pobox.com>
References: <xmqqedn5fluv.fsf@gitster.g>
 <022501d98e94$68c671c0$3a535540$@nexbridge.com>
 <ZG6gbN04DfldoadD@pobox.com>
 <025c01d98f17$f4b3bca0$de1b35e0$@nexbridge.com>
 <ZG-PCFEIDURrRVLe@pobox.com>
 <027501d98f2d$ff2c1680$fd844380$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <027501d98f2d$ff2c1680$fd844380$@nexbridge.com>
X-Pobox-Relay-ID: 22C65E64-FB23-11ED-8487-C65BE52EC81B-09356542!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

rsbecker@nexbridge.com wrote:
> On Thursday, May 25, 2023 12:39 PM, Todd Zullinger wrote:
>> I don't used the option, as the systems I build for have
>> tcl/tk, but I don't see where setting that would have an
>> effect on .po files (apart from those in git-gui or
>> gitk-git, of course).
> 
> Those two are where the .po are unprocessed.

I guess I don't understand the issue then.  If you don't
have tcl/tk, then what's the problem with not having the po
files processed for these apps you cannot run?

What errors does this cause?  I'm not really an expert in
this area, but I imagine a more concrete explanation of the
problem might be helpful.

-- 
Todd
