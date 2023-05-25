Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AB6C77B7A
	for <git@archiver.kernel.org>; Thu, 25 May 2023 13:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241435AbjEYN4Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 May 2023 09:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241422AbjEYN4S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2023 09:56:18 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC30191
        for <git@vger.kernel.org>; Thu, 25 May 2023 06:56:16 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 34PDsm1h310654
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 13:54:48 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Todd Zullinger'" <tmz@pobox.com>
Cc:     <git@vger.kernel.org>
References: <xmqqedn5fluv.fsf@gitster.g> <022501d98e94$68c671c0$3a535540$@nexbridge.com> <ZG6gbN04DfldoadD@pobox.com>
In-Reply-To: <ZG6gbN04DfldoadD@pobox.com>
Subject: RE: [ANNOUNCE] Git v2.41.0-rc2
Date:   Thu, 25 May 2023 09:56:03 -0400
Organization: Nexbridge Inc.
Message-ID: <025401d98f10$a8545c90$f8fd15b0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKqBzO6zDBfHf12TijP/VCsWNlc4wEmtn0UApIPU2GtrEx24A==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday, May 24, 2023 7:40 PM, Todd Zullinger wrote:
>rsbecker@nexbridge.com wrote:
>> I'm not sure this is a new thing but it is the first time I noticed it
>> in the log. It was not in the build log for 2.41.0-rc0.
>>
>> /usr/coreutils/bin/bash: line 3: tclsh: command not found
>>     * tclsh failed; using unoptimized loading
>
>Have you set NO_TCLTK in your builds?  I don't see that in the NonStop
section of
>config.mak.uname.
>
>> Tclsh is not available on NonStop or S/390 AFAIK. While its use does
>> go back to 2007, I just want to ensure that it does not sneak in as a
>> dependency beyond git-gui and gitk-git.
>
>The only references to tclsh outside of the Makefile and git-gui/gitk are
commented
>code in contrib/buildsystems/, engine.pl and parse.pl.

Thanks Todd. I will test this out and submit a patch for it.
Regards,
Randall

