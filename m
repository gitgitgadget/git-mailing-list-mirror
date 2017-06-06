Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 501E6209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 22:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751481AbdFFWGA (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 18:06:00 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35373 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751401AbdFFWF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 18:05:59 -0400
Received: by mail-lf0-f65.google.com with SMTP id v20so9655876lfa.2
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 15:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LkR8GLaDg7RMC0vrZyu73m4NBd/oGhTWUPf+7HNw7dU=;
        b=vShrjLyUqPFAR4bXnXM7F83myekcwHfRmLmw9wh6s5omkjMiwUI+/BRfpXoqfdnOUE
         avv1ibuEHgCK25syaT7hruKVYndIhHoApvZIyAyZMLrkLh6YOcS+GE57ytK2kEvDV9P0
         FhO45FnxoJL06Dv3+9ax7YQCdz2aSGoQNk+PaHxGmH+oFDCunvQdkS6rOPXdLZ3DUVZm
         P18BEHcRO6v42db/wAu/OCYN/zpYKJeGjbrkLTQ/7EOmQbV/m/3h6kfUbOr/TzhCdjtZ
         twGc0gLTBtjnWp5iI/O5uOVb9COCyd45SIxypFy31hQoIqbpFVcuaowXKotZcbwLQ9+r
         63eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LkR8GLaDg7RMC0vrZyu73m4NBd/oGhTWUPf+7HNw7dU=;
        b=KrA1+iogZvfpsb3sbgNYQqzKWj1kMY2m7SvGYvf35wlUSiR+91LaR/gT6n7Vs0qAzR
         XCYfPN/M8miof6gNFxC4p0iHtbK1oesdMs0NuSETzc0fLMxPPrVqlwPeL0e4jAaazmBb
         BYIApzu+QR0t5wsYzkGPU2eIDjMkBMdJpYvEePRRNMDh4t/b3lbE6D9rsbqanSFNP5tY
         GaCl9zVzOuzxdG2IWdexYlQfzM5nc5nQu3aUBpxtpcPXpr+0J0yhTEDS5U3jO2z3HX/N
         TgVJh4uBO0QeYt40NzUqXtL+aCADerBBYf0KKTEu0uptmNBP+9FRH7hx2s2GzB/AwO++
         aLfA==
X-Gm-Message-State: AODbwcBMRnaKngdxFQgYAzpXyIxLFsbx5h83oMrkx5JDQ7tbK22EJPHA
        r26IKnqC4teNB/3BC90rZFILSgIzvQ==
X-Received: by 10.25.99.21 with SMTP id x21mr5417176lfb.66.1496786758143; Tue,
 06 Jun 2017 15:05:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.79.17 with HTTP; Tue, 6 Jun 2017 15:05:37 -0700 (PDT)
In-Reply-To: <CAMy9T_H4WAh6kA3K4VVv7oUwL3KHcK-mM-4bXxC0D1FinRa8mA@mail.gmail.com>
References: <xmqq1sqzkrui.fsf@gitster.mtv.corp.google.com> <CAGZ79kY2Z-fJYxczbzheu1hChLkKkdjEcDMwsP-hkN0TjUBotQ@mail.gmail.com>
 <CAMy9T_H4WAh6kA3K4VVv7oUwL3KHcK-mM-4bXxC0D1FinRa8mA@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 6 Jun 2017 15:05:37 -0700
Message-ID: <CA+P7+xr2xrVfUPppCa4gCj72enX-_qZsAK3bNtOusfh7wWH0rg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2017, #03; Mon, 5)
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 6, 2017 at 2:50 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On Mon, Jun 5, 2017 at 8:23 PM, Stefan Beller <sbeller@google.com> wrote:
>>
>> > [...]
>> >  "git diff" has been taught to optionally paint new lines that are
>> >  the same as deleted lines elsewhere differently from genuinely new
>> >  lines.
>> >
>> >  Are we happy with these changes?
>
>
> I've been studiously ignoring this patch series due to lack of bandwidth.
>
>> [...]
>> Things to come, but not in this series as they are more advanced:
>>
>>     Discuss if a block/line needs a minimum requirement.
>>
>> When doing reviews with this series, a couple of lines such
>> as "\t\t}" were marked as a moved, which is not wrong as they
>> really occurred in the text with opposing sign.
>> But it was annoying as it drew my attention to just closing
>> braces, which IMO is not the point of code review.
>>
>> To solve this issue I had the idea of a "minimum requirement", e.g.
>> * at least 3 consecutive lines or
>> * at least one line with at least 3 non-ws characters or
>> * compute the entropy of a given moved block and if it is too low, do
>>   not mark it up.
>
> Shooting from the hip here...
>
> It seems obvious that for a line to be marked as moved, a minimum
> requirement is that
>
> 1. The line appears as both "+" and "-".
>
> That doesn't seem strong enough evidence though, and if that is the
> only criterion, I would expect a lot of boilerplate lines like "\t\t}"
> to be marked as moved. It seems like a lot of noise could be
> eliminated by *also* requiring that
>
> 2a. The line doesn't appear elsewhere in the file(s) concerned.
>
> Rule (2a) would probably get rid of most boilerplate lines without
> having to try to measure entropy.
>
> Maybe you are already using both criteria? I didn't see it in a quick
> perusal of the code.
>
> OTOH, it would be silly to refuse to mark lines like "\t\t}" as moved
> *only* because they appear elsewhere in the file(s). If you did so,
> you would have gaps of supposedly non-moved lines in the middle of
> moved blocks. This suggests marking as moved lines matching (1) and
> (2a) but also lines matching (1) and the following:
>
> 2b. The line is adjacent to to another line that is thought to have
> moved from the same old location to the same new location.
>
> Rule (2b) would be applied recursively, with the net effect being that
> any line satisfying (1) and (2a) is allowed to carry along any
> neighboring lines within the same "+"/"-" block even if they are not
> unique.
>
> Michael

This sounds reasonable to me, though I'm not sure how easy it is to implement.

Thanks,
Jake
