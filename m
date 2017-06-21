Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85B8520401
	for <e@80x24.org>; Wed, 21 Jun 2017 21:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751934AbdFUVNH (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 17:13:07 -0400
Received: from server.croesch.de ([46.163.72.134]:40314 "EHLO
        server.croesch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751108AbdFUVNG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 17:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=croesch.de; s=cr1;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=LrTXyHiOC2YasIoebQDBmBjiff5XuTmJIZqEKEMq70E=;
        b=Uc5yigfH6Yea5a+H6gl9iAJAEXMFtLn5Dj33ibxrhztGqjotSCDr9XGsvKFavBSivt6gaKrZPo5DOmbtRyNIx0zbP0TDVH/yHJYvw0W+8DLg6OIiSb54Vtj5C1KWVLWYEPyPSRmnMEhrvgXcwUjTBPc51niQf6EbAo/6LqWzQi/Xv9UD/TWiIodM37HJIrKaKzXJHz8+6f0GvuN2BLb42GIAQcgItedjSTEcldlEm2gzZOhHOly4y77+48V1Y2ubicPBRGBWjdxgmMH/UWQL69oDUEcXGLQFatBDkUpvSXIRwkh0z85O0mFP1XbLdcgkaY/+XoAJnDGJtmKp2bDY/Q==;
Received: by lvps46-163-72-134.dedicated.hosteurope.de with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (envelope-from <christian@croesch.de>)
        id 1dNmvx-00036Y-8k; Wed, 21 Jun 2017 23:13:05 +0200
Subject: Re: [PATCH 2/2] add--interactive: quote commentChar regex
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <20170621192315.3umx4lszvzwjffnb@sigill.intra.peff.net>
 <20170621192859.udejhkl66ylsbg24@sigill.intra.peff.net>
From:   =?UTF-8?Q?Christian_R=c3=b6sch?= <christian@croesch.de>
Message-ID: <0bd23975-2283-fb98-c685-9adc0a9f0216@croesch.de>
Date:   Wed, 21 Jun 2017 23:12:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170621192859.udejhkl66ylsbg24@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the quick reaction and fix!

On 21/06/17 21:28, Jeff King wrote:
> If your chosen comment character is a regex metacharacter,
> then that will behave in a confusing manner ("$", for
> instance, would only eliminate blank lines, not actual
> comment lines).

So things would get worse when using * as comment char?! Maybe I should
consider a more uncommon character as comment char ;)

Best wishes,
Christian
