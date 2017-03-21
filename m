Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0FEB2095E
	for <e@80x24.org>; Tue, 21 Mar 2017 20:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932478AbdCUUSQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 16:18:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55402 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756464AbdCUUSP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 16:18:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 10F136FFF7;
        Tue, 21 Mar 2017 16:13:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=sIF8V1Wn5Weq
        Lt+qOe3QyblT37w=; b=bQNfrtB0tBAbFrRti/WinlDYyXfLoVPAhoj49PcXCzm0
        g9d7n/t2eimHW3xGV6pVYuAKeQwzQRICAHw/BoWiegCqMPF/L8NN5KZw191gVMEh
        mWYGCySZEOavteNxDYBWbzMCpudszmfRBFjfJ0ka3AzbHdG7GSzMT4hFMsqPot4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=uAXWyt
        7GAUODqQV8VLPvn0+iFJyik7c1vjg/yJE7fcWWHH+I90zMQG3idl8o0mRXXhO9/1
        rwvEMVAzsTp2lsO6tNwwKzUPLTS5Gs7EPvwtxYDc73G01mHTpsFwcGmVYSa5FWMs
        D0YoWUlFTaZVrb9VtwDxYwfZ0B9b4wAD5JnQ0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 08DE46FFF6;
        Tue, 21 Mar 2017 16:13:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6FA916FFF4;
        Tue, 21 Mar 2017 16:13:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] doc/SubmittingPatches: show how to get a CLI commit summary
References: <20170321155153.20753-1-szeder.dev@gmail.com>
        <xmqqvar2qzof.fsf@gitster.mtv.corp.google.com>
        <CAM0VKjmZS-mTdtBb1BDhixzWMou7h7VZSo3hpj5pk_C6i_MBnA@mail.gmail.com>
Date:   Tue, 21 Mar 2017 13:13:04 -0700
In-Reply-To: <CAM0VKjmZS-mTdtBb1BDhixzWMou7h7VZSo3hpj5pk_C6i_MBnA@mail.gmail.com>
        ("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Tue, 21 Mar 2017 21:01:39
 +0100")
Message-ID: <xmqqlgryo0bz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CB1AF57E-0E72-11E7-87E8-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>> That depends on what you use it for.  I most often use mine to
>> insert the reference that flows in a sentence, not as a separate
>> displayed material, e.g.
>>
>>     1f6b1afe ("Git 2.12.1", 2017-03-20)
>>
>> so for that purpose, not adding a trailing newline is a feature.
>
> Perhaps we are running it differently.
>
> I use its output that way, too, usually running the command in a
> terminal and copy-pasting its output into an editor.

I do \C-u\M-!git one<ENTER> from Emacs in the middle of typing a
sentence (where "git one" is aliased to that --format thing), and
for this I obviously do not want the terminating newline.

Of course --pretty=3Dformat:... has the opposite effect and in a
terminal to make it easier to cut&paste you do want to have its
output separated from the prompt string.

So as I said, "That depends on what you use it for."

As this is a mere example, we should just shoot for brevity instead?
Both "--pretty=3Dformat:" and "--pretty=3Dtformat:" are much longer than
"--format=3D", so we can just mention

    git show --date=3Dshort -s --format=3D'%h ("%s", %ad)'

and let the users to customize it for their needs?
