Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15CAD1F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 21:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbfJNVqf (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 17:46:35 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:44631 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729054AbfJNVqe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 17:46:34 -0400
Received: by mail-pf1-f201.google.com with SMTP id b204so14287125pfb.11
        for <git@vger.kernel.org>; Mon, 14 Oct 2019 14:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=C8VqkIMNyWf3PI9ss2hco14HvPoa/3UaI2eTagCPP/g=;
        b=v9HXerdz58B+dctsv2A7Bx47vhAsT1cBcmuC9XETyHlzWG9oSx608/1N240C5Y5Y40
         ADqykTgzIyJW2A8jpKgIcLDSWsnt+xSPqG/nSX56fpmBRQUww2eS6jnDDOJXGxLtl3TQ
         1qWMEMjtwfdzfDXj7CSqRPbbhr8rVawdKnFUm60PL7EUTN/nWOCoqh7m8NGWmwsXxSia
         I4bbkTs3Pqi2N5enffGN08TEHPvJ+QIhqea+dtab/zEqKFBcq22Obg+uykBXOEU2RuJA
         PL2bl+ffkLndre3bG08iZlrWLhANPkDQQnAYbUu3ufj1/STTjuARQn/9ACOMhV5ZRbK4
         4dUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C8VqkIMNyWf3PI9ss2hco14HvPoa/3UaI2eTagCPP/g=;
        b=YbidtFJfBlZ2YDpE3EJpfzQJX9KVsZh1+mW2AwBfkIMo1LHZl5DRQHfOW891HGjbC7
         msJPriDTz/H02MTQiPCeGtyYMPxQnTsYD4PXjbiI43gwqOdQuj4wF/OBACRT3IkfllYl
         bYjdQglz+FNTrugzLbfLjEuS1vqvSzi9K9bf6jzPEJJdJ2uryube3fCSt1yiwU6IZhf+
         Ge/aVjSojBt+P6GZou3ixvtzdqxZr7AAQ3QXhHimy/dbfNrdOpQeRF0jf+5ATs8KKXSZ
         LJtV36rGOPyAeEk9HnSsCZ+9ifz7S4hTCRA92m6AWdqD6McYSyzFClo2XGukYWIM7xC5
         uwQQ==
X-Gm-Message-State: APjAAAV5uCLMzWlX19HA5Elvwb0Q6wDX29sxqo0FmyQ5ZXU88MU89QQD
        37Lvpts3XRVqcDnd/nafEyohw5RYGItNrLjgRNtR
X-Google-Smtp-Source: APXvYqw8bfpTkylcKlxO99TLzSPNo6ZaRaCLVCTJCHX5pFOMLlFVr78xrZqJTzqnzPGJJSsH9BnF0AqbSxG3zDg+Auvv
X-Received: by 2002:a65:5345:: with SMTP id w5mr26994147pgr.213.1571089593408;
 Mon, 14 Oct 2019 14:46:33 -0700 (PDT)
Date:   Mon, 14 Oct 2019 14:46:29 -0700
In-Reply-To: <20191014193734.GA13706@wambui>
Message-Id: <20191014214629.134882-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20191014193734.GA13706@wambui>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: Re: [Outreachy] [PATCH] blame: Convert pickaxe_blame defined
 constants to enums
From:   Jonathan Tan <jonathantanmy@google.com>
To:     wambui.karugax@gmail.com
Cc:     jonathantanmy@google.com, gitster@pobox.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Well, I agree that it could be better, but with the C language as we
> > have it now, I still slightly prefer an enum to a list of #define. Both
> > ways, we still have to manually enter values for each flag, but with
> > enum, we get better debugger display (at least in gdb) and in the
> > function declaration and definition, we can put a specific type (instead
> > of "unsigned" or "int"). gdb supports the notion that a few people use
> > enums this way too, but if we decide as a project to not use enums in
> > this way, that's fine too. For what it's worth, I tried doing a search
> > online, but most of the results I got was for C# (where it is
> > recommended - they have a "[Flags]" attribute for enums), so maybe I am
> > indeed in the minority.
> 
> I'll try to pick another set of constants to convert - before this is
> agreed on.

Thanks - perhaps that's the best way to proceed for now. Do you remember
where you found the idea to convert #define to enum? Maybe I could add a
note there to avoid converting bitsets/bitflags.
