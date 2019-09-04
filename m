Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 956FB1F461
	for <e@80x24.org>; Wed,  4 Sep 2019 06:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbfIDGAn (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 02:00:43 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38003 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbfIDGAn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 02:00:43 -0400
Received: by mail-lj1-f194.google.com with SMTP id h3so11556822ljb.5
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 23:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=f4JtO8WPJs3YchOTyRny/ovy/VOotP/rbxCi59FzW+U=;
        b=cRzkS+d/y35of2cKQGlXi1XTULXD5gqu3kDLg1uFKyJ4zVy+E45Lg+CHxLlW0eIKfU
         yiAy0MspdI9E6TCLl742Q3DSAl6GneNQzzKDYDeX955IPjqTxrcH7zg5scJZ94uHDO9E
         IWv1m+Yq2AwFj5G6TP2ifRwXpfk1skx7ufcvLIGOev9YCIgfymZh1Q6kqT/JAhZTtLCQ
         2b2IoYi9UcD3WAYIdVheWsCzzrW3jf58qGy4eJBZK+Nl/VkuW+8u3MUMk8fO7eqlTvYM
         tnNBubUorhnbbsrMS5tey6vs4TyzJTjysadDkYoVOl2h2nNQj6yU5/SpyOf0iWqvvNtM
         ftxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=f4JtO8WPJs3YchOTyRny/ovy/VOotP/rbxCi59FzW+U=;
        b=bMbNuXNKH4eSZ5kEkRTg1MVzSaHOLyqn+cuKJ2nzC9vyU+rIK70cEFP6WCbIYBPeGk
         0ForGE+BiczFJNQoSMPaGau4mZpBNiJLjtOCJDluQtBJxbF8Xn0UjCtAStmbGllOmIz4
         z0kdUcFAubAk9A57PXhfid8IvfOjapqKvN9Pj14PNmk6miIbLrEkTYiLnbB18sHkHT3x
         d2fWejhrrid8VVaN6Nkjrh3CmsRR3Ztgw0qBYa36KKansHq4in3G5JK0OBH3tCs7OO/L
         HgbxRDCQ+OK8f4zLprkBkJ8DitAP25YwqMoC1LByZz/HIrW0312xgx2oaLswpKbS5eFa
         6yDg==
X-Gm-Message-State: APjAAAVyVceFavmmcEg0hGROvWuNYHu/Z9Nz7Mm8ASIZKbQqMxE+6m+Q
        fSj9btoDTMJhV0wPDB9vhtpv/l+3xFJwGCVyjv4=
X-Google-Smtp-Source: APXvYqyPKfM6p6IZh0u8RVTWjSogGi9JVAp6RxWQrBWPtUdTEIlV0dVqJOhHHebg5RuN9aLKyVJO1iFf2pMfz9UAk6Y=
X-Received: by 2002:a05:651c:1035:: with SMTP id w21mr1544352ljm.119.1567576841871;
 Tue, 03 Sep 2019 23:00:41 -0700 (PDT)
MIME-Version: 1.0
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Wed, 4 Sep 2019 07:58:17 +0200
Message-ID: <CAGr--=JFVK6JoribkFQHpf-JRutO9XfKcFh9_adV3T2gYjvYcQ@mail.gmail.com>
Subject: Re: [PATCH] Add hotkey to toggle "Amend Last Commit" radio selector
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,


So how does this work? Should I email the patch that Bert has created?
Or is it okay that it just remains on Github. (Considering the git
mail archives)


Birger
