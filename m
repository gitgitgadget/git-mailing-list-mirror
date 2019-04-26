Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71D7B1F453
	for <e@80x24.org>; Fri, 26 Apr 2019 09:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbfDZJhI (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 05:37:08 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38647 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfDZJhH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 05:37:07 -0400
Received: by mail-io1-f66.google.com with SMTP id y6so2425441ior.5
        for <git@vger.kernel.org>; Fri, 26 Apr 2019 02:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gw/NCyNCE035Ab1hwewQpekqQNNh0aCpZGCJH1KK5FU=;
        b=fEHmzTDMujDJOyEAKBQF/6xS9NWGfZ2xd1wwHHWsfntu/9aedjyFSQuaaoRo+5sq6y
         mqWxHYK5hVJAltATRqz3v74g1tVTaWUU9pa64+rxjcHd3K5DCVR50OQhxXr86iCXtKUp
         JnPD+ugBS8Ng5Flfq67FrWcMGAekB3s3WAXRqe3JfFNsizj162GjPLVMPuwhae/ipusI
         LVva7PmDEyLsRgJxaTh2w9wNiMxn2Qs+ocGdtmwQtVpYveeHt7IFcprpjNzfL/PM3yNr
         UMApdTrhIHQBDPXx1SFKrrrESn3HDhtNA9L+jNZPce3+u8T+nWl6mX6H/eNFnWySwMww
         8xBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gw/NCyNCE035Ab1hwewQpekqQNNh0aCpZGCJH1KK5FU=;
        b=jIyj3cTt21rkjfmI2oEveBbBkKxKZpm/lVOTZniogIlrIZ4iKShaIqZw4m4tJQsQlT
         JRsMaVn23tDv6slpRqVvzX9otu9hWSA6ErPXCFFNIQWRDJBwpSqsOSgkQKXbhqXW76kP
         wuBvv1TZSGvek5kL9/d7Q40lsdZWdie+JKdIDsdf+WoUhgwelqZaWjVF6Rg4/3ygeqo1
         RloOFlryDdjEikIWx42fZwJpDE+bgEoKTrmpO1a3l4jQceJ+VOatedGWn1wFQGEcSMBg
         GpX43NLv0beS1mHSYVE/PySxMfpSE9PbaiYW/TSbxe7TVr4T/EtCOwehePggh4Mtq2dQ
         P7YQ==
X-Gm-Message-State: APjAAAWfQGL9gBEUnAulibxc3PHqnKbtoqRTVTWYyEcyAWWcClpiWJrm
        qP8kwxgpZEqidkACfADDbYPmFQFYPIDScSBSFmM=
X-Google-Smtp-Source: APXvYqzu9W4P8e5Cwun+D8xbUamraJFtbs1+V9M6nHUy/wovF7TLTslRakmbuBliviO540fio/+nlFF31mmeYv0URD0=
X-Received: by 2002:a05:6602:2042:: with SMTP id z2mr14805968iod.282.1556271426879;
 Fri, 26 Apr 2019 02:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190424004948.728326-1-sandals@crustytoothpaste.net>
 <20190424023438.GE98980@google.com> <20190424230744.GL6316@genre.crustytoothpaste.net>
 <87k1fis8gq.fsf@evledraar.gmail.com> <20190425143614.GA91608@google.com>
In-Reply-To: <20190425143614.GA91608@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 26 Apr 2019 16:36:40 +0700
Message-ID: <CACsJy8B5j2K=RU7N+h-i9HszuYuYd+fNmAftVDW-4nJ_o5z8Sw@mail.gmail.com>
Subject: Re: How to undo previously set configuration? (again)
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Barret Rhoden <brho@google.com>, Olaf Hering <olaf@aepfle.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 25, 2019 at 9:36 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Hi,
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
> > Because we don't have some general config facility for this it keeps
> > coming up, and various existing/proposed options have their own little
> > custom hacks for doing it, e.g. this for Barret Rhoden's proposed "blam=
e
> > skip commits" feature
> > https://public-inbox.org/git/878swhfzxb.fsf@evledraar.gmail.com/
> > (b.t.w. I *meant* /dev/null in that E-Mail, but due to PEBCAK wrote
> > /dev/zero).
>
> I'm confused.  Isn't that bog-standard Git usage, not a custom hack?
> That is, I thought the intended behavior is always
>
>  1. For single-valued options, last value wins.
>  2. For multi-valued options, empty clears the list.

I didn't know this! Should it be documented? At least a quick skimming
through config.txt does not mention anything about empty value
clearing multi-valued options.

I also wanted to see if it's true. However, the first var I checked,
branch.*.merge does not follow this rule. I got disappointed and
stopped.

>  3. When there is a special behavior triggered by not supplying the
>     option at all, offer an explicit value like "default" that triggers
>     the same behavior, too.
>
> and that any instance of a command that isn't following that is a bug.

Not sure how many we need to fix. The behaviour does make sense to me thoug=
h.

> Which of course leaves room for improvement in documentation and how
> we organize the implementation (as Peff discussed in [1]), but isn't
> it nice to already have something in place that doesn't require
> inventing a new syntax?

This cannot undefine a variable though, especially those single-valued
ones. But I think for most cases, the user just needs to find out what
is the default value and set to that one.

I don't know if there is any case where the lack of a variable behaves
differently (or the default value is too dynamic to be set manually)
though.

> Thanks,
> Jonahtan
>
> [1] https://public-inbox.org/git/20180406175044.GA32228@sigill.intra.peff=
.net/



--=20
Duy
