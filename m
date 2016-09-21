Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9DB01F935
	for <e@80x24.org>; Wed, 21 Sep 2016 18:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758717AbcIUSEo (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 14:04:44 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34959 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755623AbcIUSEo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 14:04:44 -0400
Received: by mail-qk0-f196.google.com with SMTP id w204so3556204qka.2
        for <git@vger.kernel.org>; Wed, 21 Sep 2016 11:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z8humBi0RPtflk4IRChpNGOIPwo133PWskAtoAYqc3c=;
        b=rVS8LpeYax5wvMItUGRxo90qN9Yk7giKEnku8zhnb7s0Js4lGShLFMpQskEmGhEp1V
         TlZm90tXm9nKk/ffmGtuiPK7nnxMcjFhO6VYcYx58OqPa2z7mcXQnem9vcLNNQrMdoav
         LqqNExjg+NlUs/9fid7Wc87N98am1F8QspCjFCQ+HnpULCkPV899i6Bs1crq8wnB1hu/
         JSFvDSC9tOgOfH3lCz/2j4eohMre7n4Yy2N9QmBi3nfEaPq0ml3G+Ew007mJQQ/WlfwG
         f2tJaVRwdbxnhe2PO/XBoU6X6B3xtUwG+x9+DFLl79pjMlnZw3R3DkIZjzQ0pZV580+r
         hCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z8humBi0RPtflk4IRChpNGOIPwo133PWskAtoAYqc3c=;
        b=dyQsvsVo9ct/h/m2qGdV9XLj88Fg8I7A8sS1VVbI1KsjrzJ31zY5l2aTzPR7vcEq61
         xmqGxFR1jkqg0/TqnB3Y9ComLnTemesBJmNpwEaT/lk+OXlRM0Ywqvpa5DRRSAOO1tmT
         txHTXriPQxvuC6CJptB9JCL0iv2B1/7CrLGhqRdHpqsdFlxzKa0hHXK0qODchngs9tkk
         A9pjB6jfPRagb3MpPkQaaA51xhLXezHKoVEq+uKJcp5qDjw9D7iWVrTbrHHxdIX1M5Lm
         ilSbQZR3z0Ael7Tk4zl35lhUbhlYsWu/qesQEdeYBMspbr2gAa9qkxxUcj1Ss3HwXsL9
         5zWw==
X-Gm-Message-State: AE9vXwPzjlzZmn7IDfWoJ5qt7i/9/6xefwoHR+nqYxfwM1qlHCYAyKkVn9NukI6wmdfb1q2VIJghj1OMvFjXqw==
X-Received: by 10.55.182.4 with SMTP id g4mr41825208qkf.120.1474481082193;
 Wed, 21 Sep 2016 11:04:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.87.133 with HTTP; Wed, 21 Sep 2016 11:04:21 -0700 (PDT)
In-Reply-To: <64389bcb-c6e4-1d19-54a1-650868b9acb5@gmail.com>
References: <20160921114428.28664-1-avarab@gmail.com> <20160921114428.28664-2-avarab@gmail.com>
 <64389bcb-c6e4-1d19-54a1-650868b9acb5@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 21 Sep 2016 20:04:21 +0200
Message-ID: <CACBZZX5mYuDUMHfurKEbCqodZkhYygQz+-G6VmKW+AMnCycm9g@mail.gmail.com>
Subject: Re: [PATCH 2/3] gitweb: Link to 7-character SHA1SUMS in commit messages
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 21, 2016 at 6:26 PM, Jakub Nar=C4=99bski <jnareb@gmail.com> wro=
te:

> P.S. I have reworking of commit message parsing and enhancement in my
> long, long and dated gitweb TODO list :-(

Anything specific you could share?

One thing that would be a lot faster in Perl is if we didn't have to
pass the log around as split-up lines and could just operate on it as
one big string.

It would make some code like git_print_log() a bit more complex /
fragile, since it would have to work on multi-line strings, but
anything that needed to do a regex match / replacement would be much
faster.

But OTOH I think perhaps we're worrying about nothing when it comes to
the performance. I haven't been able to make gitweb display more than
a 100 or so commits at a time (haven't found where exactly in the code
these limits are), any munging we do on the log messages would have to
be pretty damn slow to matter.

> P.P.S. Kay Sievers no longer works on gitweb, and I think no longer
> works at SuSE but at RedHat.

Yup, been getting bounces from his address.
