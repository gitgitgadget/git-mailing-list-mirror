Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D19992018B
	for <e@80x24.org>; Tue, 19 Jul 2016 04:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbcGSEc2 (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 00:32:28 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:36154 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924AbcGSEc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 00:32:27 -0400
Received: by mail-io0-f171.google.com with SMTP id b62so9030451iod.3
        for <git@vger.kernel.org>; Mon, 18 Jul 2016 21:32:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jH9i7zlphLHIWzHV5awFFr8z/d7AsgmUUvnEhTzNagE=;
        b=uMebXta9rOVdphIb5SmTASP1DKEmwvOHMyrxAuCE0vVg7TUufC8AyqQEpQg/OFcjWG
         3+pC85QzRaARS1g5+x1w2tCBe52czOgaZHrEDz+z5bJcMcucUB4kFyd5oK9QirRj1g4V
         7paYY0Lgfa1KlnkCq+zhDFpJEWzJZB+CtEhLLbZ7UMvCS2XRjjNSTlS5Taj52cb5lkoA
         GN0lzD134Bd1P2+sHWNB059hlhMozGjwsUcNqfFPUI4lQLE7/NLmMagcyCcXjjHHB0ys
         NicpOOR3hvfipAHIqzT5sdBIziW6QC2YRFZrZPf7GcJKy6jbjdnGIim5C2w3eXv8ll/4
         hEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jH9i7zlphLHIWzHV5awFFr8z/d7AsgmUUvnEhTzNagE=;
        b=hg5uFSsMWdsjT0IpMLpaB4A3/a0+t/w12pjQyjXxObO5ZE9ChCrWsgskN7oV7f8+RH
         tYS1uKtZW6mN9fIby29SHMSsQ5hM8SEOKebklJ5gZbo6wLJWhjHiJBUa6+DulmrXb37/
         IY16tzMsNaZgtsY+3mVZP2CrsX4cr83zDkGkz9KtE6q1pXTzL3icK1FHbDVEPcPgt0MB
         Mehs9wp0E7giGuG5MwBlgNUUqRhdulUf8kg4RjozDPch5LuqrSLw9uZzQBqL6trrxtK1
         Lqxql1lbn3jCRrN1Q/I6hs1KspCYtlMHoILEPZijp8q/DRfylbCRqYTqFN+yyKtUC2LY
         gHuw==
X-Gm-Message-State: ALyK8tJqzZ6jS6cGF2QrugKHFINYjy6y5JzBCie2ZwctuK3FRmNm2DFFRIc6D9fsXSXkwdm5FeMaVF3FXo1qUQ==
X-Received: by 10.107.44.208 with SMTP id s199mr31078075ios.0.1468902745698;
 Mon, 18 Jul 2016 21:32:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.10.97 with HTTP; Mon, 18 Jul 2016 21:32:24 -0700 (PDT)
In-Reply-To: <xmqqfur6isyr.fsf@gitster.mtv.corp.google.com>
References: <CAOiOGAcqsdMD0j_ZUdvvGiA9Bd6bUmfvxziN06Rw81f_pO7cgg@mail.gmail.com>
 <20160716051800.GA2845@sigill.intra.peff.net> <xmqqfur6isyr.fsf@gitster.mtv.corp.google.com>
From:	Parker Moore <parkrmoore@gmail.com>
Date:	Mon, 18 Jul 2016 22:32:24 -0600
Message-ID: <CAOiOGAfysmjBxcK-VwscLWBdun4rNsRs85p=foBxETvQw0J1Jw@mail.gmail.com>
Subject: Re: [PATCH] contrib/persistent-https: update ldflags syntax for Go 1.7+
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Colby Ranger <cranger@google.com>,
	Shawn Pearce <spearce@spearce.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

> The label does not even identify the version of the source in any way, so I am not sure how people are depending on that feature anyway ;-)

Would it be a better solution simply to remove this build flag?
Alternatively, if Git wished to support Go v1.5 and below, I would be
more than happy to send a patch with a dynamic lookup in the Makefile
based on the output of `go version`. I would be more than happy to
submit either patch.
