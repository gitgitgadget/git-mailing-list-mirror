Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA91C2013A
	for <e@80x24.org>; Wed, 15 Feb 2017 21:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbdBOVve (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 16:51:34 -0500
Received: from mail-wr0-f174.google.com ([209.85.128.174]:34950 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752061AbdBOVvd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 16:51:33 -0500
Received: by mail-wr0-f174.google.com with SMTP id c4so42190386wrd.2
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 13:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xbBH60ItV00MdNezuexd6OGDMJmWlikd/jTBQm3vmbs=;
        b=N3WGhebEFMCbBv/Hw65wrHMPCAZ7s0emmd+QeVBrsJcLsJV+94pwmDzV5ph3kk+iij
         JaNgZWH/1DkVaTzIzesBqvvpJTH4vOXn6DU1l05ylmgwtI/3LO0pzKSH02GZ1phpa5L2
         6zTnH7Es0Ai1L0TNE1lh/NWVPFxADARkJwdD8fqvRdGq2WNuQTH8mUZNFvOIWZSxkchf
         923oTwJ+Erce4ZRxi/q0bPAP+CaDoSe910iWPTjgFQ6604W6tP80HJAUpagD22XEswNh
         PIL9LfpcLk9i0S/eOdFJxQ7YfFvP2ia+Iwzzx9ODcZZXjUQagj1MIQO+AU5qYezPmJTV
         QC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xbBH60ItV00MdNezuexd6OGDMJmWlikd/jTBQm3vmbs=;
        b=FuJrXarK6SbORaJ/hQHUHDcm8EmTwxXa3Hv5yiKdu29H0LmFI/e/6+Zy5LXTH/GJ9K
         ZFR4cQpjyN2OcfoFhk63UJgyMY5yPDA9fqTURb9leYk75thPOpX03PWROw7MYbeiy6L+
         7H3yAX/Wrdsa4o2q6hcjxuJgbG3Z8b1+XwZJelLIaJoKu4i256yyWo39jSrmWAv6URnd
         lbz3+d0qBh8LYhAGLfOg3QK5iwT6aQ5Lv2Bo4imGDphf6yHzNe8Ft0zppd1tTHOojqsl
         gqD+iJtCG5Ir2X6r89L5kbmv4Q2euu33M86s7/a5Y4j3DMc3ceObZq2AWQsDndh7i2A1
         kHDw==
X-Gm-Message-State: AMke39ksKG89vWBKzV8oU6RboShENcYxvIFbnaials81g/B8GTT7IFODpmju7xPtnKhpbyLDTawnqM04urHmLQ==
X-Received: by 10.223.165.87 with SMTP id j23mr36752420wrb.79.1487195491466;
 Wed, 15 Feb 2017 13:51:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.138.211 with HTTP; Wed, 15 Feb 2017 13:51:30 -0800 (PST)
In-Reply-To: <20170215212157.qgscyglgzrd5cplf@sigill.intra.peff.net>
References: <CAOxYW4z=bABqhmHWCc9rizykMcGBjDvqLEuqpJ6DtPve5442Fw@mail.gmail.com>
 <20170215212157.qgscyglgzrd5cplf@sigill.intra.peff.net>
From:   Fabrizio Cucci <fabrizio.cucci@gmail.com>
Date:   Wed, 15 Feb 2017 21:51:30 +0000
Message-ID: <CAOxYW4xqk4j6Uu86jq2Vi9Bpgihxfr2Tw-DQLc+7YTZiPmDtiA@mail.gmail.com>
Subject: Re: Back quote typo in error messages (?)
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15 February 2017 at 21:21, Jeff King <peff@peff.net> wrote:

> On Wed, Feb 15, 2017 at 09:06:46PM +0000, Fabrizio Cucci wrote:
>> Shouldn't the wrong flag be surrounded by two single quotes instead of
>> a back quote and a single quote?
>
> Some people use the matched backtick/single-quote to emulate the
> non-symmetric start/end quotes used in traditional typography (and in
> fact, ``foo'' in languages like asciidoc are typically rendered using
> smart-quotes).

I definitely didn't know about the use of them in traditional typography!
But I couldn't find any example of non-symmetric quotes in AsciiDoc...

> So I think what you are seeing is not wrong in the sense of being
> unintended by the author of the message.

I had the opposite impression from the quick search in the GitHub
repo, this is why I wrote here looking for some confirmation.

> I don't know how much we care about standardizing that punctuation.

I mentioned it was very minor but, still, in my opinion a project like
Git deserves consistent punctuation! :)
