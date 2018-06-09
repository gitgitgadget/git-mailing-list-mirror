Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 904981F403
	for <e@80x24.org>; Sat,  9 Jun 2018 21:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753377AbeFIVSS (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 17:18:18 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:35088 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753254AbeFIVSR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 17:18:17 -0400
Received: by mail-ua0-f194.google.com with SMTP id s13-v6so7706765uad.2
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 14:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G+oJ9o7bt4sWFac6TavJ+lbYdedap6pdS/we5AruBaM=;
        b=CBovoEeDzbMGRU6XJajXwC8BNRibtr2R6DeN/hQ75AA1xZtHeolo2zLmIMdKGg/sZi
         qsNYde7bMqRBg2fgK5/1lDmBc9VIucils2T8Uvyp8KsVTYD7xCtkzrwP023NxCc6znvj
         8rsI38pOJW/ggXu5sZSlaI24TlFQntxH5clMyTskCsP6OUzVRgBoUUxTCxZgqNfhwxmp
         eVeEUOCh67YryDvQdV7iZAfeFW3KQ/zLVeNpnn6fuN0fNZNd/5OmnDnnjkQ7sbj6K/fr
         yld+sqI3LHtnqvZIeojj00S8QJ5tc9fEz3ksvQ4oUOf/o3RIB+6/Ituv8xbmw+Vvc2P8
         Km4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G+oJ9o7bt4sWFac6TavJ+lbYdedap6pdS/we5AruBaM=;
        b=b9rQDKSPeS/X/kL9MQEhRYXT4Ue+Okulu40DwYxen1zfnl4S7MFP1T57LGlsFwlkV4
         8pyYXoP/21+ytZAhGRcKKWbyKqMwYeqMKX9alFmDbsUk80hRnstHqHIIcyJwzxvEw/K6
         gwETZnVuiGS4VIfkVfDZl3ZuBBs/Ro3Hj1qv4RboMzUZ4B21VSvdXkEFYrMi4wadMJwD
         OsO9FY6PVZsAhuAe5aUbztYNrnhcTwGL9mju5plgHmZyA3mX7kINLZ8+XK2w1OBidNv5
         WeOw+h4KXiR+VyJn01xQPip1ylhiiMcpSIF7qWEBDN4K1obvNu1Vi8GJx9U7+vFdNbcA
         3vag==
X-Gm-Message-State: APt69E3sqCE+ZzeLX16FfcdBAT8xF5r1DuqVW/yOywJ60iai9L2R3d0+
        /ALFcFzr0D5w7npME8JnAOZL5kVCmWG6jrhb/z4=
X-Google-Smtp-Source: ADUXVKKfp35SHs/iyDFwKqIVZHcDBGvPiTjLuG7frsWmmceAcOHX3MPA3YwNu8GdyUQYwRarYejFC5syVKAUPKU0v1k=
X-Received: by 2002:ab0:22:: with SMTP id 31-v6mr3976659uai.151.1528579096683;
 Sat, 09 Jun 2018 14:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180607051958.759-1-tmz@pobox.com>
In-Reply-To: <20180607051958.759-1-tmz@pobox.com>
From:   Luis Marsano <luis.marsano@gmail.com>
Date:   Sat, 9 Jun 2018 17:18:04 -0400
Message-ID: <CAHqJXRHGq9ofPcCzffUbTmuL6fuoB=33aZnwqNdqYy+nAVA_gw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] contrib/credential/netrc Makefile & test improvements
To:     tmz@pobox.com
Cc:     git@vger.kernel.org, Ted Zlatanov <tzz@lifelogs.com>,
        avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for looking into this and addressing these issues.

On Thu, Jun 7, 2018 at 1:20 AM Todd Zullinger <tmz@pobox.com> wrote:
>
> Hi,
>
> I noticed failures from the contrib/credential/netrc tests
> while building 2.18.0 release candidates.  I was surprised
> to see the tests being run when called with a simple 'make'
> command.
>
> The first patch in the series adds an empty 'all::' make
> target to match most of our other Makefiles and avoid the
> surprise of running tests by default.  (When the netrc
> helper was added to the fedora builds, it copied the same
> 'make -C contrib/credential/...' pattern from other
> credential helpers -- despite the lack of anything to
> build.)

I think this is a good idea.

> The actual test failures were initially due to my build
> environment lacking the perl autodie module, which was added
> in 786ef50a23 ("git-credential-netrc: accept gpg option",
> 2018-05-12).

