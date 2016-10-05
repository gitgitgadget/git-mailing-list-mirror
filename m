Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBCF11F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 19:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754601AbcJETiy (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 15:38:54 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34625 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932679AbcJETit (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 15:38:49 -0400
Received: by mail-pf0-f176.google.com with SMTP id e6so36512554pfk.1
        for <git@vger.kernel.org>; Wed, 05 Oct 2016 12:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=J1ytCdmIz6rVb49H6ekqfM6siiKkqxaRWixuCiKJ0ec=;
        b=HZYZwF1rsDll+A8QUhqRVLi9IwPWykHx6sEA+p/Ifxv91qEfjajbjPF6V0QZ2ON8qF
         XXeEuXDMsN+6aZwL5Doh+8NwKyR7uagQxjy3V9Hnb50U97GZc9z7V9lNDuuUh3DUScFH
         J647ihO8q3buNtjVMG4r/5yI/B1ZQWJRsswpgSi+yzTfJPkBI7MISOhMNnn9QQWawEF7
         nsBC18zBJSOp+kh3ZQr+a/k9Unq35LboBqGNbdYC4eE96nqCd4ccc9lh8frMnC4GPkQn
         CTwQgdSAcSiGDvHpzFgULriffNpT+cSrRhZ5dfugL/gPsgniRGsKf3U6M/O5HLeEAdD5
         gmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=J1ytCdmIz6rVb49H6ekqfM6siiKkqxaRWixuCiKJ0ec=;
        b=ZBT5G+psKj39Teb/ns3OyMajxDPUxTGthwsDwHTfvX73bAjB/5nZZgdtKtPCJD9Zfh
         onq3yD3F8PgBT83veXR7st5NJXovifSC6trZZcoByqyOnFqTt7hf0glWOxrnRm6MyFE5
         DetJPrPGcxAJkhvv/999L+wPa9Bao//D70L+pcEh9tqRFowogahERWxAVHBrRRK/G1AO
         td9ui2qhhShsZX0iv71/ClQ75d4LZ8/xzkmK2WpGTtqs30EV2v8dGqBLgvYdVmncEfqd
         CgBNWjdw+NMTWcwYuj3sY0YxpzHSB/jgTbQiw4VRdSicmNuoXnDfjMrFOlaKwjwnna8x
         tZHw==
X-Gm-Message-State: AA6/9Rlf9trh8Ff2Hi1Nlgf62ZUyRYez37TYvAyd8GZNQ2ivet5JzO2nLanzj90oVZsEXF/O
X-Received: by 10.98.56.147 with SMTP id f141mr9721389pfa.83.1475696328913;
        Wed, 05 Oct 2016 12:38:48 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:6000:6149:f0e1:de76])
        by smtp.gmail.com with ESMTPSA id i13sm52109930pfi.47.2016.10.05.12.38.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Oct 2016 12:38:47 -0700 (PDT)
Subject: Re: [RFC/PATCH 0/2] place cherry pick line below commit title
To:     Junio C Hamano <gitster@pobox.com>
References: <cover.1475176070.git.jonathantanmy@google.com>
 <xmqqtwcycqul.fsf@gitster.mtv.corp.google.com>
 <11e41a94-df8c-494a-584b-e2bc8da2de3a@google.com>
 <xmqq8tu99o75.fsf@gitster.mtv.corp.google.com>
 <xmqqtwcx8669.fsf@gitster.mtv.corp.google.com>
 <e03fdabd-6690-5244-5f79-1715b0364845@google.com>
 <xmqqbmz16y42.fsf@gitster.mtv.corp.google.com>
 <d3df0636-1975-1d08-2f34-384984c72e5d@google.com>
 <xmqq8tu55bel.fsf@gitster.mtv.corp.google.com>
 <84f28caa-2e4b-1231-1a76-3b7e765c0b61@google.com>
 <xmqqwphouivf.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <a7304731-fa05-92c2-6139-ecd1e6adcefd@google.com>
