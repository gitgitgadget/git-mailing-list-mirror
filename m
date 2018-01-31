Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 126C51F404
	for <e@80x24.org>; Wed, 31 Jan 2018 23:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755904AbeAaXOk (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 18:14:40 -0500
Received: from mail-oi0-f45.google.com ([209.85.218.45]:45906 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754277AbeAaXOh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 18:14:37 -0500
Received: by mail-oi0-f45.google.com with SMTP id c189so11224616oib.12
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 15:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=mxtypjve/tVJiXULmB7kXc9+hCCS56p7zKCf06cSWHY=;
        b=FeLXkUEaUhXptWZNy1MpwtpkK9jhsG0X1a9GMRQXq3n2VOoPfpMKKVg4Mea0Tab4oX
         0agHB2qD308Y2LDVPW+TiBYgk7pzwLwp5ICB4EVh/VdhNMuIGtCXCFqTM/WNSUFdFCO6
         dL4ixKoAEsg9Bp8R3I7LrMaLpml+ohxFjRckCuIXZ9Tboqi153XR9oYkK40UgYiiP/DU
         jgjnnN79r0FOLJW5+beo4+F16WShXw1I6qG5uaYyt56kPgLZ6DYbZp1KfDDwj9Gu7Ay4
         +om56itNsmY1ESeyaB3kp0IFXvpX4E3dKXOZtYQgMLKsYV151W5fkHdbGNXG/9GD44r5
         rjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=mxtypjve/tVJiXULmB7kXc9+hCCS56p7zKCf06cSWHY=;
        b=chHKZplGALK4s0WOsGC0Q78CtzTfnJemUUUn06GiRyoLXeftc/YVSR36pJcqD55Z0u
         5GHoKyzN1HpKYl7wsFNdGL2PEgIQoGa4m66Z4aQ0EJSQT7rKtSHNmfZQs6Uminpz536l
         mTPibQ8+hjiloc7wL/B6PGQt6RntMvohPx5j60aO46RgsaAXMrgl2rZn9WfBZhVfIV/y
         NivBXjgKBlSRTBPKeTPcgSkb3gOjxPZBIJ49paV4e/k9VtrvjtzlHbH1PUqSahFOqYBM
         JPsl/53QY9mVitgpc09Rgz5FggtoKmvDt8JnEIz9J67ILJLmZeNWJLyYDVnRLsuvzrC0
         y/+g==
X-Gm-Message-State: AKwxytckuRcXgYi4nSENw6QeDxX5lg2NXW7PWD5FetXwr/Yx3zN+kUXN
        nRDqvDf2gAgA74pky2pMvktazUmWJDefu6Kxuubegw5F
X-Google-Smtp-Source: AH8x224sHHctjIzjl8zzaKVvcBkNZquoci2n0UWmWRgTsUXSXVhROxVqvjx6tmx0Uh03V9XAJZlCWfgPdAZCgtW1i8g=
X-Received: by 10.202.83.135 with SMTP id h129mr1564220oib.330.1517440476760;
 Wed, 31 Jan 2018 15:14:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.54.229 with HTTP; Wed, 31 Jan 2018 15:14:16 -0800 (PST)
In-Reply-To: <CAPm4vtnDdF31wx2VrarGk_uX9zQOubiD+LA7gsP_9qKFpqt28g@mail.gmail.com>
References: <CAPm4vtnDdF31wx2VrarGk_uX9zQOubiD+LA7gsP_9qKFpqt28g@mail.gmail.com>
From:   Hareesh Rajan <hareesh.rajan@gmail.com>
Date:   Wed, 31 Jan 2018 15:14:16 -0800
Message-ID: <CAPm4vt=oAa848JqVHeOK28+qf6KoM56_JEWzZjou7X_-fFsk3w@mail.gmail.com>
Subject: Re: Git remote helper's fast export options
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I use git remote helper to export/import repository content. Git
internally uses fast-export command and it seems like the options to
detect move and copy (-M/-C) are not being used.
Logging this issue requesting a fix to the remote helper to generate
rename and copy commands in the output dump.

Git version: 2.14.1

Thanks,
Hareesh
