Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67BA31FF6D
	for <e@80x24.org>; Sun, 18 Dec 2016 15:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753645AbcLRPQb (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Dec 2016 10:16:31 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:36012 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753104AbcLRPQa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Dec 2016 10:16:30 -0500
Received: by mail-io0-f173.google.com with SMTP id 136so135081502iou.3
        for <git@vger.kernel.org>; Sun, 18 Dec 2016 07:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vRinMCfeVvjKYj2KP09MP7nFKna9yNPlR25YliyRgRQ=;
        b=SxfHtmjshSTLBPoEgDVtHDJK9TtJ48SMZagvW30ZilUV9N2EgPcUhHP+7s0gXboXN5
         3vXZemVq5P0ZJkoqD1TOzD1vTyv5Z1n96TRf4M0WGTUBvaFRyoeS3N2e395bR6Ka0o2V
         KOLEltVjGq5ncKHklxBor4lpcpey1ieTiKSW9Z3X4XS547KFyuJCjlb7CxOvR1zmAgGh
         0YyTwCY7WmniCfaRr19zMNKnAI6ap9aNqtPupM/USZk9QmqC2jVxikSvuJ/3Yf+G3unS
         K6L50xAnjTLc3hnuNE94E5o89juumKheC2IwS6/rc5ctgv+pzllkDorj1mS5scrC1f98
         vqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vRinMCfeVvjKYj2KP09MP7nFKna9yNPlR25YliyRgRQ=;
        b=Wu2uf+7RPlKTJHP4XNk7gSBznGPNShMIw215qCrkhNUFlMVEe/pl4Io6XicMUzEtct
         B7d33owasPgMwFMvViYvj50iKblFYxrX4YQXKjX2bqNT1pEkb21BUbjI4cYUX8LdX1Ed
         nqQigVHJotIjYGCe3QphvsO5A4l5ROIhNdJlZc82zCLMNkJNvl/xb0ogfKYYzfIB2ElG
         zqHAh7FhUdjtUgBF8M+eqLFqEmSMXwM62uW0T3IukV75DGoAq62DkHytm6oll2sIcwue
         cX/yiEi1j7Lgzyij9TMRSe+/REMxhbDNQ0GbB4MqkUOHY2Fp/a7D2vek1Qho3ZefKUmE
         FOWw==
X-Gm-Message-State: AIkVDXLU0Rnu5s3ll7uF6l/W5k15MTEI0t4e9jBYXO5c/e8ceE/G1g9Uw1SQy+of9IovDg2XRF36dJBvuEoONw==
X-Received: by 10.107.31.73 with SMTP id f70mr13224781iof.232.1482074189878;
 Sun, 18 Dec 2016 07:16:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.63.215 with HTTP; Sun, 18 Dec 2016 07:16:09 -0800 (PST)
In-Reply-To: <1482063500.10858.1.camel@gmail.com>
References: <1482063500.10858.1.camel@gmail.com>
From:   Alexei Lozovsky <a.lozovsky@gmail.com>
Date:   Sun, 18 Dec 2016 17:16:09 +0200
Message-ID: <CALhvvbZSn2KVeEw5L14WQTNwo7ZhN1DY-MG31ogA1ppUMUJvVA@mail.gmail.com>
Subject: Re: Suggestion for the "Did you mean this?" feature
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18 December 2016 at 14:18, Kaartic Sivaraam wrote:
> Hello all,
>
> I have found the "Did you mean this?" feature of git as a very good
> feature. I thought it would be even better if it took a step toward by
> asking for a prompt when there was only one alternative to the command
> that was entered.
>
> E.g.
>
>> unique@unique-pc:~$ git hepl
>> git: 'hepl' is not a git command. See 'git --help'.
>>
>> Did you mean this?
>>       help
>> [yes/No] : y
>> usage: git [--version] [--help] [-C <path>] [-c name=value]
>>            [--exec-path[=<path>]] [--html-path] [--man-path] [--info-
>> path]
>> ....
>
> This would make it even better for the user as it would avoid having to
> correct the mistake long commands that had only a single error
> (considering history feature is enabled).
>
> Is this is a good idea ?

It's definitely a good thing for human users. For example, I am annoyed
from time to time when I type in some long spell, mistype one minor thing,
and the whole command fails. Then I need to press <up>, correct the
obvious typo, and run the command again.

Though, there is one aspect which may be the reason why git does not have
this feature: it requires interactive input. For example, it won't work
if some script tries to run an invalid git command. And git cannot really
tell whether it is running interactively or in a batch mode. If it is
running in batch mode then the whole script may hang indefinitely waiting
for nonexistent input. This also may apply to using git with pipes.

Maybe a configuration option or some GIT_NO_PROMPT environment variable
may be used to force disable this, but it still will be a hassle for the
scripts.
