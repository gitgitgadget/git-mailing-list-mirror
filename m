Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3194C1FBB0
	for <e@80x24.org>; Sun,  4 Sep 2016 08:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752226AbcIDI3h (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 04:29:37 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:38617 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752082AbcIDI3e (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 04:29:34 -0400
Received: by mail-it0-f49.google.com with SMTP id c198so105918679ith.1
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 01:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9TSf2RTVqAhainTKQoiuGAyyI4DqQMqY2PdvtFt+CPA=;
        b=NJzAbCaiqAHsEeEXGi8wBjQfn5YBnQATYOxjGg78y1646wAHy4CW1zNT4mdKMVeZYP
         CXWs5N+5LBj/7WpW1ZIVFfyWwRKu7+VRSnaVcDK1N71C8c0D/vuHIBJkUOZUecW0eWNF
         t6Kn8hHQLpq1hrw48BDiKI7hyTVi8+jQaadKtiyTVbPco4SbI85BlXJYS/2JvqG4bSlj
         ru4RvPr23F41XpnAnLzZbM9JZDDVK2z7G8/nVqKZshnL7U9tqEO2sO/+75ZCQmDVkUO7
         2SqwaSBcJqzIZ7F3NGxbPEmPcaL3QkMuACcxbVUxJwhl3x2qhsh7lJFqd/WsyznSBWt3
         q7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9TSf2RTVqAhainTKQoiuGAyyI4DqQMqY2PdvtFt+CPA=;
        b=gWIOdMG+ZYVj47lZArlD3B3clvGX1EAwN6BMeTl0/h1TB/pyWxgw07A7b7LLWgBFpm
         yIaYn6hpXqpBeflOk5sPdBFc6QnfXs3kDX0yNR3wsHScmvxSUJdcCUjiBU6ycCeTP80Y
         8yQsJu3BnX8+h1iHHFQJ3DsaW4eF1vBahBzk6cQjgwXvcanAO/GyujOGEGl/Uw03deBL
         Djc2QTYX+n1MOeGAmA5ycHKfNQXqNx3a38JZAPKeLi+OAJDmBgIpIFuiYczMleRP4JwJ
         NZLfeV9/Y2sH/qyOM08/mqr6XOTeva+wJ9cWiWGzPRUrVS5mwvqfbJC5rl+fy+/p9RTF
         FNhQ==
X-Gm-Message-State: AE9vXwM/uw8vXyH/UAmFw4ztdiYME5kIDazQ89u1QcnpUW4ic6s7UR7Sxf491eN2xnKfFWXYQ3LpWoP1wCyPFjz0
X-Received: by 10.36.127.7 with SMTP id r7mr14396749itc.49.1472977739212; Sun,
 04 Sep 2016 01:28:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Sun, 4 Sep 2016 01:28:58 -0700 (PDT)
In-Reply-To: <xmqqpookqi8k.fsf@gitster.mtv.corp.google.com>
References: <20160903033120.20511-1-sbeller@google.com> <xmqqtwdxqxh6.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYGnkcOxviukj9a8gyaERip5aunXcvsdH-UpBCb=vrVeQ@mail.gmail.com> <xmqqpookqi8k.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Sun, 4 Sep 2016 01:28:58 -0700
Message-ID: <CAGZ79kZp1EeDYDNiFGVLYbth8gRAe8=WLP=i1YeUwM-1TX4B9g@mail.gmail.com>
Subject: Re: [RFC/PATCH 0/2] Color moved code differently
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 3, 2016 at 11:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>>  * On 2/2, doing it at xdiff.c level may be limiting this good idea
>>>    to flourish to its full potential, as the interface is fed only
>>>    one diff_filepair at a time.
>>
>> I realized that after I implemented it. I agree we would want to have
>> it function cross file.
>>
>> So from my current understanding of the code,
>> * diffcore_std would call a new function diffcore_detect_moved(void)
>>    just before diffcore_apply_filter is called.
>> * The new function diffcore_detect_moved would then check if the
>>    diff is a valid textual diff (i.e. real files, not submodules, but
>>    deletion/creation of one file is allowed)
>>    If so we generate the diff internally and as in 2/2 would
>>    hash all added/removed lines with context and store it.
>
> I do not think you should step outside diff_flush().

After looking further into it, I think we need to step outside
or at the very least deep down in the xdl cellar from there,
because we need the context around the line both in the
pre and after image.


>  Only when
> producing textual diff, you would have to run the textual diff
> twice by going over the q twice:
>
>  * The first pass would run diff_flush_patch(), which would call
>    into xdiff the usual way, but the callback from xdiff would
>    capture the removed lines and the added lines without making any
>    output.

The callback doesn't have the context around one line as easily
accessible as the xdl emit function, so rather we'd pass in a flag,
i.e. the hashmap where to store the added/removed lines or NULL.

Both passes (the first to find and the second enhanced pass that
outputs the lines) need to have access to the context of the respective
file.

>
>  * The second pass would run diff_flush_patch(), but the callback
>    from xdiff would be called with additional information, namely,
>    the removed and the added lines captured in the first pass.
>
>  * I suspect that the fn_out_consume() function that is used for a
>    normal case (i.e. when we are not doing this more expensive
>    "moved to/moved from" coloring) can be used for the second pass
>    above (i.e. the "priv" aka "ecbdata" may need to be extended so
>    that it can tell which mode of operation it is asked to perform),
>    but if there is not enough similarity between the second pass of
>    this "moved from/moved to" mode and the normal mode of output, it
>    is also OK to have two different callback functions, i.e. the
>    original one to be used in the normal mode, the second one that
>    knows the "these are moved without modification" coloring.  The
>    callback for the first pass is sufficiently different and I think
>    it is better to invent a new callback function to be used in the
>    first pass, instead of reusing fn_out_consume().

The callback doesn't have easy accessible data IMHO,
e.g. we may get these lines in the callback:

(function context not required:)
---8<---
 {
        int i;
        for (i = 0; i < GIT_SHA1_RAWSZ; i++) {
-               unsigned int val;
-               /*
-                * hex[1]=='\0' is caught when val is checked below,
-                * but if hex[0] is NUL we have to avoid reading
-                * past the end of the string:
-                */
-               if (!hex[0])
-                       return -1;
-               val = (hexval(hex[0]) << 4) | hexval(hex[1]);
-               if (val & ~0xff)
+               int val = hex2chr(hex);
+               if (val < 0)
                        return -1;
                *sha1++ = val;
                hex += 2;
---8<---

And for the first + line (int val = hex2chr(hex);) we need
to hash that line and 2 (made up threshold) before and after:

---8<---
        int i;
        for (i = 0; i < GIT_SHA1_RAWSZ; i++) {
               int val = hex2chr(hex);
               if (val < 0)
                        return -1;
---8<---

and this is hard to reconstruct from the above diff fed into the
callback. So we have to do it in the xdl emit phase.

So I think the wrong part of the initial patch 2/2 is the too
late recording of the moved lines.
So rather whenever we call diff_flush_patch(), we have to first
call diff_prepare_moved_line_detection() first for all file pairs.

>
>    The fn_out_consume() function working in the "second pass of
>    moved from/moved to mode" would inspect line[] and see if it is
>    an added or a removed line, and then:
>
>    - if it is an added line, and it appears as a removed line
>      elsewhere in the patchset (you obtained the information in the
>      first pass), you show it as "this was moved from elsewhere".
>
>    - if it is a removed line, and it appears as an added line
>      elsewhere in the patchset (you obtained the information in the
>      first pass), you show it as "this was moved to elsewhere".
>
> Or something like that.
