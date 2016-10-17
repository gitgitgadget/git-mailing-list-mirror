Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A68531F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 16:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754723AbcJQQzb (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 12:55:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55079 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1030377AbcJQQyS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 12:54:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6161C4624E;
        Mon, 17 Oct 2016 12:54:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7rkY0V1RYUn6
        A+C5PJCPQYyWUEI=; b=HRsvJs7+uHLiXsboLVcgZOrta2XjQHFJmQsPPxcrKdBw
        vP/YCieXKvaEAWlejev5ln34qJ47FTyAw/a0BsdENK0i4sscRXKdZvB/HLpp+rI8
        p5d9sNVckqZENIO/+UFz/5tPpPD283lBPLuEHBxxW27gU/nwDNLEgX0UxCrFsD8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=VloXxW
        /VaXQhJabSVWLWH56tkcvjkm7dqNRIajXPn6xK6WDnUJSAnF5/nPCsP7BZAuWDlW
        RaxpDOb/I6pKiEsiFwSr0IgrmIHQVMEy3T0YNYf9LUImlA19Acc26lXYrmenyrwO
        m646NHTR358n2QkTNhYnyO3XWsxEjwrmES3po=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 586224624D;
        Mon, 17 Oct 2016 12:54:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BE42F4624C;
        Mon, 17 Oct 2016 12:54:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] gitweb: Link to 7-char+ SHA1s, not only 8-char+
References: <20161006091135.29590-1-avarab@gmail.com>
        <20161006091135.29590-3-avarab@gmail.com>
        <3fa9902f-3b01-5ec6-8129-34cff4c7cac9@gmail.com>
        <xmqq37jyzsdk.fsf@gitster.mtv.corp.google.com>
        <CACBZZX4FK+zrVyBTpbJAbSAxQ9LuCTXcExeEqZE6D3nwHbNxZA@mail.gmail.com>
Date:   Mon, 17 Oct 2016 09:54:08 -0700
In-Reply-To: <CACBZZX4FK+zrVyBTpbJAbSAxQ9LuCTXcExeEqZE6D3nwHbNxZA@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 15 Oct
 2016 10:11:30
        +0200")
Message-ID: <xmqqbmyiykzz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5374C386-948A-11E6-A3AD-987C12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> As far as I can tell the only outstanding "change this" is your
> s/SHA1/SHA-1/ in <xmqq37k9jm86.fsf@gitster.mtv.corp.google.com>, do
> you want to fix that up or should I submit another series?

I think I did that already myself while queuing.  Could you fetch
what I queued on 'pu' to double check?

I think the diff between what was posted and what is queued (I just
checked) looks like this:

-gitweb: Link to 7-char+ SHA1s, not only 8-char+
+gitweb: link to 7-char+ SHA-1s, not only 8-char+

 Change the minimum length of an abbreviated object identifier in the
 commit message gitweb tries to turn into link from 8 hexchars to 7.
=20
@@ -5,16 +12,18 @@
 SHA-1 in commit log message links to "object" view", 2006-12-10), but
 the default abbreviation length is 7, and has been for a long time.
=20
-It's still possible to reference SHA1s down to 4 characters in length,
+It's still possible to reference SHA-1s down to 4 characters in length,
 see v1.7.4-1-gdce9648's MINIMUM_ABBREV, but I can't see how to make
 git actually produce that, so I doubt anyone is putting that into log
-messages in practice, but people definitely do put 7 character SHA1s
+messages in practice, but people definitely do put 7 character SHA-1s
 into log messages.
=20
 I think it's fairly dubious to link to things matching [0-9a-fA-F]
 here as opposed to just [0-9a-f], that dates back to the initial
 version of gitweb from 161332a ("first working version",
-2005-08-07). Git will accept all-caps SHA1s, but didn't ever produce
+2005-08-07). Git will accept all-caps SHA-1s, but didn't ever produce
 them as far as I can tell.
=20
 Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
+Acked-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
+Signed-off-by: Junio C Hamano <gitster@pobox.com>
