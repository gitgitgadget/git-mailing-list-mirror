Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 877FD20248
	for <e@80x24.org>; Tue,  5 Mar 2019 22:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbfCEWj4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 17:39:56 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50689 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfCEWjz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 17:39:55 -0500
Received: by mail-wm1-f68.google.com with SMTP id x7so4104157wmj.0
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 14:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=MppDUlELVAP7BYyDevdNs+Ek2dLsWQzIbhnqnNIhCMk=;
        b=FGCLs04F/prHRhVG0G7bnzLtVJWZdosude0uUygV33UBxn/tUCDmXwFjTJY93k8AZ9
         EMmzDC1BZXD5o7jIByEmX2JZYx5/mPgohsxK9TG7TkYGH2013g8gsL0wuXcIGprZYbdk
         jghFmS4OKb1D29GjqMWkTHpv8JpjjucaRCFblVwkSp+Cy54MgCz9TewaFnNg99fMDWSk
         lLeVJLcdqyBu0GySJtjZ74I4O9Xc1DDoPQQ8Im4s/DPWa+eosihjzeC980SfqG5qZVw7
         zG9I0twD9hfCkCYMVSB6KuTydTfYxT/4nTIkz5yNrXs85v64PdShqaMNmu52MPbH8cLd
         0jWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=MppDUlELVAP7BYyDevdNs+Ek2dLsWQzIbhnqnNIhCMk=;
        b=EMIPRy/K/R2COiqzdjlt5XohCQhG7M5Rv0PIRLd3/SoEFtmaJ+eoOxSHwy6q3vA0xT
         UyLHjtTyoSeeqSi+cxS0H4zE0uoI4qYdOr4P6JNcmD16q3lG+3+lOLX0koQenKURc6j2
         zhb8A1rsIYV/SLuYVsuLuNQs63thsAeXbqfs1PNAM0eyrnIXdLSVazfY+Ed0gFnCBsnn
         Jv2BTYAbM4wzwwyvbSS8h5yaUhwzQZCOIhyAdEEgf4oVIxSgPxLQPlq/7NDtdJT5wfSE
         HdekVbF+BzFk4Tu4/MzTddkaXjdG81Hxx2cSEFn4P9D+m7ruGzElNdggiXVrXoREEEq8
         GvMQ==
X-Gm-Message-State: APjAAAWXo1K3hOyKPnDOWCSyroPhTM00YvTcen8c4tX5XStnLWeOHagS
        a/g2k2rBBJgSO90bgTf7Xiar/fisqs0=
X-Google-Smtp-Source: APXvYqw2RxQc/e83FvauPM7ScPIekqLrsopWPHc2uQEXcgr/7hT8xtAaZU8S9KX1pujX0QK6yMcNeQ==
X-Received: by 2002:a1c:7ec2:: with SMTP id z185mr475124wmc.69.1551825593510;
        Tue, 05 Mar 2019 14:39:53 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y1sm10773801wrh.65.2019.03.05.14.39.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 14:39:52 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Doc: fix misleading asciidoc formating
References: <20190305214423.27820-1-jn.avila@free.fr>
Date:   Wed, 06 Mar 2019 07:39:52 +0900
In-Reply-To: <20190305214423.27820-1-jn.avila@free.fr> (=?utf-8?Q?=22Jean-?=
 =?utf-8?Q?No=C3=ABl?= Avila"'s
        message of "Tue, 5 Mar 2019 22:44:23 +0100")
Message-ID: <xmqqd0n5t07b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-Noël Avila <jn.avila@free.fr> writes:

> The end of sentence in "x." at the begining of a line misleads
> ascidoctor into interpreting it as the start of numbered sub-list.

Wow.  That's tricky.

One thing that makes me wonder is how you found it, as I do not
think this file is part of the set of Documentation/technical/ files
that are usually touched by "make doc".

> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
> ---
>  Documentation/technical/directory-rename-detection.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/technical/directory-rename-detection.txt b/Documentation/technical/directory-rename-detection.txt
> index 1c0086e287..844629c8c4 100644
> --- a/Documentation/technical/directory-rename-detection.txt
> +++ b/Documentation/technical/directory-rename-detection.txt
> @@ -20,8 +20,8 @@ More interesting possibilities exist, though, such as:
>    * one side of history renames x -> z, and the other renames some file to
>      x/e, causing the need for the merge to do a transitive rename.
>  
> -  * one side of history renames x -> z, but also renames all files within
> -    x.  For example, x/a -> z/alpha, x/b -> z/bravo, etc.
> +  * one side of history renames x -> z, but also renames all files within x.
> +    For example, x/a -> z/alpha, x/b -> z/bravo, etc.
>  
>    * both 'x' and 'y' being merged into a single directory 'z', with a
>      directory rename being detected for both x->z and y->z.
