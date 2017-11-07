Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07940202A0
	for <e@80x24.org>; Tue,  7 Nov 2017 17:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758500AbdKGR1p (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 12:27:45 -0500
Received: from mail-qt0-f174.google.com ([209.85.216.174]:45446 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758386AbdKGR1o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 12:27:44 -0500
Received: by mail-qt0-f174.google.com with SMTP id p1so16202611qtg.2
        for <git@vger.kernel.org>; Tue, 07 Nov 2017 09:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=m7XEEcMqqwb4kwPU4OHPvI4OaYEURLqKeuKiwyELPfg=;
        b=exuJzHpJA/uL9QqXgcg0lCzzw4HhGAtCJPASbeMyCT2/RHxsUooArl6fkSyg9B3IDq
         Z2ZUYDeCijTaP5a5/AjxaJDMZAK3RAY3ax0+A7utDOmOMKl8qb8yB7lAfwfnr31sH+96
         jV7BSh7MqmaL0EIY/dlC+3yerpb4cQ/eYKKhiD8mv6SRsWdPd0iOwRxK+j/Ic5yeanp1
         sS7UO3wQtEXM/J7BCFv2XloJDvHZusnV0bbF3s5c2NoUPH/eEvigRa8uWOcfspigrWeT
         Na1ocxvy534dpTTqFvzIj9n8p16Fh+QcaWy16d6eZM4ClAXtk4ECNjkc5EhZU3KPJ+dh
         HALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=m7XEEcMqqwb4kwPU4OHPvI4OaYEURLqKeuKiwyELPfg=;
        b=EU75/iMQNhbspHhowkYyvu3n6iu0Rq3mR9YCizE253HLQhpd8u7fqlug+3pifvvDsD
         nq7jNCdsp2kb62nGQORWsTgVdPMw0snEQ6qgKzzJ7UzjeKD+9VwWkaonjd/HXiDawr92
         b6ch+77nYlZcnBcY6iS7RXDBYsa0+d532TkbgEwaeAJAqel+Zex7ZuRptHPAlFkniayv
         NZHsOjEe00hp20GOfsTWUuhpLOYMr+126f8TQ6icV/gXnW/Z14Kk0vwUthxaH9LhyMcM
         Le3otBy8+mAzDZKIfuv8A/i0ugPwkvRxDcATLAdG3FFlbu5OY8AcgPUShdP5EjoDITTJ
         e5Pg==
X-Gm-Message-State: AJaThX740hHYqFcSro5Dv//wtBp849qs8l1UoJkmGK+83x9zfpqigp59
        p+l5m5okqA05pfovC2T0TqwyNUVdAah/Jty7Zz/hcubo
X-Google-Smtp-Source: ABhQp+TL+bs1NI+/p47Clr5tNtaGezV4SE6VUX+DyLbMao8DPYpS66PN+GErElCipqA+hqcnELOyHa9cyt6Y6YBLsv0=
X-Received: by 10.237.34.201 with SMTP id q9mr29273609qtc.198.1510075663755;
 Tue, 07 Nov 2017 09:27:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Tue, 7 Nov 2017 09:27:43 -0800 (PST)
In-Reply-To: <xmqq8tfihn3a.fsf@gitster.mtv.corp.google.com>
References: <20171106235021.113358-1-jonathantanmy@google.com> <xmqq8tfihn3a.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 7 Nov 2017 09:27:43 -0800
Message-ID: <CAGZ79kZ3yaKGh2g2QosdzDigi4uXsuRs_v2imL8kPEo8a+qeXg@mail.gmail.com>
Subject: Re: [PATCH] Tests: document test_submodule_{,forced_}switch()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 6, 2017 at 5:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> Factor out the commonalities from test_submodule_switch() and
>> test_submodule_forced_switch() in lib-submodule-update.sh, and document
>> their usage.
>>
>> This also makes explicit (through the KNOWN_FAILURE_FORCED_SWITCH_TESTS
>> variable) the fact that, currently, all functionality tested using
>> test_submodule_forced_switch() do not correctly handle the situation in
>> which a submodule is replaced with an ordinary directory.
>>
>> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
>> ---
>> I find tests that use lib-submodule-update.sh difficult to understand
>> due to the lack of clarity of what test_submodule_switch() and others do
>> with their argument - I hope this will make things easier for future
>> readers.
>> ---
>>  t/lib-submodule-update.sh | 250 +++++++++-------------------------------------
>>  1 file changed, 46 insertions(+), 204 deletions(-)
>
> I suspect that the benefit of this is a lot larger than "document" a
> test helper function or two ;-)  "document & clean-up", perhaps?

It is.

>
> I didn't compare the before-and-after with fine toothed comb, but
> a cursory look didn't find anything glaringly questionable other
> than the above.
>

I have reviewed the patch and thinks it withstands the test of a fine comb.
