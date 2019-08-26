Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 372D61F461
	for <e@80x24.org>; Mon, 26 Aug 2019 15:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbfHZPt0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 11:49:26 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64355 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbfHZPt0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 11:49:26 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C4586729A0;
        Mon, 26 Aug 2019 11:49:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EHnBRXPcjZ+/0MwUDssDVZC+vAo=; b=lLQzEP
        SVLJSXXkzZcrlZAlFpia+69PoNY8rtygpMO9XHITMPgpDOEcIOgb235Y4wUVLReD
        r2dJDcXfPFEb/Hj+fnX6JylSA4JFzPSssvkFtGrxHnicbRjHjBwzm1kZ/cqDfQOh
        AFHaFvadbXhmE+cTCQwe+bzatFNmjNbhnz2MY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kLh/umASxGQbs5xoBmtEfvaUpGeLZ146
        mWQlnFmLqb3ENdQDSR9Mf9k4On/uJ0JBzbHWIZ+4R0WGzRr+kCLsjo27omat/Vxn
        YuJrnnswQlgshWsxPdTkhjTdv22TgwBEWRbWI+S1PxsxWalDyc7lvEzUuVXFhjX7
        cASav9iZPNo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BBA147299E;
        Mon, 26 Aug 2019 11:49:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E83A37299B;
        Mon, 26 Aug 2019 11:49:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Philip Oakley <philipoakley@iee.email>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Cesar Eduardo Barros <cesarb@cesarb.net>
Subject: Re: [PATCH v2 20/23] .gitignore: touch up the entries regarding Visual Studio
References: <pull.287.git.gitgitgadget@gmail.com>
        <pull.287.v2.git.gitgitgadget@gmail.com>
        <dc4a9cc6205afac03d1154ca935e4334536fa693.1564430879.git.gitgitgadget@gmail.com>
        <20190825120741.GM20404@szeder.dev>
        <9eed02e7-7e2d-4ae3-6c08-ab17b3c92fb6@iee.email>
        <20190825190957.GN20404@szeder.dev>
        <e221aaf8-7d0b-6feb-3f58-1e9e4382939b@iee.email>
        <nycvar.QRO.7.76.6.1908261638450.46@tvgsbejvaqbjf.bet>
Date:   Mon, 26 Aug 2019 08:49:20 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1908261638450.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 26 Aug 2019 16:57:08 +0200 (CEST)")
Message-ID: <xmqqk1b0j5a7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 12FA92DE-C819-11E9-B2C5-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > > > > --- a/.gitignore
>> > > > > +++ b/.gitignore
>> > > > > @@ -230,6 +230,7 @@
>> > > > >   *.ipdb
>> > > > >   *.dll
>> > > > >   .vs/
>> > > > > -/Debug/
>> > > > > -/Release/
>> > > > > +*.manifest
>> > > > This new line ignores the tracked file 'compat/win32/git.manifest'
>> > > > that was added fairly recently in fe90397604 (mingw: embed a manifest
>> > > > to trick UAC into Doing The Right Thing, 2019-06-27).
>> > > >
>> > > > I wonder whether that's intentional or accidental.
>
> This was an oversight of mine, my apologies. That line should go.

Good to see people finding glitches in topics that have graduated to
'master' not so long ago.  It would have been even nicer if we found
them while in 'next', but we are all human ;-)

> More precisely, manifest files are something specific to Windows, where
> you can embed metadata in an executable. Visual Studio auto-generated it
> under certain circumstances, but recent versions seem not to do that
> anymore.

I expect somebody who knows Windows .manifest better than I do to
come up with a one-liner patch with a single paragraph log message.
Or it can just be a part of a larger series that is the next batch
of Windows updates.

Thanks.
