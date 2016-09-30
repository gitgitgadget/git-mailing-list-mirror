Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38DE3207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 17:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933315AbcI3RxG (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 13:53:06 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35523 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932430AbcI3RxF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 13:53:05 -0400
Received: by mail-wm0-f65.google.com with SMTP id b4so4487554wmb.2
        for <git@vger.kernel.org>; Fri, 30 Sep 2016 10:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=XuptzI1HWUFAI/gbuZYLIiZcf7exPBNrySvPPMDFqeg=;
        b=aR/a/81kbLXssXXirpcIA4an5COqdDJNm3OnXIhdIeNisPjZgUR69vMDNa2pwaJ5QA
         0hdOuwnZII+kf2L3pc1VAx2+WHtXu36PfSSfhXiAnLf5TMbgUjTMH0r1mWTbgqAl30fg
         Sa2lckbLikbiMxGEBdTY+1sYNlUMohqF158neKDZ1pP2aSn/Q/UBRypDnvWlVufpL8L2
         lF7ZLvlSHOgZutheeNWaZc3op97hNt2hwwux2T1TRvWTmMRk7YUhSXqh+YzJqZPWwZ5A
         IXIZi5uA0PYdhxuKYg8G3WwXagMZd77K6w541vghiEAsrSfeFgrvV3+BWYab3JWzNg5s
         EkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=XuptzI1HWUFAI/gbuZYLIiZcf7exPBNrySvPPMDFqeg=;
        b=V7fSQ8g0Yht2R9b87elaJziuw28uJbJUMmiuyxyDuxFHwQeivcc9SnS3b2a2j0Ks/n
         SSTT3fZY9YSJQAfFZ0ku3yk0g17zCIa/mqddY9C3b7Q1AW753oKZXB6CM1coTuHRs0I8
         ugRrAr0muuQGhwkkO7s2yH410wBZ3n00oBIGxgXiEIqIbBNgtLxyaM72qWY68aVoCkkC
         K87VPZyoU8pikMSJuXTQo7taJBWoGiKPYJI2lXpLeRM3scHsYj7V4Xrt23MvBpj972zr
         BJ+a8JlezYfVOFOsCuqQbZRKD+on8QNXJEoeHtj1YjkrJpg8Zmg7gewdUzg4lRZESb/2
         VJkw==
X-Gm-Message-State: AA6/9RnVmYHJGPZWcQqI/Aa3YLu3CyMFY0uX4dek/5cS9rUKE/85HL4y4dCOCAc7n+ZpTQ==
X-Received: by 10.194.202.133 with SMTP id ki5mr7695556wjc.45.1475257983227;
        Fri, 30 Sep 2016 10:53:03 -0700 (PDT)
Received: from [192.168.1.26] (afo182.neoplus.adsl.tpnet.pl. [83.25.144.182])
        by smtp.googlemail.com with ESMTPSA id zz9sm18183742wjb.36.2016.09.30.10.53.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Sep 2016 10:53:01 -0700 (PDT)
Subject: Re: [PATCH v2 03/11] i18n: add--interactive: mark strings with
 interpolation for translation
To:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
 <1472646690-9699-4-git-send-email-vascomalmeida@sapo.pt>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <b8c25ae3-143c-3e9b-0c7b-115a9b4756ae@gmail.com>
Date:   Fri, 30 Sep 2016 19:52:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1472646690-9699-4-git-send-email-vascomalmeida@sapo.pt>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 31.08.2016 o 14:31, Vasco Almeida pisze:

> Use of sprintf following die or error_msg is necessary for placeholder
> substitution take place.

No, it is not.  Though I don't think that we have in out Git::I18N
the support for Perl i18n placeholder substitution.

From gettext manual:
https://www.gnu.org/software/gettext/manual/gettext.html#perl_002dformat

  15.3.16 Perl Format Strings

  There are two kinds format strings in Perl: those acceptable to the Perl
  built-in function printf, labelled as ‘perl-format’, and those acceptable
  to the libintl-perl function __x, labelled as ‘perl-brace-format’.

  Perl printf format strings are described in the sprintf section of
  ‘man perlfunc’.

  Perl brace format strings are described in the Locale::TextDomain(3pm)
  manual page of the CPAN package libintl-perl. In brief, Perl format uses
  placeholders put between braces (‘{’ and ‘}’). The placeholder must have
  the syntax of simple identifiers.
 
Git doesn't use Locale::TextDomain, from what I understand, to provide
fallback in no-gettext case.  Also, Locale::TextDomain is not in core.

The syntax, with the help of shorthand helper function, looks like this:
http://search.cpan.org/dist/libintl-perl/lib/Locale/TextDomain.pm#EXPORTED_FUNCTIONS
https://metacpan.org/pod/Locale::TextDomain#EXPORTED-FUNCTIONS

  __x MSGID, ID1 => VAL1, ID2 => VAL2, ...
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  One of the nicest features in Perl is its capability to interpolate
  variables into strings:

    print "This is the $color $thing.\n";

  This nice feature might con you into thinking that you could now write

    print __"This is the $color $thing.\n";

  [But this doesn't work...]

  [...] The Perl backend to GNU gettext has defined an alternative format
  [to using printf / sprintf] for interpolatable strings:

    "This is the {color} {thing}.\n";

  Instead of Perl variables you use place-holders (legal Perl variables
  are also legal place-holders) in curly braces, and then you call

    print __x ("This is the {color} {thing}.\n", 
               thing => $thang,
               color => $color);

> Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
> ---
>  git-add--interactive.perl | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index e11a33d..4e1e857 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -612,12 +612,12 @@ sub list_and_choose {
>  			else {
>  				$bottom = $top = find_unique($choice, @stuff);
>  				if (!defined $bottom) {
> -					error_msg "Huh ($choice)?\n";
> +					error_msg sprintf(__("Huh (%s)?\n"), $choice);

So this would be, self explained without need of comment
for translators:

  +					error_msg __x ("Huh ({choice})?\n"), choice => $choice);


>  					next TOPLOOP;
>  				}

Though this is probably more work that you wanted to do.
The __x might be defined like this (borrowing from Locale::TextDomain),
which needs to be put into perl/Git/I18N.pm

  sub __ ($);
  sub __expand ($%);

  # With interpolation.
  sub __x ($@)
  {
  	my ($msgid, %vars) = @_;

  	return __expand (__($msgid), %vars);
  }
  
  sub __expand ($%)
  {
  	my ($translation, %args) = @_;
    
  	my $re = join '|', map { quotemeta $_ } keys %args;
  	$translation =~ s/\{($re)\}/defined $args{$1} ? $args{$1} : "{$1}"/ge;

  	return $translation;
  }



Best regards,
-- 
Jakub Narębski
