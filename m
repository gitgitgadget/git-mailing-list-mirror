Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36400C433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 00:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiKCAVZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 20:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiKCAVX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 20:21:23 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E51AE4F
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 17:21:22 -0700 (PDT)
Received: (Authenticated sender: amy@amyspark.me)
        by mail.gandi.net (Postfix) with ESMTPSA id 778FB240005;
        Thu,  3 Nov 2022 00:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amyspark.me; s=gm1;
        t=1667434880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IIC8WNloW/FhEqs0ZQUvDYTrt2Xxzsm7J3RRElzOi0k=;
        b=mQzyPVJZE3mrWSl6nivEbO8K3Mg+pBsdQUVCfn17lNT6MZ6Y9DtctyKw/LMqM1ciZXOpca
        hKdZI68BeSD+XK70nsI5ZCJw4GMDe40fkBAcl+v17XreegmQmklGlQRHMLTSsRwnvOfZvX
        nfGT5AiU77V0b3j3S7UjFFkroT28WQh/6IeH1N/XQcx3D4ySOBzjRbqKm8d6c+L+YS9Pkm
        5IseG5QGYY0EDJ0GU+vnygm1oGrBYTVvU69t7ZDVehltRtgCavHGVVtKV7HBGPzhOKRwok
        otG1wl0MpEhxDhBL+XCUvJ11zosQfdQ8fV/gGEvY6XJKB89JCKCJtOgBN6KM3g==
Message-ID: <527f8050-7955-50b1-304c-617703cf99e6@amyspark.me>
Date:   Wed, 2 Nov 2022 21:21:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:107.0)
 Gecko/20100101 Thunderbird/107.0
Subject: Re: [BUG] git format-patch incorrectly follows the mailmap when used
 with --cover-letter
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
References: <cb90779b-edb0-1911-c8bd-a6c56203a201@amyspark.me>
 <Y2MGyM3O7ljEZ4Hm@nand.local>
From:   "L. E. Segovia" <amy@amyspark.me>
In-Reply-To: <Y2MGyM3O7ljEZ4Hm@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey,

The shortlog in the cover letter follows the active mailmap (incorrectly).
The letter itself (From: header), as well as the patches, are attributed
correctly.

Best,

amyspark

On 02/11/2022 21:09, Taylor Blau wrote:
> On Wed, Nov 02, 2022 at 08:54:32PM -0300, L. E. Segovia wrote:
>> What did you expect to happen? (Expected behavior)
>>
>> The cover letter should have tallied my commits and associate them with
>> the current repository's user.name value.
>>
>> What happened instead? (Actual behavior)
>>
>> The cover letter follows my active mailmap and applies it when tallying
>> the commits. There is no way to tell it not to.
> 
> Are you referring to the shortlog in the cover letter, the patches
> themselves, or both?
> 
> As you note, there is no '--[no-]mailmap' option in format-patch, though
> implementing one should be relatively straightforward.
> 
> Thanks,
> Taylor

-- 
amyspark 🌸 https://www.amyspark.me
