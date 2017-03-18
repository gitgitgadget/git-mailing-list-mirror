Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86C1B2095B
	for <e@80x24.org>; Sat, 18 Mar 2017 20:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751115AbdCRUIF (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 16:08:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64416 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751023AbdCRUIE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 16:08:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4626A88943;
        Sat, 18 Mar 2017 16:08:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=t6G8+wMVd3Ys
        Y+A41ddx9SQJSwQ=; b=sF2/EslVHTMSQaK2mmKoF7/DvyhrX/3u90xagPdR8CYT
        FD2+O7s6qfSfy/KOFK9bWuEof+UvkflRGHYA5qRe45oE4SyLRjkCNICk4Ph8QolO
        JASiETn5WnqeBcVDHYDYzfCHC8VmVmsuYEOX9WPpq4RnM+XS1SnjaXZow58/ydw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=m9hGdU
        DjJmqD7PXvcadMDErjAAvmA2HNlSueJbMRtWBODRoDWlnUoxJl7Aiat3dXDgb6eU
        QkJM3yUXaqj/6rUdqKxOBNfnzEoVdLV0n2hQA2fZP7uhWBbmO+rsTSFydyQ3iJj/
        MwCbtPt3Z+p/8Rl/IumDCIlCzMJ8zJuh1PjgA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 089F388940;
        Sat, 18 Mar 2017 16:08:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E17268893E;
        Sat, 18 Mar 2017 16:08:00 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] doc/SubmittingPatches: clarify the casing convention for "area: change..."
References: <20170318184203.16890-1-avarab@gmail.com>
        <xmqqvar6310x.fsf@gitster.mtv.corp.google.com>
        <20170318184203.16890-2-avarab@gmail.com>
        <xmqq7f3m2yph.fsf@gitster.mtv.corp.google.com>
        <CACBZZX4+HRnb1SV_URqJyxyaeBJ40p_hh_kGEoRj089xJGARHQ@mail.gmail.com>
Date:   Sat, 18 Mar 2017 13:07:59 -0700
In-Reply-To: <CACBZZX4+HRnb1SV_URqJyxyaeBJ40p_hh_kGEoRj089xJGARHQ@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 18 Mar
 2017 20:16:40
        +0100")
Message-ID: <xmqqbmsy1h7k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9659DEA8-0C16-11E7-8FE8-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> ...it makes this subsequent example more succinct and clear, because
> e.g. "githooks.txt" is shorter than "git-cherry-pick.txt", and
> "clarify" is obviously a normal looking word...

Ah, that makes sense.  Thanks.

