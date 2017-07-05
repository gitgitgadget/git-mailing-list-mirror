Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 618D2202A7
	for <e@80x24.org>; Wed,  5 Jul 2017 17:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbdGERGz (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 13:06:55 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:36517 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751695AbdGERGy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 13:06:54 -0400
Received: by mail-pg0-f43.google.com with SMTP id u62so127207276pgb.3
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 10:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=fFuoiYPil2JVZwtaxncbPyFJREGGyGX3/G5dJOGOxaQ=;
        b=QS/wa5FXHfbM4Y+eMnjLsyEBOd+leUtsM2INQGwvgIwFgZNHD0hBKg/W47uZX6z0p5
         Af39wWJJm+R0wFjakOatGgLf5vt+BdbI8vr+yzxRmt6KEbdm/XMU8z95mDwMyfzkyfWM
         kDtZbrkuQ9uEzo+ngE8pOHmjIVlT16Z5lNjHuG7l3II9feqaxyjzmedQLdKD7ZYo417P
         Md6LzCDQCvKve1au6b3ZAuHb1OiPx09WFuL8HgDXqBccodW8Z+c83UkDF8bpuKgnJyvQ
         RlUJ1Bq1KWODaP5g6vXJhZIlu6UcdGyI2/vwPfhWVsjslcwhkdK77t64eN8M0i2NPEP9
         FCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=fFuoiYPil2JVZwtaxncbPyFJREGGyGX3/G5dJOGOxaQ=;
        b=rQALvwMiFXKGZj8/ct0lbWdIm1bMd6mGEJdCC5iadkNQJKlZWClfcQc7+JGxaXdt5w
         Km4+W2PJyrYsTe4UW154SclGQbldPI6GLoRLGtkUFU/+Rq5vFBiUA2bygO0h7mi7a7Ni
         r5RA05ac8/VrQGj6GXH/ypLGckXtkWe0ebpl0pPa5O/IoVknQ15NcxhWxOyQAJwPIihM
         nKkPbZ3ZJI/9fsoA22ePfcmUiRRXXumfqFhiftg8R1IySuRzan29VQTaDiOiccfyMp6w
         afw1Art+t7Ya9R/peTtkgcxlSo5sPLioast4hOj7AySYxwytyLeNunm52NcXf0cyAvK9
         /21w==
X-Gm-Message-State: AIVw110UFUQ+EXRw7infhEySkWjI5ahZpx8mxANh+Df8vM3mb0+Vlr+P
        6RuzXCZQPT5yxg==
X-Received: by 10.84.135.129 with SMTP id 1mr22999271plj.12.1499274413633;
        Wed, 05 Jul 2017 10:06:53 -0700 (PDT)
Received: from unique-pc ([117.209.172.103])
        by smtp.googlemail.com with ESMTPSA id w85sm64807107pfj.115.2017.07.05.10.06.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jul 2017 10:06:53 -0700 (PDT)
Message-ID: <1499274396.16389.4.camel@gmail.com>
Subject: Re: Help needed for solving a few issues with building git
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Wed, 05 Jul 2017 22:36:36 +0530
In-Reply-To: <1499198419.6428.7.camel@gmail.com>
References: <1499087898.4156.6.camel@gmail.com>
         <xmqqshidl76n.fsf@gitster.mtv.corp.google.com>
         <xmqqk23pl1q8.fsf@gitster.mtv.corp.google.com>
         <1499198419.6428.7.camel@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2017-07-05 at 01:30 +0530, Kaartic Sivaraam wrote:
> I tried pointing it to the installed location, it doesn't seem to be
> working. To elaborate a little on what I did,
> 
>         * I installed the "libcurl4-openssl-dev" package b
>         * I found that the 'include' directory to be present  at
>         '/usr/include/x86_64-linux-gnu/curl'. I wasn't sure if
>         '/usr/lib/x86_64-linux-gnu/' is the corresponding library
>         directory. 
>         * I took the common parent of both '/usr' and ran the
> following 
>           commands to build 'git'
> 
>             $ make CURLDIR=/usr prefix=/custom/location
>             $ make CURLDIR=/usr install prefix=/custom/location
> 
>         * The build did succeed but I get an error that "'https'
> helper
>         is not found"
> 
> Was anything I did, wrong?
> 
Ok, at last I was able to build git with https support using 'curl'
built from it's source. Anyways, thanks for the help, folks.

> >  This is probably because you are trying to run without installing?
> 
> Nope. I'm *installing* git not using the binary wrappers.
> 
> >  Ask the "git" you built what its --exec-path is, and run "ls" on
> >  that directory to see if you have git-remote-https installed?
> >  
> 
> Obviously, I don't see any 'git-remote-https' binary in the folder to
> which I built git.
> 
> >  Trying a freshly built Git binaries without installing is done by
> >  setting GIT_EXEC_PATH to point at bin-wrappers/ directory at the
> >  top-level of your build tree (that is how our tests can run on an
> >  otherwise virgin box with no Git installed).
> > 
> 
