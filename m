Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED000202AC
	for <e@80x24.org>; Tue,  4 Jul 2017 20:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752194AbdGDUAV (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jul 2017 16:00:21 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34289 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752161AbdGDUAU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jul 2017 16:00:20 -0400
Received: by mail-pg0-f44.google.com with SMTP id t186so114372320pgb.1
        for <git@vger.kernel.org>; Tue, 04 Jul 2017 13:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=cVmw3cIEF+qwcKm3wDykINQB/SMc5TVxFeTVhyuPBbU=;
        b=RWKWpf6TIAunncw/vJakmbN5YZLJwA0fbwLaEtYsZ3BJ4r8fwoo4yyAy8EKA11l719
         jYXr7PvkYVzkQB8txt+MIizqkN/UKNav/AyEqyNdrrWczjQ/1lZrvY/E3yqwp0G9ml4s
         r6MFMpF18gthpMSrVDI/8OUGXPdPq3os9Lz2kurR+Gg9/pB0rk75iJRgQMm2oZ8h/IGL
         2JXiB+lV3nzAn9b/lR1XIq0E/Hyo02ttBvrfobhXCw48c8T68XOHNN2AVDI5E+9ZYp6F
         Me5Ba58L2pCJrHYtA2QiLzIJagpx2A8ri6GP59YFH1H59r5ZJH3flwiKpf9bycJT4Stu
         y1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=cVmw3cIEF+qwcKm3wDykINQB/SMc5TVxFeTVhyuPBbU=;
        b=Sz0zVF3jOu4U8l+Xu+MOXfRC6Ko0/blFyFxvsox6byBeAbMKjjB01WuBSKC7I3cuG6
         AvSXj7iX4j79tEHI9zFPb6I/bFZl9ax5QYNxC/IfSqiITEtjv1xy0+wZj80Pd8OO/Tkl
         phpkZVi0uXXIA/kS5jcg7SsyUQQfAyMIgfoRBXpH9IWYm3niunvciuk3R5fiG6emSeLi
         nmHx7CpnBf8pARdNBKl7M8hyfu9hG5Kv7VURMpfHorRyBx8UrJLSDwl4nvmCl8n0K1mV
         xfL+v/Vsu5gSl5HadAioHb3jWb9PVhQT1BhOVACq4owPhofvm0AyPD6/t9wcD51x/fCq
         vwFw==
X-Gm-Message-State: AIVw112GHTGjSKf2IVqdcTp7y2YJjaT6++hzgqceS36L49Pkl53HL9Wi
        HGJ0oeTZB0OkLQ==
X-Received: by 10.99.2.69 with SMTP id 66mr17694752pgc.61.1499198418134;
        Tue, 04 Jul 2017 13:00:18 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id u9sm46256610pfd.56.2017.07.04.13.00.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Jul 2017 13:00:17 -0700 (PDT)
Message-ID: <1499198419.6428.7.camel@gmail.com>
Subject: Re: Help needed for solving a few issues with building git
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Wed, 05 Jul 2017 01:30:19 +0530
In-Reply-To: <xmqqk23pl1q8.fsf@gitster.mtv.corp.google.com>
References: <1499087898.4156.6.camel@gmail.com>
         <xmqqshidl76n.fsf@gitster.mtv.corp.google.com>
         <xmqqk23pl1q8.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2017-07-03 at 11:13 -0700, Junio C Hamano wrote:
>     Adding HTTPS support
> > >     --------------------
> > >     I tried to add HTTP/HTTPS support to the custom built version
> > > for which
> > >     AFAIK 'git' depends on 'curl'. I tried providing the location
> > > of the
> > >     curl source in the Makefile using the following line after
> > > reading the
> > >     instructions in the Makefile.
> > > 
> > >     CURLDIR=/path/to/curl/source
> > 
>  Shouldn't this point at an installed location (iow, we do not build
>  curl from the source while building Git)?
>  
>      # Define CURLDIR=/foo/bar if your curl header and library files
>  are in
>      # /foo/bar/include and /foo/bar/lib directories.
I tried pointing it to the installed location, it doesn't seem to be
working. To elaborate a little on what I did,

        * I installed the "libcurl4-openssl-dev" package b
        * I found that the 'include' directory to be present  at
        '/usr/include/x86_64-linux-gnu/curl'. I wasn't sure if
        '/usr/lib/x86_64-linux-gnu/' is the corresponding library
        directory. 
        * I took the common parent of both '/usr' and ran the following 
          commands to build 'git'

            $ make CURLDIR=/usr prefix=/custom/location
            $ make CURLDIR=/usr install prefix=/custom/location

        * The build did succeed but I get an error that "'https' helper
        is not found"

Was anything I did, wrong?

>  This is probably because you are trying to run without installing?
Nope. I'm *installing* git not using the binary wrappers.

>  Ask the "git" you built what its --exec-path is, and run "ls" on
>  that directory to see if you have git-remote-https installed?
>  
Obviously, I don't see any 'git-remote-https' binary in the folder to
which I built git.

>  Trying a freshly built Git binaries without installing is done by
>  setting GIT_EXEC_PATH to point at bin-wrappers/ directory at the
>  top-level of your build tree (that is how our tests can run on an
>  otherwise virgin box with no Git installed).
> 


On Mon, 2017-07-03 at 13:11 -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>     $ make NO_GETTEXT=1 NO_MSGFMT=1
> 
> may help.
> 
Ok, I seem to have crapped a little. It seems following the intructions
in the Makefile blindly led to this issue. Reading the instruction
"Define NO_GETTEXT if you don't want Git output to be translated.", I
defined NO_GETTEXT=1 in the Makefile itself! (as specified in the
previous thread)

I'm able to build git without localization support by using the
following command,

    make NO_GETTEXT=1 prefix=/custom/location

> NO_GETTEXT is "My build environment may or may not be capable of
> doing the gettext things, but I choose not to use it in my build
> result" but NO_MSGFMT is simply "I do not have the msgfmt tool".
> 
> Having to specify both is rather unfortunate and we may want to
> streamline this.
I guess it's not required!

-- 
Kaartic
