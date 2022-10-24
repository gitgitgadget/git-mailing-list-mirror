Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADF5C67871
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 00:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiJYAc0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 20:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiJYAcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 20:32:09 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DCD2D2870
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 15:56:15 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 76BFC1CBF88;
        Mon, 24 Oct 2022 18:56:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QfIx+a4+T2VyuwimMK8ZrHsc0WkhkSxo59zAfC
        R8OVg=; b=Rc5j8DKZTEwO5Wda68YQ+a0+3TBWRkIe3kGCNkq4pOle2wfW+gMXus
        +wECrU0bzziLUkZna2Gm48//V7xa078iH/UisvevnxZyJcn2g4NVKFSqTt5JlQZI
        gPKDyUBUnaEiIWvQh5OwhTWN2yCosx85oBhrRRChOdT1RhgIhd0UU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6530D1CBF87;
        Mon, 24 Oct 2022 18:56:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 826E91CBF86;
        Mon, 24 Oct 2022 18:56:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Julia Ramer <prplr@github.com>
Cc:     Julia Ramer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, git-security@googlegroups.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Keanen Wold <keanenwold@github.com>,
        Veronica Giaudrone <veronica.Giaudrone@microsoft.com>,
        Bri Brothers <brbrot@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Julia Ramer <gitprplr@gmail.com>
Subject: Re: [PATCH v3] embargoed releases: also describe the git-security
 list and the process
References: <pull.1345.v2.git.1666142160427.gitgitgadget@gmail.com>
        <pull.1345.v3.git.1666338109778.gitgitgadget@gmail.com>
        <xmqqo7u5m8ku.fsf@gitster.g>
        <CADq8SzV06zTHmG+uSW==R5sL=MveuA9VSMhpV8hck+rzvVSp4Q@mail.gmail.com>
Date:   Mon, 24 Oct 2022 15:56:11 -0700
In-Reply-To: <CADq8SzV06zTHmG+uSW==R5sL=MveuA9VSMhpV8hck+rzvVSp4Q@mail.gmail.com>
        (Julia Ramer's message of "Mon, 24 Oct 2022 13:18:21 -0700")
Message-ID: <xmqqeduwrfuc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0E986C1A-53EF-11ED-99ED-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Julia Ramer <prplr@github.com> writes:

>> > +- Once the review has settled and everyone involved in the review agrees that
>> > +  the patches are ready, the Git maintainer, and others determine a release date
>> > +  as well as the release trains that are serviced. The decision regarding which
>>
>> We typically know how involved the final changes would be (i.e. the
>> minimum time it would take for us and involved others to prepare the
>> release) way before all the t's are crossed and i's are dotted in
>> the patches, so setting the release date may be done much earlier.
>
> Distilled into s/ready/nearing the finish line/

Excellent.

>> > +- Less than a week before the release, a mail with the relevant information is
>> > +  sent to <distros@vs.openwall.org> (see below), a list used to pre-announce
>> > +  embargoed releases of open source projects to the stakeholders of all major
>> > +  distributions of Linux as well as other OSes. This includes a Git bundle
>> > +  of the tagged version(s), but no further specifics of the vulnerability.
> ...
> I think it makes sense to just remove the entire last sentence, as the
> relevant information is referenced in the parenthetical "(see below)".

Very sensible.

Thanks.
