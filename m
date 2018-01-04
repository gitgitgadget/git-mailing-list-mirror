Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46EB01F404
	for <e@80x24.org>; Thu,  4 Jan 2018 19:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752758AbeADTAX (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 14:00:23 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60953 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752215AbeADTAV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 14:00:21 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A8C0CCAA0A;
        Thu,  4 Jan 2018 14:00:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1yWw0cH6Sc4U9NgChWELSzr6BSI=; b=imy6Bm
        YtBsCbPlPm7p+fmUqtKQoWJCNZCIZE0VT4QPYqF5JdDGim+xUKdjNLOsQLBmbjj/
        X85rtrOOZfiUdFfwTtXutF1bmDkVtjCxcgqHWDeeXwJf5n7MYs+RnOu48W2t04Sx
        0AEdBHLL+AlqY3Ilf6xqFP05vKoGOE9eixbRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UxYHRks9IcIdB1KK+c0DfJx9QFxlzhmm
        +I4l7zTSJQm/kwIcnIzlZsJwMQwwA/JKESAK1Fg3iT30u2R+WzlhMHNw3c9ctOi8
        lyMDh2zWEDoqot2GiyFpPnN56d8GWk4ZyfXnlTg3L9Bd9p7kxQ6HkuP08OQRL60U
        8Z2nREAFuBY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A0102CAA09;
        Thu,  4 Jan 2018 14:00:20 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 11F7ECAA08;
        Thu,  4 Jan 2018 14:00:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc/SubmittingPatches: improve text formatting
References: <20180102153350.11723-1-tmz@pobox.com>
        <20180103235625.GB817655@genre.crustytoothpaste.net>
Date:   Thu, 04 Jan 2018 11:00:18 -0800
In-Reply-To: <20180103235625.GB817655@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Wed, 3 Jan 2018 23:56:26 +0000")
Message-ID: <xmqqa7xtfnzx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 82848FBC-F181-11E7-9A5E-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Tue, Jan 02, 2018 at 10:33:50AM -0500, Todd Zullinger wrote:
>> 049e64aa50 ("Documentation: convert SubmittingPatches to AsciiDoc",
>> 2017-11-12) changed the `git blame` and `git shortlog` examples given in
>> the section on sending your patches.
>> 
>> In order to italicize the `$path` argument the commands are enclosed in
>> plus characters as opposed to backticks.  The difference between the
>> quoting methods is that backtick enclosed text is not subject to further
>> expansion.  This formatting makes reading SubmittingPatches in a git
>> clone a little more difficult.  In addition to the underscores around
>> `$path` the `--` chars in `git shortlog --no-merges` must be replaced
>> with `{litdd}`.
>> 
>> Use backticks to quote these commands.  The italicized `$path` is lost
>> from the html version but the commands can be read (and copied) more
>> easily by users reading the text version.  These readers are more likely
>> to use the commands while submitting patches.  Make it easier for them.
>
> I think this change is fine.  I don't have a strong opinion either way
> and if others think the change makes the plain text more readable, I'm
> all for it.

I too would prefer to move towards plain text that reads easier,
especially if it does not make the resulting typeset version
unreadable; thanks, both.
