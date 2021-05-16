Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AABC433ED
	for <git@archiver.kernel.org>; Sun, 16 May 2021 01:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DFB2610CA
	for <git@archiver.kernel.org>; Sun, 16 May 2021 01:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbhEPA66 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 May 2021 20:58:58 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54427 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbhEPA65 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 May 2021 20:58:57 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 66B8A130B1D;
        Sat, 15 May 2021 20:57:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dowve8d1cKpk
        VtbGUMTwu0YzbJup6kWGqDJYntBwbZ0=; b=bDgat0FcB4XHzS0MSsbt+XDvLQ6I
        2kpw0QzwLHfW72oj99AMKPCkcnQMtyQpXNLJmLXPv41P9BUIbpQJanYbHrOltrzE
        bb1jQnkCUJ8AfKEG2+KipK5Aw0aVfZdk3Me/0/RHNdVB1LODFZU7+jBiSh9xuQPe
        /CdqAVO8b/+n2d4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3C5DF130B1C;
        Sat, 15 May 2021 20:57:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6E24F130B1B;
        Sat, 15 May 2021 20:57:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Documentation/howto: tracking git.git
References: <20210514124925.39229-1-bagasdotme@gmail.com>
        <xmqqwns177cv.fsf@gitster.g>
        <cbbde4f4-3e10-2c08-6ca1-6f22f8497194@gmail.com>
Date:   Sun, 16 May 2021 09:57:38 +0900
In-Reply-To: <cbbde4f4-3e10-2c08-6ca1-6f22f8497194@gmail.com> (Bagas Sanjaya's
        message of "Sat, 15 May 2021 10:32:27 +0700")
Message-ID: <xmqqsg2n7awt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B6D5B46C-B5E1-11EB-B8FA-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 14/05/21 20.49, Junio C Hamano wrote:
>> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>>=20
>>> +Available Branches
>>> +------------------
>>> +
>>> +There are several branches on git.git with different purposes:
>>> +
>>> +master::
>>> +This is the most stable branch. Changes (topics) that are merged
>>> +to master should have been stabilized in next and suitable for
>>> +production use. Feature releases (vX.Y.0) are cut from this
>>> +branch.
>> Isn't "maint" meant to be more stable?
>>=20
>
> I think "maint" is maintenance branch for latest feature release.
> For feature stabilization it happens on "main", so "master" is fully
> polished.

With the status of being back-then-most polished plus only fixes and
no unnecessary new features that can introduce unstability yet to be
discovered, by definition 'maint' ought to be "more stable" than
'master', no?

In any case, as =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh pointed out, I=
 think we have
most of these written down elsewhere, and it is easier for readers
if we can find a way to reorganize them and incorporate new stuff
that is brought in by this proposal.

