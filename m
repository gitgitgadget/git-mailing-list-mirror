Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0DBB1F404
	for <e@80x24.org>; Wed, 27 Dec 2017 13:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751115AbdL0NgD (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 08:36:03 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:42015 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbdL0NgC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 08:36:02 -0500
Received: by mail-lf0-f67.google.com with SMTP id e27so7545736lfb.9
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 05:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UMAfB6dZzgCWdYELua0+QO7ssT6hiPezN8ZdFvk9fgs=;
        b=NdkiO//+m4NgyBADQB9/L6xZU2+EGY8C/AxlD5OcYMNayp/7BnO5rcD5Zp5z84qBmZ
         smGA5M4kK5JrP8zT6Wj4YJV4ZwdoLDAJv2cjtLc/nbsvzgIX3atT0zh/k+iTiZU5yrzH
         x2XCUvYa93NZ3gYclj3C65hca3axt1oHxPfRZYQxeNakimuQM8izn27G4SnbRG+L8djc
         h7EZoobVsmy8h8w5+t2UNkyf8IOJxqO9N/xL/ZIn2kN7xgqE9JkSgfv9cigiIaN5tsKo
         4oD3DrqNKhv2IiyOzqiMBNn8BkH3NqDebFcHoua79FVfOxPs1J/mL/7Pco59ho3V6+us
         zKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UMAfB6dZzgCWdYELua0+QO7ssT6hiPezN8ZdFvk9fgs=;
        b=dPwhuZaAl05gha//DtNwT4HIbAcA2NT9cOpCU+AGVzgKmKIc3+E0c7iyvIvqLLEH24
         0QK1QhX4nDkY4BjgskBmTHT18gG7Z8oRQOUuz2Pf5NgkVtsWl0UdZJNeFZpCRCAj4sTE
         kI76syxgyC4vsH5OLSr5K5SKRsdMv+jDQawEah2byYymZIvCmaQwVZfQgSvK3NzIcqEM
         rOlldpwzoFJScEI4ebd5TUFqOcAoOiBVOrNJGQ1bsnqozDSRErWhk/HibITdp6SVvHxu
         EW02fShkDxGw7TQF7CJZQ+KVEZ5BE+/CEJrRulHujjUMhXz7PFOuTrSlRm91PiGh2JZO
         XksA==
X-Gm-Message-State: AKGB3mJT9OF+MElZn2z/GkuPd7qW59wgcSm4OKZp4U3BiXOOcZKFemNc
        nS5pPVPPRMXCxTof2onLJ/UyUswm
X-Google-Smtp-Source: ACJfBotZCUJDL4f7/VGtVnN7fJxngBQnRcarPEos1jzQrB5TZJNbXcHNmkosL+A9tbwGMKYAZvupCA==
X-Received: by 10.46.15.25 with SMTP id 25mr16516171ljp.119.1514381761229;
        Wed, 27 Dec 2017 05:36:01 -0800 (PST)
Received: from [192.168.0.102] ([46.98.30.228])
        by smtp.gmail.com with ESMTPSA id s65sm1845762lfi.76.2017.12.27.05.35.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Dec 2017 05:36:00 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Bring together merge and rebase
From:   Alexei Lozovsky <a.lozovsky@gmail.com>
In-Reply-To: <20171227043544.GB26579@Carl-MBP.ecbaldwin.net>
Date:   Wed, 27 Dec 2017 15:35:58 +0200
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Git Mailing List <git@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <C82A30ED-D608-4F79-B824-C23DDB078DD9@gmail.com>
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com>
 <20171225035215.GC1257@thunk.org>
 <20171227043544.GB26579@Carl-MBP.ecbaldwin.net>
To:     Carl Baldwin <carl@ecbaldwin.net>
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Dec 27, 2017, at 06:35, Carl Baldwin <carl@ecbaldwin.net> wrote:
> 
> On Sun, Dec 24, 2017 at 10:52:15PM -0500, Theodore Ts'o wrote:
>> 
>> My experience, from seeing these much more complex use cases ---
>> starting with something as simple as the Linux Kernel Stable Kernel
>> Series, and extending to something much more complex such as the
>> workflow that is used to support a Google Kernel Rebase, is that using
>> just a simple extra "Replaces" pointer in the commit header is not
>> nearly expressive enough.  And, if you make it a core part of the
>> commit data structure, there are all sorts of compatibility headaches
>> with older versions of git that wouldn't know about it.  And if it
> 
> The more I think about this, the less I worry. Be sure that you're using 
> 
>> then turns out it's not sufficient more the more complex workflows
>> *anyway*, maybe adding a new "replace" pointer in the core git data
>> structures isn't worth it.  It might be that just keeping such things
>> as trailers in the commit body might be the better way to go.
> 
> It doesn't need to be everything to everyone to be useful. I hope to
> show in this thread that it is useful enough to be a compelling addition
> to git. I think I've also shown that it could be used as a part of your
> more complex workflow. Maybe even a bigger part of it than you had
> realized.

I think the reasoning behind Theo's words is that it would be better to
first implement the commit relationship tracking as an add-in which uses
commit messages for data storage, then evaluate its usefulness when it's
actually available (including extensions to gitk and stuff to support the
new metadata), and then it could be moved into core git data structures,
when it has proven itself useful. It's not a trivial feature which warrants
immediate addition to git and its design can change when faced with real-
world use-cases, so it would be bad for compatibility to rush its addition.
Storage location for metadata seems to be an implementation detail which
could be technically changed more or less easily. But it's much easier to
ignore a trailer in commit message in the favor of a commit header field
than to replace a deprecated commit header field with a better one, which
could cause massive headache for all git repositories in the world.
