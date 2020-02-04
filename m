Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDB5C35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 18:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4FC20674
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 18:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KKkwmZ9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgBDS36 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 13:29:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64549 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbgBDS36 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 13:29:58 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D1C953B79D;
        Tue,  4 Feb 2020 13:29:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JUNZPbWjQkRiEz4wg3SvY/Syh/Y=; b=KKkwmZ
        9rdszLxLYPEiNLi9aIcF9hoy+o2SlFjw8qfdA6csnpFLoIzmKv4MzBoY8ug71arc
        ggpMl1m9U1Z7XNgE+nvMTNB6vbr+glw63XcKyaiTO9iQNSJyZpKJ3GZbLuudX5d2
        EEUUav7452ThCkzsH+0zB5pjocXQYWriVTDIU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HuIdUmoTyDvq9G+WHmrV+ksf3Yy80xg3
        TgJO6ILSctv7FWpAPSBSu4fkl1/Tbsi3kicq62HKpO23ODcBD8S67jpt7Va+x1Nu
        GY9SJaG3KWh44NzPAJpFQ1wmv1TU3meAD4j8rRZq91lnmg//KhxT2KVJteUrnx3w
        qxpCjc7fbEc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C96593B79C;
        Tue,  4 Feb 2020 13:29:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3AD753B79B;
        Tue,  4 Feb 2020 13:29:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Mike McGranahan <mike@mcgwiz.com>, git@vger.kernel.org
Subject: Re: Patch text in git-add patch mode lacks whitespace highlighting
References: <CAK7jxYgJNvCp=m6rH31HNzN9Mqgaav7_YPvUMZmRb7mdYDZ_1g@mail.gmail.com>
        <nycvar.QRO.7.76.6.2001311304140.46@tvgsbejvaqbjf.bet>
        <20200201110203.GA1864964@coredump.intra.peff.net>
        <nycvar.QRO.7.76.6.2002012205520.46@tvgsbejvaqbjf.bet>
        <20200203085456.GD2164@coredump.intra.peff.net>
        <nycvar.QRO.7.76.6.2002031320180.46@tvgsbejvaqbjf.bet>
        <20200203145155.GA272077@coredump.intra.peff.net>
Date:   Tue, 04 Feb 2020 10:29:53 -0800
In-Reply-To: <20200203145155.GA272077@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 3 Feb 2020 09:51:55 -0500")
Message-ID: <xmqqlfpi8au6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5698FF0C-477C-11EA-8220-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If just the human-readable one, then many options that change the line
> count would be problems: diff.context, diff.interhunkcontext,
> diff.orderfile, etc.
>
> If both, then some options would be problematic for applying. Just
> looking over the list, these jump out at me:
>
>   - color.diff=always would obviously be an issue (though TBH I think
>     anybody doing that is inviting a lot of breakages anyway)
>
>   - diff.external would be a problem if it kicked in, though I think it
>     would require --ext-diff to actually do anything
>
>   - diff.submodule would generate diffs that can't be applied

What can truly help "git add -p" might be a new output mode from
"git diff", perhaps, in which instead of writing a stream of text
(with color codes intermixed), the output machinery makes a call to
API-user supplied callbacks to report ("type of output line", "the
payload", "list of coloring information") tuples for each line, so
that the API-user can synthesize _both_ versions it currently uses
with a single invocation of "diff"?  There may be tons of "output
line" types, like the diff header, hunk header, context, removed,
added, etc., and depending on the type, the form the payload takes
may be different (e.g. a context line may be just a plain text, a
hunk header line may be a five-tuple (pre- and post-context line
numbers and line countsm plus the function-header line text).

As long as the call the API-user makes to the diff machinery grabs
everything that is needed for both human and machine consumption in
a single call, there is no risk of getting confused by two sets of
inconsistent patch data.


