Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E86F920437
	for <e@80x24.org>; Tue, 31 Oct 2017 18:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753925AbdJaSIO (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 14:08:14 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:45738 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753917AbdJaSIN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 14:08:13 -0400
Received: by mail-qt0-f175.google.com with SMTP id p1so21863262qtg.2
        for <git@vger.kernel.org>; Tue, 31 Oct 2017 11:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wSVWauv9G0/njDnl/6eN7ZxOdiH6Vg0hDrb+EdANAUc=;
        b=Ywdmn7R2XH7vouWEXKFe4GW3mAFz1I19ulnjLWalTzV5efTi38VVQBP/P5o9BSfA7L
         EmtsIxdori/5kGiBOrPFyL+oNZUXOEnPgBUN6AnZwVIaVJTi4kzq5kTPcd06SL4ikLkV
         Aqt49rqEHIXPVMNLQv4lxOKWsZp3A97dMkkuN3DEcz/TYSbwoPV3CGNl4ZAoPLn9QTpz
         UT6fnZlAQFyIoiLRLcd9Vo0mIkqzHfv532IB7Os8G0jJ6rrXRch0OnkAXrnPeBVJ2fuR
         GTrOMaf8BKQ7HclZBGJhxWL16CRSwIbr9lJker2kMlnQX1JNo5Y9SchnyG7STp8PFNhV
         5GWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wSVWauv9G0/njDnl/6eN7ZxOdiH6Vg0hDrb+EdANAUc=;
        b=uUMJ+E1pzgV1WsWk5k/E6tWJl3sb1ILx5ljXwC3IZMS5pqEacMUoXCKN+FxoCYuW8b
         WvmnDuM2WD2Mz64Ix96EHkgucNXKqyzi3lJptQ3fOjMHV4Sh2rykX3no9wfpEuRK8XHI
         yJ9YnlUHMqCJdIvONGnQ5klabCXV260epaZf9XO1HtD/xEBIqkhlq2MO5AdqH+J9PHZq
         X5pAHtIRa4USOfRSit+aha1L6ahtYj5mgsaXzi6QyZjw31HmUikGXlt16GgPCd5fVDe5
         V7caTaygSaRMAMwU7BdvR0lcM1iaJSm8ss7geS5evLOKW3+JGCQ6ZT+bYcj8kVQ6B0n0
         Ydcg==
X-Gm-Message-State: AMCzsaWkpWOMnr8pmCML3ZZhneIO0gtbknFqfmUzUypOl7tIgJ8G7Fq7
        3+ZkFx5OzpTIntDQqItBwIcMgzM/k8V9lma+DVI=
X-Google-Smtp-Source: ABhQp+QmdTWEEu5DNORZ70Opfyiv4vRy7I8BEhqpr8GpJE6aTvYXUZF6ul+nowxvMupi884lesc6jMfeggZGxbXCA9I=
X-Received: by 10.200.4.169 with SMTP id s41mr4329091qtg.212.1509473293119;
 Tue, 31 Oct 2017 11:08:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.20.162 with HTTP; Tue, 31 Oct 2017 11:07:52 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1710311819590.6482@virtualbox>
References: <20171029211308.272673-1-sandals@crustytoothpaste.net>
 <20171029211308.272673-3-sandals@crustytoothpaste.net> <xmqqa8096yzu.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1710301333420.6482@virtualbox> <CAHVLzcnS6n_BODDo3wrBzNkpEPTYBLD0V51H4O10q82J=xYnqw@mail.gmail.com>
 <alpine.DEB.2.21.1.1710311819590.6482@virtualbox>
From:   Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Date:   Tue, 31 Oct 2017 19:07:52 +0100
Message-ID: <CAHVLzckqV8+Bf91VsY95fo==97saHbq=R4xuCF0KX3FY8fgOwA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Documentation: convert SubmittingPatches to AsciiDoc
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 31, 2017 at 6:21 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Paolo,
>
> On Mon, 30 Oct 2017, Paolo Ciarrocchi wrote:
>
>> On Mon, Oct 30, 2017 at 1:35 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> >
>> > On Mon, 30 Oct 2017, Junio C Hamano wrote:
>> >
>> >> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> >>
>> >> Thanks.  I personally prefer the plain-text original, but I do
>> >> understand the need to have a version with ids that you can tell
>> >> others to visit in their browsers.  Assuming that this goes in the
>> >> right direction, here are a few comments.
>> >
>> > If you want to go into the direction of the web, AsciiDoc is actually the
>> > wrong choice IMO, and Markdown would be the right choice. Basically
>> > everybody on the web is either supporting Markdown or being asked by users
>> > to do so.
>> >
>> > Assuming that *that* is something we want to pursue, I would also suggest
>> > to move the man pages away from AsciiDoc to Markdown (using e.g.
>> > [ronn](https://rtomayko.github.io/ronn/ronn.1.html)).
>>
>> Nitpick, the right URL is: https://rtomayko.github.io/ronn/ronn.1.html
>> You put an extra ')' at the end and therefore I've got a scaring 404 error :-)
>
> The first closing parenthesis closes the link associated with the label
> `ronn`, the second closing parenthesis closes the remark I started in the
> previous line (beginning with the word "using").


You are right. I've got confused by the fact that gmail fails to
properly handle that link.
Sorry for the noise.

Regards,
-- 
Paolo
