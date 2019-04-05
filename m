Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0475820248
	for <e@80x24.org>; Fri,  5 Apr 2019 01:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbfDEBch (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 21:32:37 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57273 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730369AbfDEBch (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 21:32:37 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 173534FD4C;
        Thu,  4 Apr 2019 21:32:35 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=VFDqPb8HyRhWGuOQ/OAzFLnOnIE=; b=hSCvpWi
        DkkSCeXKf00Pm/mH5iz7gTZodfTR2g1jkZ77rsQROyzNP4LFVGXIpqNrB1U9B4EZ
        hrHFypxGD5qEPhJeGwxT/K77pyd3PfRhbRJo3Vk98h224ixVZgSW+PhMCQIx/XcU
        2GqDV1J6r4v53kqQ4zalz5i9zCUaNDaAgMBI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=PnsscxsiLqwt3UHWw0gZhlkcHsHdnCzB9
        B9cC+iDcDTTKkeE+IhtXNTsk3fX1pwWfqQhBf5GFvTGH7g6Au3vGir8Kbs3DQkuQ
        kfVgMSzXU8iyVz0HN3JF/xOOl019Sb4ZWWxGB7milRIzGB4TX8hRfbZ+lbMTyhi2
        DL7iiKVipk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0D0B24FD4B;
        Thu,  4 Apr 2019 21:32:35 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9ACCF4FD47;
        Thu,  4 Apr 2019 21:32:31 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Thu, 4 Apr 2019 21:32:28 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v1 2/2] Documentation/git-status: fix titles in porcelain
 v2 section
Message-ID: <20190405013228.GQ4047@pobox.com>
References: <20190330183001.16624-1-tmz@pobox.com>
 <20190330183001.16624-3-tmz@pobox.com>
 <a8be0a1e-bb34-5709-0307-68b1fdd2d95c@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8be0a1e-bb34-5709-0307-68b1fdd2d95c@jeffhostetler.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: AEA94718-5742-11E9-99A0-EE24A11ADF13-09356542!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff Hostetler wrote:
> On 3/30/2019 2:30 PM, Todd Zullinger wrote:
>> The '^### ' lines were added in 1cd828ddc8 ("git-status.txt: describe
>> --porcelain=v2 format", 2016-08-11).  I'm _presuming_ they were made
>> with markdown syntax in mind, but if not I can drop that bit from the
>> commit message.  Jeff H, do you happen to recall?
> 
> Yes, I was probably had markdown on the brain that day.

Cool, thanks.  Lucky guess on my part then.  It's not like
I've ever done something similar in other repos. ;)

-- 
Todd
