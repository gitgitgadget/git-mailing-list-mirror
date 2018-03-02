Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BEF11F404
	for <e@80x24.org>; Fri,  2 Mar 2018 16:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936537AbeCBQdD (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 11:33:03 -0500
Received: from mail-ua0-f169.google.com ([209.85.217.169]:40842 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932746AbeCBQdB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 11:33:01 -0500
Received: by mail-ua0-f169.google.com with SMTP id c14so6402967uak.7
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 08:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6MDxvt8l5VFV7JmIBKFJaZFaymZuSXI+USbXreZ+MZk=;
        b=oviBjCkYM3At2SA+0KwrXF1nw5pJN98j3QZWJifkXKaHoXGd1DXlJIU2MHCInTCVSK
         FX5JT86wF31iv342XSdRRl0GEUKm1xYv+wcn6OUlf/+Y8H8v9HHEJrSkq5/iO6my+4f3
         RoEM4BmwMt9hShzZJ5divhqhP6XvOo0kVYaoJq8bSB6cGpM3xWmxK9S16Yx8Kw0uCK4h
         MBZpDFl769CgjkThaOJrUqar+ne6ieBhmIi2lfAtdBzAwXqU3Ns4oLlHOrRo9W3modRn
         aZBZ5imbJZef0PvZL4zsL5q5dQKf8NlyovDibKosXCsISbzptoC6Oaq1ov8UGy6b9E2y
         xkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6MDxvt8l5VFV7JmIBKFJaZFaymZuSXI+USbXreZ+MZk=;
        b=DGZqgRzMpnJWoCp5HanUaxHlG8G/dR/UQoXV2ka+8ZOBAo1j1xsckg87qkHRzJYwDZ
         Mq1jEqXwucXCKWdGaMXaKMWHd7wUUYku75/pDjwhiLwK6fzLkE6DafZQ//VimLIuT4hq
         2tGBS2CKQicWCv1HRMkbe2UtdGF+hnSR+mUHUmTadBCET6ZmSxHDgz5WtsHU3NsnqCPR
         fCKETXkqVEJe7K0VHX4pmk9hoMvinANBhw/XlEMzwPIxNAqZFETGFKaYAbNTIXcZde9l
         u/yL/qyt54DXGjlHDOg6QzW32UcWSl1Ndw/CdV5cGl0odl+q3ZRC/2xULhjDovuAGr1T
         Y0Ww==
X-Gm-Message-State: APf1xPAlkFTCf9/UCu/+JTZBKEmKeBJr24EWCD7Rfu/xO7D6hJhVCBSr
        bXkVyCaHf6ZK1sW0WWn2C+QZuHqw+IHQWjqxzKs=
X-Google-Smtp-Source: AG47ELuyBo6q1tFnfh7+h86kCFFDs7hsDGbRa4RYGPixfEAKQAKWlbcJrk527NXYovPIj9o0/V5AfytyjClkYnMg53g=
X-Received: by 10.159.59.229 with SMTP id y37mr4577351uah.48.1520008381240;
 Fri, 02 Mar 2018 08:33:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.59.233 with HTTP; Fri, 2 Mar 2018 08:33:00 -0800 (PST)
In-Reply-To: <xmqqpo4ne8ud.fsf@gitster-ct.c.googlers.com>
References: <xmqqpo4ne8ud.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 2 Mar 2018 17:33:00 +0100
Message-ID: <CAM0VKjmRT-vdyxsXTk1FB4BMLc8z6968kapqyqx5djKof5hQFg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2018, #01; Thu, 1)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 1, 2018 at 11:20 PM, Junio C Hamano <gitster@pobox.com> wrote:

> * sg/travis-build-during-script-phase (2018-01-08) 1 commit
>  - travis-ci: build Git during the 'script' phase
>
>  Stalled for too long without any response; will discard.

I still think this is a good change as-is and it does make checking the
results of Travis CI builds easier.  The issue Lars raised in [1] is in
my opinion a non-issue [2] in practice and Lars hasn't yet disagreed
with that.

Not sure what else I could say what's no already in the commit message
or in my response in [2].


[1] - https://public-inbox.org/git/5DE3FA05-2347-4BE7-8A1A-A6E5FEEC7C2B@gmail.com/

[2] - https://public-inbox.org/git/CAM0VKjnSzoc+E408ifKCg+qPTaGRNL3e3JVdRN573kdcBSzbHw@mail.gmail.com/
