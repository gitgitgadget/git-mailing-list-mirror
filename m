Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D05F01FA14
	for <e@80x24.org>; Fri, 26 May 2017 17:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753934AbdEZRuv (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 13:50:51 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34204 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752123AbdEZRut (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 13:50:49 -0400
Received: by mail-pf0-f179.google.com with SMTP id 9so17775588pfj.1
        for <git@vger.kernel.org>; Fri, 26 May 2017 10:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jc+pr5hh3XI36+fdOSZwFRmHPdSCixoujG9GmSN1+88=;
        b=dXqR7MXWU8PumuXI2z+n8kIfReXMo05FkCYQ7FJ69u/F9mNyg3osEqAdA5ig+i7ins
         g8oIgsfey75NrTlwJ3aL1pCVodp9Uz2Z3247ec652CO9MxPKvXSt/A9ESHUfsZycPDWc
         aigD+qkshNuvCgQzaaiZZ+ou1PtERtuWxEOJZZjt2vAuiMCQs6Ggt71uTYhNYPLwi2TZ
         sq8p+g0CqW3cITJ8+JcHi8gi5eEw7zqHfqTVMN+52dUgsDw3RSI7guXTHdQIsW5WRfk3
         R+R17JLVNfEbj8M7lH4uqiiAgiMIF30og6ROiGOyTwzgiY/Vv+KzgSioikgBM4rvIZ7o
         tBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jc+pr5hh3XI36+fdOSZwFRmHPdSCixoujG9GmSN1+88=;
        b=AUUUHcrcQNECf5Gq+Ylp6V0xWhgFBoMh54XyvWrPeuWZ3WerS53GylZgBjcIiQZsHX
         dSe/0jSpkEpGrmjaxPtu/bURS+/UtFXjraqksQ2TU8kTQerY51A/1eSCnAg+s9Omg11p
         5KTVJGaCwAeNBQuYqeYWqN9aoEv4RIyR9LbRikBaBUfU8bhtar4wi6B7jJkuTWJ2m0Yn
         LYO/s3Sra6oh5hdqmQYmmXiiHxhMaZ7BjisISzhOSMxTvvdb8EPRPQhXyyHZ3/o2z66t
         fQHoAfY1XZvBVxI1+iIHdAUudf48AKmqJnnyGMjbt8+LjOPD4qHYIrHOoPPHGGcWLfZq
         k+ZQ==
X-Gm-Message-State: AODbwcBP6lW43XaMQTG3uyFNZOdmQDIpqTeMbRlDG3xPa88iaDEhd5f9
        EJO3ArMNbTsPE+vkEFZv6Ee9f0NU4oGYKinkxQ==
X-Received: by 10.84.231.206 with SMTP id g14mr58613251pln.12.1495821048808;
 Fri, 26 May 2017 10:50:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Fri, 26 May 2017 10:50:48 -0700 (PDT)
In-Reply-To: <20170526031524.27935-1-liambeguin@gmail.com>
References: <fefd59fb626a9a0ddd6c9bc3a7a42d6d1016b4c3.1493414945.git.johannes.schindelin@gmx.de>
 <20170526031524.27935-1-liambeguin@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 26 May 2017 10:50:48 -0700
Message-ID: <CAGZ79kYeeCog03NHqqzZeb4Ya_m+jpQfzfG9Aa=rM5pxHpRCKQ@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] rebase -i: remove useless indentation
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 25, 2017 at 8:15 PM, Liam Beguin <liambeguin@gmail.com> wrote:
> Hi Johannes,
>
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> The commands used to be indented, and it is nice to look at, but when we
>> transform the SHA-1s, the indentation is removed. So let's do away with it.
>>
>> For the moment, at least: when we will use the upcoming rebase--helper
>> to transform the SHA-1s, we *will* keep the indentation and can
>> reintroduce it. Yet, to be able to validate the rebase--helper against
>> the output of the current shell script version, we need to remove the
>> extra indentation.
>>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>>  git-rebase--interactive.sh | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
>> index 609e150d38f..c40b1fd1d2e 100644
>> --- a/git-rebase--interactive.sh
>> +++ b/git-rebase--interactive.sh
>> @@ -155,13 +155,13 @@ reschedule_last_action () {
>>  append_todo_help () {
>>       gettext "
>>  Commands:
>> - p, pick = use commit
>> - r, reword = use commit, but edit the commit message
>> - e, edit = use commit, but stop for amending
>> - s, squash = use commit, but meld into previous commit
>> - f, fixup = like \"squash\", but discard this commit's log message
>> - x, exec = run command (the rest of the line) using shell
>> - d, drop = remove commit
>> +p, pick = use commit
>> +r, reword = use commit, but edit the commit message
>> +e, edit = use commit, but stop for amending
>> +s, squash = use commit, but meld into previous commit
>> +f, fixup = like \"squash\", but discard this commit's log message
>> +x, exec = run command (the rest of the line) using shell
>> +d, drop = remove commit
>
> do we also need to update all the translations since this is a `gettext`
> function?

Translations are handled separately, later before a release is done.
Separation of skills. ;)

As programming is quite complicated and involved we'd rather ask
Johannes to only focus on the code in such a patch here and then later
the translators will focus on getting the translation right. As the translation
tools are sophisticated, they will likely give the previous translation such
that the translators see that there is only a white space change.

But as the commit message hints at a later patch that will reintroduce the
original indentation, maybe the translators won't even see that change?

For more information on how the translations work in the git workflow,
see 951ea7656e (Merge tag 'l10n-2.13.0-rnd2.1' of
git://github.com/git-l10n/git-po, 2017-05-09) or see
https://public-inbox.org/git/CANYiYbGfDXj4jJTcd3PpXqsDN-TwCC8Dm8B9Ov_3NaSzwsrCfg@mail.gmail.com/
