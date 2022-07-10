Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E61C433EF
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 18:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiGJS0i convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 10 Jul 2022 14:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiGJS0h (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 14:26:37 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8252C13D19
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 11:26:36 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 26AIQTPP031507
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 10 Jul 2022 14:26:29 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "=?iso-8859-1?Q?'Michal_Such=E1nek'?=" <msuchanek@suse.de>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "=?iso-8859-1?Q?'=C6var_Arnfj=F6r=F0_Bjarmason'?=" <avarab@gmail.com>,
        "'Jonas Aschenbrenner'" <jonas.aschenbrenner@gmail.com>,
        <git@vger.kernel.org>
References: <CADS2hGpnkiPzivVDyN-PnGsQCTafqx68PxigXvBK1bv4O=p4kg@mail.gmail.com> <220710.86r12t82ea.gmgdl@evledraar.gmail.com> <20220710145502.GT17705@kitsune.suse.cz> <xmqq1qutrkm8.fsf@gitster.g> <20220710180131.GU17705@kitsune.suse.cz>
In-Reply-To: <20220710180131.GU17705@kitsune.suse.cz>
Subject: RE: Suggestion to rename "blame" of the "git blame" command to something more neutral
Date:   Sun, 10 Jul 2022 14:26:22 -0400
Organization: Nexbridge Inc.
Message-ID: <004601d8948a$922e5fa0$b68b1ee0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQE9X8cvlPCRej21C8yQF5dDcOALWQKVET6KAuY1BZAC/6I79AE869rFrmCWtkA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 10, 2022 2:02 PM, Michal Suchánek wrote:
>On Sun, Jul 10, 2022 at 09:35:43AM -0700, Junio C Hamano wrote:
>> Michal Suchánek <msuchanek@suse.de> writes:
>>
>> >> What do you think about this old patch of mine to add a 'git praise'?:
>> >> https://lore.kernel.org/git/20190401101246.21418-1-avarab@gmail.com
>> >> /
>> >
>> > Since you are asking .. I think it completely misses the point.
>> >
>> > I would consider it effective if users of git-praise(1) needed no
>> > knowledge of existence of git-blame(1).
>>
>> I think you are the one who completely misses the point of him sending
>> the URL (hint: what is the date of the patch?)
>>
>> "blame" is perfectly fine.  It is the tool we use to find a commit or
>> a series of commits to be blamed for whichever blocks of code in the
>> current codebase we are interested in.  Even if it is to find the
>> source of the buggy or ugly code in the current codebase (i.e. "verb
>> with negative connotation"), we are trying to put our fingers on the
>> commit to be blamed.
>
>If the word 'blame' is considered offensive by some pople a solution which
>basically adds an alias for the blame command without eliminating the
offensive
>word is insufficient.
>
>Sure, you may not find the word 'blame' offensive. I don't find it
offensive either. I
>don't find the word 'master' offensive either, and it was changed anyway.
>
>I don't want to decide whose offense is considered relevant and whose is
>disregarded.
>
>It's completely feasible to provide sound solution to eliminating the word
'blame'
>from the git source with the exception of some comaptibility alias, and the
linked
>patch is not it.

We already have git annotate as an effective alias. Why not use that if you
don't want git blame?
--R.

