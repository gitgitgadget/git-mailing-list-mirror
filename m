Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A1EC7EE29
	for <git@archiver.kernel.org>; Thu, 25 May 2023 17:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjEYRtB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 May 2023 13:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjEYRtA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2023 13:49:00 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB53B6
        for <git@vger.kernel.org>; Thu, 25 May 2023 10:48:58 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 34PHlbJc360308
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 17:47:37 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Todd Zullinger'" <tmz@pobox.com>
Cc:     <git@vger.kernel.org>
References: <xmqqedn5fluv.fsf@gitster.g> <022501d98e94$68c671c0$3a535540$@nexbridge.com> <ZG6gbN04DfldoadD@pobox.com> <025c01d98f17$f4b3bca0$de1b35e0$@nexbridge.com> <ZG-PCFEIDURrRVLe@pobox.com> <027501d98f2d$ff2c1680$fd844380$@nexbridge.com> <ZG-dXsQpLrAoNVSD@pobox.com>
In-Reply-To: <ZG-dXsQpLrAoNVSD@pobox.com>
Subject: RE: [ANNOUNCE] Git v2.41.0-rc2
Date:   Thu, 25 May 2023 13:48:52 -0400
Organization: Nexbridge Inc.
Message-ID: <027f01d98f31$2e94e660$8bbeb320$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKqBzO6zDBfHf12TijP/VCsWNlc4wEmtn0UApIPU2EBj1WUbQGMPGHAAVBuqz4Bfoz+nq19OD0Q
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday, May 25, 2023 1:40 PM, Todd Zullinger wrote:
>rsbecker@nexbridge.com wrote:
>> On Thursday, May 25, 2023 12:39 PM, Todd Zullinger wrote:
>>> I don't used the option, as the systems I build for have tcl/tk, but
>>> I don't see where setting that would have an effect on .po files
>>> (apart from those in git-gui or gitk-git, of course).
>>
>> Those two are where the .po are unprocessed.
>
>I guess I don't understand the issue then.  If you don't have tcl/tk, then
what's the
>problem with not having the po files processed for these apps you cannot
run?
>
>What errors does this cause?  I'm not really an expert in this area, but I
imagine a
>more concrete explanation of the problem might be helpful.

What I'm concerned about is what other users of the builds are depending on.
If I change a setting in config.mak.uname to just remove a message that has
no otherwise impact, I am fine with doing that. Adding NO_TCLTK has a
broader impact on the overall build, so I am hesitant to put my name on a
contribution (trivial regardless) for such a change without understanding
why there is a non-trivial impact. My thought as this point, as a packager,
is that I should live with the situation.

