Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47DEA1F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 18:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbfKMS1g (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 13:27:36 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37613 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbfKMS1g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 13:27:36 -0500
Received: by mail-pg1-f193.google.com with SMTP id z24so1888154pgu.4
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 10:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xosizF9Br+vTKKjCTAzK35geuTpSytUD39FLH9VQnL8=;
        b=KAdgvjECcqmpmwgNxB0opcvhq6gObMts2mEDBoaTgnf0q+RJOggjSL7Z2UIZNfQuXq
         cKVDANPss2qyUVFRLQBmu+bAGikx++YIWTEewjxXDdGH+GdNmDQ+7NRrwzTISQ38n0H6
         DfWYrpQSRBeW9+JxdQOPEHpwdqj9OT+3Hwrk+iOQssVznECb19MfUeRDc2VyFhgm6AIs
         5btunDeguOBdMu01aTIiymgCA+tAtxadofpGK1Maz6QNQhl8Z2vQod7DEmRWtdHziZkg
         EknBDiuOiAmfRkHDT+S+YwhV6J2N0FrFOVGP/80ngcHlqkbA2yTLvKtiktLACrMEiwzL
         kJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xosizF9Br+vTKKjCTAzK35geuTpSytUD39FLH9VQnL8=;
        b=pAuUBn3yef9O6DPOmBCcs3HB+yaadwLH7uhrIr67UxViE8wKhiaVesdK8ZsH9U6S4u
         nz8Dqu/xvSNN43l8I4BJNHVaIITdw3IjuI69XfbIlENmFS5tXRVubn8M/ioNz68oUa+F
         /ebev+w6aRbhRLQyqjh1G8Rhbl3t+6xUHVOLOhAKBilS8OI+q5TdSZ/jofQ8VNKUXSwK
         XtSO7oJYBIKe0QnDKu02E/rTLOG98QtcR5TBTNp33iDWX+eAsXvGvTLxJY6hlXDONJhQ
         EAjk5/md70ho6tLQR25lwTC0gpOIiUN+sy1w0p193K5q+9XMgwGYWphJs1DjcjMdGwMO
         UdoQ==
X-Gm-Message-State: APjAAAVNFpWkrfagJFNSIbvBF4fhF+niIgFrsQhFhXaK4AepUvJdfBUx
        e9fj7Q4YB8fc+p0Tin+K1Rr8Q/i92K7zBLvIYvA5wTiX
X-Google-Smtp-Source: APXvYqwLwip3R3XIK5gj5x0kCx/fNdDPHi8ILGhh3xdJigQTMLiOoZRPap0LH4U2Vil3n5vgvWNzWkSI6Ruwfw6PS/U=
X-Received: by 2002:a65:55c3:: with SMTP id k3mr5162280pgs.155.1573669655020;
 Wed, 13 Nov 2019 10:27:35 -0800 (PST)
MIME-Version: 1.0
References: <f867512c-e5b2-6bca-2a37-2976f4c182bd@web.de> <20191112175926.GA41101@generichostname>
In-Reply-To: <20191112175926.GA41101@generichostname>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 13 Nov 2019 19:27:23 +0100
Message-ID: <CAN0heSodNonkDK8AT9iJqmWLLCdO0OoHho0ijZOAmri5ren2dw@mail.gmail.com>
Subject: Re: [PATCH] coccinelle: merge two rules from flex_alloc.cocci
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Markus,

On Tue, 12 Nov 2019 at 19:02, Denton Liu <liu.denton@gmail.com> wrote:
> I see that you've sent many Coccinelle patches to the mailing list. It
> might be better to send them all together as a single threaded patchset
> so that reviewers will have an easier time finding all of them.

FWIW, I had the same thought.

> > This script contained two transformation rules for the semantic patch language
> > which used duplicate code.
> > Thus combine these rules by using a SmPL disjunction for the replacement
> > of two identifiers.

My knowledge of coccinelle and cocci rules is basically zero, but my
impression from this list is that running "make coccicheck" can be
expensive, both in terms of time and memory. Do these patches help there
in any way? Or could they hurt?

Martin
