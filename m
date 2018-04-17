Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62E981F513
	for <e@80x24.org>; Tue, 17 Apr 2018 02:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbeDQCXB (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 22:23:01 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43348 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751172AbeDQCXA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 22:23:00 -0400
Received: by mail-wr0-f194.google.com with SMTP id y7so31063358wrh.10
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 19:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=24Su3VXl+F5a2HvfnAlTvB0p/cVOi05RCUkrybGw2E8=;
        b=HuuvPlIO05c4/gTM8oL2pIQQZUPz+tEqrpqOnHzsxF3mU+G2AgYqvPeKlRNEcWPYvL
         70sn3nM0K9F41pRsyMwD2aXUE9b5MfWpoVMQLT6Z4tzEVeUKfRdos4n9Ttx+XLwXswlh
         aWKh/XUZ2ZffbatOa0JGt37OoapE6emZ9IyNQbmqlsKFfR53qxi8cggr0jcvfWRCMlIQ
         MRmW+g5ZpEdlYLXzjvixbsrvUsW1E57+4JwABoSFdUUdGpJqQuO7kGjN9SX8++iGIilW
         HNWAKMP7MHz2X8ib4jE1GxIknZcVVgp2rCxB02pQ7xe7zm6LTS6/Tyb2BTEY8X+KzMOe
         yPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=24Su3VXl+F5a2HvfnAlTvB0p/cVOi05RCUkrybGw2E8=;
        b=kHCDm1+ynpLW0MFkN8D9xOGIqky/5zaBfNpxsiRxCe6IptnXq98aK6t43bhht96Avn
         5kGWtns9Hi4cEUgeEps6m0fNh4/useLPM+CmpV2N+ARtBXcAcWMwsCPFO3zsmIM6/oYn
         AaWEJ5PpIotIupKjcwBjsLEonjgUUNrg8MFszDr8351x8PbChDJGUs6889Zz0mVgy9i3
         aHNSKe2gEvHJBMYm0GKIxUftIFHRtfPV5t8ArupFF+urkSIuDa1PXo8eqq5P4UvnfDEN
         1E7Rfz6yRjpto0L2KO4h91ilSCpz03iM9qnvxHhfv7kINpLxcSTzvSlqQOxCBoKkcH+l
         DBqg==
X-Gm-Message-State: ALQs6tC01m8ZV8WhT+OS0/VAxDE6+IhkZFxswQiBRXkyMwR6qYghOnoL
        KKeRi/UzR8DoJ53hIYZSeN8Pck1o
X-Google-Smtp-Source: AIpwx4+HJHujyBt8dW66lOH3F1yXyscYYTmKTb93UTNYzU48akiu1DLJNiNs7aY2mOcHBrjeZaQByg==
X-Received: by 10.223.158.201 with SMTP id b9mr110479wrf.215.1523931778758;
        Mon, 16 Apr 2018 19:22:58 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y9sm15283067wrg.46.2018.04.16.19.22.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Apr 2018 19:22:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] glossary: substitute "ancestor" for "direct ancestor" in 'push' description.
References: <87muy31zbf.fsf@javad.com>
Date:   Tue, 17 Apr 2018 11:22:57 +0900
In-Reply-To: <87muy31zbf.fsf@javad.com> (Sergey Organov's message of "Mon, 16
        Apr 2018 08:43:16 +0300")
Message-ID: <xmqqwox6vaf2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Even though "direct ancestor" is not defined in the glossary, the
> common meaning of the term is simply "parent", parents being the only
> direct ancestors, and the rest of ancestors being indirect ancestors.

Makes sense.  If there were distinction among parents of a single
child, perhaps a direct ancestor might be a term to refer to an
ancestor that is reached by following only the special kind of
parent (rather than "side" ancestor that involves at least one hop
of other lessor kind of parent), but there isn't anything like that
in the system, so there is no need to use a confusing and undefined
term here in the documentation.

> As "parent" is obviously wrong in this place in the description, we
> should simply say "ancestor", as everywhere else.

Yup.  Great.

>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  Documentation/glossary-content.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index 6b8888d..6c2d23d 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -463,7 +463,7 @@ exclude;;
>  [[def_push]]push::
>  	Pushing a <<def_branch,branch>> means to get the branch's
>  	<<def_head_ref,head ref>> from a remote <<def_repository,repository>>,
> -	find out if it is a direct ancestor to the branch's local
> +	find out if it is an ancestor to the branch's local
>  	head ref, and in that case, putting all
>  	objects, which are <<def_reachable,reachable>> from the local
>  	head ref, and which are missing from the remote
