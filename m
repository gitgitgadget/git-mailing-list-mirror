Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07815211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 19:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbeLETLW (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 14:11:22 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:36082 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbeLETLW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 14:11:22 -0500
Received: by mail-ed1-f47.google.com with SMTP id f23so18008126edb.3
        for <git@vger.kernel.org>; Wed, 05 Dec 2018 11:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=qTK8JgTONBevLfltjZh9QnuzzY6gWqOuZpkncqabeVU=;
        b=rpkhs6MTOCbrr+/ZB2RiMOMl7DNiP71LEJtdrtmD1bZHEgJji1EOCxAIt576kWXYbI
         2zQfZxv762qD7zelUc0j6O9SE6LtWrPv4ExB0zabVJS2fhwTYrY+mPhlrNcT6Ob2v2bN
         k73TChGCgli2gDKAdRwGYfpMj4O5JI1ZVYQO4YhZus1OXHS9skG1rcr9Lhszjkwe69I3
         CZSuJivJNsfozCL6tcSicRkLfOpSJfsoq2pzhYWC9/3EvwSNbZOz7fmBVePmD75tKzEM
         MJK7VvONfvNGTdY5fwozJBek8/3PeSyKilN3qNndwvC+TbwiMtbN+rFk+vA8o6E3iabI
         Yejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=qTK8JgTONBevLfltjZh9QnuzzY6gWqOuZpkncqabeVU=;
        b=FXdx6J3e5voGQkVkB0eA0dBJ50/FZCKXXOPwmOq4xfzf41JnYK6wizrVh/Jk7xz2fC
         ZjpCc/QatPikpzDDnVXMyiRbpROo1G8GDpNbvGpZZ6GQfPhQECz1gPbZoNcddaa1Owbp
         bURWn3zPJbCS7peBdkwx61/xdGRUPxOg1mMUtQgpXoqoK4sAF9hGNrFpF7VekV2lGFBB
         NISeS6g9UEAjYqPh/L6wsMXRCqJttWguzIO7R1uvYO03QZ9f3z8t4/qyl3Li5pMWNSJC
         4ReJzmIP/EAwVRxrlh0sIYKB1S50YvmjZheK8vqV2QnRhOGybLcoc/DZyZm3K69h5fzr
         hWjQ==
X-Gm-Message-State: AA+aEWYLaO3CitKvBiity1H4X8DiaS4h9+NsgZ9buJ6Vb/raXioSrGAl
        qcv6axLjjjwUB15LrBaA4R8=
X-Google-Smtp-Source: AFSGD/UjPw1MfDcRZA9pC2DmI+pwHA1uxFEtK9Sn5obMPkFaGDgwbxIK3qCNEnfAD/XSQltKVMrQtQ==
X-Received: by 2002:a50:a3d1:: with SMTP id t17mr22998004edb.238.1544037080504;
        Wed, 05 Dec 2018 11:11:20 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id z40sm3768816edz.86.2018.12.05.11.11.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 11:11:19 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Martin Mares <mj@ucw.cz>, git@vger.kernel.org
Subject: Re: gitweb: local configuration not found
References: <154401401074.29584.11169979442731329694.reportbug@gimli.ms.mff.cuni.cz> <20181205184404.GC246451@google.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181205184404.GC246451@google.com>
Date:   Wed, 05 Dec 2018 20:11:17 +0100
Message-ID: <87bm5zzt4a.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 05 2018, Jonathan Nieder wrote:

> Martin Mares wrote[1]:
>
>> After upgrade to Stretch, gitweb no longer finds the configuration file
>> "gitweb_config.perl" in the current directory. However, "man gitweb" still
>> mentions this as one of the possible locations of the config file (and
>> indeed a useful one when using multiple instances of gitweb).
>>
>> It was probably broken by Perl dropping "." from the default search path
>> for security reasons.
>
> Indeed, perldelta(1) tells me that in 5.24.1 (and 5.26, etc),
>
>   Core modules and tools no longer search "." for optional modules
>
> gitweb.perl contains
>
>  sub read_config_file {
>          my $filename = shift;
>          return unless defined $filename;
>          # die if there are errors parsing config file
>          if (-e $filename) {
>                  do $filename;
>
> which implies an @INC search but it is silly --- as the "-e" test
> illustrates, this never intended to search @INC.
>
> Documentation says "If you are absolutely certain that you want your
> script to load and execute a file from the current directory, then use
> a ./ prefix".  We can do that, like so:
>
> diff --git i/gitweb/Makefile w/gitweb/Makefile
> index cd194d057f..3160b6cc5d 100644
> --- i/gitweb/Makefile
> +++ w/gitweb/Makefile
> @@ -18,7 +18,7 @@ RM ?= rm -f
>  INSTALL ?= install
>
>  # default configuration for gitweb
> -GITWEB_CONFIG = gitweb_config.perl
> +GITWEB_CONFIG = ./gitweb_config.perl
>  GITWEB_CONFIG_SYSTEM = /etc/gitweb.conf
>  GITWEB_CONFIG_COMMON = /etc/gitweb-common.conf
>  GITWEB_HOME_LINK_STR = projects
>
> but that does not help if someone overrides GITWEB_CONFIG, and besides,
> it would be nicer to avoid the possibility of an @INC search altogether.
> Another alternative would be to use
>
> 	local @INC = ('.');
>
> Would that be better?
>
> Advice from someone more versed than I am in perl would be very welcome
> (hence the cc to Ævar).

It seems most sensible to follow the ./FILE.pl advice per
https://metacpan.org/pod/distribution/perl/pod/perl5260delta.pod#Removal-of-the-current-directory-(%22.%22)-from-@INC

Just:

    local @INC = '.';
    do 'FILE.pl';

Would do the same thing, but seems like a more indirect way to do it if
all we want is ./ anyway. FWIW to be pedantically bug-compatible with
the old version (we should not do this) it's:

    local @INC = (@INC, ".");
    do 'FILE.pl';

I.e. before our behavior was implicitly to check whether we had a local
FILE.pl, then loop through all of @INC to see if we found it there, and
finally come back to the file we did the -e check for.
