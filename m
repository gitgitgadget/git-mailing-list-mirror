Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1028C11F68
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 14:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5D3B61427
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 14:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbhGBOR4 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 2 Jul 2021 10:17:56 -0400
Received: from elephants.elehost.com ([216.66.27.132]:60481 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbhGBORz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 10:17:55 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 162EFEVE076094
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 2 Jul 2021 10:15:15 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>
Cc:     "'martin'" <test2@mfriebe.de>,
        "'Felipe Contreras'" <felipe.contreras@gmail.com>,
        "'Andreas Schwab'" <schwab@linux-m68k.org>, <git@vger.kernel.org>,
        "'Junio C Hamano'" <gitster@pobox.com>
References: <20210702100506.1422429-1-felipe.contreras@gmail.com> <20210702100506.1422429-6-felipe.contreras@gmail.com> <871r8hauvi.fsf@igel.home> <60dee7d4e27bf_2964b20817@natae.notmuch> <65b1d215-c3ab-e0e3-f4ac-a30131541f9b@mfriebe.de> <60def07e686c7_7442083a@natae.notmuch> <3e82a574-fdcc-08b8-8fb5-1ff15f8ae564@mfriebe.de> <03a401d76f45$e1c6fce0$a554f6a0$@nexbridge.com> <874kdcal1k.fsf@evledraar.gmail.com>
In-Reply-To: <874kdcal1k.fsf@evledraar.gmail.com>
Subject: RE: [PATCH 5/5] config: add default aliases
Date:   Fri, 2 Jul 2021 10:15:08 -0400
Message-ID: <03ac01d76f4c$ad23a130$076ae390$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFt4lYZIaBsC/3edPIiz2atDh3oKQJ0jboPAtZ1RKIBrdoWqQDA6SjYAdtwiv8B5YNkIAHEAWDFAhqQj4OriAlxUA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 2, 2021 9:42 AM, Ævar Arnfjörð Bjarmason wrote:
>To: Randall S. Becker <rsbecker@nexbridge.com>
>Cc: 'martin' <test2@mfriebe.de>; 'Felipe Contreras' <felipe.contreras@gmail.com>; 'Andreas Schwab' <schwab@linux-m68k.org>;
>git@vger.kernel.org; 'Junio C Hamano' <gitster@pobox.com>
>Subject: Re: [PATCH 5/5] config: add default aliases
>
>
>On Fri, Jul 02 2021, Randall S. Becker wrote:
>
>> On July 2, 2021 7:15 AM, martin wrote:
>>>On 02/07/2021 12:54, Felipe Contreras wrote:
>>>> martin wrote:
>>>>> IMHO it would be good to (partly) follow other vcs, and have commit
>>>>> = ci
>>>> I'm fine with leaving co out of the default aliases if it's deemed
>>>> "too controversial".
>>>>
>>>> But ci doesn't make sense. ci comes from "check in" which has no
>>>> similitude in git.
>>>svn uses it for "commit".
>>>It can be seen as CommIt.
>>>
>>>But of course other letters can be picked. I don't see an advantage in it though.
>>>Like CoMmit cm ? or CommiT ct ? None of them seems any better to me.
>>>
>>>> I don't think it's a good idea to leave "git checkout" without an
>>>> alias (it's perhaps the second or third most used command), but at
>>>> least some aliases are better than no aliases.
>>>Well, that goes back to a bigger question. And from the brief time I
>>>have been on this mail list, it appears to me there is a divide into 2 groups.
>>>
>>>If checkout is really meant to give way to switch/restore then it
>>>needs no further advertising. And then the current usage statistics are a relict from the before switch/restore time.
>>>
>>>If on the other hand checkout is not just to be kept for backward
>>>compatibility, but should always remain an equal alternative to switch/restore (i.e. it should still be taught to new user in 20 years) then
>it wants to have a default alias.
>>
>> In my opinion, default aliases are not a good path. If a command is
>> intended to be part of the git command set, then it should be a
>> builtin not an alias. Users have their own alias setups and implied
>> conflicts are just going to be confusing and end up in help, examples,
>> presentations, and so forth.
>
>So aside from the "are these aliases good idea?" discussion, would you prefer if they're implemented that we theat them the exact same
>way we do "git fsck-objects" and "git fsck"? I.e. list them twice in git.c, just pointing to the same cmd_fsck?

Without knowing the full history of why the duplication, yes. That would be my preference. If it is a git command, it should be handled like one as closely as possible. Presumably, it also would show up in git help -a. I would not expect aliases to show in help.

