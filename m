Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E4A42070F
	for <e@80x24.org>; Thu, 15 Sep 2016 21:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754118AbcIOVhI (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 17:37:08 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37330 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753360AbcIOVhH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 17:37:07 -0400
Received: by mail-wm0-f53.google.com with SMTP id k186so7542016wmd.0
        for <git@vger.kernel.org>; Thu, 15 Sep 2016 14:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KnpeYqsTnZfUcazNzTI57UP/YN+Jw0B8PvWEl7++n1U=;
        b=goB8THt80i2FUnCYaRFzHarEIv/aX5GnS3UbjKKxwrx99hWIZ//MGQO+YnUWopsJra
         xNH0pjkNV5SoW5tEg4unA6kO9TECQ9JZFaVroDeFGudaKsbh0y1OSqH8vE3RRrz3NRVs
         WfAUhRu4IGIITch5WiwTYfkaAAPCw07IjtpdyC2j8BtrdLIcztrsl+2VsQicFjhlXmcq
         /Lj4l12+DIeAnEiZ/Y5T6Wkk6ig1DOwbtkv1AoBzsTOrrG5wr/hYwlMRPsxnS9l1BDUc
         F7eCU6ozmQ0eALSlYN+jtcYYST0ZE8/oSqmDbYx+YLcUcc6ORvruG+aMzlYYIitTy8Uu
         BClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KnpeYqsTnZfUcazNzTI57UP/YN+Jw0B8PvWEl7++n1U=;
        b=gJzfXzm4iNG+B7mesQGeKWeFs8ojnATjGgod7BSkPnWXqyUWqF5RkvWvN9CcTuGAA4
         ZDfkpy0EXTACS5JGtRfee94/Tm3kxsy67zth665vDX8P7SUbhIrA1JKd/8LFKOkuvOVH
         mOlqkGaOeis8bjom0U83pOjUUhN5UtQG4/FIY4vXmNpv7Db0T6N//+R4N7/3n5e4Q1Ou
         rJb8ZzFxvgE0wdto8wGHyjmaCDM3JP8hRsYh9SBFig82hRwkKVCA+lxePjpkKrH7JKMY
         MoVvsn3RvJUX4wZi2FyMQK6yWNRpgnqa5eQoer5X8kMzNeZnaYnsB0JRkDtmk/37PN/H
         iytA==
X-Gm-Message-State: AE9vXwPxbpqhPd7z710oqeZ+EIcMOeylpZRmvV8Rz1WGjfmN8p2MOIMwMiNMrl5yDzEPuy9p84gXvDphjgMngDE8
X-Received: by 10.194.164.102 with SMTP id yp6mr9804267wjb.50.1473975425230;
 Thu, 15 Sep 2016 14:37:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.69.25 with HTTP; Thu, 15 Sep 2016 14:37:04 -0700 (PDT)
In-Reply-To: <CAGZ79kaCVZ-Z+XSYWK6YtkT8L=pDrDQE-pAyseHNf5w2NO5XMw@mail.gmail.com>
References: <xmqqzinbvk15.fsf@gitster.mtv.corp.google.com> <20160915205109.12240-1-gitster@pobox.com>
 <20160915205109.12240-3-gitster@pobox.com> <CAGZ79kaCVZ-Z+XSYWK6YtkT8L=pDrDQE-pAyseHNf5w2NO5XMw@mail.gmail.com>
From:   Brandon Williams <bmwill@google.com>
Date:   Thu, 15 Sep 2016 14:37:04 -0700
Message-ID: <CAKoko1qj4FS=g-H0UzeTmKNoJQyxmf5bBsQJFhJjH1hYyFtQcQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] SQUASH??? Undecided
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yeah if that is the convention then I have no problem with the change.

-Brandon

On Thu, Sep 15, 2016 at 2:12 PM, Stefan Beller <sbeller@google.com> wrote:
> + cc Brandon
>
> On Thu, Sep 15, 2016 at 1:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> If we were to follow the convention to leave an optional string
>> variable to NULL, we'd need to do this on top.  I am not sure if it
>> is a good change, though.
>
> I think it is a good change.
>
> Thanks,
> Stefan
>
>> ---
>>  builtin/ls-files.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
>> index 6e78c71..687e475 100644
>> --- a/builtin/ls-files.c
>> +++ b/builtin/ls-files.c
>> @@ -29,7 +29,7 @@ static int show_valid_bit;
>>  static int line_terminator = '\n';
>>  static int debug_mode;
>>  static int show_eol;
>> -static const char *output_path_prefix = "";
>> +static const char *output_path_prefix;
>>  static int recurse_submodules;
>>
>>  static const char *prefix;
>> @@ -78,7 +78,7 @@ static void write_name(const char *name)
>>          * churn.
>>          */
>>         static struct strbuf full_name = STRBUF_INIT;
>> -       if (*output_path_prefix) {
>> +       if (output_path_prefix && *output_path_prefix) {
>>                 strbuf_reset(&full_name);
>>                 strbuf_addstr(&full_name, output_path_prefix);
>>                 strbuf_addstr(&full_name, name);
>> @@ -181,7 +181,8 @@ static void show_gitlink(const struct cache_entry *ce)
>>         argv_array_push(&cp.args, "ls-files");
>>         argv_array_push(&cp.args, "--recurse-submodules");
>>         argv_array_pushf(&cp.args, "--output-path-prefix=%s%s/",
>> -                        output_path_prefix, ce->name);
>> +                        output_path_prefix ? output_path_prefix : "",
>> +                        ce->name);
>>         cp.git_cmd = 1;
>>         cp.dir = ce->name;
>>         status = run_command(&cp);
>> --
>> 2.10.0-458-g97b4043
>>
