Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCDEC433E2
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 16:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27BAE2078C
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 16:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="V3AMEhud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbgFIQCv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 12:02:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50972 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbgFIQCs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 12:02:48 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6357F6B257;
        Tue,  9 Jun 2020 12:02:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4x7z2+hbUTmkyCdhMzOPsychnuA=; b=V3AMEh
        udvvd0Hh6cSUWhoRXoorUQuhGJtQZm2kQ77N2+D1HIK3wr6h+JB3WsHZiLfgA5ji
        v/SB8htQzIqtRmTBA63vxhsFswlblNjdsS1CUykVxZIFBns4nwfWY3+Lo/tplV4t
        KkQJbhb9A7REztNDsLfEAEYxcdHZuw3oRFaws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TEjpaZWaZ9S2W1f4S2xLppDP19H2aqbh
        pNQ8jWzQqWydJcaga9iVGHkq1M9zoFURNwhpJNmQe/CQ6TuHg1b5eegs7zplJ826
        BhEhrZ188DmjUMZcnqqYmHm9nLph9nuYYmf2+SrOJcEJ0WoezNnHWRJ7s/E8pn/P
        fX8etYZnt58=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A6FD6B256;
        Tue,  9 Jun 2020 12:02:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CCD056B255;
        Tue,  9 Jun 2020 12:02:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Simon Pieters <simon@bocoup.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, don@goodman-wilson.com
Subject: Re: Rename offensive terminology (master)
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
        <20200505231641.GH6530@camp.crustytoothpaste.net>
        <CAOAHyQx=+fM1FpAv+g3M+j7j4MgLJA03=MGFmXLvZcfJKAEpGg@mail.gmail.com>
Date:   Tue, 09 Jun 2020 09:02:43 -0700
In-Reply-To: <CAOAHyQx=+fM1FpAv+g3M+j7j4MgLJA03=MGFmXLvZcfJKAEpGg@mail.gmail.com>
        (Simon Pieters's message of "Tue, 9 Jun 2020 17:16:57 +0200")
Message-ID: <xmqqeeqoi5wc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A75150F6-AA6A-11EA-A405-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simon Pieters <simon@bocoup.com> writes:

> If someone is interested in helping with this, please follow up with
> Don. But I would like to ask again for git mainline to seriously
> consider adopting this change, given the information presented above
> and the ongoing movement against systemic racism.

I am OK in principle if a future version of Git, when used by a new
user of Git who does not have any custom configuration, wrote a
string other than 'master' in .git/HEAD when "git init" is run.

Picking a good replacement word to mean the primary branch is
tricky, though.  Just having a notion that one is special among
many (i.e. the primary-ness of the thing being named with a word
that will replace 'master') may already be offending to some folks.

Also notice that the qualified statement above talks only about the
plain vanilla experience---the change of the default should be
designed to avoid harming workflows in existing repositories and
tools built around them.

So, I think there are two separate tasks that can run in parallel.

 * Pick the new default word to replace 'master'; it may turn out
   that the Git project choose not to pick any to avoid offending
   anybody, in which case "git init" may force end users pick the
   default they want to use and offer recording in the ~/.gitconfig
   file.

 * Engineering work that uses the word that replaces 'master' by
   default (if one got chosen) when not configured, and use the word
   the end user chose when configured (iow, allow users to override
   the default word that will replace 'master').  This includes
   design work to decide what to do in existing repositories (if
   there is anything that needs to be done).

Without digging deeply, I think we are pretty good about basing
things on HEAD (e.g. "git branch -d" protects the branch by seeing
if it is already merged to 'HEAD' or its @{upstream}, and not treats
'master' any specially), so it might be the matter of teaching "git
init" (it uses 'master' by default) and "git clone" (it tries to use
the name of the branch the HEAD at origin points at, but falls back
to 'master' when the branch name their HEAD points at cannot be
determined).

