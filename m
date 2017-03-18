Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC5212095B
	for <e@80x24.org>; Sat, 18 Mar 2017 19:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751612AbdCRTRR (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 15:17:17 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:35758 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751748AbdCRTRQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 15:17:16 -0400
Received: by mail-it0-f44.google.com with SMTP id m27so53325268iti.0
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 12:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+ZN4pfSbhevPg4edTMQfDeq/TPUyoy2HbphLKLaVrBI=;
        b=vZEI8u3330csqkNkhlT15wJJcA9skqJpasfq0lVfoZY8m8y868Y2yXI3KREWZUXSuK
         8GPwQAYrAijqxNaRupQ6DdXTyG9GGg+r7lmYUifl72VNHzuoSEGc/7ONFMF3EZQqvFyb
         sKDQyT8ANrbcFWVnB8I6m3o0pv+INapV+NcRZ71BpFVn8fR08t3XEU8LKVbKyQKwnxdV
         v+7xMqpBSknLHvWhrPBCdcvSgOmNVZtObujsWJTuNg5gtjETM0769SWuoR5wfu/+3ts3
         NhSe0xyysLX1N7KxXfoge2GNTeHbpD40soxIO3DTES2GcmW1uYoRp4UHWMatslychZD9
         NwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+ZN4pfSbhevPg4edTMQfDeq/TPUyoy2HbphLKLaVrBI=;
        b=Ui1OtHanczjcBNLCgfQZD981QYN+ifgmzi3fwBfu/VunyQOj5NiV+28k+kuW95td+A
         jTTiY8XKUKrcPkosRr6Cp4kJX4cWWdMSW9W3o6dHH8j4trAkvEVp8/wCg8+G29ojK9kG
         7tNFNJ54Cz1uawm674pjfXLqDe+nksEMguWJo/HyPZ0eVcEL+Jy3nBKj5vAKiHGvvFic
         GFFmLcr1aZoIuVcr7vpRBR9i3xJo0KphlpSN0BR0E8Nm3VhKbQZc44rjVzyZoKsfiXvC
         2QG2UgGOlEPvEVIh5/W8ulLjQFANh4I0tGkqQanynKEh+5+BDFZCdg2c9LGIDWZ/6YlZ
         3VzA==
X-Gm-Message-State: AFeK/H1gH3qDrPWCNLP6553KkUFcbp12zeOPvtpH4kP/eSN3wJ1HnIbKF0zyY8d9UTzY3HrdmPR9sCFER5E0AA==
X-Received: by 10.36.116.71 with SMTP id o68mr4264021itc.60.1489864620879;
 Sat, 18 Mar 2017 12:17:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sat, 18 Mar 2017 12:16:40 -0700 (PDT)
In-Reply-To: <xmqq7f3m2yph.fsf@gitster.mtv.corp.google.com>
References: <20170318184203.16890-1-avarab@gmail.com> <xmqqvar6310x.fsf@gitster.mtv.corp.google.com>
 <20170318184203.16890-2-avarab@gmail.com> <xmqq7f3m2yph.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 18 Mar 2017 20:16:40 +0100
Message-ID: <CACBZZX4+HRnb1SV_URqJyxyaeBJ40p_hh_kGEoRj089xJGARHQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] doc/SubmittingPatches: clarify the casing convention
 for "area: change..."
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 18, 2017 at 8:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>>  prefix the first line with "area: " where the area is a filename or
>>  identifier for the general area of the code being modified, e.g.
>>
>> -  . archive: ustar header checksum is computed unsigned
>> -  . git-cherry-pick.txt: clarify the use of revision range notation
>> +  . doc: clarify distinction between sign-off and pgp-signing
>> +  . githooks.txt: improve the intro section
>
> Sorry, but I fail to spot why this is an improvement (it is not
> making things worse, either).

Because...

>>  If in doubt which identifier to use, run "git log --no-merges" on the
>>  files you are modifying to see the current conventions.
>>
>> +It's customary to start the remainder of the first line after "area: "
>> +with a lower-case letter. E.g. "doc: clarify...", not "doc:
>> +Clarify...", or "githooks.txt: improve...", not "githooks.txt:
>> +Improve...".

...it makes this subsequent example more succinct and clear, because
e.g. "githooks.txt" is shorter than "git-cherry-pick.txt", and
"clarify" is obviously a normal looking word which you'd expect to be
capitalized after a full stop, but it might take a couple of readings
to understand that "unstar" without a hyphen isn't some jargon.
