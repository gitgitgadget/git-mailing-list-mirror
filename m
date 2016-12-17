Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C0CF1FF6D
	for <e@80x24.org>; Sat, 17 Dec 2016 08:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752224AbcLQIjF (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Dec 2016 03:39:05 -0500
Received: from mail-yw0-f170.google.com ([209.85.161.170]:33461 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751522AbcLQIjE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2016 03:39:04 -0500
Received: by mail-yw0-f170.google.com with SMTP id r204so43148919ywb.0
        for <git@vger.kernel.org>; Sat, 17 Dec 2016 00:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XmCc5UA1KdqXVwKIcdtMqcOFzyhKP58Jxxka1xySrL0=;
        b=rJ1o0ee8pNsvexvVRYGEMk++EqxgECd22bS4P0UqBqrBI0cqvQ/8oDz6us/hWWn0/2
         EbT2GMadvxEjXLt4gqls5qDsExrAx1qrZApBF0Ee4qan8lbTLaIwvQ5rvEG2euzc+Y+M
         Heuh7T+Qaw21Q7331uUVVDR93H+fefu7Vg8O2bqu9ko9SPUjD6eBsHxq0Qa8HMRiNepR
         AdLRRn4gSfjWsp+rW3s5m8CgBTWJK2u6QyXFuH6rFAGvjr/TFn49f56DSwuM1SeNsce+
         j+2cPx19IZ2XkWRC+ywzegmmAYOAaQ9W5+af0MzM31WqMaB86O1HEnSEu35vGk1S2iWn
         t4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XmCc5UA1KdqXVwKIcdtMqcOFzyhKP58Jxxka1xySrL0=;
        b=qO3tpf+QH5hEVAJd9EhRvVHKu+J4mjPEABvb7IWAku2SBzAEyRPxxwnpVjW4BtigYn
         kGDdDg3Q48QA1TR9SeQnZ5KB8RJYA7bKXXsr4BDoPpzeVcR7Fu6sKeo0GslCwezhVQOZ
         CwXnr4wL/bURZbaDZX7ko43GzJ2cArqXS8knFKPegAs9fnEUl7wyASFEoSIRfxvxqK4Y
         wxjLdzbn3bbVwR47maODSFzVeZS0RyMk1ytlJKQCDQHr6irKz6h+F+A7I0vl789gqRg1
         9xcJcH/s2JhFR2jqufNGSydsivuVEAbYN67z5/vh6POlBC8iriTnDeHI5v8/YPN0w8mA
         ihCA==
X-Gm-Message-State: AKaTC01v3vhycsD/bsPDmGlyhdGggZRZfPX6wbranhIRyF6lGR0fZGeOnF30K7Ke5IlrmN2eCoKd/a8lww0GHg==
X-Received: by 10.129.62.24 with SMTP id l24mr5269193ywa.346.1481963943666;
 Sat, 17 Dec 2016 00:39:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.129.19.214 with HTTP; Sat, 17 Dec 2016 00:38:33 -0800 (PST)
In-Reply-To: <xmqqbmwbqw25.fsf@gitster.mtv.corp.google.com>
References: <xmqqbmwbqw25.fsf@gitster.mtv.corp.google.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Sat, 17 Dec 2016 14:08:33 +0530
Message-ID: <CAOLa=ZREUWqdH_2HNn_JQcf4RW9k1dAN5BtwPN2HnzuDoUdkWw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2016, #04; Fri, 16)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

>
> * kn/ref-filter-branch-list (2016-12-08) 20 commits
>  - branch: implement '--format' option
>  - branch: use ref-filter printing APIs
>  - branch, tag: use porcelain output
>  - ref-filter: allow porcelain to translate messages in the output
>  - ref-filter: add an 'rstrip=<N>' option to atoms which deal with refnames
>  - ref-filter: modify the 'lstrip=<N>' option to work with negative '<N>'
>  - ref-filter: rename the 'strip' option to 'lstrip'
>  - ref-filter: make remote_ref_atom_parser() use refname_atom_parser_internal()
>  - ref-filter: introduce refname_atom_parser()
>  - ref-filter: introduce refname_atom_parser_internal()
>  - ref-filter: make "%(symref)" atom work with the ':short' modifier
>  - ref-filter: add support for %(upstream:track,nobracket)
>  - ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
>  - ref-filter: introduce format_ref_array_item()
>  - ref-filter: move get_head_description() from branch.c
>  - ref-filter: modify "%(objectname:short)" to take length
>  - ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
>  - ref-filter: include reference to 'used_atom' within 'atom_value'
>  - ref-filter: implement %(if), %(then), and %(else) atoms
>  - for-each-ref: do not segv with %(HEAD) on an unborn branch
>
>  The code to list branches in "git branch" has been consolidated
>  with the more generic ref-filter API.
>
>  What's the doneness of the topic?  I recall discussing die vs empty
>  and also saw a "squash this in when you reroll", but I lost track.
>

I was waiting for more reviews, if any.
For now we need to come to a conclusion on the die vs empty discussion
(http://marc.info/?l=git&m=148112502029302&w=2) I'll start working on returning
empty rather than die.

Also Jeff suggested some changes, which I've incorporated into my local branch.
(http://marc.info/?t=148112503600001&r=1&w=2). I'll reroll if no
further changes are
suggested soon :)

-- 
Regards,
Karthik Nayak
