Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CCF61F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 22:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753864AbdARWCX (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 17:02:23 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:36352 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753858AbdARWCW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 17:02:22 -0500
Received: by mail-io0-f181.google.com with SMTP id j13so23402643iod.3
        for <git@vger.kernel.org>; Wed, 18 Jan 2017 14:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Gxm4tQC2Nb+O2i+s7+tdJsMB3ED9KmEtWF+B34KbTAs=;
        b=uOB9YI8DGTSD5obq6VltUAPwU1SFb1wz8ioJFckGRT43V7j0M0HD4H858i4+LAZZM1
         oFg6DoQ+Hwgqauqi/HUc4skbdC0NWOX9o+T9VuVtiCCEMQJ4v/ZxwkYiqanvt4LcjMh1
         Gy8HdEwhGRROFBmf2xoeO5PSTA4/TRhqaH1ZMZt/jLnAA6Cl7hs566rTrKyu6d7aGbBO
         C5t1iqfQN2PchV/teqnN7kL9E3cadhDDyMIkETDA1Pt/LVWkR8C1A/BRXvbFWqiHX73n
         8beTgYnT7WHS/AlmAfxgoopVoZLDGb0oS67G/q4T1hGvo29s9nooS3JdIY7iruNwNy4z
         ycWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Gxm4tQC2Nb+O2i+s7+tdJsMB3ED9KmEtWF+B34KbTAs=;
        b=Ws6mBRJBoIU0Y8orYInxnNGFnMnJtv7b0V7Wh1Pu8k7OOztoTLzwn8vrdRaiRhPHLB
         WQNyS7bTUAiIgwxb4JTfv98TS1VAt0W0Ow3GdT6DHCT1tvc52SSCrYyMQZvDarIHyvt0
         6eFD/LhFVZrLFTIN57yyaqR3veL0TQ0ZzJsO1HNuYexzkudxkos3ed1ASDyyMrIj8kn2
         +7pXKV8Ws16RPKmzbV+AhkHrRLxS2FngMDZuzVP3Wg5HGHLjsHsDQPOxMemjUA8WVChv
         2uBbIPtk65QJ9oTs5qPFxnmMFfj+jlGW89pN0w1SyhwnOsstcshp8eiOLn1Kv7HM0Z1t
         GwQA==
X-Gm-Message-State: AIkVDXJgQQFYQkAt7DZeBhFY/CifpkLBNCLHy2vByGBpX9TSkJZ+PC0TcXQjeZcro+x4d/NSIFReA/hMcGBikfxJ
X-Received: by 10.107.3.160 with SMTP id e32mr5754518ioi.52.1484776936231;
 Wed, 18 Jan 2017 14:02:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Wed, 18 Jan 2017 14:02:15 -0800 (PST)
In-Reply-To: <xmqqk29s3wg0.fsf@gitster.mtv.corp.google.com>
References: <20170117233503.27137-1-sbeller@google.com> <20170117233503.27137-2-sbeller@google.com>
 <xmqqk29s3wg0.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 18 Jan 2017 14:02:15 -0800
Message-ID: <CAGZ79kbOEk9o=CsHcF876D+u1J+vYa64aEYWs_NdLSJmy-7TOQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] document index_name_pos
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2017 at 1:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  cache.h | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/cache.h b/cache.h
>> index 1b67f078dd..270a0d0ea7 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -575,7 +575,22 @@ extern int verify_path(const char *path);
>>  extern int index_dir_exists(struct index_state *istate, const char *name, int namelen);
>>  extern void adjust_dirname_case(struct index_state *istate, char *name);
>>  extern struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int igncase);
>> +
>> +/*
>> + * Searches for an entry defined by name and namelen in the given index.
>> + * If the return value is positive (including 0) it is the position of an
>> + * exact match. If the return value is negative, the negated value minus 1 is the
>> + * position where the entry would be inserted.
>> + * Example: In the current index we have the files b,d,e:
>> + * index_name_pos(&index, "a", 1) -> -1
>> + * index_name_pos(&index, "b", 1) ->  0
>> + * index_name_pos(&index, "c", 1) -> -2
>> + * index_name_pos(&index, "d", 1) ->  1
>> + * index_name_pos(&index, "e", 1) ->  2
>
> The above may not be wrong per-se, but it misses one important case.
> A conflicted entry in the index with the same name is considered to
> sort after the name this asks.  If there are stage #1 and stage #3
> entries for path "g" in addition to the above, i.e.
>
>         [0] [1] [2] [3] [4]
>         b#0 d#0 e#0 g#1 g#3
>
> then
>
>         index_name_pos(&index, "g", 1) -> -3 - 1 = -4
>         index_name_pos(&index, "h", 1) -> -5 - 1 = -6
>
>> + * index_name_pos(&index, "f", 1) -> -3
>> + */

Oh, I see. With this property in mind, we know that
when using index_name_pos for sorting, the stages for a
given path are ordered correctly (in ascending order,
0 comes before 1, which comes before 3).

>
> Shouldn't this be -4?  We originally have [0], [1], and [2] in the
> index, and "f" needs to go to [3], so -3 - 1 = -4, no?

yes, it should be -4.
