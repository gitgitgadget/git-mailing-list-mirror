Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07B8D1FAE2
	for <e@80x24.org>; Mon,  5 Feb 2018 18:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753102AbeBESRN (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 13:17:13 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33622 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752738AbeBESRM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 13:17:12 -0500
Received: by mail-pl0-f67.google.com with SMTP id t4so12296989plo.0
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 10:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f4XCRgCL8G4zeKXYth5OREG3znEGP+8qIzbxfjk2l+I=;
        b=WJQ95k31ZyYTxnGWWKvIiEpFwM0i3cYqCmUptXY6fj0Jynj4m/gO8p988kPQLgM32i
         TNl13E/Plx+ZesFOSqFmY4LDIqWGlzvsIScm/EurZGowidH3GE2smqmYF1q23JxwyvUq
         foIE/jo7ctuyzHi92Q6zAWZbm4NgsaCQhiXyC1pgoOEAtUW4peSaXB7TKM/NHBeT9Rux
         xscFLZ92f8sjPV+SM9svNFirSsfqJ1yuDBQD/r+MjjK4jjc6dNNisZsUlpa20N36undX
         1ysTZ+9rJjmaZEMFJjpeNGAo9YogMAWXug7fqU8CVv2l7SM0hytHR+zLWZ4tYxMcUXdj
         drKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f4XCRgCL8G4zeKXYth5OREG3znEGP+8qIzbxfjk2l+I=;
        b=pcl0Mth3lv8sb96Ube7xymUy7RvKc+OmQoHjLS+wxmIoFRUHgXqg3U1UDgteC1cAim
         PfQs5cvtBkRIf8l8J71BYAX8fnSDl8NBKGsxdj5A09lGetfAEcYPerOVSOfjS0epraPb
         kw3lDEkpyNHdu0KGkZuJTcPyIitpPmMTqMW3q25hKTR4msTDFyrfjlOWLL0O41IT+2pE
         hgJothgZdOj0Aanx9q6IoEkzvinkYejKx/LNoq/8aUgyVr0wj0iqiBDm7jpiJ/fKqWoi
         fIqjk1k5k9BtN34ObW3EFnY+RWwk2NIkqMHgge6pmbRO5bmpl4W96IWHD2KZ9KwJ9O6e
         dK3A==
X-Gm-Message-State: APf1xPAVAt9U8okU3z3n4OdZj8F3W5DJdKGSe80dMaUISW9msPPIJrCb
        C6bkau7hDiGNc7JQg6NlCcpLfDYLaXJQOx0NrSA=
X-Google-Smtp-Source: AH8x224v1BGLJShjjhxXsEGdBMaTc5CY5LxgoIjxobe+WHCVBOgR6xGSElZ2vb/h+s0ENLEvIGN+gnbLys09dedOdlQ=
X-Received: by 2002:a17:902:6c44:: with SMTP id h4-v6mr7811693pln.373.1517854631704;
 Mon, 05 Feb 2018 10:17:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.236.140.151 with HTTP; Mon, 5 Feb 2018 10:16:31 -0800 (PST)
In-Reply-To: <20180205175500.GA104086@aiede.svl.corp.google.com>
References: <CAAXyoMOp2OdgTVZN2FyP-u1ha9PjwHkTDq-pyu-4GrjP91X70A@mail.gmail.com>
 <CAAXyoMMxuF=LUTWJkPL8GmFCgL-xacPBAgRE2Qr97CgF7yppgA@mail.gmail.com>
 <handler.873424.D873424.151784496817038.ackdone@bugs.debian.org> <20180205175500.GA104086@aiede.svl.corp.google.com>
From:   Yangfl <mmyangfl@gmail.com>
Date:   Tue, 6 Feb 2018 02:16:31 +0800
Message-ID: <CAAXyoMN_DYHO0BX1fn+97+GPPPFLGya3nCi4SEvDJDRL3-6=dA@mail.gmail.com>
Subject: Re: git: handling HTTPS proxy w/ password inappropriately
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     873424@bugs.debian.org, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-02-06 1:55 GMT+08:00 Jonathan Nieder <jrnieder@gmail.com>:
> Hi,
>
> Yangfl <mmyangfl@gmail.com> wrote[1]:
>
>> not affected any more
>
> Can you say a little more about this?  Do you mean that newer versions
> of Git are working better for you or that your proxy setup changed?
>
> This looks similar to
> https://public-inbox.org/git/CAHnnmh6QCnHTycbMDLjfFYoXW4dErTZoTHsPrkYdhZKnXcHHYQ@mail.gmail.com/
> to me, which makes me fear it hasn't been fixed.
>
> Thanks,
> Jonathan
>
> [1] http://bugs.debian.org/873424

I just repeated it three times to make sure it works perfectly.
However, I still see 2 connection attempts in my wireshark, the first
one without password (then FINed), and the following one with.

$ git --version
git version 2.15.1

Versions of packages git depends on:
ii  git-man          1:2.15.1-3
ii  libc6            2.26-4
ii  libcurl3-gnutls  7.58.0-2
ii  liberror-perl    0.17025-1
ii  libexpat1        2.2.5-3
ii  libpcre2-8-0     10.22-5
ii  perl             5.26.1-4
ii  zlib1g           1:1.2.8.dfsg-5

Versions of packages git recommends:
ii  less                         487-0.1
ii  openssh-client [ssh-client]  1:7.6p1-3
ii  patch                        2.7.5-1+b2

Versions of packages git suggests:
ii  gettext-base                          0.19.8.1-4
pn  git-cvs                               <none>
pn  git-daemon-run | git-daemon-sysvinit  <none>
pn  git-doc                               <none>
pn  git-el                                <none>
pn  git-email                             <none>
pn  git-gui                               <none>
pn  git-mediawiki                         <none>
pn  git-svn                               <none>
pn  gitk                                  <none>
pn  gitweb                                <none>