I added 'use autodie;' without realizing it had external dependencies.
According to the documentation
http://perldoc.perl.org/autodie.html
it's a pragma since perl 5.10.1
Removing 'use autodie;' should be fine: it's not critical.

> After installing the autodie module, the failures were due
> to the build environment lacking a git install (specifically
> the perl Git module).  The tests needing a pre-installed
> perl Git seemed odd and worth fixing.

I mistakenly thought 'use lib (split(/:/, $ENV{GITPERLLIB}));' in
test.pl handled this.
Since it doesn't, and I was only following an example from
t/t9700/test.pl that doesn't fit, this line should be removed and it
might make more sense to set the environment from
t-git-credential-netrc.sh near '. ./test-lib.sh', which also sets the
environment.
Something like

diff --git a/contrib/credential/netrc/t-git-credential-netrc.sh
b/contrib/credential/netrc/t-git-credential-netrc.sh
index 58191a6..9e18611 100755
--- a/contrib/credential/netrc/t-git-credential-netrc.sh
+++ b/contrib/credential/netrc/t-git-credential-netrc.sh
@@ -23,5 +23,6 @@
        # The external test will outputs its own plan
        test_external_has_tap=3D1

+       export PERL5LIB=3D"$GITPERLLIB"
        test_external \
     'git-credential-netrc' \

Your solution, however, is reasonable, and I don't know which is preferred.

> The second patch in the series aims to fix this.  I'm not
> sure if there's a better or more preferable way to fix this,
> which is one of the reasons for the RFC tag. (It's also why
> I added you to the Cc =C3=86var, as you're one of the
> knowledgeable perl folks here.)
>
> The other reason for the RFC tag is that I'm unsure of how
> to fix the last issue I found.  The tests exit cleanly even
> when there are failures, which seems undesirable.  I'm not
> familiar with the perl test_external framework to suggest a
> fix in patch form.  It might be a matter of adding something
> like this, from t/t9700/test.pl:
>
>     my $is_passing =3D eval { Test::More->is_passing };
>     exit($is_passing ? 0 : 1) unless $@ =3D~ /Can't locate object method/=
;
>
> ?  But that's a wild guess which I haven't tested.

Good idea.
It looks like you found an issue with t/t9700/test.pl, too.
When altered to fail, it first reports ok (then reports failed and
returns non-0).

not ok 46 - unquote simple quoted path
not ok 47 - unquote escape sequences
1..47
# test_external test Perl API was ok
# test_external_without_stderr test no stderr: Perl API failed: perl
/home/luism/project/git/t/t9700/test.pl:
$ echo $?
1

To make git-credential-netrc tests behave correctly, I ended up making
the changes below.
They might be okay, unless someone knows better.

diff --git a/contrib/credential/netrc/t-git-credential-netrc.sh
b/contrib/credential/netrc/t-git-credential-netrc.sh
index 58191a6..9e18611 100755
--- a/contrib/credential/netrc/t-git-credential-netrc.sh
+++ b/contrib/credential/netrc/t-git-credential-netrc.sh
@@ -23,9 +23,10 @@
        # The external test will outputs its own plan
        test_external_has_tap=3D1

+       export PERL5LIB=3D"$GITPERLLIB"
        test_external \
     'git-credential-netrc' \
-    perl "$TEST_DIRECTORY"/../contrib/credential/netrc/test.pl
+    perl "$GIT_BUILD_DIR"/contrib/credential/netrc/test.pl

        test_done
 )
diff --git a/contrib/credential/netrc/test.pl b/contrib/credential/netrc/te=
st.pl
index 1e10010..abc9081 100755
--- a/contrib/credential/netrc/test.pl
+++ b/contrib/credential/netrc/test.pl
@@ -1,6 +1,4 @@
 #!/usr/bin/perl
-use lib (split(/:/, $ENV{GITPERLLIB}));
-
 use warnings;
 use strict;
 use Test::More qw(no_plan);
@@ -12,7 +10,6 @@ BEGIN
        # t-git-credential-netrc.sh kicks off our testing, so we have to go
        # from there.
        Test::More->builder->current_test(1);
-       Test::More->builder->no_ending(1);
 }

 my @global_credential_args =3D @ARGV;
@@ -104,6 +101,9 @@ BEGIN

 ok(scalar keys %$cred =3D=3D 2, 'Got keys decrypted by command option');

+my $is_passing =3D eval { Test::More->is_passing };
+exit($is_passing ? 0 : 1) unless $@ =3D~ /Can't locate object method/;
+
 sub run_credential
 {
        my $args =3D shift @_;
