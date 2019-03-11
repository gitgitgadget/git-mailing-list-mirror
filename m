Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,URIBL_SBL,URIBL_SBL_A
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5524B20248
	for <e@80x24.org>; Mon, 11 Mar 2019 17:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfCKRxb (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 13:53:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44024 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfCKRxa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 13:53:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id d17so6149119wre.10
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 10:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QshhegDFbzvtqax3Gt+4vzkFtX6eguuhwdZhLAEUoIw=;
        b=TFuHj/t+Y2hc7KkIOVUFjR5PSKYhlag0BWVWSjSFECt6Mp4EeqyZSfZEQsJC5KRu5a
         IdTghyE1EZQmhSeyk49YequRz/dfIe3sSx1nfi+jaeh71BEvFgbtxoBfCmkoPoSOZpgD
         tTvganb0DM857SbM4dN29RUrYO1ITu3UVr78pMuWmemkpNBlCeBsp/Ffeo5RzW2e7Q33
         QFGSnTHxQixq9lSVvFzciSH9QjnY1X/+EGDJPc9MIIxN/i1Qn4AXG1WJMJFZcJsBJc9l
         kgIFAWtj522xxuVp2Q2CLODYJKPIye5bNlAZHOHib7GSQUWiOzGG+t709cfSM+45jWih
         GdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QshhegDFbzvtqax3Gt+4vzkFtX6eguuhwdZhLAEUoIw=;
        b=cq+BWYI97f2y2SFYF4xbKk9QZTcrX/gNchU9RH8EnGendDnbX1QrhBxxdw0gwSsxPt
         4IFhMT8JuA2jmEPlg5Y9sXsZ7jPALM/VGzinuWSyZUffAaevqEQk8bT9qht8CRh3ZMB9
         s2pkNwk2VVRCZKkzCTY+GdIbZDWkPQ9r2LEnbS+P+31IoYqFEhRLmkbn/USzUemLCqOx
         38mkPEG+oi9RwUimnM8KTXhfv63afHQgOsFzUpeJhYgUF1KXTjcTDZyySidkbyHZN484
         m77eoSQWlDmViL6dA0UIjUnEOwIYuebR9IPLn8jUjdzVpQutHhWOeoNdeCr1g+yNriQp
         L2yA==
X-Gm-Message-State: APjAAAV/AlV+qYP8e5PlU1VEJLcUY3kZQmwDCqdpt0Dh0W7GatERA8KR
        6wGnH5OG3w5SQqydr4obEtOOt6WqoL+iktYLQMwakWsnYBQ=
X-Google-Smtp-Source: APXvYqxKUNG12xlsQQOEHPPJTXWDE/xtf5foRDIqQsrasFzFtubU5QTmVmzVRoUZ/NCZ4CratkTu3PniAd+bYaTBrWw=
X-Received: by 2002:adf:ffc3:: with SMTP id x3mr12084173wrs.111.1552326807602;
 Mon, 11 Mar 2019 10:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <CA+dzEBkkbQj0rCjvPfcET2Uvt6fP_v+wQE52ZkAND2Mps08SNQ@mail.gmail.com>
 <10972e0e-7fe1-437f-efe6-cff82a1205e0@kdbg.org>
In-Reply-To: <10972e0e-7fe1-437f-efe6-cff82a1205e0@kdbg.org>
From:   Anthony Sottile <asottile@umich.edu>
Date:   Mon, 11 Mar 2019 10:53:16 -0700
Message-ID: <CA+dzEB=EaMoeSac09kj6huuwdk3sOLf7QQHEoghy2B8UoG2eyg@mail.gmail.com>
Subject: Re: `git add <<windows 8.3 path to file inside repo>>` results in
 "fatal: ... is outside repository"
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 11, 2019 at 10:48 AM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 10.03.19 um 23:41 schrieb Anthony Sottile:
> > git init longname-repo
> > cd longname-repo
> > touch f
> > git add ..\longna~1\f
> >
> ...
> >
> > C:\Users\Anthony\AppData\Local\Temp\t\pre-commit-hooks\longname-repo>git
> > add ..\longna~1\f
> > fatal: ..\longna~1\f: '..\longna~1\f' is outside repository
>
> This has nothing to do with long vs. short path names. It would report
> the same error when you say
>
>   git add ..\longname-repo\f
>
> -- Hannes

Oops, I misreported while trying to minimize my reproduction

Here's an accurate bug report

git properly handles this:

    git add C:\full\path\to\longname-repo\file

When the root of the repo root is `C:\full\path\to\longname-repo`

But it does not handle the equivalent 8.3 path:

    git add C:\full\path\to\longna~1\file
