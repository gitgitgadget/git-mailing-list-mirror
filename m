Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17DCB20986
	for <e@80x24.org>; Sat,  1 Oct 2016 18:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751259AbcJASsm (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Oct 2016 14:48:42 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35786 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751032AbcJASsl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Oct 2016 14:48:41 -0400
Received: by mail-wm0-f67.google.com with SMTP id f193so3560075wmg.2
        for <git@vger.kernel.org>; Sat, 01 Oct 2016 11:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=+iLD9iQLX3cBujIhgh66uIjUZZLUNopMIbiof0sFgEc=;
        b=0VwrqPYwxboM7gk5P2a+8InmxAMsp/5J4w2dZsNrh6amM9vGHoO8PFi1QNywuWjcFx
         S21JzV89t+ErPA9IR4chIrqfmclSpGrYijjl4q6cHArZyhfwnIVEW/D1Kff64nWCQ3G9
         EgwyREKOpcN6IO//ouTKl5c5UxJ0WKvWajm4HL7abMGD7hD0J0ZvFJu5WN1dKeuIBl/U
         /StqsQzhFumdEJZOYihoNuiDdlWyfbn/tKvoKtPvrUACGK5MtSMBODKHNkkA5yD7xZQm
         lDnVk2y6yw0Nyh9O6DQm4WavCCEQi3nNMHMxuBoK7tdzzGXhdk8DQKMt2ox4gZpGlmfb
         jSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=+iLD9iQLX3cBujIhgh66uIjUZZLUNopMIbiof0sFgEc=;
        b=OyTPZO9wzcnLtm2/XrVuWEWd2si6ypz8czgeKCo+Er52kHa7Ae+BBI8DDMu3aLHidL
         zGT0uCkUJ/mUNQfnImd9jUQuI+AC7MklIcmnLvCFfiEBPnNxiiZAjSea96l3HxPZ6nc8
         1tJhyaOZG88gtjP+Z21vZLB6uAqgthgNSQ28R4Ob3rgArXLZfO17Bn+ylevGqgWHkhBe
         WMpdCVK2Ci9Ls0Jz2rkeMhU6Bu3BdnYt8BPx3s2CiuCVXWGO07893bv+gVuXIOwOEXu9
         W6+kFS0IOYUTTX0idK1K8qyLXNO7V7XvvqSnT8vP4fCvcSfDqCY9+5DQzeoBmzYBvI7M
         H9kg==
X-Gm-Message-State: AA6/9RnGQ55h5hvK1NYxe01qcgdzmAMC63vEg6Xmw/jjB6zPmPfG2spfQLQJpsJ8VSXjpQ==
X-Received: by 10.28.137.212 with SMTP id l203mr3287174wmd.26.1475347720182;
        Sat, 01 Oct 2016 11:48:40 -0700 (PDT)
Received: from [192.168.1.26] (abrc125.neoplus.adsl.tpnet.pl. [83.8.96.125])
        by smtp.googlemail.com with ESMTPSA id v189sm10357337wmv.12.2016.10.01.11.48.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Oct 2016 11:48:39 -0700 (PDT)
Subject: Re: [PATCH v2 07/11] i18n: add--interactive: mark edit_hunk_manually
 message for translation
To:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
 <1472646690-9699-8-git-send-email-vascomalmeida@sapo.pt>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <84857c15-9f46-5e1c-d253-e08a170ff77d@gmail.com>
Date:   Sat, 1 Oct 2016 20:48:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1472646690-9699-8-git-send-email-vascomalmeida@sapo.pt>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 31.08.2016 o 14:31, Vasco Almeida pisze:

> Mark message of edit_hunk_manually displayed in the editing file when
> user chooses 'e' option.  The message had to be unfolded to allow
> translation of the $participle verb.

Actually you need to unfold the message if exact translation (the ordering
of words) depends on the $participle verb.

Moreover, because the translation of message of edit_hunk_manually can
depend *only* on $participle verb (it cannot depends on $remove_minus
and $remove_plus, as they are either ('-', '+') or ('+', '-')), with
"particular" (contexted) translation of $participle, if the translation
would be different for different $participle, one can simply move whole
translation to $participle.

> 
> Some messages end up being exactly the same for some uses cases, but
> left it for easier change in the future, e.g., wanting to change wording
> of one particular use case.
> 
> Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
> ---
>  git-add--interactive.perl | 60 ++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 49 insertions(+), 11 deletions(-)
> 
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index acbfa4e..235142c 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -1057,22 +1057,60 @@ sub edit_hunk_manually {
>  	my $fh;
>  	open $fh, '>', $hunkfile
>  		or die sprintf(__("failed to open hunk edit file for writing: %s"), $!);
> -	print $fh "# Manual hunk edit mode -- see bottom for a quick guide\n";
> +	print $fh __("# Manual hunk edit mode -- see bottom for a quick guide\n");

This would be left as is (though you can write __"..." instead of __("...")).

>  	print $fh @$oldtext;
> -	my $participle = $patch_mode_flavour{PARTICIPLE};

This would be replaced with

  -	my $participle = __($patch_mode_flavour{PARTICIPLE});

Additionally you would need to mark the text of $participle itself for
translation, with context; for example:

  -                PARTICIPLE => 'staging',
  +                PARTICIPLE => N__p('Participle for "stage" operation, for edit hunk manually message', 'staging'),

That would require adding "--keyword=N__p:1c,2" to Makefile, of course.
The entry in the *.pot / *.po translations file would be preceded with 
"msgctxt <context>" line.

>  	my $is_reverse = $patch_mode_flavour{IS_REVERSE};
>  	my ($remove_plus, $remove_minus) = $is_reverse ? ('-', '+') : ('+', '-');
> -	print $fh <<EOF;
> -# ---
> -# To remove '$remove_minus' lines, make them ' ' lines (context).
> -# To remove '$remove_plus' lines, delete them.
> +	print $fh sprintf(__(

  +	print $fh __x(<<'EOF', remove_minus => $remove_minus, remove_plus => $remove_plus,
  +		      participle => $participle);

or

  +		      participle => __($participle));

assuming that $participle assignment doesn't use __ then.

Note that xgettext supports heredoc syntax for Perl language:

  Here-documents are recognized. If the delimiter is enclosed in
  single quotes, the string is not interpolated. If it is enclosed
  in double quotes or has no quotes at all, the string is interpolated.

  Delimiters that start with a digit are not supported!

> +"# ---
> +# To remove '%s' lines, make them ' ' lines (context).
> +# To remove '%s' lines, delete them.

  +# To remove '{remove_minus}' lines, make them ' ' lines (context).
  +# To remove '{remove_plus}' lines, delete them.

>  # Lines starting with # will be removed.
> -#
> -# If the patch applies cleanly, the edited hunk will immediately be
> -# marked for $participle. If it does not apply cleanly, you will be given
> +#"), $remove_minus, $remove_plus),

   # Lines starting with # will be removed.
  +#
  +# If the patch applies cleanly, the edited hunk will immediately be
  +# marked for {participle}. If it does not apply cleanly, you will be given

[...]

Here is definition of relevant subroutines, based on Locale::TextDomain.

sub N__p($$) {
    return @_;
}

-- 
Jakub Narębski
