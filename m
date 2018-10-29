Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBE341F453
	for <e@80x24.org>; Mon, 29 Oct 2018 03:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbeJ2MGS (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 08:06:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34390 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbeJ2MGS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 08:06:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id l6-v6so7034258wrt.1
        for <git@vger.kernel.org>; Sun, 28 Oct 2018 20:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sUgULkwMmpAwf3UDjBYk6oqpDS9peF8ILAUtZzs8GYE=;
        b=Q2VsiycjFpLRe+KO7HR/qfDvjw2NJLZ9Z6c6q7pIBWpf1i3H3/SOkb+IMmzZ9jqeTW
         3YHVS2aW3oVKaPyiSTcwYGi6gGox7f/QFulLGuQYHkO9IdylKaqj3O5vxYAqCpfnYCcF
         YzX7M4NPYQ//3QRFU3crVUwy/Y8fVDZssOsGEJlv618NsgYTohnSPkUXIrQ5fA4q3ckN
         vLtN3vregksoFU9WEu5R/NKleywG844iGWX4sb0eN7zT1uwWQUXizeij0kDfTxXcy1Id
         O6HyHvvd72P3SBb5H2AqnebjimiRIsfJ8crL0WzsAR8JhqXjabK20eu6wp7JTUi5OKzA
         7ofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sUgULkwMmpAwf3UDjBYk6oqpDS9peF8ILAUtZzs8GYE=;
        b=mkhZQ2qKIY9xlD56soANqCd2I+UGLMX1NlMVSRltBNbI66BAqV8/C3/VpqA5duxZxC
         wgrQq/btdXsBWHgPVEo9DB0MM5s35fFDNCkQh8WHWnJIdaxEl8RzYzFtSr9neFc1m9+z
         02SEtu8yXBi7eiYQ9ntV8ZB0lj8eAnAIBv73L1elULeWKRDuwOfHNsl3VXSOPpRWIfsm
         o6EnOQ0ofo+EFkeaxcC3M9Wli1UsdXYUzFbCx+oNwSW77kfnPPE/tHnQNkR0yqhN/px3
         Pk80Ifva3GKus1qy6q2bK+VHKa7fgHWW+y/+aj5v3IbMzzBnO/rZrc9xb1lVlvnhPoV4
         Wc1Q==
X-Gm-Message-State: AGRZ1gKRfZ5ECvzkRmT5WlzixzARmyELqdp1kppHnHny+njgRuQHuna0
        Bd7RJFJs/OVQH4QDRl5GzI9sJkLMCdE=
X-Google-Smtp-Source: AJdET5e6UuEEu9wK0MvVP8SkTEvq5+0Hj1d0q3PcxSzgF9LTnVXBNxp199sFjThjoE5NmQlPWAODBQ==
X-Received: by 2002:a5d:68cc:: with SMTP id p12-v6mr2336650wrw.34.1540783169704;
        Sun, 28 Oct 2018 20:19:29 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c184-v6sm8124820wma.15.2018.10.28.20.19.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 20:19:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glenn Strauss <gstrauss@gluelogic.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] update git-http-backend doc for lighttpd
References: <01020166b80743cd-0b220d55-a283-456b-a3c3-bdea8aafed8a-000000@eu-west-1.amazonses.com>
Date:   Mon, 29 Oct 2018 12:19:27 +0900
In-Reply-To: <01020166b80743cd-0b220d55-a283-456b-a3c3-bdea8aafed8a-000000@eu-west-1.amazonses.com>
        (Glenn Strauss's message of "Sun, 28 Oct 2018 00:16:15 +0000")
Message-ID: <xmqq8t2h8mo0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glenn Strauss <gstrauss@gluelogic.com> writes:

> use "GIT_HTTP_EXPORT_ALL" => "1" with a value for best compatiblity.
> lighttpd 1.4.51 setenv.add-environment does add vars with empty value.
> lighttpd setenv.set-environment does, but was only introduced in 1.4.46
>
> git-http-backend may be found at /usr/libexec/git-core/git-http-backend
>
> scope lighttpd config directives for git-http-backend under "^/git"
>
> Signed-off-by: Glenn Strauss <gstrauss@gluelogic.com>
> ---
>  Documentation/git-http-backend.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
> index bb0db195cebd6..905aa1056d26f 100644
> --- a/Documentation/git-http-backend.txt
> +++ b/Documentation/git-http-backend.txt
> @@ -192,16 +192,16 @@ ScriptAlias /git/ /var/www/cgi-bin/gitweb.cgi/
>  
>  Lighttpd::
>  	Ensure that `mod_cgi`, `mod_alias`, `mod_auth`, `mod_setenv` are
> -	loaded, then set `GIT_PROJECT_ROOT` appropriately and redirect
> -	all requests to the CGI:
> +	loaded, then set path to git-http-backend, set `GIT_PROJECT_ROOT`
> +	appropriately, and redirect all requests to the CGI:

The addition here is

	set path to git-http-backend

That reads as if you are telling the reader to do this

	GIT_PROJECT_ROOT => "/var/www/git",
	path => "/usr/libexec/git-core/git-http-backend"

because the descriptions for these two are next to each other and so
similar, but I somehow do not think you meant there is a variable
whose name is `path` (note that I do not use lighttpd and am not an
expert on its configuration---which makes me the ideal guinea pig to
judge if your update makes sense to the target audience).

Do you mean something like

	use `alias.url` to mark that `/git` hierarchy is handled by
	the `git-http-backend` binary (use the full path to the
	program).

I do not see any quoting in your updated text, but many of what the
end-user needs to type literally must be `quoted for monospace`, I
would think.

>  +
>  ----------------------------------------------------------------
> -alias.url += ( "/git" => "/usr/lib/git-core/git-http-backend" )
>  $HTTP["url"] =~ "^/git" {
> +	alias.url += ("/git" => "/usr/libexec/git-core/git-http-backend")
>  	cgi.assign = ("" => "")
>  	setenv.add-environment = (
>  		"GIT_PROJECT_ROOT" => "/var/www/git",
> -		"GIT_HTTP_EXPORT_ALL" => ""
> +		"GIT_HTTP_EXPORT_ALL" => "1"
>  	)
>  }
>  ----------------------------------------------------------------
>
> --
> https://github.com/git/git/pull/546

Thanks.
