Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7E7C433EF
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 02:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbiDHCPY convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 7 Apr 2022 22:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiDHCPW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 22:15:22 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E768BFF
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 19:13:18 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.251.39] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 2382DHWR043358
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Apr 2022 22:13:17 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc:     "'Adam Dinwoodie'" <adam@dinwoodie.org>,
        "=?utf-8?Q?'Carlo_Marcelo_Arenas_Bel=C3=B3n'?=" <carenas@gmail.com>,
        "'Fangyi Zhou'" <me@fangyi.io>,
        "'Josh Steadmon'" <steadmon@google.com>,
        "=?utf-8?Q?'Martin_=C3=85gren'?=" <martin.agren@gmail.com>,
        "'Todd Zullinger'" <tmz@pobox.com>,
        "'Victoria Dye'" <vdye@github.com>,
        "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>
References: <xmqqo81gpokn.fsf@gitster.g> <xmqq1qy8qske.fsf@gitster.g>
In-Reply-To: <xmqq1qy8qske.fsf@gitster.g>
Subject: RE: [ANNOUNCE] Git v2.36.0-rc0
Date:   Thu, 7 Apr 2022 22:13:12 -0400
Organization: Nexbridge Inc.
Message-ID: <006b01d84aee$365e2100$a31a6300$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQDXNCLtBgYvVwopPrSUHRpE2ctfTgH/E0durtd7MUA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 On April 7, 2022 9:21 PM, Junio C Hamano wrote:
>To: git@vger.kernel.org
>Cc: Adam Dinwoodie <adam@dinwoodie.org>; Carlo Marcelo Arenas Belón
><carenas@gmail.com>; Fangyi Zhou <me@fangyi.io>; Josh Steadmon
><steadmon@google.com>; Martin Ågren <martin.agren@gmail.com>; Todd
>Zullinger <tmz@pobox.com>; Victoria Dye <vdye@github.com>; Ævar Arnfjörð
>Bjarmason <avarab@gmail.com>
>Subject: Re: [ANNOUNCE] Git v2.36.0-rc0
>
>Junio C Hamano <gitster@pobox.com> writes:
>
>> An early preview release Git v2.36.0-rc0 is now available for testing
>> at the usual places.  It is comprised of 661 non-merge commits since
>> v2.35.0, contributed by 80 people, 25 of which are new faces [*].
>
>Thanks for finding and fixing many oops glitches in this preview so quickly.
>Hopefully with the tip of 'master/main' today, we can tag a bug-free -rc1
>tomorrow ;-)
>
>$ git shortlog --no-merges v2.36.0-rc0..master Adam Dinwoodie (1):
>      configure.ac: fix HAVE_SYNC_FILE_RANGE definition
>
>Carlo Marcelo Arenas Belón (1):
>      git-compat-util: really support openssl as a source of entropy
>
>Fangyi Zhou (1):
>      submodule-helper: fix usage string
>
>Josh Steadmon (1):
>      ls-tree: `-l` should not imply recursive listing
>
>Martin Ågren (1):
>      git-ls-tree.txt: fix the name of "%(objectsize:padded)"
>
>Todd Zullinger (1):
>      doc: replace "--" with {litdd} in credential-cache/fsmonitor
>
>Victoria Dye (1):
>      contrib/scalar: fix 'all' target in Makefile
>
>Ævar Arnfjörð Bjarmason (2):
>      Documentation/Makefile: fix "make info" regression in dad9cd7d518
>      Documentation: add --batch-command to cat-file synopsis
>

The NonStop builds are now working. t6200 is likely to fail - not sure what to do about that because of SSH location restrictions. At least the build works.

