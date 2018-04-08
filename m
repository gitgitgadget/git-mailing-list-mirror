Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C43BA1F404
	for <e@80x24.org>; Sun,  8 Apr 2018 23:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752668AbeDHXRy (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 19:17:54 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34128 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752479AbeDHXRx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 19:17:53 -0400
Received: by mail-wm0-f68.google.com with SMTP id w2so15134364wmw.1
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 16:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=4S/fPfjXQxRo923J/kQXpvvgNKV+c38VACaCLpONstM=;
        b=Or6HmukNh05tufBImHy+2PI6VgqSHqAf2LSq+X2hNG+gKmSJBiQ0fkI4UOx3fCpj1b
         P3JtsjFNIRKj9ztyqzXqGS0Jq/B6fpxaIW64QcQKa4IkQYgGsvxph8uVoNWDmNWKlmEH
         GTraVaHdJIwlQ2ttsL6mgBYdOvDFLIF9EX4rSVgak3azdsTymhwOUZFaRIAS9E5aQFla
         w0iROKwO6Kq/hPRSwZi0mDhKCb7v7EZCH6eYRVYAgvV0shQYEqyLChxUqiFCYDKQozIs
         juZq5EzNz887ZmGL89V3gMLkYeXpIB8/MtOB4PFwgly8C1xYaQ584KH8pduOcM4I9rGj
         d/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=4S/fPfjXQxRo923J/kQXpvvgNKV+c38VACaCLpONstM=;
        b=b4hMXprrJ59ha72eDVMv+bcD5TQGqDEqbpry+JtB5NqhzvYZmApVQnQEP3NhsMgfuX
         9hQkTQCaoO88o4xWql64OeULhBxgGS8FdRMSLGonUjXLjV56CGoCNnwNk8y3VIWV12Nr
         M05vkoYke+HrYmK62NbEVDDZr61Mq/tMDGf9FHCrDhzkvG4GZAKSPLIXKVQAUP/KQjZ+
         ZMevzs8PeKw3Tpg4EIHvMD/xhBmvEwD/DB9k0vWhLCpXZyN1pVk9Lu1leLVDaLKvHrXr
         SHzO+9q86Quu1lRZ5gWGU8DiZXITIAU49SDJV7QpbsyHagcpXNBBy2PLqK4P5bfNY9zU
         wdKg==
X-Gm-Message-State: AElRT7ExxypfYAetAeBeVUePvtd19/7rw7QX5XNOvIRmyALfJC0mH8kZ
        0C/epSZLH3jU5nkefPlqBCs=
X-Google-Smtp-Source: AIpwx496vqA8y7I2lutSGfMwJmhhw/ZvB1Rm884UUASZAgu6QGvvFeFtEoSyEbGOd4ZeZ5+xmimm1w==
X-Received: by 10.28.153.12 with SMTP id b12mr20239539wme.104.1523229472205;
        Sun, 08 Apr 2018 16:17:52 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i44sm475104wri.17.2018.04.08.16.17.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Apr 2018 16:17:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stephon Harris <theonestep4@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] specify encoding for sed command
References: <0102016293c8dca7-6626fcde-548d-476e-b61f-c83ecdeedfe1-000000@eu-west-1.amazonses.com>
Date:   Mon, 09 Apr 2018 08:17:51 +0900
Message-ID: <xmqqd0z98ezk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephon Harris <theonestep4@gmail.com> writes:

> Fixes issue with seeing `sed: RE error: illegal byte sequence` when running git-completion.bash
> ---
>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index b09c8a23626b4..52a4ab5e2165a 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -282,7 +282,7 @@ __gitcomp ()
>  
>  # Clear the variables caching builtins' options when (re-)sourcing
>  # the completion script.
> -unset $(set |sed -ne 's/^\(__gitcomp_builtin_[a-zA-Z0-9_][a-zA-Z0-9_]*\)=.*/\1/p') 2>/dev/null
> +unset $(set |LANG=C sed -ne 's/^\(__gitcomp_builtin_[a-zA-Z0-9_][a-zA-Z0-9_]*\)=.*/\1/p') 2>/dev/null

Shouldn't LC_ALL and LANG both set and exported to C, as

 (1) ancient systems understand only LANG but not LC_*; and

 (2) modern ones that understand both give precedence to LC_ALL over
     LANG?

If we were to set only one, it is probably more sensible to set
LC_ALL, I suspect, but it may be better to set both, which sends a
sign to the readers that we know what we are doing ;-)

