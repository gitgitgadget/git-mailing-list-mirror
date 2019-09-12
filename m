Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D0591F463
	for <e@80x24.org>; Thu, 12 Sep 2019 21:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfILVlo (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 17:41:44 -0400
Received: from smtp78.ord1c.emailsrvr.com ([108.166.43.78]:42768 "EHLO
        smtp78.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726074AbfILVlo (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Sep 2019 17:41:44 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Sep 2019 17:41:43 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1568324076;
        bh=Sj7NAnNM2H//dk2B2a5F6Jc1lYZx0f5IQR69d/Wc1vQ=;
        h=Subject:To:From:Date:From;
        b=a79HWbijEAT+N7VacEdj5Hb3UZHjwLz5AXvybi2+i0tRgyfIAzns3gIDdb2MU67Y9
         /nGNfVozi+ioQhnf64qIM/dolhBjUM/oF2fz/A8oUMI1l/usaZ8s4zIXEiqPlgyVaE
         Cd+Dh7eIm7M+jyJGL8qb1PBPYAqgD1FLceI6OSjo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xiplink.com;
        s=20181102-2c3qeqyt; t=1568324076;
        bh=Sj7NAnNM2H//dk2B2a5F6Jc1lYZx0f5IQR69d/Wc1vQ=;
        h=Subject:To:From:Date:From;
        b=NbEtCp3//gVoxcAzFmUl/EgoLHP5aoEDP9tuxiemfUB/FO4dfskfoeUPU3tlTPaC8
         S6GeRuryT+ZVV24rMvr/nm+6vKFkd+lp5ME20wJ9/cHGbUeReD2Oc5FQvJQqPTk/y/
         sjIw5LX52avjWXe+hG3xFTJFGcDaHdeY2SRtJTac=
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp26.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 084DAE02CB;
        Thu, 12 Sep 2019 17:34:36 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Thu, 12 Sep 2019 17:34:36 -0400
Subject: Re: [PATCH 2/2] git-gui: add hotkey to toggle "Amend Last Commit"
 check button/menu
To:     Pratyush Yadav <me@yadavpratyush.com>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Git List <git@vger.kernel.org>
References: <ab1f68cc8552e405c9d04622be1e728ab81bda17.1567713659.git.bert.wesarg@googlemail.com>
 <b82a00441ff1a6a9cea3fd235c1c33729ec31b71.1567713659.git.bert.wesarg@googlemail.com>
 <20190911205539.vb6asqcc22nzgdqa@yadavpratyush.com>
 <CAGr--=Jz9xN6NMmiXjHeq9wZsYUx4eqfQrWjjVMkj3J1YCG_8g@mail.gmail.com>
 <20190912162924.phb5o2ppovnxa7nn@yadavpratyush.com>
From:   Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <db01db41-eff0-fb56-161a-ba26d1b18f55@xiplink.com>
Date:   Thu, 12 Sep 2019 17:34:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190912162924.phb5o2ppovnxa7nn@yadavpratyush.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-09-12 12:29 p.m., Pratyush Yadav wrote:
> On 12/09/19 08:05AM, Birger Skogeng Pedersen wrote:
>> Hi Pratyush,
>>
>> On Wed, Sep 11, 2019 at 10:55 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
>>> Also, I notice that the bindings for other letters have the same
>>> function bound for both small and capital letters (IOW, same behavior
>>> with shift held and released).
>>>
>>> I don't necessarily think that is a great idea. It is a pretty common
>>> pattern to have, say Ctrl+a, do something, and Ctrl+Shift+a, do
>>> something else. Just want to pick your brain on whether you think we
>>> should do the same thing for both Ctrl+e and for Ctrl+E (aka
>>> Ctrl+Shift+e), or just bind it to Ctrl+e, and leave Ctrl+E for something
>>> else.
>>
>> I just tested what happens when you press Ctrl+e while Caps Lock is
>> enabled; the Ctrl+e binding is not invoked. That's probably why other
>> key bindings have the same function bound for both lower- and
>> upper-case letters, to have the same behaviour with/without Caps Lock
>> enabled. With that in mind, we should probably bind Ctrl+E aswell.
> 
> Nice catch! Makes sense to have the same behaviour for both caps lock
> enabled and disabled.

(I've been a git-gui user for many years...)

I disagree!  Who expects anything to work properly when capslock is on?

		M.


>>
>> Should I create and send a new patch?
> 
> Yes, please do.
> 
