Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0A5520248
	for <e@80x24.org>; Fri, 12 Apr 2019 12:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfDLMlf (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 08:41:35 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37146 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfDLMlf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 08:41:35 -0400
Received: by mail-oi1-f196.google.com with SMTP id v84so7812700oif.4
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 05:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zc9YtY8ssjp25keLIw6tSqbaYKRAoCem7euEkaPh7XU=;
        b=hq19yzoDD4JG4tTPIlO0Z2jPkkOeDLNMjItm+vX9njdEsufCJ6MAucgwt/I4b9ejDy
         Q9N9nmofrEIWx8o85zp6JAwHfXvf2KCVqg0fpai1HwTIWk/bG7VyryGhvuSFqXuChP3u
         C0vaWVD8Q1/5dAVG51dTr9gDEq03ZOwk9wiIXmHbfRxEUQZHSNV39wcwYKfBKrlCUWrt
         DsqdBbpLxP5Um/YuZHv1y+p9OrAYbqC8a8zXkvy65zFnB40PCoKpOgRrGJC1e8xLDLSY
         2vS8flypYmCKtzskaNQHMoiTxQM/Kiy3OPBhdGiKp9gdg+SGYVbvCnsEDnsC1kqR90DT
         jpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zc9YtY8ssjp25keLIw6tSqbaYKRAoCem7euEkaPh7XU=;
        b=lPkUGN0G9P9cgBDlcow0M3Uj4t/knK8NReaVASVpkESIpaRC/o/qdwaGNOdQy3V8MV
         NMIgvDVlO/N4u1BMc2WJSl4BslkLRc8IvyVPzw3IbMff6Wg8tBAq8UWtLwCAlkV5Q9C4
         Gh4By7knBriXwbpQMSZSyBtTxZ8Y8yeL4yUqSPlwcuCyZvGk3kU5zxl88vSm4yRW5d3W
         PQOfYuxe9GckGhbXhW5W6bo+acUSUHqb2skUXyNs7MWm+XKuX9PYyE+GQxteObigVdOX
         +FAj5AB2xQ+Xyarvzqw4tzDBnPZbMG1VY9Ca+g51G6uKiyeVbcV5IGr2y3ToS98/TvGZ
         bOzg==
X-Gm-Message-State: APjAAAVw631DCPYar4xwTv1ZjfQ87BZg2zs+3T0rYHNKPkFvdTZOLzAW
        SSzpOlAbWmpx0JAI/bBiJJjvisH1ofW1LI6buGs=
X-Google-Smtp-Source: APXvYqyhpnrTKpA7giFhvufGl8+sRBQCMshW2e0NkXslDUZlRb+0CNOMGdzLhU1ABj5t9jkkDVpeo9orx9/Po8v5gsE=
X-Received: by 2002:aca:d4d8:: with SMTP id l207mr9812086oig.29.1555072894337;
 Fri, 12 Apr 2019 05:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <CABgj7us=Rk3EUvd2EVVqsYKDUGS7VfAX09SpW04fB26cgntw5g@mail.gmail.com>
 <CACsJy8B0dmonaCuAmT6wNJae8iX0JxUOvU-P=zvjVUrQnoHoUw@mail.gmail.com>
In-Reply-To: <CACsJy8B0dmonaCuAmT6wNJae8iX0JxUOvU-P=zvjVUrQnoHoUw@mail.gmail.com>
From:   NoName Req <nonamereq29@gmail.com>
Date:   Fri, 12 Apr 2019 15:41:22 +0300
Message-ID: <CABgj7uu95Pg7jJY1CN7kUS-SWE6+FCgQshuzWWRrhMqBd_zMMA@mail.gmail.com>
Subject: Re: Bug(feature?) on git-diff-files
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Okay thanks for the reply. I didn't know about git update-index will
try that now.

On Thu, Apr 11, 2019 at 3:57 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Thu, Apr 11, 2019 at 7:49 PM NoName Req <nonamereq29@gmail.com> wrote:
> >
> > Summary
> >    `git -C (folder path) diff-files --name-only` output is not correct
> >
> > Steps to Reproduce
> > 1. Apply change to a clean git repository. Go to another folder (not
> > within this repository) and apply the command
> >    `git -C repo-path diff-files --name-only`
> > The above command lists dirty files in that repository.
> > 2. Now undo your changes on the repository
> > 3. Issue the same command. It still lists the file.
> >
> > More Information
> >
> > `git -C repo-path diff`  command doesn't seem to have this problem.
>
> I haven't tried to reproduce. But my first impression is diff-files,
> as a low-level plumbing sometimes requires you to refresh the index
> first. Sometimes without that, you'll get wrong output.
>
> "git diff" is a more high-level command that always refreshes the
> index internally.
>
> >
> > System Information
> >
> > Arch Linux 5.0.7-arch1-1-ARCH
> > git version 2.21.0
>
>
>
> --
> Duy
