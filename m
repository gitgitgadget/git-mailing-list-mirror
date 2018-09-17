Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 564D01F404
	for <e@80x24.org>; Mon, 17 Sep 2018 18:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbeIQXqe (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 19:46:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44157 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbeIQXqe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 19:46:34 -0400
Received: by mail-pf1-f195.google.com with SMTP id k21-v6so7933426pff.11
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 11:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gPA8ZBqCyQEpCIhxfqbfbPJ6pOy1gbY9f/rMTyFZC7g=;
        b=KNm3+wiE5wpS+LjgmOf1YeLFEpqjohrHQf0A1Ypsi5oB2e89kh3+X9M6yT6pCFcZdR
         5XnkD/Q7YJLDEtMq0V7VDGRu21y1H0r10d1RHt/U85WGrmbMkuQP7Q2yRp/RTN6Xl4nN
         r/o7MXqXTYy8Oj9PAYuwUnIPL+KKavmlSAEWsWX7byUzMSiLSQIJKrEG/bDQV46JnvDK
         5HvVCyBFUVQA/7O4c6BmTe/b8fah+XLhj14gNAnGhOk/10JSQ3d7K9TyOxMllA2f+RhP
         hROObTkkzz8R29tzBrf0l96RaDKMPeUovAdsHqBLmZRLzcu23ercedWWoRrmWM2Oq4S3
         TDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gPA8ZBqCyQEpCIhxfqbfbPJ6pOy1gbY9f/rMTyFZC7g=;
        b=oPGUCgHyyoyf+ujushp29bkh9DNpJDrBVRNG3WLgRfzot59XAtE1eRI24ol4oe1xuU
         TEWymz2LiYPJQDb3ywE7qFlONv/HriKkRn4FB+kaozrjHEjFH6z04KKWmcYdammDZQl7
         FXAbKiRw7uJE/+ex1ggMC3CWnYiKGqg7n/IaWZtdNpBmHM4OTqfxg6kojobL8Af/l5F3
         XqlQvPj9lf9iHFMpckX4vawojmVZE1OasBTef3khWoXm/U2u0dgkKbaOgjH5T4i8oull
         fZsBFgox9nOVwb7tL/bEU14x8grj/Q5ovm/PBPy3qR6fO910zRjEqCLWcOw6wheXCpFn
         8neA==
X-Gm-Message-State: APzg51AE3llnRbAopteILB1+UR21PhRRl7S7a/BoQNUf6mvx8dMEbJHP
        J/dmkn8huJFUMQOpwkrjujY=
X-Google-Smtp-Source: ANB0VdbI4TIgWvEseBb/AZbipf+vsAvYcuVc/5LHRj4aKCfnw62lV4gcr8lZ7i0zWKsEKBm7lEQfgQ==
X-Received: by 2002:a63:a319:: with SMTP id s25-v6mr23831602pge.199.1537208283127;
        Mon, 17 Sep 2018 11:18:03 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id x2-v6sm23722145pfi.166.2018.09.17.11.18.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 11:18:02 -0700 (PDT)
Date:   Mon, 17 Sep 2018 11:18:00 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH] mailmap: consistently normalize brian m. carlson's name
Message-ID: <20180917181800.GA140909@aiede.svl.corp.google.com>
References: <20180506232421.975789-1-sandals@crustytoothpaste.net>
 <20180508015845.268572-1-sandals@crustytoothpaste.net>
 <20180522220826.GP10623@aiede.svl.corp.google.com>
 <20180522224215.GI652292@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522224215.GI652292@genre.crustytoothpaste.net>
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
brian m. carlson wrote:
> On Tue, May 22, 2018 at 03:08:26PM -0700, Jonathan Nieder wrote:

>> These commits use author Brian M. Carlson <sandals@crustytoothpaste.net>.
>> Previously they matched
>>
>> 	brian m. carlson <sandals@crustytoothpaste.ath.cx> <sandals@crustytoothpaste.net>
>>
>> but now they don't match any line in the .mailmap file.
>>
>> Should we add a line
>>
>> 	brian m. carlson <sandals@crustytoothpaste.net>
>>
>> to handle these commits?
>
> Ah, good point.  Probably so.

Sorry to leave this hanging for so long.  How about this patch?

Thanks,
Jonathan

 .mailmap | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index f165222a78..29047a110a 100644
--- a/.mailmap
+++ b/.mailmap
@@ -25,7 +25,7 @@ Ben Walton <bdwalton@gmail.com> <bwalton@artsci.utoronto.ca>
 Benoit Sigoure <tsunanet@gmail.com> <tsuna@lrde.epita.fr>
 Bernt Hansen <bernt@norang.ca> <bernt@alumni.uwaterloo.ca>
 Brandon Casey <drafnel@gmail.com> <casey@nrlssc.navy.mil>
-brian m. carlson <sandals@crustytoothpaste.net> Brian M. Carlson <sandals@crustytoothpaste.ath.cx>
+brian m. carlson <sandals@crustytoothpaste.net> Brian M. Carlson <sandals@crustytoothpaste.net>
 brian m. carlson <sandals@crustytoothpaste.net> <sandals@crustytoothpaste.ath.cx>
 Bryan Larsen <bryan@larsen.st> <bryan.larsen@gmail.com>
 Bryan Larsen <bryan@larsen.st> <bryanlarsen@yahoo.com>
-- 
2.19.0.397.gdd90340f6a

