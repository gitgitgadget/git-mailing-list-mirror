Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F82A1FAE2
	for <e@80x24.org>; Mon,  5 Mar 2018 09:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933729AbeCEJiB (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 04:38:01 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:34236 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752556AbeCEJiA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 04:38:00 -0500
Received: by mail-io0-f178.google.com with SMTP id e7so17273454ioj.1
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 01:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LSAhtSPnMt+/UGRjyXq/V8FML0Vjidqnt6xLCkY+Y+Y=;
        b=oX9DjTsHzKwe+jXJUlZijVjsgnhvgxBKYItedmRA3CZlwTIoEKifA8Sx75kiMJscp9
         RdWp3obqzyU+0sXj0ocDhnmdtKzakLY0LlUzjCVfKLs0sTKD9qt3CQu3j2TqJPqzt0sM
         SXRTXvH4INR8VIfSClcSr0KmAuZdqp4aKgBGqxPfQIVaTCcV/ox8QOi2ophUPWmknq+n
         ttOaLjTuZRpVpNOnhmSaPENINWmQNNcGZpLRvju83r1BQvCo0tseGkq6T9iVsvjj4H/u
         G38mTzQciS+j4QGoaNtYAqbHxiZb1CnTOwttPGHgavy7zjBzuc1ufQWbYhzywc7c7lyB
         PDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LSAhtSPnMt+/UGRjyXq/V8FML0Vjidqnt6xLCkY+Y+Y=;
        b=Ar1teesWgm5Gj9Mnxy5aaQmZjKaZpGH8Sa1n/GM0fF6aWgd482ynhG081Zt3vBCYdI
         g0gdwSCmBzNjxX7yZgsTc14Eh8j+3kSYTjIWP046y0cPsU3kNBmO8I1bT32gATApkg3p
         0dUTdkEL/j2aqoOYZNljvmO1Nq6rFbl70DGxtZflO2Eq5iWgELiHJGyx3J1gAPgELs8H
         Nvghcmrji6iEjABk965MIicIEzNE0K3DZHz5WigAxNPRR8G54H7mBg3UGh0V15GEFLzn
         af6JxxHVi6qg47O/Pb9UCHiCaW/k/YZwKHoNqqgNMpdZR55ll8KiHQzgzOJGJvGiF0BF
         r8WA==
X-Gm-Message-State: APf1xPBbOxQysElg5+Ajobae+d91BbAQLfEPbOkyEiZEYbyoBUuPfDKb
        /1HJiyzGO14L/qI/61x+9bthZ9s2958cY9yJHJo=
X-Google-Smtp-Source: AG47ELtT4pYsFKLpZHnXKuLdY04z2PEUilITzVS9CLT4TcLj+YjD3BJ/TxhMsUsjRFi+6UcGnyGBHJpe1xPVUifDZsc=
X-Received: by 10.107.18.158 with SMTP id 30mr17283638ios.164.1520242679733;
 Mon, 05 Mar 2018 01:37:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.157.20 with HTTP; Mon, 5 Mar 2018 01:37:59 -0800 (PST)
In-Reply-To: <CAPig+cQTpbj6q_s_pX2HjmpYF4W+5wKH7YLQQdZTiMPfK4G2Ng@mail.gmail.com>
References: <20180304112237.19254-1-asheiduk@gmail.com> <20180304112237.19254-2-asheiduk@gmail.com>
 <CAPig+cQTpbj6q_s_pX2HjmpYF4W+5wKH7YLQQdZTiMPfK4G2Ng@mail.gmail.com>
From:   Andreas Heiduk <asheiduk@gmail.com>
Date:   Mon, 5 Mar 2018 10:37:59 +0100
Message-ID: <CAFhHFBysKuDO9H4yJtnC6MJ+Jih5q4RsfwHTCsRXhXknapp4xg@mail.gmail.com>
Subject: Re: [PATCH 2/2] git-svn: allow empty email-address in authors-prog
 and authors-file
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Eric Wong <e@80x24.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-03-05 2:42 GMT+01:00 Eric Sunshine <sunshine@sunshineco.com>:
> On Sun, Mar 4, 2018 at 6:22 AM, Andreas Heiduk <asheiduk@gmail.com> wrote:
>> The email address in --authors-file and --authors-prog can be empty but
>> git-svn translated it into a syntethic email address in the form
>> $USERNAME@$REPO_UUID. Now git-svn behaves like git-commit: If the email
>> is explicitly set to the empty string, the commit does not contain
>> an email address.
>
> Falling back to "$name@$uuid" was clearly an intentional choice, so
> this seems like a rather significant change of behavior. How likely is
> it that users or scripts relying upon the existing behavior will break
> with this change? If the likelihood is high, should this behavior be
> opt-in?

I don't know nor understand the intial choice. Didn' git-commit support
empty emails once upon a time? Or is the SVN-UID important for some
SVK/SVM workflows?

My reasoning was: If authors-prog is NOT used, the behaviour
is unchanged - the UUID will be generated. If a Script IS used, then I
assume that a valid email was generated and this change will not
break these scripts. Only scripts intentionally not generating emails
will break. But again - was would be the purpose of such a script?
And such a script can be easily changed to add the UUID again.

So I think adding an explicit opt-in does not pay off.


> Doesn't such a behavior change deserve being documented (and possibly tests)?

The old behaviour was neither documented nor tested - the
change did not break any test after all.

>
>> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
>> ---
>> diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
>> @@ -1482,7 +1482,6 @@ sub call_authors_prog {
>>         }
>>         if ($author =~ /^\s*(.+?)\s*<(.*)>\s*$/) {
>>                 my ($name, $email) = ($1, $2);
>> -               $email = undef if length $2 == 0;
>>                 return [$name, $email];
>
> Mental note: existing behavior intentionally makes $email undefined if
> not present in $author; revised behavior leaves it defined.

But only if the data comes from authors-prog. authors-file is unaffected.

>
>>         } else {
>>                 die "Author: $orig_author: $::_authors_prog returned "
>> @@ -2020,8 +2019,8 @@ sub make_log_entry {
>>                 remove_username($full_url);
>>                 $log_entry{metadata} = "$full_url\@$r $uuid";
>>                 $log_entry{svm_revision} = $r;
>> -               $email ||= "$author\@$uuid";
>> -               $commit_email ||= "$author\@$uuid";
>> +               $email //= "$author\@$uuid";
>> +               $commit_email //= "$author\@$uuid";
>
> With the revised behavior (above), $email is unconditionally defined,
> so these //= expressions will _never_ assign "$author\@$uuid" to
> $email. Am I reading that correctly? If so, then isn't this now just
> dead code? Wouldn't it be clearer to remove these lines altogether?

The olf behaviour still kicks in if
 - neither authors-file nor authors-prog is used
 - only authors-file is used

> I see from reading the code that there is a "if (!defined $email)"
> earlier in the function which becomes misleading with this change. I'd
> have expected the patch to modify that, as well.

I will look into that one later.

> Also, the Perl codebase in this project is still at 5.8, whereas the
> // operator (and //=) didn't become available until Perl 5.10.

I can expand these into something like

    $email = defined $email ? $email : "$author\@$uuid";

or

    $email = "$author\@$uuid" unless defined $email;


> (However, there has lately been some talk[1] about bumping the minimum
> Perl version to 5.10.)
>
> [1]: https://public-inbox.org/git/20171223174400.26668-1-avarab@gmail.com/

Did the thread result in some actual action?


>>         } elsif ($self->use_svnsync_props) {
>>                 my $full_url = canonicalize_url(
>>                         add_path_to_url( $self->svnsync->{url}, $self->path )
>> @@ -2029,15 +2028,15 @@ sub make_log_entry {
>>                 remove_username($full_url);
>>                 my $uuid = $self->svnsync->{uuid};
>>                 $log_entry{metadata} = "$full_url\@$rev $uuid";
>> -               $email ||= "$author\@$uuid";
>> -               $commit_email ||= "$author\@$uuid";
>> +               $email //= "$author\@$uuid";
>> +               $commit_email //= "$author\@$uuid";
>>         } else {
>>                 my $url = $self->metadata_url;
>>                 remove_username($url);
>>                 my $uuid = $self->rewrite_uuid || $self->ra->get_uuid;
>>                 $log_entry{metadata} = "$url\@$rev " . $uuid;
>> -               $email ||= "$author\@" . $uuid;
>> -               $commit_email ||= "$author\@" . $uuid;
>> +               $email //= "$author\@" . $uuid;
>> +               $commit_email //= "$author\@" . $uuid;
>>         }
>>         $log_entry{name} = $name;
>>         $log_entry{email} = $email;
