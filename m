Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A21DD1F453
	for <e@80x24.org>; Fri, 26 Oct 2018 21:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbeJ0Fn6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 01:43:58 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44857 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbeJ0Fn6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 01:43:58 -0400
Received: by mail-ed1-f68.google.com with SMTP id z21-v6so2427358edb.11
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 14:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NJ+3Er8SdL3davcMuubN1DBbSgCgWAorveTqBZ39weM=;
        b=RJKC8Chcq3ZXvK3cj4b5GM0P2PTMAKUsE3UkpAgveoVERcpKPLBpKl8hSyeMoDvfSI
         jQVfIoKk7N8mvzU/9jO5eQc/2cpbx+1YeAJZKjkxrTNaWH/LFE5ZuYd8T//U/44GXY2N
         5UhaYjXNyELzuXOM2LHuiTz6cpUyrLBLdEADULuuMM5uutz5Ds/nW4GgDKl18nkA3NY6
         jyQXrEfZFOcIHHALyMhEiYe2qhaDUYHXz9qMNdn5dHneh+4wwy5AjihezSYQ3fVAsj/Q
         2f0FqxjyNTT+yX7h8DJ9cOT8CHxDowpkXefUJppJ2t4NEoYi7BZI1DltqQWDl6Ymtq4a
         DPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NJ+3Er8SdL3davcMuubN1DBbSgCgWAorveTqBZ39weM=;
        b=Fug4rHyk4nGw/bUyJYI3HEJF/poGyzxAIRtZtKsKeB4sZDBhodIq0KHH0kc5jdyLe2
         rEW1AGl+KAk4An+fjL8BVq/X5kA0GVtXDVxphp9haou1RjFtl4YPpeSuXTzOc8yTiYzP
         yCg+oGSnRa2Hdz22438GQanqwc3F9HW5ij4HeygzNgnX5IVcsMW8d3odPXkPEQrLapFb
         xnRVfpPAEs/VMgansTDrdKAq9mmib407kUdZRsIVPdkyjSgBIYwBcCjHBdpEuHn+bSNq
         lohByQuOkm7ly5QWy9EU7k1hguyN0ej8mcYkFo3xXrw+cJay5VaPq8nZpw3APwx6Pxsw
         eMYQ==
X-Gm-Message-State: AGRZ1gKrQuXzNe4s1/f1iNMg6qpZ2hBDewCy2bxiLU8enwZCKPiT4zCT
        bY8qJ0HwyTLu0p2TupJQzb7jbfQTJgOM1TBmT+kpAQ==
X-Google-Smtp-Source: AJdET5dwnpeP13HRBFjbeI3wJ2QBSXrG/03PnTUkJ0sPp5xAsFxSSpEjrBJ02jSWDbiqDKnyWjZzfFMyoojOsGU0/KA=
X-Received: by 2002:a50:aca2:: with SMTP id x31-v6mr4386652edc.76.1540587922833;
 Fri, 26 Oct 2018 14:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq5zy8f6gr.fsf@gitster-ct.c.googlers.com> <20181026192734.9609-2-avarab@gmail.com>
In-Reply-To: <20181026192734.9609-2-avarab@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 26 Oct 2018 14:05:11 -0700
Message-ID: <CAGZ79kYTHx6vz_YTCLBTBnoxPEV0sCa+Q46OmMVxuY09Dm1Skw@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] remote.c: add braces in anticipation of a
 follow-up change
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 26, 2018 at 12:27 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> The CodingGuidelines say "When there are multiple arms to a
> conditional and some of them require braces, enclose even a single
> line block in braces for consistency.". Fix the code in
> match_explicit() to conform.

A tangent from a bystander:

This sounds like a lovely transformation that we'd want to
apply to the whole tree (Who wouldn't want to conform to
our self-imposed coding guidelines?),
so I tried coming up with a coccinelle patch to do that,
but I did not manage to produce such a patch, yet.
So far I am at

@@
expression E1;
statement S1, S2;
@@
 {<...
 if (E1) {
   S1;
-} else
+} else {
  S2;
+}
 ...>}

but this doesn't transform the simple test program that I wrote.

> While I'm at it change the if/else if/else in guess_ref() to use
> braces. This is not currently needed, but a follow-up change will add
> a new multi-line condition to that logic.

The patch looks good.

Stefan
