Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C8131F453
	for <e@80x24.org>; Wed, 30 Jan 2019 19:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387609AbfA3T1H (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 14:27:07 -0500
Received: from mout.gmx.net ([212.227.15.15]:38077 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbfA3T1H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 14:27:07 -0500
Received: from MININT-6BKU6QN ([62.119.166.9]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MTBsk-1ghg0M1qVS-00S98Y; Wed, 30
 Jan 2019 20:26:56 +0100
Date:   Wed, 30 Jan 2019 20:26:39 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>
cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH (Apple Git) 10/13] Support for Xcode.app co-exestince
 and relocation
In-Reply-To: <20190129193818.8645-11-jeremyhu@apple.com>
Message-ID: <nycvar.QRO.7.76.6.1901302025490.41@tvgsbejvaqbjf.bet>
References: <20190129193818.8645-1-jeremyhu@apple.com> <20190129193818.8645-11-jeremyhu@apple.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:JavjSA/DgqWPvA+BN2BhOre6pbk04j3/bxCWPQTxxubC2a7bevt
 O4onvLyFUy79eJ8tXwLsx7pQtBskKYbhkzKzS6iHlGWW//UXQAjbAh+s6r67a495e+jgs+2
 TA7fzBWHszz8z44ZYIqqeHbGuvoawsrmhRFtWdO3ZnnkRiZW92E2p8e+vLW8G+rLPfkPB8c
 uLE6ufQgbcVsB3rP9AW8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YdwzlvQgL7M=:y/yqCAQ67l3eEyprhZjsBi
 dQrb7JVVfjcVUXlVwfM3C2CCi7lEL36l/VmzWyExtPcMdC4ddr5hiBhs1R5R4i4ASnz8YQxLy
 G4+7HSfUl/NP4VjBUHqzV3Nd/kcrmCs82lYeW75YD3m+AZJeBl2k2K79iueAKdBvAxqmXRGz4
 ofVZglVTgYcXegqNwqoScn4rk2T5rXpvWyprS/gYxZec0tvb2DqHQwpsp25oiZweU7wlPeeoR
 yFmujblhqEj6SBDoYdjP5NeJAyoG/nFoEp3E2Hm3pjqjUOFumj+8EpuUPifH1otBZTmyMTEUZ
 5a1NX0+wX0NAOguXU2fObSMqf5Sq/papU5FlLhAR6I22umXH5WWngVP6GHCe/5Te6vARLwJD6
 Thgm3YImvTlwWpIBwg9tt8W7+HIZQsiyKVLM+/dhtnMLy6gk5Ke3YvsTtGINYqCdad8qGXwJw
 cRYmLPNj90q+mxwdFXFS8Zyu4o1C8XCN3zupFbvj8nu+/oYYrSXL1GPPpQwDXcCPHlKe1rcy6
 JcPzZIgEex/fk99F9P069HG4hEIF5+fPhFpKQUUmR7OTFa4zKqbW/98fL4etVJJeLZHv3ZDnP
 vXXnMhtd4Ps0HGrOLp3JNSaNquyGlN6IYug162GcGfmtupHS5OL/PvHukJmFDv4vVy3Gay1gV
 13q+SQKl+c2ZJT5hK6nmLeIWAywkqkBKQHdOnwNFdqcevh1f2yQ/1X2civYUFRTbRuwky/W2S
 rEBydksRcMkS5YiewePW3HHmkAAfH57oSqu3+PxU4MiOfYghqmgvad6WGEuEhjW9B/3W5CWxK
 HRQjEvLkS++sYi6kezpLumMLMqnT/0V0APq2CxC6ND9UbkGWX9cBe2Fy6D1igJm1/07vpFOoj
 r+tHVs43h5BO4timZ+Wh+dtU6ar+e9UE1MMuqOSWFrX+aLKmzRQAK/mYC6CcU9NQ6IXmXAWYP
 KMBO4bCfWww==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeremy,

On Tue, 29 Jan 2019, Jeremy Huddleston Sequoia wrote:

> This patch has been trimmed down significantly from its original version
> when rebasing on top of git 2.18 because git 2.18 included support for
> runtime prefix support for darwin, making this patch mostly duplicative.
> 
> The remaining changes are needed to ensure that git-perl can find the
> subversion perl module (which relocates with it) and handle relocation
> of python scripts.
> 
> Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>

I am really curious about this kind of problem now. Is it that you want to
bundle a Perl inside a portable Git, and that Perl is not at all
relocatable and so you force Git to pretend that it is?

Ciao,
Johannes

> ---
>  Makefile                                      |  3 +++
>  .../runtime_prefix.template.pl                | 25 +++++++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index 60711d6abe..97f46444f5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2171,6 +2171,7 @@ GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES Makefile
>  	sed -e 's=@@PATHSEP@@=$(pathsep)=g' \
>  	    -e "s=@@INSTLIBDIR@@=$$INSTLIBDIR=g" \
>  	    -e 's=@@PERLLIBDIR_REL@@=$(perllibdir_relative_SQ)=g' \
> +	    -e 's=@@PERLVERSION@@=$(shell grep DEFAULT /usr/local/versioner/perl/versions | sed 's:^.*= *\([^ ]*\)$$:\1:')=g' \
>  	    -e 's=@@GITEXECDIR_REL@@=$(gitexecdir_relative_SQ)=g' \
>  	    -e 's=@@LOCALEDIR_REL@@=$(localedir_relative_SQ)=g' \
>  	    $< >$@+ && \
> @@ -2206,6 +2207,8 @@ $(SCRIPT_PYTHON_GEN): GIT-CFLAGS GIT-PREFIX GIT-PYTHON-VARS
>  $(SCRIPT_PYTHON_GEN): % : %.py
>  	$(QUIET_GEN)$(RM) $@ $@+ && \
>  	sed -e '1s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
> +	    -e 's|\(os\.getenv("GITPYTHONLIB"\)[^)]*)|\1,"@@INSTLIBDIR@@")|' \
> +	    -e 's|"@@INSTLIBDIR@@"|os.path.realpath(os.path.dirname(sys.argv[0])) + "/../../share/git-core/python"|g' \
>  	    $< >$@+ && \
>  	chmod +x $@+ && \
>  	mv $@+ $@
> diff --git a/perl/header_templates/runtime_prefix.template.pl b/perl/header_templates/runtime_prefix.template.pl
> index 9d28b3d863..b0b6b0bef1 100644
> --- a/perl/header_templates/runtime_prefix.template.pl
> +++ b/perl/header_templates/runtime_prefix.template.pl
> @@ -1,3 +1,28 @@
> +# BEGIN XCODE RUNTIME_PREFIX generated code
> +BEGIN {
> +    use File::Spec;
> +    my $PERLVERSION = "@@PERLVERSION@@";
> +    if ($^V =~ m/v([0-9]+).([0-9]+)/) {
> +        $PERLVERSION = $1.".".$2;
> +    }
> +    my $__prefix = File::Spec->rel2abs( __FILE__ );
> +
> +    if ($__prefix =~ m/\/libexec\/git-core\// ) {
> +        $__prefix =~ s/\/libexec\/git-core\/.*//;
> +        unshift @INC, $__prefix . "/share/git-core/perl";
> +        unshift @INC, $__prefix . "/../Library/Perl/".$PERLVERSION."/darwin-thread-multi-2level";
> +    } elsif ($__prefix =~ m/\/bin\// ) {
> +        $__prefix =~ s/\/bin\/.*//;
> +        unshift @INC, $__prefix . "/share/git-core/perl";
> +        unshift @INC, $__prefix . "/../Library/Perl/".$PERLVERSION."/darwin-thread-multi-2level";
> +    } elsif ( $__prefix =~ m/\/usr\// ) {
> +        $__prefix =~ s/\/usr\/.*/\/usr/;
> +        unshift @INC, $__prefix . "/share/git-core/perl";
> +        unshift @INC, $__prefix . "/../Library/Perl/".$PERLVERSION."/darwin-thread-multi-2level";
> +    }
> +}
> +# END XCODE RUNTIME_PREFIX generated code.
> +
>  # BEGIN RUNTIME_PREFIX generated code.
>  #
>  # This finds our Git::* libraries relative to the script's runtime path.
> -- 
> 2.20.0 (Apple Git-115)
> 
> 
