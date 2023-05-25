Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C99FC77B7A
	for <git@archiver.kernel.org>; Thu, 25 May 2023 14:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241512AbjEYOs1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 May 2023 10:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241137AbjEYOs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2023 10:48:26 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268E1E7
        for <git@vger.kernel.org>; Thu, 25 May 2023 07:48:25 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 34PEl29j321769
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 14:47:03 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Todd Zullinger'" <tmz@pobox.com>
Cc:     <git@vger.kernel.org>
References: <xmqqedn5fluv.fsf@gitster.g> <022501d98e94$68c671c0$3a535540$@nexbridge.com> <ZG6gbN04DfldoadD@pobox.com>
In-Reply-To: <ZG6gbN04DfldoadD@pobox.com>
Subject: RE: [ANNOUNCE] Git v2.41.0-rc2
Date:   Thu, 25 May 2023 10:48:17 -0400
Organization: Nexbridge Inc.
Message-ID: <025c01d98f17$f4b3bca0$de1b35e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKqBzO6zDBfHf12TijP/VCsWNlc4wEmtn0UApIPU2GtrFsBkA==
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

Setting NO_TCLTK=NoThanks inhibits processing of some .po files. I do not
know whether that is intended. Can you advise

Thanks,
Randall

