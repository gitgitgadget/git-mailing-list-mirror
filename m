Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1E7C1F404
	for <e@80x24.org>; Wed, 10 Jan 2018 17:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751624AbeAJRiB (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 12:38:01 -0500
Received: from mout.gmx.net ([212.227.15.19]:64113 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751106AbeAJRiA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 12:38:00 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MQzUc-1eR1ll3HkU-00UIBl; Wed, 10
 Jan 2018 18:37:55 +0100
Date:   Wed, 10 Jan 2018 18:37:54 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, git-packagers@googlegroups.com,
        git-for-windows@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.16.0-rc1
In-Reply-To: <xmqqy3l63dzy.fsf@gitster.mtv.corp.google.com>
Message-ID: <nycvar.QRO.7.76.6.1801101823420.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <xmqqbmi7ano1.fsf@gitster.mtv.corp.google.com> <nycvar.QRO.7.76.6.1801061354430.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1801062248160.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
 <xmqqy3l63dzy.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:/nu6vN2y7r5npx6Ak48wrrMIMGN9NC1G626Zm51lBSANllpdEgf
 adk4UnlLmNLqnK5z4eulbMcoIfdQNo6QBxaW1Rv3/wtG3+6u6MynigQoJMgWniSufKhTuUy
 7qaX01YrV8BXYcE+8Alo2TFNKTRPXAqOjoINSn/JuNs0paQ8TPnsYGvxAkqnETYLTIjdz4F
 i15TUAVSCP29OueOraURw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2LT7viMXM9A=:6mpVYjJqVxysBy8TQzO1HY
 8ZKjDV7IWXvFDbMHTWh5xnuEbYYMvTTZu0Teaqrn2ApzEhA3W+/dRelL11p4lqS+IwLJ1NcQ8
 yx6TJOTv0Ieou89jcKbBMu5YDY6056uL6rYBn+RfNLpgXOqu8W5doYfkzg7XkDoGRR5ZSsF/I
 MyYGRJgsShztuwtSynS7TbIfE2+fnxuq2U0//BySffeS41ZfnMtnAJH8KlFqm8EpmakGt5X/M
 LY9O8rGPKNxbqILBYm72ZjhumV1zD7op43vt7/pOl1wrwfeQ39YwRQtk8Wc5YPvSuhD0LixVI
 Jx3ElfV6qMHIngs/u8mQt+0DfwvEu3D8xZsVfH9l3UnuKKoCIE48isuWR/nD5dkUWKcKbpD05
 wMkvyXI1dURK+RQAWbI9OBqRdGmjeAM3YfyL5qzpJ2cQRvSQ99A/K7t4ZpXwOxdjDAqdrxp9V
 RqboUmKcNnHlTEHZMZOzrSa1EXNJKueVi+ifRiF/QZ+4+aCSg3NOOZjqjQFwRMPj5DrNqnQpN
 DJOBVB/Waxf+SXesr2zx5zdMftxFpcKqP5V8hx6T2lZ8s1nK5vFWy4rd0zHDZ7eRBoCX8EuF3
 gg1PhEzFfHIix6zZHxS1mu17CY9mssNXFV8JYovhoh11Hhffd/45x0cfDjQwXr0ldFGxZLn2Q
 F2odEgq8QyBM4IZa3nxxU9jLS/SZtVW9y1GaMLhykyL22SSdjzYoy9E6bwt56k/tGH+TvBGql
 RtR6Rzbwwg50mIWrs0FBMmSkeQ00cfDs8mqD3TJQPP5T65JDbUy7P+suduQ0dWdpFLG6DEOpu
 8qEKh4dqND3dqclhTqBhX8gcW6qx24i6MDqZ3JPeGVKlZQ6wfQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 9 Jan 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
> > index f1678851de9..470107248eb 100644
> > --- a/t/t0021/rot13-filter.pl
> > +++ b/t/t0021/rot13-filter.pl
> > @@ -31,7 +31,22 @@
> >  #
> >  
> >  use 5.008;
> > -use lib (split(/:/, $ENV{GITPERLLIB}));
> > +sub gitperllib {
> > +...
> > +	if ($ENV{GITPERLLIB} =~ /;/) {
> > +		return split(/;/, $ENV{GITPERLLIB});
> > +	}
> > +	return split(/:/, $ENV{GITPERLLIB});
> > +}
> 
> This cannot be the whole story for a few reasons.
> 
>  - In t/test-lib.sh we see this:
> 
>    GITPERLLIB="$GIT_BUILD_DIR"/perl/blib/lib:"$GIT_BUILD_DIR"/perl/blib/arch/auto/Git
>    export GITPERLLIB
> 
>    If this part wants to split with ';', then the joining needs to
>    be done with ';' to match, no?

No.

It is a lot more complicated than that. As you know, on Linux there is
this implicit assumption that path lists are colon-separated. As a
consequence, Cygwin does the same (because it would be too hard to port
all those Linux/Unix projects to stop assuming colon-separated path lists,
right?)

This is what Cygwin's Bash does (and hence the MSYS2 Bash used by Git for
Windows, too).

Then the MSYS2 Bash calls git.exe, which is *not* an MSYS2 program, hence
the MSYS2 runtime knows that it has to convert the path lists to Windows
paths separated by semicolons.

The next thing happening in our case is that the Perl script is called
from git.exe. Now, the MSYS2 runtime (implicitly spun up by the MSYS2 Perl
interpreter) does *not* convert those path lists back to Unix-like paths
separated by colons.

And that's why the Unix shell script can happily construct the
colon-separated list, and the Perl script will *still* receive the
semicolon-separated version of it.

>  - In addition to t0021, there are similar split with colon in 0202,
>    9000 and 9700, yet I am getting the feeling that you observed the
>    issue only in0021, to which I do not think of a good explanation
>    why.

Here is the good explanation: t0021 relies on a Perl package that is not
yet installed. t0202 relies on Git::I18N, of which there is a version
installed in Git for Windows' SDK. (I do not bother to slow down the test
runs by the Subversion tests, I always skip all of them, that's why t9*
does not matter to me.)

Granted, that is a bug, and an old one at that: the test suite should test
what is in the current revision, not what happens to be installed into the
system locations.

But this late in the game, I am really uncomfortable with the idea to rush
through an equivalent fix to all Perl scripts: who knows what it breaks?

Ciao,
Dscho
