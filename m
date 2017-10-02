Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 656CE20281
	for <e@80x24.org>; Mon,  2 Oct 2017 23:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751866AbdJBXAV (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 19:00:21 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:50008 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbdJBXAU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 19:00:20 -0400
Received: by mail-pg0-f46.google.com with SMTP id v13so3737163pgq.6
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 16:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hxEZug8AeOlHrJ0PNQgVkn71fj0mmM1nJkqpn/dTYNU=;
        b=LG+lHCEV6VxoyFDX01or6MVNMktMQX7BKLnSGt2Zu+j3XyS8dc3hkF/Aj5O5XZJ6tP
         9ZAFkCZOyrbBIEx7LtpG4/Y2i9oq33LgSniUCGkDImkDNhSLwNmm6kde+In2BsSVwF+C
         SuC2XWDqMT3Sx8E4SDwQyTEbsA+Qx/waF6kvbqJYctS0YDuknpJyC2OwcayDDguax3WI
         O1af7pI1V04fua+hat9GPibSEbSwDXmCekIldNnrY0gfSuvFitoa1M3D+oiyIrF+SQEX
         Qyg1zixqoB7LZ++5zbodagBQvCzI1SPNehYovju7h851D8GTdVHs3xbsMLfh/KL7N/TI
         /g6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hxEZug8AeOlHrJ0PNQgVkn71fj0mmM1nJkqpn/dTYNU=;
        b=H+gWo+sCfe1P6hUGkXvmos2IZc6WdCmbm11LGkBgfeGdHYeWOn85ab7GOw+Rl5Jwgj
         35h6zY7ZgwtKfIs8klDvrrlF9rlvTcxV53/s8N/o+z2PA/9RWJDbu0JN2ajVccPmZMTL
         2oUkTVtZmuEJ9UCzQUvf08Qdu6qpq51OzZwseq0oNSmEfMIFFGwtu+xANHdMkz4ld6j8
         Nc8yjiFtBzWOxbIrcaGA3bEkvQTT1v9/9AWqaH/rnaIjr1M1ByKGt/UsEOnZKZjy9l5y
         EcikwaaMGOsYcMdrIe/4MykZMM8tZj/Izk9aHAuuNQuVs6M8/SNHa0E7rdNAUkcL1vRW
         oajw==
X-Gm-Message-State: AHPjjUj55DXiw7ZRJOuQfQZ39KylUGQxOR33A/5tEMbgQmqoEKcK3Qi/
        DQyHF837Q+xC5eppe7YXkfuy9IlX
X-Google-Smtp-Source: AOwi7QC3qQGAh9q+/1frfnTAgAo6MWoXis4w2YB5wMInOjt5a9ryctUByV+ypMkOYMvQZtoAXh1L6w==
X-Received: by 10.159.208.69 with SMTP id w5mr15387847plz.381.1506985219945;
        Mon, 02 Oct 2017 16:00:19 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:c1fd:a9ac:f156:8142])
        by smtp.gmail.com with ESMTPSA id k67sm15657913pga.46.2017.10.02.16.00.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 02 Oct 2017 16:00:19 -0700 (PDT)
Date:   Mon, 2 Oct 2017 16:00:17 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Toni Uebernickel <tuebernickel@gmail.com>
Cc:     git@vger.kernel.org, Tsvi Mostovicz <ttmost@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: Updated to v2.14.2 on macOS; git add --patch broken
Message-ID: <20171002230017.GT19555@aiede.mtv.corp.google.com>
References: <86D0A377-8AFD-460D-A90E-6327C6934DFC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86D0A377-8AFD-460D-A90E-6327C6934DFC@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Toni Uebernickel wrote:

> I updated to git version v2.14.2 on macOS using homebrew.
>
> Since then `git add --patch` and `git stash save --patch` are not
> working anymore. It's just printing the complete diff without ever
> stopping to ask for actions. This results in an unusable state, as
> the whole command option is rendered useless.

Would a patch like the following help?

I am worried that other scripts using diff-files would need the same
kind of patch.  So it seems worthwhile to look for alternatives.

An alternative would be to partially roll back v2.14.2~61^2~4 (color:
check color.ui in git_default_config, 2017-07-13) by making it not
take effect for plumbing commands (i.e., by adding a boolean to
"struct startup_info" to indicate whether a command is low-level
plumbing).  That would make the behavior of Git harder to explain so I
don't particularly like it.  Plus it defeats the point of the patch.

Yet another alternative would be to treat color.ui=always as a
deprecated synonym for color.ui=auto.  I think that's my preferred
fix.

What do you think?

Thanks again for reporting,
Jonathan

diff --git i/git-add--interactive.perl w/git-add--interactive.perl
index 28b325d754..4ea69538c7 100755
--- i/git-add--interactive.perl
+++ w/git-add--interactive.perl
@@ -101,49 +101,49 @@ sub apply_patch_for_stash;
 
 my %patch_modes = (
 	'stage' => {
-		DIFF => 'diff-files -p',
+		DIFF => 'diff-files --no-color -p',
 		APPLY => sub { apply_patch 'apply --cached', @_; },
 		APPLY_CHECK => 'apply --cached',
 		FILTER => 'file-only',
 		IS_REVERSE => 0,
 	},
 	'stash' => {
-		DIFF => 'diff-index -p HEAD',
+		DIFF => 'diff-index --no-color -p HEAD',
 		APPLY => sub { apply_patch 'apply --cached', @_; },
 		APPLY_CHECK => 'apply --cached',
 		FILTER => undef,
 		IS_REVERSE => 0,
 	},
 	'reset_head' => {
-		DIFF => 'diff-index -p --cached',
+		DIFF => 'diff-index --no-color -p --cached',
 		APPLY => sub { apply_patch 'apply -R --cached', @_; },
 		APPLY_CHECK => 'apply -R --cached',
 		FILTER => 'index-only',
 		IS_REVERSE => 1,
 	},
 	'reset_nothead' => {
-		DIFF => 'diff-index -R -p --cached',
+		DIFF => 'diff-index --no-color -R -p --cached',
 		APPLY => sub { apply_patch 'apply --cached', @_; },
 		APPLY_CHECK => 'apply --cached',
 		FILTER => 'index-only',
 		IS_REVERSE => 0,
 	},
 	'checkout_index' => {
-		DIFF => 'diff-files -p',
+		DIFF => 'diff-files --no-color -p',
 		APPLY => sub { apply_patch 'apply -R', @_; },
 		APPLY_CHECK => 'apply -R',
 		FILTER => 'file-only',
 		IS_REVERSE => 1,
 	},
 	'checkout_head' => {
-		DIFF => 'diff-index -p',
+		DIFF => 'diff-index --no-color -p',
 		APPLY => sub { apply_patch_for_checkout_commit '-R', @_ },
 		APPLY_CHECK => 'apply -R',
 		FILTER => undef,
 		IS_REVERSE => 1,
 	},
 	'checkout_nothead' => {
-		DIFF => 'diff-index -R -p',
+		DIFF => 'diff-index --no-color -R -p',
 		APPLY => sub { apply_patch_for_checkout_commit '', @_ },
 		APPLY_CHECK => 'apply',
 		FILTER => undef,
