Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13647C4332F
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 17:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbiDCR6T convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 3 Apr 2022 13:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359711AbiDCR6J (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 13:58:09 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9818D38BC0
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 10:55:58 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.251.39] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 233Htove022957
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 3 Apr 2022 13:55:51 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Eric Wong'" <e@80x24.org>
Cc:     <git@vger.kernel.org>
References: <20220403084258.GA27999@dcvr> <Ykna7sJP8ktvNLor@camp.crustytoothpaste.net>
In-Reply-To: <Ykna7sJP8ktvNLor@camp.crustytoothpaste.net>
Subject: RE: any real-world SHA-256 repo users out there?
Date:   Sun, 3 Apr 2022 13:55:45 -0400
Organization: Nexbridge Inc.
Message-ID: <02b501d84784$0e904260$2bb0c720$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQILkAUOWdQzGbo6mk1MnVYkb3oX8wEuaEawrG50XlA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 3, 2022 1:36 PM, brian m. carlson wrote:
>On 2022-04-03 at 08:42:58, Eric Wong wrote:
>> Hey all, just wondering if it's something I should prioritize adding
>> support for in some git-using project I hack on...
>>
>> Of course, I'm not dropping SHA-1 support.  So I'm wondering if I
>> should wait for (or hack on :P) git to handle both SHA-256 and
>> SHA-1 in one process; or if it's something I'd be better off managing
>> via multiple (git cat-file --batch) processes.  No OIDs are
>> abbreviated, so it's just 20/40 vs 32/64.
>
>Git can already use one binary to handle SHA-1 and SHA-256 repositories and has
>been able to since Git 2.29 (although 2.30 has some fixes you should use). It just
>doesn't provide interop at this point, and I'm only working on it as I find time, so I
>wouldn't hold your breath for it.
>
>I have some indefinite plans to improve the support for SHA-1/SHA-256 interop in
>the future, as well as port SHA-256 support to libgit2, but those are dependent on
>some things which are not certain (but very
>likely) to occur.
>
>I strongly encourage folks to add SHA-256 repository support to tooling since it's
>likely going to become more popular in the future.  I have some local SHA-256
>repositories on my systems and they appear to work fine.

Our tooling works correctly regardless of the choice of SHA-256, but have been waiting for GitHub et. al., to provide capabilities. I would welcome interoperability. What help do you need?

Regards,
Randall

