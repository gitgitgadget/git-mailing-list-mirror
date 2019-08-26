Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E778B1F461
	for <e@80x24.org>; Mon, 26 Aug 2019 15:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfHZPs1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 11:48:27 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:36773 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728350AbfHZPs1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 11:48:27 -0400
Received: by mail-lj1-f178.google.com with SMTP id u15so15561995ljl.3
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 08:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=tRMn4944rb46d1WH6EmOhQdbq5ry62RnzU9DJl8zL1E=;
        b=hc9O2eVaoQjkObmhOUM7LdTI57OP40c7N8Tr7hNsaG/9tCy7d3cd11l2N79GrhYYqj
         9I/6s4NECEj1InekOIZScnPkK3LnGbCWJm13JDbn6u2VMEYrCgmqAHGPtH92Q3FfXA7j
         OAS1Nf3Wbvi/iRvKOtVL8TCMixRv/n87wH3iUojplhFTM0bI3Pc+xuT3Km/lYJO4wN5e
         YebGEdNMYm48qCxDy1RCZl3g1vlLQstTfZC7Lh6JQ2GOXmFvc1DC57CEiB6I0WVumh57
         swQ+QkF+mx3jPzRVJvhdFYV0z91VEVkp+krgudBWW6fI1rInF+mka7g+GcDKutZFDH2f
         RNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=tRMn4944rb46d1WH6EmOhQdbq5ry62RnzU9DJl8zL1E=;
        b=rH5v/t05NDN4evx2gh6bkNjEPnW2vT1SAhsr8G2BhCQ+GFRFUmF2ga1S+VL4QtSHqa
         UjxbmrJFgBNdcOoQEZtsZlQypSj3v8+r7UXUDBnJQjjjRW2ORGhOXLJX0HsRwJuo5shQ
         tAG4p0/XqyrhiDg3TCBuhTxCdOi8SIfhiwIS3EdDqZW84+wmf74fUtAczxjHz2SsIpL/
         B0b63maHzYkE21lvhvvUcXzn7zx/E+h8AjAyhqvIQUJRiiTPq+uQoIotlzVYswOSLv6g
         o/GhIqroNioSNOvdzvzaZoGMrSaylvdruVtGQEpKnmSgLci43iAzCTVRZztKMiM6qjnA
         TMxw==
X-Gm-Message-State: APjAAAU2e0YpUvU1blJFIGcJppeTR8T7wKaJN3Jly+s3mN7aJOMI7HMU
        zBukOTmd4aI61pkzD8QgXl5s2q/UFuDQOwV9tuaM/XAI
X-Google-Smtp-Source: APXvYqzpv9S0xbe2/7EILgce6cVfuTaSFie6jwmJ3WLxKa6tyTwMTE7eZoOj6HzqrAd/RVEdGI8lzjpliBnHXPDGgAE=
X-Received: by 2002:a2e:914c:: with SMTP id q12mr11083004ljg.34.1566834505134;
 Mon, 26 Aug 2019 08:48:25 -0700 (PDT)
MIME-Version: 1.0
References: <CADSGPzV+dfNR=epmz2whKkrpiH=JMUR4gVjpZ+x+kzKrX0kD-A@mail.gmail.com>
 <20190818024757.765fx3tdfekseim5@LykOS.localdomain> <CADSGPzU6+AdMtrEnc98SHASmcmxGsj52Y99Dd5zvkOeRqWS-jQ@mail.gmail.com>
In-Reply-To: <CADSGPzU6+AdMtrEnc98SHASmcmxGsj52Y99Dd5zvkOeRqWS-jQ@mail.gmail.com>
From:   Dhaval Patel <drdhaval2785@gmail.com>
Date:   Mon, 26 Aug 2019 21:18:12 +0530
Message-ID: <CADSGPzVgweL4tCEqg3LvfXbp=HZyQ7BngKpVrFp0_0SFJZVezQ@mail.gmail.com>
Subject: git diff autocomplete
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If it is only about files and revisions both being handled by git
diff, would it not ne possible to do something like this?

For files

git diff -f a[PRESS TAB]

For revisions

git diff -r a[PRESS TAB]

Some sort of flag which says we are handling files or revisions.
