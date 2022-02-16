Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA04BC433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 19:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237987AbiBPTC1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 14:02:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237979AbiBPTCV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 14:02:21 -0500
X-Greylist: delayed 129378 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Feb 2022 11:02:08 PST
Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3DCAEF3C
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 11:02:07 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4JzS4W3gWmz5tl9;
        Wed, 16 Feb 2022 20:02:03 +0100 (CET)
Message-ID: <108f009b-daa3-4ef4-755e-7c9f86f898c5@kdbg.org>
Date:   Wed, 16 Feb 2022 20:02:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 0/2] Improvements to tests and docs for .gitattributes
 eol
Content-Language: en-US
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
References: <20220111021507.531736-1-sandals@crustytoothpaste.net>
 <20220214020827.1508706-1-sandals@crustytoothpaste.net>
 <xmqqilth2u28.fsf@gitster.g> <20220214204631.mquj645jt5qajwku@tb-raspi4>
 <xmqq8rud0ytj.fsf@gitster.g> <9ab7761a-ff63-f809-47af-033825e5779e@kdbg.org>
 <YgwtMhuODDcVWEd6@camp.crustytoothpaste.net>
 <9ce63b16-cf75-3404-88cf-0623194db07b@kdbg.org>
 <YgzRyKZwsPw6rTyT@camp.crustytoothpaste.net>
Cc:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <YgzRyKZwsPw6rTyT@camp.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.02.22 um 11:28 schrieb brian m. carlson:
> The situation is that eol is in effect if and only if:
> 
> * text is set;
> * text is unspecified; or
> * text is auto, the file is detected as text, and the file has LF line
>   endings in the index.
> 
> Alternately, it has no effect if and only if:
> 
> * text is unset;
> * text is auto and the file is detected as binary; or
> * text is auto and the file is detected as text and has CRLF line
>   endings.
> 
> I'm not sure one reads significantly easier than the other.  I slightly
> prefer the former because it has fewer conditions with multiple nested
> entries, though.

I agree that the first version is easier to understand.

-- Hannes
