Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 511BA20954
	for <e@80x24.org>; Tue,  5 Dec 2017 00:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752025AbdLEAai (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 19:30:38 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52623 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751428AbdLEAah (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 19:30:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E5146A565A;
        Mon,  4 Dec 2017 19:30:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Cm/RJnF09FXBY+53gyST+DKfzgM=; b=gcgdmV
        Ku4KVoFmwajnp9fhY2oz0ESiJH4fBfL+zPLqKTcIfmrkpX11L6OGz4elACOKnFi1
        EzJCVu7W9sbADfkcXjZ2TpCabDEH4FpU3Lleo71utSmG6aehFMFF52GwO6kvoO4v
        O84q5Erd21cwmlAaSZ6gtfVnFV/gh57HZtfi0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=w8nCtERdpp/w/D8XsmDbSd4xkiQzQ9/e
        43RiPHiXusIasqkn1E/gz3mY4C58R+0lxkuKc0zQdLjOd7tr16BZ3tvGAEQGxWik
        C1HBU8tJk9+ldn7Va38Zi9wwda3UF1CzrEvdGilsjwLt8cof80e05zsoKoqoVNWs
        tQauH4LmmX0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB5C3A5659;
        Mon,  4 Dec 2017 19:30:36 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 55AB1A5657;
        Mon,  4 Dec 2017 19:30:36 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: What's cooking in git.git (Dec 2017, #01; Mon, 4)
References: <xmqqmv2ykvy4.fsf@gitster.mtv.corp.google.com>
        <20171204154607.2e29acc6eb269ce4c96ee9a2@google.com>
Date:   Mon, 04 Dec 2017 16:30:35 -0800
In-Reply-To: <20171204154607.2e29acc6eb269ce4c96ee9a2@google.com> (Jonathan
        Tan's message of "Mon, 4 Dec 2017 15:46:07 -0800")
Message-ID: <xmqq8teikod0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8322747A-D953-11E7-BD7C-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> On Mon, 04 Dec 2017 13:46:43 -0800
> Junio C Hamano <gitster@pobox.com> wrote:
>
>> * jt/diff-anchored-patience (2017-11-28) 1 commit
>>  - diff: support anchoring line(s)
>> 
>>  "git diff" learned a variant of the "--patience" algorithm, to
>>  which the user can specify which 'unique' line to be used as
>>  anchoring points.
>
> Is there anything I can do to progress this?

I had an impression that there weren't any major outstanding issues.
Such topics will move at their own pace and the only thing somebody
could do to expedite is to somehow block other topics in flight so
that we have to worry about smaller number of topics ;-)

