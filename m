Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F91E20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 01:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbeLKBQM (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 20:16:12 -0500
Received: from mail-it1-f174.google.com ([209.85.166.174]:54346 "EHLO
        mail-it1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbeLKBQK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 20:16:10 -0500
Received: by mail-it1-f174.google.com with SMTP id i145so1047940ita.4
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 17:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AEa4by8hh0az1fwSGfADMlyPwV/dpZ8XNoBMbWwL1oo=;
        b=dHN4gyOSeFsV/bI9nyMXjyq0VogKf0yQN7PAyoy9LQ4h2fZtZfOct4xvAcG2JhinkF
         V5xeHqVuHnjdN/raVgVELeE/YmSJ4MYiG20hi16U0QAa3uNCmNFRmhWsClCmOa1kDOsv
         my5Gz/FqEf2jdh+PU6mfIJ09Y1lOI3Sz8MeXEx0BfhXXghL8gJutmN22XPVhI1vbHGkg
         +KGaZf1hl9jTfhL5if/Rqb9690K1usU/X4k/wa0EWGvqFq4nW6djaoYdRywD1nuPjjrI
         Cd85Z277fWXRN3HfX2SXJbKIyPXZWfeIvI5FjeLqWhz2mUY8DwYUmza0XTDdSbYdSMTb
         6wWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AEa4by8hh0az1fwSGfADMlyPwV/dpZ8XNoBMbWwL1oo=;
        b=dHeZW3Z0E8Xc2/ECMaiD/oCWTiId+1fw4CvM0svaYolBzQ+tHMbxViokdZ0uPtm3D7
         nGJFsjz8/c2SnKAkrn8w6AQeBbATN/tFNlk8byqE5Zsan9DBF9kvObZ736o0XJrZsFCP
         UcctIRKlnhy2NRniRumGo62iVNEvkL2MnUcx/mUiGJcsSJ/KgBhVg93v+4xNEW+abT5W
         QD3/0xtSpwbWFG3rvKr5NT/OnvVIO3JCq6CRTPdaG4l5/ITwkw/vJyNaDH8NDzLfKa4o
         AvEU4NqZ7xB1rkXrbTFco6bsmBt7HVecY16BkxaQWnLTnmgXLRPLIhx/6aPb7uxJfvG4
         qHAA==
X-Gm-Message-State: AA+aEWYtht0Rtvr7UYlrJZIVnPBwVd9zL8Cv5elnCJ3Ithoxwg51aBoT
        jfuxKYnZ+V2IyjncoNYXrkmvF3NrmLFNN8pqssxMJGZvV9s=
X-Google-Smtp-Source: AFSGD/UJ6Wiiyofc0lD9FEL+HjpZ1VdvdZ3KfAtLIrPu1wOQRO5XtDcWQLAanPHVm5a+67DSsx2Kx8KgjPIkMUWVnP8=
X-Received: by 2002:a24:cfc1:: with SMTP id y184mr592730itf.72.1544490968754;
 Mon, 10 Dec 2018 17:16:08 -0800 (PST)
MIME-Version: 1.0
References: <CY4PR19MB1526704FC790724C2DC68465ADA60@CY4PR19MB1526.namprd19.prod.outlook.com>
In-Reply-To: <CY4PR19MB1526704FC790724C2DC68465ADA60@CY4PR19MB1526.namprd19.prod.outlook.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Mon, 10 Dec 2018 17:15:57 -0800
Message-ID: <CAGyf7-HHnwJyEu8G4p4A0RxJELJkEaJGMVj5nNznhWthAgS19g@mail.gmail.com>
Subject: Re: Git clone fails with fatal: the remote end hung up unexpectedly
To:     oofiesh@maxlinear.com
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 10, 2018 at 4:55 PM Owen Ofiesh <oofiesh@maxlinear.com> wrote:
>
> We are seeing an issue where git clone in Linux Ubuntu 14.04.5 LTS fails with the following error using the HTTP protocol.
>
> The error on the client is:
>    fatal: the remote end hung up unexpectedly
>    fatal: early EOF
>    fatal: index-pack failed
>
> The client is writing to an NFS volume.

A further detail on this (Owen correct me if I'm wrong), but the same
clone performed to a local disk, rather than NFS, succeeds.

>
> The HTTP POST error on the server is:
>    c.a.s.i.w.filters.StreamGuardFilter The remote client has aborted the connection
>    c.a.s.i.w.filters.StreamGuardFilter Failed to flush buffer; the remote client aborted the connection

Bitbucket Server developer here. I just want to clarify one thing
here, for the list. The above is logged when the cloning client
disconnects unexpectedly in the middle of a hosting operation (push or
pull). So, from the server's perspective, everything was going well
and then the client left without saying goodbye.

>
> Our git repositories are managed by Atlassian's bitbucket server v5.5.1.
>
> We see this with the Linux git client SW v1.9.1 and v2.19.2 (doesn't seem to matter the client SW version).
>
> The Linux git server is SW v2.9.5.
>
> Per discussions about this we've tried the following:
> 1. We increased the GIT_HTTP_MAX_REQUEST_BUFFER setting on the server to 100MBs.
> 2. We set the http.postBuffer client value to 100MBs.
> Neither of these helped.
>
> Any thoughts about this please?
>
> Note:
> For reasons I will not enter into, we cannot use SSH for this.
>
> Thank you.
>
> end
>
> Regards,
> Owen Ofiesh, SCM, Software Test and Development Manager
> MaxLinear, Inc.  |  www.maxlinear.com
> 5966 La Place Court Suite 100 Carlsbad, CA 92008
> Phone: 760-517-1109
> Cell: 858-335-1690
> oofiesh@maxlinear.com
>
>
