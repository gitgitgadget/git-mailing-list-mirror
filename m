Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878E7C4742C
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EA9022275
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uXJH3pbs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbgKBUkk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 15:40:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54944 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgKBUkB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 15:40:01 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0FDD38E9F1;
        Mon,  2 Nov 2020 15:39:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=nnrKJdhoAr7PvML/g+whGafr9IM=; b=uXJH3pbs+xsqx17T9nfz
        DADYBj+u9m7rakrMTGbxih54E9tj8KlWGaWCpbhOFeF0YZ4P/+FKLgaaWjK1NGAj
        EEIQMvb+0x2b+bvfluiYUIeCXmP8MWLyxyhy/nOybPEOwEst/nfU+qt6/zY56HBS
        t7YJAa5VQRFdmvxttgmeg+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=vWFUe2asezuImPMx2QpaNX02bCAaKnoxje4u0OMh+zjWT5
        sQW2x55qRTC+yrtY8B2YJfMuFhpKx0qFfrvZ+cpx5XLBJ4PRhxZqUAxISkUzBsjs
        JL9/emjjZ6njpcBeJhxTY1XlZJGTIGgbT16mnGe3eDYR02Lo2QbQ5VjP/k7C0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 075A78E9F0;
        Mon,  2 Nov 2020 15:39:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 757448E9EB;
        Mon,  2 Nov 2020 15:39:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sibo Dong <sibo.dong@mail.utoronto.ca>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitgitgadget@gmail.com" <gitgitgadget@gmail.com>,
        "sibo.dong@outlook.com" <sibo.dong@outlook.com>
Subject: Re: [PATCH] git-prompt.sh: make `option` a local variable
References: <1d19cdf35c12b1079cee0861469dc1a652642c82.camel@mail.utoronto.ca>
Date:   Mon, 02 Nov 2020 12:39:57 -0800
Message-ID: <xmqqlffjtrvm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92A59EB0-1D4B-11EB-91A9-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sibo Dong <sibo.dong@mail.utoronto.ca> writes:

> Thank you for the feedback Junio; I'm a bit new to contributing. Since
> you've justified this change much better than I have, is there any need
> for further action on my part?

The reviews by others are offered and taken as input to improve the
patch(es), but they are merely sugestions.  It is up to the original
contributors to either disagree and not take them with explanation,
or agree with and take them to improve their patch(es) before
sending the next iteration.

So, at least you'd need to say if you agree with the suggested
change and to what degree.  Since you've done so, I can save one
roundtrip by rewriting the proposed commit log message myself while
queuing your patch ;-)

Thanks.

