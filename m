Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64410C07E95
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 22:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4484C6140E
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 22:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhGBWFx convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 2 Jul 2021 18:05:53 -0400
Received: from elephants.elehost.com ([216.66.27.132]:58065 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhGBWFx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 18:05:53 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 162M3Cbr018447
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 2 Jul 2021 18:03:13 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'martin'" <test2@mfriebe.de>,
        "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>
Cc:     "'Felipe Contreras'" <felipe.contreras@gmail.com>,
        "'Andreas Schwab'" <schwab@linux-m68k.org>, <git@vger.kernel.org>,
        "'Junio C Hamano'" <gitster@pobox.com>
References: <20210702100506.1422429-1-felipe.contreras@gmail.com> <20210702100506.1422429-6-felipe.contreras@gmail.com> <871r8hauvi.fsf@igel.home> <60dee7d4e27bf_2964b20817@natae.notmuch> <65b1d215-c3ab-e0e3-f4ac-a30131541f9b@mfriebe.de> <60def07e686c7_7442083a@natae.notmuch> <3e82a574-fdcc-08b8-8fb5-1ff15f8ae564@mfriebe.de> <03a401d76f45$e1c6fce0$a554f6a0$@nexbridge.com> <874kdcal1k.fsf@evledraar.gmail.com> <03ac01d76f4c$ad23a130$076ae390$@nexbridge.com> <8f847f31-5c5d-0236-997c-bd07040f7ea7@mfriebe.de>
In-Reply-To: <8f847f31-5c5d-0236-997c-bd07040f7ea7@mfriebe.de>
Subject: RE: [PATCH 5/5] config: add default aliases
Date:   Fri, 2 Jul 2021 18:03:07 -0400
Message-ID: <03cf01d76f8e$0d8cf620$28a6e260$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFt4lYZIaBsC/3edPIiz2atDh3oKQJ0jboPAtZ1RKIBrdoWqQDA6SjYAdtwiv8B5YNkIAHEAWDFAhqQj4MBoKTRiQHzUw0Fq2vswnA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 2, 2021 10:44 AM, martin wrote:
>To: Randall S. Becker <rsbecker@nexbridge.com>; 'Ævar Arnfjörð Bjarmason' <avarab@gmail.com>
>Cc: 'Felipe Contreras' <felipe.contreras@gmail.com>; 'Andreas Schwab' <schwab@linux-m68k.org>; git@vger.kernel.org; 'Junio C
>Hamano' <gitster@pobox.com>
>Subject: Re: [PATCH 5/5] config: add default aliases
>
>On 02/07/2021 16:15, Randall S. Becker wrote:
>> On July 2, 2021 9:42 AM, Ævar Arnfjörð Bjarmason wrote:
>>> So aside from the "are these aliases good idea?" discussion, would
>>> you prefer if they're implemented that we theat them the exact same
>>> way we do "git fsck-objects" and "git fsck"? I.e. list them twice in git.c, just pointing to the same cmd_fsck?
>> Without knowing the full history of why the duplication, yes. That would be my preference. If it is a git command, it should be handled
>like one as closely as possible. Presumably, it also would show up in git help -a. I would not expect aliases to show in help.
>>
>But, if it is a git command, can you still overwrite it with your on alias?
>
>As it was pointed out, some of those are used by people as aliases for other things already.

If an alias overwrites/overrides a git command, I would expect NIST to have a proverbial cow and a CVE will be raised, probably by me.

Overriding base product functionality with something that does something other than what is documented is a highly questionable practice.

