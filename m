Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C7CB1FF6D
	for <e@80x24.org>; Fri, 16 Dec 2016 00:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938556AbcLPAT7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 19:19:59 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56778 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S938386AbcLPAT4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 19:19:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C2CC58334;
        Thu, 15 Dec 2016 19:19:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0V3snbwvSUIW1bHSyOl32mFVn3g=; b=s2qWQ8
        mLGt8MrgtXwAvHayqDwcelXpbTPKjA4KB/IBaFh1LPntvR0hwA2EQlSqYCDO0bqK
        utXlG8SnmXCFY5xe4ytyy1pusB3D0hPKTOsjBCvVebcEWZRO6y4jvdTXcVIjij+c
        6dLJuTYtegYTdOZFvymDrAbg2uMTiVZyL7kew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HqTiMlKBGGjXzrH/P3uylMY6hd/I1TAd
        7xiBo8+fcNPY5nvskCs5RLCVHo/3Vg/OZJ8SNFoFUSRmao30IQejIrycf4Kxjysg
        v/TFlhoaeTg+FQQ6oLEbG6yV4Ab6m1NfY1aeExOB3WlNQwTOnHYE9yG4CxT1O7hF
        4t8W+5076OE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 439C258333;
        Thu, 15 Dec 2016 19:19:10 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8F15758332;
        Thu, 15 Dec 2016 19:19:09 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Allow "git shortlog" to group by committer information
References: <CA+55aFzWkE43rSm-TJNKkHq4F3eOiGR0-Bo9V1=a1s=vQ0KPqQ@mail.gmail.com>
        <CA+55aFxSQ2wxU3cA+8uqS-W8mbobF35dVCZow2BcixGOOvGVFQ@mail.gmail.com>
Date:   Thu, 15 Dec 2016 16:19:08 -0800
In-Reply-To: <CA+55aFxSQ2wxU3cA+8uqS-W8mbobF35dVCZow2BcixGOOvGVFQ@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 15 Dec 2016 13:29:47 -0800")
Message-ID: <xmqqoa0cu3nn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 438EAB5C-C325-11E6-9061-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Just a ping on this patch..
> 
> Jeff had apparently done something similar as part of a bigger
> patch-series, but I don't see that either. I really don't care very
> much how this is done, but I do find this very useful, ...
>
> Yes, I can just maintain this myself, and maybe nobody else needs it,
> but it's pretty simple and straightforward, and there didn't seem to
> be any real reason not to have the option..

This fell off the radar partly because of the distractions like
"there are other attempts and other ways", and also because the
message was not a text-plain that can be reviewed inline.  Let me
try to dig it up from the mail archive to see if I can find it.
