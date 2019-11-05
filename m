Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DEF11F454
	for <e@80x24.org>; Tue,  5 Nov 2019 01:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbfKEBVD (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 20:21:03 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:39797 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728602AbfKEBVD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 20:21:03 -0500
Received: by mail-ot1-f53.google.com with SMTP id e17so7681685otk.6
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 17:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wKqZkGHl4gJ1o4Oy32hMduaphuB1rSVBW6TEP0Nh3nA=;
        b=QJ1FOkxLX06u3itvQK7nXXDnnqGCdOKH4E3u3ZYH7h+xaGfN7GrCjWnTOgnITQQnYF
         TYXH0lmqxOSppVnI4s70WNnGBwYD9Y8QqxKfx+TBFffeCGyZT0eOikhtNdxFLRKrjADa
         KYrpQG2lw6f5SFveisjRJk35Z4JINezEIm5qNkfHq0+iPe1lAz6a8bE2tuBPStgAI+uh
         rCDsR4uhONhziZfaeAhxXwDleh+PH0Ql0vHBgFFRQm7hWpliQ4Ccgvrk3dT+9kpAf1Xq
         SkvNpEVLpdI2FRlD8IBp5ZMoIQVY7o5NZcqfdLOgL2O+2mRPFapBmkvUnrCuXEqS1TA2
         61AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wKqZkGHl4gJ1o4Oy32hMduaphuB1rSVBW6TEP0Nh3nA=;
        b=ajr3ixwvdqJgl43fZP/BFD3wiCwXCbevR27y9Z25XSo1Ys5bHyYGkwsHd04WbIQ8SN
         3C5bLLdm7EVzddhyrXw0K17YAso2J5Z+0iS0sWpSNjQJhjKF5Iqw8HBzO7/f9FMEhYvj
         2niSSif/DtCNLpkzn148HE4F3lGJZxzcCQ1BHNFeHrEtTMYB5g3OiiGdbqxfKG6qwz8R
         eqOVcBDOh1uicTrz1Rj1FOQ5mF8wGIwxo5QmX5buhiIQSxImyXXP6HuvKsINgk8H/u2Y
         fUq2sBPgJOKri/mrm+gECyd8N6AF1e0qGk4ABQYX6KfMQgz/2OF6zkDTYMRR5iymLRwJ
         5zDg==
X-Gm-Message-State: APjAAAWo6BZorrpwvK4LjEJ6GUnJaei+hm8XJYy042DlTLqxenX+Vhzz
        tQ1JOgMlfG/mC0mLS+4m9i76sMZQ4cIqtycO29A=
X-Google-Smtp-Source: APXvYqzoqPmhgBHR2ye16iaVsuO/TDIr93tGTsWhdJ4aTJSamuD2IvgQXge1QFb+kAT4Hs9aUUJMXq69h2rJkGUj1qc=
X-Received: by 2002:a9d:6302:: with SMTP id q2mr7586840otk.345.1572916861996;
 Mon, 04 Nov 2019 17:21:01 -0800 (PST)
MIME-Version: 1.0
References: <xmqqzhhcxkvx.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqzhhcxkvx.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 4 Nov 2019 17:20:50 -0800
Message-ID: <CABPp-BFgnAS6E-jAjGB0iowBDaEc9+3B__THMWymVMS0AUPocw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2019, #01; Mon, 4)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 3, 2019 at 9:48 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
>
> Git 2.24 has been tagged.  Hopefully there needs no immediate brown
> paper bag fixes needed for the 'master' branch. The next cycle will
> start perhaps early next week by first rewinding the 'next' branch,
> after the dust settles. Topics marked as "will cook in next" can be
> given a fresh start by ejecting them from 'next' and queueing a new
> version (please just ask).

Please go ahead and eject en/doc-typofix from next; I'll send a
re-roll with a lot more typofixes.  :-)
