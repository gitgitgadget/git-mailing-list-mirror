Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 381FC20798
	for <e@80x24.org>; Sat, 14 Jan 2017 12:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752233AbdANMm0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jan 2017 07:42:26 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:35099 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752221AbdANMmY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2017 07:42:24 -0500
Received: by mail-io0-f195.google.com with SMTP id m98so8176233iod.2
        for <git@vger.kernel.org>; Sat, 14 Jan 2017 04:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1VSV1BdThHCmp65gh3xtAuwdzUJ4py2hzvTSWSLX3no=;
        b=fUC+OKffCSvVErlDYHN1m0R46nqMJJo1s2aGUmdHO6tpRAcX+nt5OYFJpZtxds3js2
         TyPK1O99SxpsTJqhvLMk8fnG+8PXcJDbd6iGwy+WiSQGCAZ4QZSCn7UnA226wf/gmF+d
         o4mHGviQIqCKqmggTiXc7P9MFJZ2V/3fgBV5wnzwizfTweMWW13pJjyI0D+fCHCU3U4f
         ROEiFafiwaHSGoeSwhl5aYk5cIiDExyywsPEQjwgthu7R68Lt9cW0KK2h+hlznNaGFif
         D6grMN2qUQqYzIarG83X+JMlhPbTpZlO5LHo1EbvAkpT6nUWIwZki55OWAlrIilikhR0
         zUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1VSV1BdThHCmp65gh3xtAuwdzUJ4py2hzvTSWSLX3no=;
        b=pU+awjmBBLQW6nmk6GBwZ0YtdZH3tL5LIb4/M+IR6U/GJ2pF0xvJKS/0yF+W4bsQo3
         DrGrgZwaZe0XUpyr2iSRpQnfZiLDrC/DK7k4Gn40fNckMUOUayZINO2anPPKiPa00OMT
         2DZq/ukPYvaKeM4RhJofQjc5E6/giIHFi1fAtq5yauePA/d2ETfl3lHmRY7MD6haBnMY
         xYOaN5PnHljsOCpwbdde6zmVrbQC+12PaEpkAJY59CerFMJ6kBOKbHMn8oQij+1VqmcA
         2Mah+V0xNDwPzlZtwYlWIHwsB7Yf3dGc3C9Z7fqVepH05sRaBewONXS3+LwQq0Z63CT2
         e7kg==
X-Gm-Message-State: AIkVDXKKGnU7NtqTQoraWdxw1WbMNx9JnLVRokJM+UJ5R05Q/WQHQ6310TTLQ2XL3tc9tilu07xOqiNvraPKug==
X-Received: by 10.107.149.18 with SMTP id x18mr22405435iod.167.1484397738649;
 Sat, 14 Jan 2017 04:42:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.133.208 with HTTP; Sat, 14 Jan 2017 04:42:18 -0800 (PST)
In-Reply-To: <20170113183309.GA28002@google.com>
References: <20170113175801.39468-1-gitter.spiros@gmail.com>
 <20170113175801.39468-2-gitter.spiros@gmail.com> <20170113183309.GA28002@google.com>
From:   Elia Pinto <gitter.spiros@gmail.com>
Date:   Sat, 14 Jan 2017 13:42:18 +0100
Message-ID: <CA+EOSBm_ciQ-7bXuzn4Ba7Q5qqihaYH3Sdkkv+0M0VKWbhk=7w@mail.gmail.com>
Subject: Re: [PATCHv3 2/2] builtin/commit.c: switch to xstrfmt(), instead of snprintf,
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ok. I agree. But  is it strictly necessary to resend for this ?

Thanks

2017-01-13 19:33 GMT+01:00 Brandon Williams <bmwill@google.com>:
> On 01/13, Elia Pinto wrote:
>> In this patch, instead of using xnprintf instead of snprintf, which asserts
>> that we don't truncate, we are switching to dynamic allocation with  xstrfmt(),
>> , so we can avoid dealing with magic numbers in the code and reduce the cognitive burden from
>> the programmers, because they no longer have to count bytes needed for static allocation.
>> As a side effect of this patch we have also reduced the snprintf() calls, that may silently truncate
>> results if the programmer is not careful.
>>
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> Helped-by: Jeff King <peff@peff.net>
>> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
>
> Small nit's with the commit message:
> * Stray comma ',' of on its own
> * lines are longer than 80 characters
>
>> ---
>> This is the third  version of the patch.
>>
>> Changes from the first version: I have split the original commit in two, as discussed here
>> http://public-inbox.org/git/20161213132717.42965-1-gitter.spiros@gmail.com/.
>>
>> Changes from the second version:
>> - Changed the commit message to clarify the purpose of the patch (
>> as suggested by Junio)
>> https://public-inbox.org/git/xmqqtw95mfo3.fsf@gitster.mtv.corp.google.com/T/#m2e6405a8a78a8ca1ed770614c91398290574c4a1
>>
>>
>>
>>  builtin/commit.c | 10 ++++------
>>  1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index 09bcc0f13..37228330c 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -1526,12 +1526,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
>>  static int run_rewrite_hook(const unsigned char *oldsha1,
>>                           const unsigned char *newsha1)
>>  {
>> -     /* oldsha1 SP newsha1 LF NUL */
>> -     static char buf[2*40 + 3];
>> +     char *buf;
>>       struct child_process proc = CHILD_PROCESS_INIT;
>>       const char *argv[3];
>>       int code;
>> -     size_t n;
>>
>>       argv[0] = find_hook("post-rewrite");
>>       if (!argv[0])
>> @@ -1547,11 +1545,11 @@ static int run_rewrite_hook(const unsigned char *oldsha1,
>>       code = start_command(&proc);
>>       if (code)
>>               return code;
>> -     n = snprintf(buf, sizeof(buf), "%s %s\n",
>> -                  sha1_to_hex(oldsha1), sha1_to_hex(newsha1));
>> +     buf = xstrfmt("%s %s\n", sha1_to_hex(oldsha1), sha1_to_hex(newsha1));
>>       sigchain_push(SIGPIPE, SIG_IGN);
>> -     write_in_full(proc.in, buf, n);
>> +     write_in_full(proc.in, buf, strlen(buf));
>>       close(proc.in);
>> +     free(buf);
>>       sigchain_pop(SIGPIPE);
>>       return finish_command(&proc);
>>  }
>> --
>> 2.11.0.154.g5f5f154
>>
>
> --
> Brandon Williams
