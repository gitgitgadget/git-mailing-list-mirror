Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75F3A1FBB0
	for <e@80x24.org>; Tue, 29 Nov 2016 04:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754162AbcK2En5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 23:43:57 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37239 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753460AbcK2Enw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 23:43:52 -0500
Received: by mail-wm0-f41.google.com with SMTP id t79so175478781wmt.0
        for <git@vger.kernel.org>; Mon, 28 Nov 2016 20:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Il7p9Dl/4e1n9TcR4rFjeozsP9TF0w63DjBxcNoV6ro=;
        b=cAdc/yogHbbfRGVbf+hlQQGnLrsyUhyIwQKxACVN29kHfbpiFmsWakeERwuvbFW9r5
         ZVmiWTd/o4b5EbTvgJSNJ70W9Zf0d4NGusLbSGg0IGOKU1UzcooHfpz+joHnFATeqHgA
         Q74xSOSnxb2dUPjvNbBmwTrb4wXRkKm+MfFXfUvRB24YUQtpOOk/tIb3nHmIKqxs7GAy
         lFOt9H89yvTtkEZMUjPaIIWd13nRgZdkhKSx8DFCdsgdraROpO9xSJxbBxRCVFZJ+TCU
         HL02jvvzdMVxRtPHfyPDohrE0lieuc4/96zqYvydckdmEtXTi46Gq0fgCPN4DmwCJHiN
         F2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Il7p9Dl/4e1n9TcR4rFjeozsP9TF0w63DjBxcNoV6ro=;
        b=gDYplxQr0wsZqopRMurum8pj/Mbt7cJv2opM3zvxHWjSeJuMwHCLSSKkZNnlYab3yO
         dEO687B9ZbV/PIJSjQgPrgaLq61AkbPztXirDEFLczp5oCdVZqSowmjRM4LMt6X6NZF2
         4eRZFJIgR2Tbz74sa8GwfhlNHCOgIeD/o3MgcMk6mTWxMHIkzJsi2fytHkcmK6XsE7gW
         x5tfdqVu8iZXjXdTXGrzRizz+MRL8jgEijxonhhg4gPiNSFlJ60BkhaT2cmpW4wa+nL6
         vF3YvJxwsHK9tsKBk3iNCxWopEzA/E2f8cugEjF4p6dganWX/vedNQXPh6lRHkf0+4z0
         yiaA==
X-Gm-Message-State: AKaTC01BN5xePguhpsVvHO1ZtCrzSitxTCmAq/5Y81HlrpWHW+WbGvOgONVVSgK/ku9E9oa1oNFhsOU8R7VA9ccP
X-Received: by 10.28.69.217 with SMTP id l86mr21411069wmi.129.1480394630272;
 Mon, 28 Nov 2016 20:43:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.216.193 with HTTP; Mon, 28 Nov 2016 20:43:49 -0800 (PST)
In-Reply-To: <xmqqpolfgndq.fsf@gitster.mtv.corp.google.com>
References: <xmqqk2btlr3x.fsf@gitster.mtv.corp.google.com> <732c0e78-74b5-befa-e3c5-5ed9f221fa3a@google.com>
 <xmqqpolfgndq.fsf@gitster.mtv.corp.google.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Date:   Mon, 28 Nov 2016 20:43:49 -0800
Message-ID: <CAGf8dg+=Neozuacsp21Neg=wp30k84bvfnBYs-bOoyTjMGvzVA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2016, #05; Wed, 23)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 28, 2016 at 4:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> On 11/23/2016 03:21 PM, Junio C Hamano wrote:
>>> * jt/use-trailer-api-in-commands (2016-11-02) 6 commits
>>>  - sequencer: use trailer's trailer layout
>>>  - trailer: have function to describe trailer layout
>>>  - trailer: avoid unnecessary splitting on lines
>>>  - commit: make ignore_non_trailer take buf/len
>>>  - SQUASH???
>>>  - trailer: be stricter in parsing separators
>>>
>>>  Commands that operate on a log message and add lines to the trailer
>>>  blocks, such as "format-patch -s", "cherry-pick (-x|-s)", and
>>>  "commit -s", have been taught to use the logic of and share the
>>>  code with "git interpret-trailer".
>>>
>>>  What's the doneness of this topic?
>>
>> Stefan Beller mentioned [1] that this seemed OK to him from a cursory
>> read. Do I need to look for another reviewer (or a more thorough
>> review)?
>
> I gave it a cursory review when it was queued, too, so another
> cursory read does not help very much ;)  If I recall correctly, I
> got an impression that it was reasonably well done.
>
> I haven't had a chance to look at the series again to see if the
> SQUASH is just the simple matter of squashing it into the one
> previous, which is the main reason why I haven't decided if it is
> ready to be in 'next'.
>
> Thanks.

Sorry, I'm not sure what you mean by this. The SQUASH is an update in
documentation (for a C function) (reproduced below [1]) which can be
squashed cleanly (just to confirm, I tried it using "git rebase -i").
It can also be rebased cleanly onto master or next (at least, as of
now).

If you are asking about whether I think the contents of your SQUASH
commit is reasonable, I think that it is.

[1]
$ git show 7e7587d
commit 7e7587d563ddb540875075e5a84359a8a96a5188
Author: Junio C Hamano <gitster@pobox.com>
Date:   Wed Nov 2 19:28:53 2016 -0700

    SQUASH???

diff --git a/trailer.c b/trailer.c
index dc525e3..eefe91d 100644
--- a/trailer.c
+++ b/trailer.c
@@ -565,7 +565,9 @@ static int token_matches_item(const char *tok,
struct arg_item *item, int tok_le
 /*
  * If the given line is of the form
  * "<token><optional whitespace><separator>..." or "<separator>...", return the
- * location of the separator. Otherwise, return -1.
+ * location of the separator. Otherwise, return -1.  The optional whitespace
+ * is allowed there primarily to allow things like "Bug #43" where <token> is
+ * "Bug" and <separator> is "#".
  *
  * The separator-starts-line case (in which this function returns 0) is
  * distinguished from the non-well-formed-line case (in which this function
