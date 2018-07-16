Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A7CF1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 15:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbeGPQ1Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 12:27:25 -0400
Received: from mout.gmx.net ([212.227.17.20]:43461 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbeGPQ1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 12:27:25 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M7TQZ-1g0dSu3DRn-00xGvA; Mon, 16
 Jul 2018 17:59:07 +0200
Date:   Mon, 16 Jul 2018 17:59:03 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Aaron Schrab <aaron@schrab.com>
cc:     git@vger.kernel.org, Daniel Harding <dharding@living180.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] sequencer: use configured comment character
In-Reply-To: <20180716045902.16629-1-aaron@schrab.com>
Message-ID: <nycvar.QRO.7.76.6.1807161758560.71@tvgsbejvaqbjf.bet>
References: <xmqq4lh4z870.fsf@gitster-ct.c.googlers.com> <20180716045902.16629-1-aaron@schrab.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9hiSxKwpTg5eWmVEfzPxr4EFgUCwRLMKW9lxE/qPiW/cRvOD6Lu
 jY/FJlsU+5WdrTeHFQlptuGL313sbrLRU/83meGTmh3SKmDfG8oTeJ9WpVtyk2+BVJSK7+Y
 FZcxBkyG8zByQfxWwZircW8m87CwTmPAXhOr3FPvAOjPiZPoK9TVxzR5wZqgQ2lPBZ7y3VM
 qsS8WGVQgbiTG3nsaPTUQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:paUivy40tNo=:aD4du5MoSjnqPYDe4bSlUR
 51erSVZBozcTxMvFMmm6QbKdm0aPbGyZTZe/zXsp2ulA84cD5gpfgRCWLUvhgX0Shyph1Wqh/
 wFULBp1p7tuh8xeqEXTA/vGp8l+VHzX0xqwBit17ayHcZ5wJy7t5sn6b7cw9RO0KB2HVxxo/y
 4SA39QsNPdrkRQnQj9Ytu/WaXTN/GaeN0g2aYrXnZ2v0VR1ep3xpPQ+o4lQzaa8+wBmCIicAS
 jEUB3vOQdlzorsfXGHNcZA/Kts01NSwGOZrSlAU5qVh0FH3WkJPfNShxoTeQCiyeDBxSwbam4
 U/6K04rccNo6Cfirr1dimJ1MoQHLJrjSz/+wlv/tIw79FN8o+PTPKiM00QZ/yZ7vvBgnR+P22
 Y1PVsi4Kb4v1rtHAaLvZ6WkMXX4Eesvi3epsQvg5jyGlab/yjn2NRnxHl8qtcTh/x7uT4A+Wk
 YLe0rJiIZKt1fdy/TtvL6144Vb8XhF/nUH08G0tRtWIWpC9dLMX4ZdiT+kCk0bE9Yrs74Rqs0
 918Mi6CT/qWM/v3YMizkymKLVZU/FonIODqHBceQ0lwJ5VAVE/ZUxxz2lM5tza1eXM+TJwLlL
 +kLUAu0SY5Z5DStN1WAE37G9oJeSbKqZsX1DIIAsRiFxAb+aOXf744OGKzvdRXxQ9W1NuCpQK
 bkGC0Pl64yB9qJp8GzUr7rBmeYid8tk/rYHKe8m/kLtkQgy+GOxVMb3evIH5M2oAUZ18jG1K2
 yQCQO5eN2dCWjn7gbNqnXycdMZA+OLH2dUP/WOpKt2ER+Fiz5hjSByOIwtWquVVlbigpQysy3
 8ppyUao
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Aaron,

On Mon, 16 Jul 2018, Aaron Schrab wrote:

> At 10:15 -0700 12 Jul 2018, Junio C Hamano <gitster@pobox.com> wrote:
> >Aaron Schrab <aaron@schrab.com> writes:
> >> Note that the comment_line_char has already been resolved by this point,
> >> even if the user has configured the comment character to be selected
> >> automatically.
> >
> >Isn't this a slight lie?
> 
> Looking into that a bit further, it does seem like my explanation above 
> was incorrect.  Here's another attempt to explain why setting 
> core.commentChar=auto isn't a problem for this change.
> 
> 8< -----
> 
> Use the configured comment character when generating comments about
> branches in a todo list.  Failure to honor this configuration causes a
> failure to parse the resulting todo list.
> 
> Setting core.commentChar to "auto" will not be honored here, and the
> previously configured or default value will be used instead. But, since
> the todo list will consist of only generated content, there should not
> be any non-comment lines beginning with that character.

How about this instead?

	If core.commentChar is set to "auto", the intention is to
	determine the comment line character from whatever content is there
	already.

	As the code path in question is the one *generating* the todo list
	from scratch, it will automatically use whatever core.commentChar
	has been configured before the "auto" (and fall back to "#" if none
	has been configured explicitly), which is consistent with users'
	expectations.

Ciao,
Johannes
