Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B27151F404
	for <e@80x24.org>; Mon, 19 Mar 2018 22:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755892AbeCSWsW (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 18:48:22 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:40953 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755830AbeCSWsT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 18:48:19 -0400
Received: by mail-wm0-f50.google.com with SMTP id t6so18812022wmt.5
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 15:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zNtGpHOXWnDKG9rn8XqZ7SE/heHZLdBddnwhYfIgadM=;
        b=I2XUTZHpL5/Z6nBGQ3JktdPOUCk5g2aIPJ+pRA06FKj3ad9U/N/VQh0lxFmIh9oQxI
         DPDeog2F0hZ4SApENH7LBiew1SYCEohvLl9bcCxcEMf5IUl1nuD7Ryidq6KyQxTSXWet
         YalIM8fHRzaRm2zM7MR3/y0tWxdY3XKVD6K4NhYS3VHDEQD5j3unffnu841NDl6pdTtt
         Z+YLPEaHBO5GjH2wAQXYYRyRo9vAXhLAYiGB9dhvI12r85BcS79yBRN98yaIYiFD+4fP
         8uVozrEyrp3mZzDM1QT2yse3MkqV12d844Shu3ypOmVBpUjZ7CMbgvxIMVGbBCL67n1F
         tD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zNtGpHOXWnDKG9rn8XqZ7SE/heHZLdBddnwhYfIgadM=;
        b=tyZI7Kxt+c4PYGl6EX4DinOWbcTyuBsokr/jICsr5AdA7CUir3yj/jktizow4H9r9M
         LAD83XddHPhFxKwooPvFjU4P7uVocWIw175S1BaBjxsIelU1ggBXupwxu8lFfDgfI6Wa
         vd49acIZZOeF9eUN4RdozUMSJjBoynMAQS3JlzHclhqFBMlmTU25V/KFAEnuAcGufpxR
         oFS/hhV7qiSPLHkpELL1vWlTjMP7YpGKcu37wpKQjudV7YUTt3Jbn//R/L69nObx5gRQ
         M/pSZ/7nQFSF2fGgc8qIwxPAvZRpGjVOMyuwscpO3WJ95oGy7lhj9dIXvRyVjxkvmFK/
         jpHA==
X-Gm-Message-State: AElRT7HfFSjcBpfhqS9HY39qe0Sr/MJD75RcLb7vcwtPkIB6jaN0FAua
        t4BrvritTlXgGqTUMyMuooTl+g==
X-Google-Smtp-Source: AG47ELt4M2kdfhiGVGVDqFioBB/sKHtIypiTpakYNbCvQIC4ctc9/kFETcSQSlX1mV3BzjFFxmT1tw==
X-Received: by 10.28.127.204 with SMTP id a195mr334342wmd.58.1521499698019;
        Mon, 19 Mar 2018 15:48:18 -0700 (PDT)
Received: from ?IPv6:2001:a62:81d:ab01:6c59:1028:d507:aa62? ([2001:a62:81d:ab01:6c59:1028:d507:aa62])
        by smtp.googlemail.com with ESMTPSA id e67sm332492wmf.20.2018.03.19.15.48.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 15:48:17 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] git-svn: allow empty email-address in authors-prog
 and authors-file
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
References: <20180304112237.19254-1-asheiduk@gmail.co>
 <20180311135835.9775-3-asheiduk@gmail.com> <20180318230425.GB25017@80x24.org>
From:   Andreas Heiduk <asheiduk@gmail.com>
Message-ID: <b3fce9b7-9fc7-c5a6-eaa5-a5c12ef7d492@gmail.com>
Date:   Mon, 19 Mar 2018 23:48:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180318230425.GB25017@80x24.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.03.2018 um 00:04 schrieb Eric Wong:
> Andreas Heiduk <asheiduk@gmail.com> wrote:
>> The email address in --authors-file and --authors-prog can be empty but
>> git-svn translated it into a syntethic email address in the form
>> $USERNAME@$REPO_UUID. Now git-svn behaves like git-commit: If the email
>> is explicitly set to the empty string, the commit does not contain
>> an email address.
> 
> What is missing is WHY "<>" is preferable to "<$USERNAME@$REPO_UUID>".
>
> $USERNAME is good anyways since projects/organizations tie their
> SVN usernames to email usernames via LDAP, making it easy to
> infer their email address from $USERNAME.  The latter can also
> be used to disambiguate authors if they happen to have the same
> real name.

That's still available and it's even still the default.

But: If the user of git-svn takes the burden of writing an authors
script or maintaining an authors file then he should have full control
over the result as long as git can handle the output reasonably.
Currently that's the case for git but not for git-svn.

Git can handle empty emails quite nicely:

    > git -c user.email= commit --allow-empty -m "foo"
    > git show --format=raw HEAD | egrep "author|committer"
    author jondoe <> 1521495217 +0100
    committer jondoe <> 1521495217 +0100

Doing the same with current git-svn requires a filter-branch followed
by `rm -r .git/svn/`  followed by `git svn fetch` to recreate the
rev_map files. That would be feasible for a one-time conversion but
not in a situation where SVN is live and the master repository.

>
> "<>" is completely meaningless.
>

Not quite. The "<>" is not the only information - there is still the
mandatory "name" part. So the commit id

    jondoe <>

just means: "There is intentionally no email address." For an
internal, ephemeral repository that can be OK. It has the advantage,
that no automatic system (Jira, Jenkins, ...) will try to send emails to 

    jondoe <jondoe@6aafaa21e0fb4338a68ab372a049893d>

Additionally the log output isn't cluttered with irrelevant stuff. :-)

And last but not least we don't have to hunt down names long gone by and
already deleted in LDAP. In that case the UUID doesn't help either.


Further steps: Eric Sunshine mentioned [1] that you might have concerns about
the change of behavior per se. For me the patch is not so much a new feature but
a bugfix bringing git-svn in sync with git itself. Adding an option parameter 
to enable the new behavior seems strange to me. But there might be other ways
to achieve the same effect:

- changing the output format of the file and prog: empty emails could be 
  marked by a syntax which is invalid so far.

- OR (if some change of behaviour is acceptable) the script could evaluate
  a new environment variable like GIT_SVN_UUID to compose the 
  `<$user@$uuid>` part itself.

- OR just mention it in the relaese notes ;-)

- OR [please insert ideas here]


[1] https://public-inbox.org/git/CAPig+cQ1Si-AvazF_1Kf4yX9+eGD9tGUdvP7npJ3uYxy1pLy2w@mail.gmail.com/
