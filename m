Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,STOX_REPLY_TYPE,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F3981F424
	for <e@80x24.org>; Sun, 24 Dec 2017 12:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752902AbdLXMdu (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Dec 2017 07:33:50 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:26791 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751882AbdLXMdt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Dec 2017 07:33:49 -0500
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id T5TOehC9oCbAZT5TOeMHhH; Sun, 24 Dec 2017 12:33:47 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=JvuBlIwC c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=EWPDJS0nAAAA:8 a=Xohx2MEitNktA-VSL-4A:9 a=QEXdDO2ut3YA:10
Message-ID: <99FE6DCAB81A4510ACF961290988C094@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "anatoly techtonik" <techtonik@gmail.com>
Cc:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, "Randall S. Becker" <rsbecker@nexbridge.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        "Git Mailing List" <git@vger.kernel.org>,
        "Igor Djordjevic" <igor.d.djordjevic@gmail.com>
References: <201711231458.vANEwUMK048049@elephants.elehost.com> <003c01d3646c$df78fc50$9e6af4f0$@nexbridge.com> <CAPkN8xJBWRs-2DxViBACLKzAbD1_EBA2MvmWVZmWgL+Sg72znw@mail.gmail.com> <CACBZZX4SM45hgA=PW0MEP9Ea0OG_8OTb5U7JCOX7xnd=hT5n3A@mail.gmail.com> <CAPkN8xKDQrf+LMpj9GHw9n_crJ1UUwq7Zek+Z1dgQ0n2Jz5U6g@mail.gmail.com> <FF34D4C2058D44E990BF149F3AB1E010@PhilipOakley> <CAPkN8xL1tUszvMuwwrc1ym6B6R5TzE4G9jKQ08oY2O_VPc8K_w@mail.gmail.com>
Subject: Re: Re: Unify annotated and non-annotated tags
Date:   Sun, 24 Dec 2017 12:31:36 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="utf-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 171224-0, 24/12/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfHAXIvEm/Z4hSjw1feUfXZlUr7svf3yxor/86teal9wMorS72Ulu8OeIAZAvlQJEfX8bipn6M+uSVaSVOLUX2XjFAnWj5f92Uv+3CDtnwQZGEfq2pKU2
 U8VRUsJKC6VKteqbNr0pNCUskbQfWNvY6HReecvlwcXvwvp72bzRJm+cAveTPMUvQShJK+6Gg2tXAZ5EoEfeJsPun6XYOzzbSDOzoI/n35cxCNySuIygz7f8
 CMVdkFHitp1uqOuZEaLO8YCAjr1qouXK2pQWb2JR02ME3YGHPI/ye6pRjxkD/TTxDvmlw+LKYBUVEKSOUJ16PpMRpy/xkEsm1VonP/YdzcY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "anatoly techtonik" <techtonik@gmail.com>
> From: Philip Oakley
> > So if I understand correctly, the hope is that `git show-ref --tags` 
> > could
> > get an alternate option `--all-tags` [proper option name required...] 
> > such
> > that the user would not have to develop the rather over the complicated
> > expression that used a newish capability of a different command.
>
> > Would that be right?

> That's correct.

> > Or at least update the man page docs to clarify the annotated vs
> > non-annotated tags issue (many SO questions!).

> Are there stats how many users read man pages and what is their
> reading session length? I mean docs may not help much,

The "reading the manual" question is fairly well answered in the Human Error 
literature in terms of clarity and effectiveness, and the normal human error 
rates (for interest search for "Panko" "Spreadsheet errors" [1]). Typical 
human error rate is 1%. Most pilot error ends up being, in part, caused by 
confusing / incomplete manuals (i.e. we fail to support them).

If the manuals are the peak of perfection then they are well visited and the 
supporting material is usually good. If manuals are a sprawling upland with 
bogs, fissure, islands of inaccessability, then they are rarely used.

Git does suffer from having a lot of separate commands, which makes seeing 
the woods for the trees difficult sometimes, especially as its core concepts 
are not always well understood.

Improving the manuals (as reference material) will always help, even if the 
trickle down effect is slow (made worse by alternate sources of error - 
Stackoverflow and blogs... ;-)

> > And indicate if the --dereference and/or --hash options would do the 
> > trick!
> > - maybe the "^{}" appended would be part of the problem (and need that 
> > new
> > option "--objectreference" ).

> --dereference would work if it didn't require extra processing.
> It is hard to think about other option name that would give
> desired result.
> ---
> anatoly t.
--
Philip

[1] https://arxiv.org/abs/1602.02601  https://arxiv.org/pdf/1602.02601
"This paper reviews human cognition processes and shows first that humans 
cannot be error free no matter how hard they try, and second that our 
intuition about errors and how we can reduce them is based on appallingly 
bad knowledge." 

