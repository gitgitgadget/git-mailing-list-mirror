Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B62C433B4
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 22:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D94761178
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 22:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbhDBWX0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 18:23:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61548 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbhDBWX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 18:23:26 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 63960BAC65;
        Fri,  2 Apr 2021 18:23:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Gy+yfIixljkyhdOA7W/UyxYrqgw=; b=Vhrmhb
        sGyNcpskQeoQPTgfujerAeSn73C9f6IA2gqZ1QOvEOnpwgyILoh55V3gNNk/u3KT
        XQhZnd3tKlbPnm60h5KFZqxEMJ/2FfmaGETsqCPp68gFnu6wm7YfDat7Gpl2Dl9n
        uINSDROwOHzZ2Boa+m47Zrp4kj2anbjRzSkMM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XHQRc5jUWIcWmiVl1lw0msZM5viIRGeu
        t9wXJSispopcqEgieC8yVDBv0v++Xs0GUdJMxMC075+2xh7oFz/+3Grcvk6wGIo3
        kaTXfJL2A7PPTOKWTLeEIKC1wpnugwasjd4MR4/H/YztR4DXO/pc2h6uOzQtaq9b
        Erae+CKUCVg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A8BABAC64;
        Fri,  2 Apr 2021 18:23:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D557FBAC63;
        Fri,  2 Apr 2021 18:23:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Firmin Martin <firminmartin24@gmail.com>
Cc:     git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: Re: [PATCH][GSoC] user-manual.txt: fix empty heading of introduction
References: <20210402121303.344914-1-firminmartin24@gmail.com>
        <xmqqwntk2xgy.fsf@gitster.g> <xmqqsg482x4f.fsf@gitster.g>
Date:   Fri, 02 Apr 2021 15:23:22 -0700
In-Reply-To: <xmqqsg482x4f.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        02 Apr 2021 14:29:52 -0700")
Message-ID: <xmqqblaw2un9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 09B97684-9402-11EB-9803-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Firmin Martin <firminmartin24@gmail.com> writes:
>>
>>> For future reference, here are the content of the relevant & auto-generated files
>>> before this commit.
>>
>> I would have expected to see "before and after".  Is it too obvious
>> what the postimage would be?  Otherwise, a better presentation would
>> be to show (an excerpt from) diff between preimage and postimage
>> output.
>>
>> Thanks.
>
> Another thing to look out for.  I do not think git.info is the only
> consumer of user-manual.txt.  Does this change affect the other
> consumer, user-manual.html, and if so how?

So, here is what "before and after" of the user-manual.xml output
file looks like.  It shows that the standalone document loses its
Preface and all the chapters have been renumbered (because what was
in the Preface has become the first chapter).

To pages like http://git-scm.com/docs/user-manual that take our
source material and show them in preformatted, this change will
cascade through.  Hopefully these places won't be upset for not
having the Preface (e.g. this particular site does not even refer
to the chapters as "chapter 1", "chapter 2", etc.) but we'd never
know until we try and break them ;-)


--- user-manual-without-patch.xml
+++ user-manual.xml
@@ -7,8 +7,8 @@
 <bookinfo>
     <title>Git User Manual</title>
 </bookinfo>
-<preface>
-<title></title>
+<chapter id="introduction">
+<title>Introduction</title>
 <simpara>Git is a fast distributed revision control system.</simpara>
 <simpara>This manual is designed to be readable by someone with basic UNIX
 command-line skills, but no previous knowledge of Git.</simpara>
@@ -31,7 +31,7 @@ pages, or <ulink url="git-help.html">git-help(1)
 without any explanation.</simpara>
 <simpara>Finally, see <xref linkend="todo"/> for ways that you can help make this manual more
 complete.</simpara>
-</preface>
+</chapter>
 <chapter id="repositories-and-branches">
 <title>Repositories and Branches</title>
 <section id="how-to-get-a-git-repository">
