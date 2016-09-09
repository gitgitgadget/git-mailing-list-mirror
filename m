Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9610207DF
	for <e@80x24.org>; Fri,  9 Sep 2016 23:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755195AbcIIXHC (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 19:07:02 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:35848 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755069AbcIIXHB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 19:07:01 -0400
Received: by mail-qk0-f171.google.com with SMTP id z190so82882578qkc.3
        for <git@vger.kernel.org>; Fri, 09 Sep 2016 16:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jUnBmn/4cYUvChyK/uVVZuxvbXrqHkvaaQYJT2u/8vQ=;
        b=JdQm2doeyDeiQe0sTpganjL9vF6tT6hxotPKBtsh4l2bzvomzu3NXzvMBuZyWgVvhy
         25LItEb3rsJZULgntjoNXa7A8UAzDndsjyap1fRk+aTiiB70r7HOQ+J0VRWGT88tF2Pm
         AWBh50a2bOrWrYn9opz2FGG6BnKQLq4Wdm4Hq3umVk3VH7rfA3JDhxleMHsPwzIIOto5
         gQfykOrwfU8C499CoFbflRe0vG9KCyl3sptaSzMuNSFnuQ6PgWYIFqdrjOKMRG2emBJf
         GNauErLo+gAwshqYWIxxDl7wdFcH2I5hYzkRFF3oxW6Pab6ZiwgLOjplXp/DXcF0kBeK
         HlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jUnBmn/4cYUvChyK/uVVZuxvbXrqHkvaaQYJT2u/8vQ=;
        b=GPHX2UyKdrcTL73fudmZH/M+vz7EOLs5jysl5gBLx450HiSQk9WYOrzj4Fa3Lm+Z5d
         XsU98hBtI6bWHIeyCTqqXf7GKbWB6PLegJKVNH8ZRTk5mHiJXXP1fERzAZDVusYmJeJV
         TSVx0CHGHbb0DcM2Wwr4At057+8RvA6nF2uDNWstu/Dz5yZff9llUTPd2ObOLUjH5gDo
         XAiATBLtp/NZr3HEyeOsuZZgwp9Ii7+7Nt3ysVVGuc5dOCzRXFTWmc40VvbtOI182Qqk
         WhVFhBVDLMFQwo2TwZfyxBxnH+ztAp43h6XFvMSWBjYjo4apDuEvDo0otH92Ip+fDKyB
         Fi7A==
X-Gm-Message-State: AE9vXwOqifJBCTLdIKQChVsWBi9S4JI/G4lbmY1jGiN66LjJVu10m5PdRDQZgW9A1lakRoE1B1n6ahco0MC6AA==
X-Received: by 10.55.18.1 with SMTP id c1mr7509008qkh.27.1473462421027; Fri,
 09 Sep 2016 16:07:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.49.227 with HTTP; Fri, 9 Sep 2016 16:07:00 -0700 (PDT)
In-Reply-To: <xmqqwpik8zy3.fsf@gitster.mtv.corp.google.com>
References: <CAKmQUfa_U-g6vC+SjbQSicEUwO+WofNfzezEEwikeOAeL31W5g@mail.gmail.com>
 <b71adc54-2ae6-ef8e-1dca-0883cd617e6e@web.de> <CAKmQUfbemaid61xPyvNheLM2jVGXGjiyF_x=NZnxkZ=5wccQ=Q@mail.gmail.com>
 <e17a88cd-2de7-dc84-2262-743e82d8b047@gmail.com> <CAKmQUfafCP6ZwUm7Ec5n2PzvNzBHnFWEJL1usMTFB6Ef0m=8pw@mail.gmail.com>
 <xmqqwpik8zy3.fsf@gitster.mtv.corp.google.com>
From:   john smith <wempwer@gmail.com>
Date:   Sat, 10 Sep 2016 01:07:00 +0200
Message-ID: <CAKmQUfYCUq=kUTau1-3NjjPVBk6WkP3KdTjgMC8sZtU8h=H4iQ@mail.gmail.com>
Subject: Re: How to simulate a real checkout to test a new smudge filter?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/10/16, Junio C Hamano <gitster@pobox.com> wrote:
> The clean and smudge operations should look _only_ at the contents
> they are filtering, and nothing else, and the clean/smudge filtering
> mechanism is designed to support that use case.  It is not designed
> to do things like embedding the name of the branch that is being
> checked out into the result.

Ok, I think I get it. It was actually my original problem with smudge
filters because I wanted them to be run after *every* checkout even if
file contents stayed the same (hence the subject).

Now Jakub suggested post-checkout hook in conjunction with only clean
filter for my problem of managing dotfiles but I think I don't fully
get it.  The problem is that in the scenario presented in my last
e-mail clean filter is run in the situation which doesn't like a
checkin to me.  Is `git checkout <PATH>' doing a *checkin*" under the
hood so that the clean filter is called?  What does actually `checkin'
mean in Git?  I thought that checkin it's the same as committing a
file into the repository.

-- 
<wempwer@gmail.com>
