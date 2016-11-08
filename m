Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6ECC2021E
	for <e@80x24.org>; Tue,  8 Nov 2016 08:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752360AbcKHINT (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 03:13:19 -0500
Received: from mail-yw0-f178.google.com ([209.85.161.178]:35457 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752005AbcKHINS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 03:13:18 -0500
Received: by mail-yw0-f178.google.com with SMTP id i145so69216739ywg.2
        for <git@vger.kernel.org>; Tue, 08 Nov 2016 00:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7CVR+4EJHA6zXJCZnREwYreS9smdiFKzF/ozplY2Z8g=;
        b=xyjiwaVecmGv4QPAoUN8wJq++30R+W1CvUKkDyt9AD0P+kkHAezku6f9h20v5T/mRc
         Epj3u3Y0mzf0S2WSkyOhX4ghY+ywO3KF2nNP//le6mIehewSORCtlcSswlQ5auBRU8Sb
         5nchYdIKVCYDUUfdctDmAUbv5rRWD8h6Do5sZe10XMOpjYjwqC3qwHko7F/dG95YmsmD
         m+JpMsLnmGZlkNuWcBNZYtTYE/uTj6kebgbjdf48YVM9M/J9iX78ArkQvbmNV80YWGOL
         nrawM8HZMNuAEoRoH3hTpBpAs3VGPJo7ZWESBC5/AzrUfh5Toi4Spw9rP+xRB/wscULV
         xpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7CVR+4EJHA6zXJCZnREwYreS9smdiFKzF/ozplY2Z8g=;
        b=VTfllannnJTj5/tXUOQmeqiAWhHzyOqukJnam/nadddAlHmGeQux5Hl4GSzzZIy951
         KsbXBQTKmHs9o6Wq8HCHJPqF7zrHUT9u8wZG14MBsjC/yi/1TQoKsboEFrBxqdRL/h+c
         3pTY2bhHMDIf+9Xwa5DCGsQt/Fw7l+okS/2WoTsWAHi29U3lxuaydBfQcoYiI9HIb442
         16eHi8XQXATkvo5X73BdhBFaO0eWShrm2V7G5QQFMxIdrccVUWNUD/hbkpM7QmPtJ+Ev
         RfDtA9/xBdA8Hro1QyXMZbq64yq4qmH+vhIgtiKHxCTo4QRToFhCtiXwul52fNnG5aQQ
         zmlA==
X-Gm-Message-State: ABUngvdhJwkjFIDdwhcvhIVPk89NPB938q47BRc0P7y3CuH0QuairTps19A6yk5hZ5ZV4KPBLinvvAgxwc2UzA==
X-Received: by 10.13.200.134 with SMTP id k128mr9431835ywd.72.1478592797978;
 Tue, 08 Nov 2016 00:13:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.207.69 with HTTP; Tue, 8 Nov 2016 00:12:47 -0800 (PST)
In-Reply-To: <xmqqwpgoqjct.fsf@gitster.mtv.corp.google.com>
References: <xmqqwpgoqjct.fsf@gitster.mtv.corp.google.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Tue, 8 Nov 2016 13:42:47 +0530
Message-ID: <CAOLa=ZS=X=5ZvSn=AynOLpD1tDcpRkGyO6-m7d2RPoFf-4v_bg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Oct 2016, #09; Mon, 31)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

>
> * kn/ref-filter-branch-list (2016-05-17) 17 commits
>  - branch: implement '--format' option
>  - branch: use ref-filter printing APIs
>  - branch, tag: use porcelain output
>  - ref-filter: allow porcelain to translate messages in the output
>  - ref-filter: add `:dir` and `:base` options for ref printing atoms
>  - ref-filter: make remote_ref_atom_parser() use refname_atom_parser_internal()
>  - ref-filter: introduce symref_atom_parser() and refname_atom_parser()
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
>
>  The code to list branches in "git branch" has been consolidated
>  with the more generic ref-filter API.
>
>  Rerolled.
>  Needs review.

Anything I could do to push this forward? It's been a while now.
