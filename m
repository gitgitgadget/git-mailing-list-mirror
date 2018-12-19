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
	by dcvr.yhbt.net (Postfix) with ESMTP id A1F621F405
	for <e@80x24.org>; Wed, 19 Dec 2018 13:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbeLSNnH (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 08:43:07 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:35226 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbeLSNnH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 08:43:07 -0500
Received: by mail-wm1-f54.google.com with SMTP id c126so6494588wmh.0
        for <git@vger.kernel.org>; Wed, 19 Dec 2018 05:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=//cu2c4TA6wG3HHEI23cQ51TtL9Aq+7/yxjL4izTg9o=;
        b=U4WnDt1KaJb8HmE//lsQUfK0X8NSvV32+1XnG9h/7rQ1303p5rbxfSjkPGO69nFYZr
         y7Ll7UTGPcYmK+0jOgEHQwAVp/UB0DLOKMBNdEO9f3c3h4vnhvmIMLMP3xtZXZ0QO9ks
         jYCk/XF+QwdTVfxlzI/xsvg4jwt5H3wZPRDaCN0LqwWn0q7R4DgckYOlVeLoJKtae67t
         fWm4t8ah0KYtKB5XpNz5f04e42rWq8kw7VPdsbJ69QvC+4cVaeaks+CziqXhGZ7nz73S
         o+XhvKHiATwmPG0iastqruH+NZn9EBdq+56IHIdk/p23XRujRQ+OZEfbKPgTuUOM1jB5
         Qd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=//cu2c4TA6wG3HHEI23cQ51TtL9Aq+7/yxjL4izTg9o=;
        b=m93G7mJULpEImz6lIv+CUTPfWgEXzAb0X10nvlVVu860+v+qwcStzIRPRMrUIVqRXe
         bDEJCvTWpDOsiGJHjJekODMfkvXAgu6fYsn36D89u0qKGivDfpCYGU3IkONNh6VVF+78
         ZGp2xoq9TRN7miiieRdj/Bt7lQ/zDag5FR5i/ohaISiWfjoeZFTslNUY2Ah26qoETqoV
         wnsGiTIASDoJ2R/OIo4Dswot+XA2WeGuUevAedqwbVYCF9A9YOFlHPTrVJ+2ZcQuVpCh
         xXG3mm5E0dZZshGWe1E80EV1EFtQG6L6rUKmoJ2bwvzAPdJzUC7qlVNTdwMlzMLLzINP
         VoRw==
X-Gm-Message-State: AA+aEWalDo8fyAaFKA2kmnJT/oid79AqITViYXQRp3fA8epUaFHbUvJ2
        jH0pJ9liFT0zcJL6hkoeRqCM9J1z
X-Google-Smtp-Source: AFSGD/VFNO5jxohavR/H8pDz+wEZ3gQj4J6HNmcLwyzE1EG/8yEgsU35Tkn/J7e31Ea3F9RaVFTgFQ==
X-Received: by 2002:a1c:11c1:: with SMTP id 184mr6904066wmr.59.1545226984415;
        Wed, 19 Dec 2018 05:43:04 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id c9sm6404751wmh.27.2018.12.19.05.43.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 05:43:03 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     John Passaro <john.a.passaro@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Can git choose perl at runtime?
References: <CAJdN7Kioa22xrDP2ssZXmBbu7KDkcr2MQCUDW=Tzm5ydzeChBQ@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAJdN7Kioa22xrDP2ssZXmBbu7KDkcr2MQCUDW=Tzm5ydzeChBQ@mail.gmail.com>
Date:   Wed, 19 Dec 2018 14:43:10 +0100
Message-ID: <87a7l1fx8x.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 19 2018, John Passaro wrote:

> I recently submitted my first patch using OSX and found the experience
> frustrating, for reasons that have come up on the list before,
> concerning git-send-email and perl dependencies that you need to be
> root to update.
>
> Last seen here:
> https://public-inbox.org/git/878t55qga6.fsf@evledraar.gmail.com/
>
> The struggle is that Mac's package manager Homebrew has opted,
> apparently with some finality, to no longer support linking to a user
> perl at build time. PERL_PATH is hard-coded to link to the system
> perl, which means the user needs sudo to install the SSL libraries
> required for send-email. So for send-email to work, you need to either
> sudo cpan or build git yourself. The obvious solution here would be to
> do /usr/bin/env perl, but in the above message Aevar pointed out
> pitfalls with that.
>
> It seems that choosing perl at compile time necessarily comes with
> tradeoffs. So I wonder if there is a way we can support choosing a
> perl at runtime without breaking the existing mechanism of linking to
> perl at compile time.
>
> I'm picturing adding an executable "git-perl" to libexec that checks
> config core.perlPath and envvar GIT_PERL_PATH, in some order. Having
> chosen one of these or the build-time PERL_PATH as a last resort, it
> exec's the correct perl executable.
>
> Then relevant scripts (e.g. git-add--interactive, git-send-email)
> invoke git-perl instead of /usr/bin/perl, and the makefile no longer
> replaces that with PERL_PATH -- instead that will be used at runtime
> via git-perl when we can be sure the user does not explicitly prefer
> something different.
>
> That does mean we have a new command to support and document: "git
> perl". If it is preferred to keep this hidden as an implementation
> detail, we could call the executable something like "util-git-perl"
> instead so that it doesn't show up when scanning libexec for git
> commands.
>
> Does this seem like a good idea? I'd be happy to work on a patch.

I see no problem with this. As I noted in my message you linked to doing
this unconditionally is a bad idea, but we can just do it with a config,
e.g. this works:

    diff --git a/perl/header_templates/fixed_prefix.template.pl b/perl/header_templates/fixed_prefix.template.pl
    index 857b4391a4..f96e2ecd11 100644
    --- a/perl/header_templates/fixed_prefix.template.pl
    +++ b/perl/header_templates/fixed_prefix.template.pl
    @@ -1 +1,7 @@
    +BEGIN {
    +    chomp(my $perlPath = `git config --get core.perlPath`);;
    +    if ($perlPath and $^X ne $perlPath) {
    +       exec($perlPath, $0, @ARGV);
    +    }
    +}
     use lib (split(/@@PATHSEP@@/, $ENV{GITPERLLIB} || '@@INSTLIBDIR@@'));

Here you just optionally set core.perlPath in your config and if set
it'll chainload to the new interpreter you point at.

I leave wondering if you also want a setting for @INC there, dealing
with perl/header_templates/runtime_prefix.template.pl and docs/tests as
an exercise for the reader :)
