Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D01F1F453
	for <e@80x24.org>; Mon, 24 Sep 2018 17:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbeIXXmW (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 19:42:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35959 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbeIXXmW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 19:42:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id b7-v6so1910479pfo.3
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 10:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZfRPiEBzLMQDnROY+IbE3e59UX3AlLgWGvc/6Pp80hE=;
        b=IVxQVjDXu+/Koku5r2t2ucusFH8aF0+U1uPi6oLgqv9koRSY5MRdj84SPjDW5ynP+P
         7d276/IGaMDFs9eijVp4DiqbMQmdtl3CKE12qodd3mavfhEo0mNqgqEcxmbZesIlUmOe
         q9S05x0UQaxEo3rhx8Nzax/6NrsXBnM2rx/klLPCBlqp/8IVSaFeJ4RroQLfTIF4JCy9
         Fb8WRf4QKLpYdPupF6w2QnoJDP2tb8GoG83BC2CdCdeaYaeL4z5T3LvLbpbqGKAAQKh4
         fdPey89uxEixjN7uFje7RD89fQWkmzBA+2pI35TsM8fLntpCBt4Yv3tBcIH26gBGFENt
         jZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZfRPiEBzLMQDnROY+IbE3e59UX3AlLgWGvc/6Pp80hE=;
        b=p91n7U4cY3zloIIGvswmCpkqlEOQ7TV2JPaMPh5RbDRMKWZuaLdmLKE1w/KPkgQta7
         Y5IMpmnHN1mrXbB7bYprLKLKiVq/5hg0+3Pv6TMcBB5Pni7NddAIhEn7FYT/SBKEvqBc
         wbRm8qGxnuH57XBmUd/q+fbSmmF6uMjvgKs6rj22H1m9POTBK5EI7Pwtg8+XSFdV2pfZ
         ccnAizlxxA8Q4TQqi35mDxTaWLoV39B8hOpaGC19MF3cAxaWv6U9PuHzJu+/C3WcyUXn
         lCkMUUyGj8cLTthIw8O1BLZiX05NRd1i2wZc9goqTUixYcbHlcrLA4L9d0uvjKTFO7tv
         AP3A==
X-Gm-Message-State: ABuFfojM55+9OAxSvBYdDFnHPASHgqcOFFS/ZGbRnjexO6CMHWluqobA
        WuUjXf5mZTGXsIviSv5w0HI=
X-Google-Smtp-Source: ACcGV60XIAhi0EyjbEbP8hdSYrVQxaLwOXLI+zPBVsuKB7RVE0ICdMnaSEOVBhnGKag1OvTBWG/pkQ==
X-Received: by 2002:a63:4716:: with SMTP id u22-v6mr8876298pga.95.1537810746137;
        Mon, 24 Sep 2018 10:39:06 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id a11-v6sm7223757pgv.29.2018.09.24.10.39.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 10:39:05 -0700 (PDT)
Date:   Mon, 24 Sep 2018 10:39:02 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH v2] mailmap: consistently normalize brian m. carlson's name
Message-ID: <20180924173902.GB138072@aiede.svl.corp.google.com>
References: <20180506232421.975789-1-sandals@crustytoothpaste.net>
 <20180508015845.268572-1-sandals@crustytoothpaste.net>
 <20180522220826.GP10623@aiede.svl.corp.google.com>
 <20180522224215.GI652292@genre.crustytoothpaste.net>
 <20180917181800.GA140909@aiede.svl.corp.google.com>
 <20180917222158.GY432229@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917222158.GY432229@genre.crustytoothpaste.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2.18.0-rc0~70^2 (mailmap: update brian m. carlson's email address,
2018-05-08) changed the mailmap to map

  sandals@crustytoothpaste.ath.cx
   -> brian m. carlson <sandals@crustytoothpaste.net>

instead of

  sandals@crustytoothpaste.net
    -> brian m. carlson <sandals@crustytoothpaste.ath.cx>

That means the mapping

  Brian M. Carlson <sandals@crustytoothpaste.ath.cx>
    -> brian m. carlson <sandals@crustytoothpaste.net>

is redundant, so we can remove it.  More importantly, it means that
the identity "Brian M. Carlson <sandals@crustytoothpaste.net>" used in
some commits is not normalized any more.  Add a mapping for it.

Noticed while updating Debian's Git packaging, which uses "git
shortlog --no-merges" to produce a list of changes in each version,
grouped by author's (normalized) name.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi,

brian m. carlson wrote:

> I think this commit message makes sense.  I apparently still fail to
> understand how the .mailmap format works, so I can't tell you if the
> patch is correct.

Thanks for looking it over.  What would it take to make the patch make
sense, too? ;-)

Most mailmap entries are of the form

	Some Name <someemail@example.com>

which means "Wherever you see the email address someemail@example.com,
canonicalize the author's name to Some Name".  We can use that:

	brian m. carlson <sandals@crustytoothpaste.net>

When we see sandals@crustytoothpaste.ath.cx, we also want to
canonicalize the email address.  For that, we can do

	brian m. carlson <sandals@crustytoothpaste.net> <sandals@crustytoothpaste.ath.cx>

There's only one person who has used these email addresses, so we
don't have to do matching by name.  If we wanted to tighten the name
normalization to match by name, I think we'd do something like

	brian m. carlson <sandals@crustytoothpaste.net> Brian M. Carlson

but I can't get that to seem to have any effect when I test with the
"git check-mailmap" command --- for example, "git check-mailmap 'Dana
How <random.email@example.com>'" does not map and "git check-mailmap
'Random Name <danahow@gmail.com>'" maps to 'Dana L. How
<danahow@gmail.com>'.

The even tighter matching used in v1

	brian m. carlson <sandals@crustytoothpaste.net> Brian M. Carlson <sandals@crustytoothpaste.net>

does work, but it's unnecessary complexity.  We don't need it.

How about this?

Changes since v1:
- loosened the matching to only look at email and ignore name
- no other changes

 .mailmap | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index f165222a78..bef3352b0d 100644
--- a/.mailmap
+++ b/.mailmap
@@ -25,7 +25,7 @@ Ben Walton <bdwalton@gmail.com> <bwalton@artsci.utoronto.ca>
 Benoit Sigoure <tsunanet@gmail.com> <tsuna@lrde.epita.fr>
 Bernt Hansen <bernt@norang.ca> <bernt@alumni.uwaterloo.ca>
 Brandon Casey <drafnel@gmail.com> <casey@nrlssc.navy.mil>
-brian m. carlson <sandals@crustytoothpaste.net> Brian M. Carlson <sandals@crustytoothpaste.ath.cx>
+brian m. carlson <sandals@crustytoothpaste.net>
 brian m. carlson <sandals@crustytoothpaste.net> <sandals@crustytoothpaste.ath.cx>
 Bryan Larsen <bryan@larsen.st> <bryan.larsen@gmail.com>
 Bryan Larsen <bryan@larsen.st> <bryanlarsen@yahoo.com>
-- 
2.19.0.444.g18242da7ef

