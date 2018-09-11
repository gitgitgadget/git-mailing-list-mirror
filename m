Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94F1F1F404
	for <e@80x24.org>; Tue, 11 Sep 2018 19:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbeILA4l (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 20:56:41 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:40383 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbeILA4l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 20:56:41 -0400
Received: by mail-qt0-f175.google.com with SMTP id h4-v6so29604142qtj.7
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 12:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=82DpA9l+VOaczsOKYQCV1ddi2kC5FubLE6Ghjq3TbU8=;
        b=RAX/3O/X9U8NhG47n3Nw0FfGeKqHKp9dtwOZ8DpSe/eWWXf2W4oRXyNdKw3Ai10s8K
         DiacCpEu/rXfGKnlG4Hu7EMCP7jKPaXkefFqXLxS6SSS6/iB/iFcn+/55ql1PdA/E9vv
         Hu5QX5slHPk1+23h7ojtSgx2VAZ1jbAHbdxAnWXGjyf/r0lpX+vfcSwCikWA+j4Hsjsa
         +fu345TKALTltPJ3f1T0X9mMssDh3a3jI7JUQp8pnvle9Cgui6cPLnlWpLBs5bV6ZZPZ
         YZHBGc5EwcOqqrh69WRDeyTipzB01iowu+cIDzMSrUiSxqNyTYstwHk6D6HqCimHF+Kl
         0acg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=82DpA9l+VOaczsOKYQCV1ddi2kC5FubLE6Ghjq3TbU8=;
        b=LUmcfSii5BaUJrVvtnUGSRMHF2DrIhvnXIHSnPNwHvuWzZBDNdJrquKtgKI7qRSgAG
         iW7ASetyqnQ0FFSktFamns5a9wSfhTXWebws07hyQHIfYOQE33psYwwOarcRnIDIeHZz
         iJKGZgt/6eiF6xqjWRri32rRw5dvgKdJ2iSC6/Q8YseEizLX8OBk9/3VF3P46Xp8gVlh
         yJJxbH/f1u8GbyJVSoXCFObi0IkRxafcICH12aN6tvmiHu7AVMUkWbFdiveSBw5I/DIP
         WPoxMKIXb/oND13dbX6t4DTEsi8ZPxGxFJ7OGYoSjYhU2gx7VEPUXHLmtHhquK133iqk
         iWGA==
X-Gm-Message-State: APzg51BwImfGOQ3DEhb5OthM7xUIpb1nTGK3U/EdGQbyBMQ2yQWFTtOZ
        i5Pl1LTOzWLp5iOpgsI6wjBPnaTGK4rpDf5DUTz5jQng
X-Google-Smtp-Source: ANB0VdZcMg57GNUqI46jJd2So3VzkstIQHRk24dsUkuXDgW53Jms3oGoqpO6J0vKkIHD5F9m7TL5p3UF/jGKRvg/MbE=
X-Received: by 2002:ac8:2977:: with SMTP id z52-v6mr890411qtz.111.1536695750137;
 Tue, 11 Sep 2018 12:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAMK-fcye+nNyB9pFrp1nQwQC1+sQWMt_4yq2f7svJUiB=ZnnJA@mail.gmail.com>
In-Reply-To: <CAMK-fcye+nNyB9pFrp1nQwQC1+sQWMt_4yq2f7svJUiB=ZnnJA@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 11 Sep 2018 21:55:39 +0200
Message-ID: <CACBZZX7EijsVZcwb1BkZdYEzKJbyRWGJNBKXXNRt_i47R0o08w@mail.gmail.com>
Subject: Re: Allow git bisect in reverse mode?
To:     bdavis@saintandreas.org
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 11, 2018 at 9:54 PM Brad Davis <bdavis@saintandreas.org> wrote:
> I'm currently trying to determine when an issue was fixed in a long
> list of commits.  I attempted to do this by running `git bisect` and
> marking the commit where I knew it was broken as bad, and the tip as
> good, but I got back an error message saying that good revs weren't
> ancestors of bad ones.
>
> I'm currently working around this by mentally reversing the meanings
> of good and bad, but it feels unnatural and error prone to have to say
> `good` when I encounter the failure and `bad` when i don't.
>
> Couldn't git simply do the same thing and internally reverse the
> meaning of good and bad if the bad revision is an ancestor of the
> good?

This feature already exists. See --term-{old,good}=* in the
"git-bisect" manpage.