Date:   Wed, 5 Oct 2016 12:38:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqwphouivf.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/04/2016 10:25 AM, Junio C Hamano wrote:
> So I would say it is perfectly OK if your update works only for
> cases we can clearly define the semantics for.  For example, we can
> even start with something simple like:
>
>  * A RFC822-header like line, together with any number of whitespace
>    indented lines that immediately follow it, will be taken as a
>    single logical trailer element (with embedded LF in it if it uses
>    the "line folding").  For the purpose of "replace", the entire
>    single logical trailer element is replaced.
>
>  * A line that begins with "(cherry picked from" and "[" becomes a
>    single logical trailer element.  No continuation of anything
>    fancy.
>
>  * A line with any other shape is a garbage line in a trailer
>    block.  It is kept in its place, but because it does not even
>    have <token> part, it will not participate in locating with
>    "trailer.where", "trailer.ifexists", etc.

Sounds reasonable to me. Would the "[" be a bit of overspecification, 
though, since Git doesn't produce it? Also, identifying it as a garbage 
line probably wouldn't change any behavior - in the Linux kernel 
examples, it is used to show what happened in between sign-offs, so 
there will always be one "Signed-off-by:" at the top.  (But I do not 
feel strongly about this.)

> A block of lines that appear as the last paragraph in a commit
> message is a trailer block if and only if certain number or
> percentage of lines are non-garbage lines according to the above
> definition.

I think the number should be 1 - that seems like the easiest to explain. 
But I'm OK with other suggestions.

> I wonder if we can share a new helper function to do the detection
> (and classification) of a trailer block and parsing the logical
> lines out of a commit log message.  The function signature could be
> as simple as taking a single <const char *> (or a strbuf) that holds
> a commit log message, and splitting it out into something like:
>
>     struct {
> 	const char *whole;
> 	const char *end_of_message_proper;
> 	struct {
> 		const char *token;
> 		const char *contents;
> 	} *trailer;
> 	int alloc_trailers, nr_trailers;
>     };
>
> where
>
>  - whole points at the first byte of the input, i.e. the beginning
>    of the commit message buffer.
>
>  - end-of-message-proper points at the first byte of the trailer
>    block into the buffer at "whole".
>
>  - token is a canonical header name for easy comparison for
>    interpret-trailers (you can use NULL for garbage lines, and made
>    up token like "[bracket]" and "(cherrypick)" that would not clash
>    with real tokens like "Signed-off-by").
>
>  - contents is the bytes on the logical line, including the header
>    part
>
> E.g. an element in trailer[] array may say
>
>     {
> 	.token = "Signed-off-by",
>         .contents = "Signed-Off-By: Some Body <some@body.xz>\n",
>     }

I get the impression from the rest of your e-mail that no strings are 
meant to be copied - is that true? (That sounds like a good idea to me.) 
In which case this might be better:

   struct {
     const char *first_trailer; /* = end_of_message_proper */
     struct {
       const char *start;
       const char *value;
       const char *end;
     } *trailers;
     int trailers_nr, trailers_alloc;
   };

start = value for "[", "(cherry picked from" and garbage lines. We also 
need end because there is no \0 there (we didn't copy any strings).

The existing code (in trailer.c) uses a linked list to store trailers, 
but an array (as written in your e-mail) is probably better for us since 
clients would want to access the last element (as also written in your 
e-mail).

> With something like that, you can manipulate the "insert at ...",
> "replace", etc. in the trailer[] array and then produce an updated
> commit message fairly easily (i.e. copy out the bytes beginning at
> "whole" up to "end_of_message_proper", then iterate over trailer[]
> array and show their contents field).  The codepaths in the core
> part only need to know
>
>  - how to check the last item in trailer[] array to see if it ends
>    with the same sign-off as they are trying to add.
>
>  - how to append one new element to the trailer[] array.
>
>  - reproduce an updated commit log message after the above.

I don't think we need trailer block struct -> commit message conversion 
- when adding a new trailer or replacing an existing trailer, the client 
code can just remember the index and then modify its behavior 
accordingly when iterating through all trailers. But this conversion can 
be easily added if/when we need it.

 > Hmm?

Overall, this seems like a good idea - I'll go ahead and do this if 
there are no other objections.

It just occurred to me that there could be some corner cases when the 
trailer separator is configured to not include ":" - I'll make sure to 
include tests that check those corner cases.
