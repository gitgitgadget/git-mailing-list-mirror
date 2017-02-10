Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8D651FCC7
	for <e@80x24.org>; Fri, 10 Feb 2017 01:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751327AbdBJBq7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 20:46:59 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34551 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbdBJBq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 20:46:58 -0500
Received: by mail-pf0-f194.google.com with SMTP id o64so365956pfb.1
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 17:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ybivvNwtc1glJHSMZC1tTc56yMrkM2WbjGwIp2fdU5w=;
        b=i/v38UmIIjkJhwwfNZ2h8SDn4zpVITdUUOL0vRx1Dz6QQN0v0ft70AxPAsrrRELQIF
         M9+8uFd2K/6fh23ZhzuL47R9hKYlsDy4hpeoyX+AlY4jab+HgcPqJd+2SAaIbYnZKM5v
         tdu6X1Le43Z6YM5wdmo9hDtlQkyvW2j584Op/T7nDL8/3y9w/eb+jsZ9w9AMzg4gxZ8H
         emdPQowdDLU5ACruG6IvvhUs7BzxwFby9lmPlw03Ss2LO3bnkPKu029r2GTqcW+BBtPE
         2Wu9UC8M2YoPcLRYxJ1PuuzootA/68XTnkaVToenX0Y/P640o/+8HIhwauY2QKGBquU5
         k8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ybivvNwtc1glJHSMZC1tTc56yMrkM2WbjGwIp2fdU5w=;
        b=QOR+D+QSjYclEwBQXaMlp3mEaNhWAmmpVYenNh8Y9dxBpPIoeG2QUfk16ghM339lzc
         /VkSWAYdwPceXfEYeyUeMEBuIGHAYoeqI5fuDI3V+vTB2VorJ3mhYi59zIqTQzLiKslV
         FMAe9eXR6aLgxkJ6qZBPhflrvTaQbL1npruXYKJVjhfajwPe4QK3bQ9JeDAiUgZAmFRt
         9JfSoMOEhcMQFn6NukdWhN/Pmtk3u+FepVD1RCSn+KzxHJn03NRxkYPMVL4NFeaoq412
         QzBIS1VNsugM189l72r6sf8kd6n6kWdiZpBObllJzdil2zs2c1HMJwPE242BXD1sWImy
         WJfg==
X-Gm-Message-State: AMke39mGUDkatqIzYYFsSdUrSEGRYvZXXq8VxYftVy5oAgv0jadi1fqpIu8jFL6IBB80sw==
X-Received: by 10.84.143.131 with SMTP id 3mr7949030plz.56.1486691218078;
        Thu, 09 Feb 2017 17:46:58 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:704f:61dd:c9f4:9782])
        by smtp.gmail.com with ESMTPSA id u75sm175658pgc.31.2017.02.09.17.46.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Feb 2017 17:46:57 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tom Kunze <mail@tom-kunze.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] help: show help for aliases
References: <137f35a4-ec2e-b8aa-c6a5-b17688eca61a@tomabrafix.de>
Date:   Thu, 09 Feb 2017 17:46:56 -0800
In-Reply-To: <137f35a4-ec2e-b8aa-c6a5-b17688eca61a@tomabrafix.de> (Tom Kunze's
        message of "Fri, 10 Feb 2017 01:17:53 +0100")
Message-ID: <xmqq7f4yn7fz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tom Kunze <mail@tom-kunze.de> writes:

> If an alias is a single git command show the man page of the
> aliased git command with --help.
>
> Signed-off-by: Tom Kunze <mail@tom-kunze.de>
> ...
> diff --git a/builtin/help.c b/builtin/help.c
> index 49f7a07..655ed49 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -437,6 +437,10 @@ static const char *check_git_cmd(const char* cmd)
>
>  	alias = alias_lookup(cmd);
>  	if (alias) {
> +		if (alias[0] != '!') {
> +			strtok(alias, " \t\n");
> +			return alias;
> +		}

While I understand where you come from, I am moderately negative,
especially with that strtok() to ignore options.

For a truly simple alias, e.g.

    $ git co --help
    `git co' is aliased to `checkout'

I do not think I would mind the updated behaviour given by this
patch that much.

But most of the time, when I do "help" on an alias, I am primarily
interested in what default customization I am using over the base
command, i.e.

    $ git lgf --help
    `git lgf' is aliased to `log --oneline --boundary --first-parent'

is my way to remind me that I am using these three options to "git
log" in the alias I very often use (and forgot what they were).

Jumping directly to the "git log" manual page is the last thing I
want "help" to do.
