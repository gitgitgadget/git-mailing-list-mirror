Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E85EE1FD99
	for <e@80x24.org>; Sat, 20 Aug 2016 18:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753942AbcHTSDE (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Aug 2016 14:03:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62548 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753108AbcHTSDD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2016 14:03:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B900935905;
        Sat, 20 Aug 2016 14:03:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=hQmoTIRVdaGK
        F3oYtfjjY2iw/WQ=; b=SLRt8oikSntilHH9uCjtxGbkC1F0tfhhcapiShu5Kc8y
        VY6UhhZaSyTFuzvKSPh4mOGOXiBJHZUK/4htrz7fFxxzTHufCf6qrMeL1pr3NOqm
        mPgys4IBOPXUkFN+d+z5txdCsFcrf9o3IpurdU71hSq/H5ynjVex3lX60fOX1jc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=tqOI7A
        Yqb6Rb5GcNjcghPDfm6XQH/2iz9cT1jtlRmMTV/LJNiyOnJqjCqE8o/k+GKnkl6j
        DIh9Tle59exg3w9Mbqez/Y0d0bPAsLYE2YwH8RoK5t/FAFLZhBh5kDe9Kgq4HLhV
        MPV8FgxCgEd34TZ+iA7vcZcZifKE6196TY+HQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AFF6735903;
        Sat, 20 Aug 2016 14:03:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2946635901;
        Sat, 20 Aug 2016 14:03:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Marco Sousa <marcomsousa@gmail.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Nelson Martell <nelson6e65@gmail.com>,
        Brian Gesiak <modocache@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [L10N] Kickoff of translation for Git 2.10.0 round 1
References: <CANYiYbGL+GVRNuhszp1UShaN_oJgm3netsQxZfbW74pVK0gOYQ@mail.gmail.com>
        <9262712.D6TC1VHfMN@cayenne>
Date:   Sat, 20 Aug 2016 11:03:00 -0700
In-Reply-To: <9262712.D6TC1VHfMN@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
        "Sat, 20 Aug 2016 18:01:55 +0200")
Message-ID: <xmqqy43rxqqz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 56090E20-6700-11E6-A0B4-E86612518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:

> 1.  In config.c, the changes to the function die_bad_number tried to fl=
atten the=20
> translated strings (no message building logic). I think it went too far=
, and=20
> the reason of the failure can be factorized so that we don't have to=20
> retranslate each time. I might be wrong on this one, but I have no exam=
ple of=20
> language where we would need differentiated error reasons.

I do not have a strong opinion on this one.  I think it is an
attempt to avoid language-lego.

> 2.  in sequencer.c, there is a mistake in the original string to transl=
ate=20
> "Cannot revert during a another revert"

This should be corrected. Thanks for spotting.

> 3. git-rebase--interactive, in this_nth_commit_message and=20
> skip_nth_commit_message are not localizable,

As the "TRANSLATORS" comment alludes to, "This is the Nth thing" can
be rephrased to "This is the thing N" or "This is the thing #N"
easily, and if that form without ordinal is acceptable for many
languages, we should say that it is also OK in C-locale without
translation.  So I agree that the recent change was pointless (even
though the result may be localizable).

In an ideal world, I would imagine that this would be done by using
Q_("This is the first thing", "This is the thing #%d", nth) aka
ngettext, but

    (1) I haven't seen ngettext used from shell scripts; and

    (2) I do not think po files are set up to express "for this
        message, this language has 4 variants and here are the local
        rules to decide which one to use depending on the number,
        but the rules apply only to this message".  The Plural-Forms
        rule [*1*] seems to be global to a .po file, unfortunately.

so I do not think we cannot do it with ngettext().

[Reference]

*1* https://www.gnu.org/savannah-checkouts/gnu/gettext/manual/html_node/P=
lural-forms.html

