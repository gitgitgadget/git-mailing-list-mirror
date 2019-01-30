Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCAA91F453
	for <e@80x24.org>; Wed, 30 Jan 2019 20:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388012AbfA3U5K (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 15:57:10 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45310 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732013AbfA3U5K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 15:57:10 -0500
Received: by mail-ed1-f68.google.com with SMTP id d39so760015edb.12
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 12:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=AQZbUbLM8jd+mtd2EFBCXNLvUUhC/s0kU+ELolzPTg4=;
        b=ikII4k/9aj5U/k7tqDlwO4BozievAcVHy60ZyXglDyUBc1WXv1j0Zt8TljulljDUPs
         MUX/BhUAY5mew07Gmh25bVe8qWntIbTfYt26IroBL6NoeqYTOIyNHVUTuhZApRkXcXHP
         s1TYI0FBda/UE0tge2u718xnO0FyFVMZcAG3GRYjkyrZ7iwZh9zhF0GmiNvt68fcpZno
         NODzeQljTNnfIVztw7aM4MFsO9YPaWtONwb70WAN36DrGZ8axS2FLuQTGW5TjmpSSIBS
         9AdELkpnPkYZMfilz4oDHUkiuopt5WrzRvZbg0BDhFwPwFnIhKd/VlNmdA6H5mhFCPL+
         gg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=AQZbUbLM8jd+mtd2EFBCXNLvUUhC/s0kU+ELolzPTg4=;
        b=Q9X5QkdH5JSyENq5mHDNZqziQlAv2i03SaoDUby/MedtJ8KkQ7M1q6CN804EF+z4aF
         fORAvOVfR3ZAhlaTHDDI2QJxo5x3Y6oYjWaUJY0NTXoq3iKSvR8I6S38D7KaJXhFn1yp
         SMkTvSGL7Eb4HrEZ+A73RMmOSR2jHpmt7PWO/x3mvIfQhtx/gA2AlMnldPUEYz8vzPXR
         AH+Cz4MCTV/OA5T4gkGuBWndCkSCdySeEaSQymJmcy8hXGOwBYyLGrBw2fSeteLoG+fz
         ZkWsqLbOgv27oi9hMTqvKO2WeGx+WzbC/R3xZGp49Rilr5LODjk349772hW9a+kNQAlp
         TH0w==
X-Gm-Message-State: AJcUukeq5ILNtAeZ+eMuaRCkxTLoo8CViySCpHsTkzS+a7P9ni4vsR8O
        3OIxL/0D8Wrwmhygu6KmnUM=
X-Google-Smtp-Source: ALg8bN4+p4oD0W0fdM8fNRouY8VEEWQIPviPz/7NpusLHUYrUJJ0Cyc8+8R/nMXP/koVv7Bgp1ajbA==
X-Received: by 2002:aa7:d394:: with SMTP id x20mr25213199edq.193.1548881827817;
        Wed, 30 Jan 2019 12:57:07 -0800 (PST)
Received: from evledraar (ptr-a4kmumi3cjyxp9zp488.18120a2.ip6.access.telenet.be. [2a02:1811:5182:c100:ea6c:e022:ac1f:78a8])
        by smtp.gmail.com with ESMTPSA id v43sm779377edc.18.2019.01.30.12.57.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 12:57:06 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Contributor Summit Topics and Logistics
References: <20190122075027.GA29441@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190122075027.GA29441@sigill.intra.peff.net>
Date:   Wed, 30 Jan 2019 21:57:04 +0100
Message-ID: <87va253lun.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 22 2019, Jeff King wrote:

> There's no set agenda; we'll decide what to discuss that day. But if
> anybody would like to mention topics they are interested in (whether you
> want to present on them, or just have an open discussion), please do so
> here. A little advance notice can help people prepare more for the
> discussions.

This is definitely a "little" advance seeing as it's tomorrow morning.

> Even if you're not coming, please feel free to suggest topics (but bonus
> points if you convince somebody who _is_ coming to lead the session).

Things I'd be interested in hearing / talking about about that haven't
yet been mentioned.

These are in descending order of how interesting I think these will be
to a general audience, to the point where maybe only I care about the
bottom of this list...

* "Big repos". We had discussions about this in years past. It's a very
  spawly and vague topic. Do we mean big history, big blobs, big (in
  size/depth/width) checkouts etc?

  But regardless, many of us deal with this in one way or another, and
  it would be good to have a top-level overview of how the various
  solutions to this that are being integrated into git.git are doing /
  what people see on the horizon for scalabiltiy.

* "Structured remote logging". We had an RFC spec for turning our trace
  format into something more structural with a way to send it to a
  remote server. There were both implementation & privacy concernse,
  last time at least a couple of users of git reported having in-house
  patches for this (not ready for upstream). Where are we on this now?

* "commit graph by default". I had this on my list, but Derrick Stolee
  sent out a much better summary:
  https://public-inbox.org/git/6d0dc2a2-120c-0d42-1910-14ffed7adaf1@gmail.com/

* I've been using (but haven't yet re-rolled) my "relative SHA-1
  abbreviation" series
  (https://public-inbox.org/git/20180608224136.20220-1-avarab@gmail.com/)

  I'm interested in seeing if anyone else is interested in this, and
  particularly what the overlap (if any) is between this & midx.

* "Making strict fsck checks on clone the default". I worked a bit on
  this in this last year in between a couple of security issues that
  needed fsck checks. Has caveats etc., but would give users some more
  protections.

* "The CI I set up for git on the GCC Compile Farm". Can be folded into
  a general "state of git.git CI" topic:
  https://gitlab.com/git-vcs/git-ci/pipelines

* If people care about making the TAP mode in our test suite mandatory
  (i.e. require "prove" or a tool like it). See
  https://public-inbox.org/git/87zhrj2n2l.fsf@evledraar.gmail.com/
