Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C44D20985
	for <e@80x24.org>; Wed, 21 Sep 2016 17:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934826AbcIURJr (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 13:09:47 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35768 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933140AbcIURJq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 13:09:46 -0400
Received: by mail-wm0-f65.google.com with SMTP id 133so9720564wmq.2
        for <git@vger.kernel.org>; Wed, 21 Sep 2016 10:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=zKRLM+NGBdb9QEC74hAUwySe8HoX5SwWPWxvIV6Xq3o=;
        b=XqFrQvKqxS5hQ0xVbdV6HUQNAcefFcZDAkWttJ6vi2Rdl5UATpRWCY//4vj1UjWDTL
         KxoqzhBWge2EzyFCWFKMFpIJAVF32HaENR1275KWW/mK+SVWs5i+a63t4jvm9UqYf27p
         etNYTTgJGb1V8izynXSmynalNQqGzvp17ljXj27i9uIZyWcVE5aMlV2wYzH83dMTz1am
         VjWN93sHJK6HuWgKd6ph9DOPrEYwp+t5pQmdP0/mYOkzewEmv6HrSAXQDHJ4wN908yPD
         Vh9Y6Rp0LCDDVbe6qBMnDcBLtGp7VuTjOxPy9c8LXhle0b/sCzhoKCQohi3gehVM0E1h
         Hj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=zKRLM+NGBdb9QEC74hAUwySe8HoX5SwWPWxvIV6Xq3o=;
        b=bdcFr0sBayxVQS/fA8z9ieDCtTMhZoQbQm9ugjArJcpOan0laZz6xeXM2Nk0Dp9Ak7
         NQFZSDieJ8Fvmx/eyGqUm1+WKthBxX3WG+6XxZcbcCudJjjcsdciXTQ+a1v/1tJNKmk1
         KQ7fXVsmJNKXtxdgCZuZQU36x9W16B7WefvpZFaFUPNExgpKCuwmByubbaUzLYbW/8Qm
         s2IhksX0EiNCeWV3GC3qt/UDrrXd1lO/XO0HSjtXBLDTvY2NJwpD7EWdR/M4nvg5+fpF
         TOCAI9xeniwJ+DtbX2d641Q+HfYILxz0Ph6EJJoeymIfv+O60rIiXYmJKNi1UCk4XLtW
         AXVQ==
X-Gm-Message-State: AE9vXwMPj0N9bwkiPohYA9Bl07vBxjuy/J2xpCfPu1GxvDlfLZ2Gp8xLpMj6wf9w+eWxdw==
X-Received: by 10.194.5.202 with SMTP id u10mr38903913wju.149.1474477785054;
        Wed, 21 Sep 2016 10:09:45 -0700 (PDT)
Received: from [192.168.1.26] (enn40.neoplus.adsl.tpnet.pl. [83.20.3.40])
        by smtp.googlemail.com with ESMTPSA id w207sm33498024wmd.8.2016.09.21.10.09.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Sep 2016 10:09:43 -0700 (PDT)
Subject: Re: [PATCH 3/3] gitweb: Link to "git describe"'d commits in log
 messages
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <20160921114428.28664-1-avarab@gmail.com>
 <20160921114428.28664-3-avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <fadd75f3-3737-1eaf-30f3-46a2ef132b27@gmail.com>
Date:   Wed, 21 Sep 2016 19:09:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160921114428.28664-3-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 21.09.2016 o 13:44, Ævar Arnfjörð Bjarmason napisał:

> Change the log formatting function to know about "git describe" output
> like v2.8.0-4-g867ad08 in addition to just plain 867ad08.

All right, that is a good plan.

> 
> This also fixes a micro-regression in my change of the minimum SHA1
> length from 8 to 7, which is that dated tags like
> hadoop-20160921-113441-20-g094fb7d would start thinking the "20160921"
> part was a commit.

Actually 20160921 is 8 characters, so assuming that '-' is treated
as word boundary by Perl, it is not a regression; this false positive
was there.  The new feature would help, instead of linking false match
it links whole git-describe output.

So this paragraph needs to be changed wrt. the above.

Note that there are quite a bit of shortened SHA-1 that are composed
entirely from digits, without a-f characters.

> 
> There are still many valid refnames that we don't link to
> e.g. v2.10.0-rc1~2^2~1 is also a valid way to refer to
> v2.8.0-4-g867ad08, but I'm not supporting that with this commit,
> similarly it's trivially possible to create some refnames like
> "æ/var-gf6727b0" or whatever which won't be picked up by this regex.

Hopefully hierarchical tags are rare.  We need to reduce false
positives.

> 
> There's surely room for improvement here, but I just wanted to address
> the very common case of sticking "git describe" output into commit
> messages without trying to link to all possible refnames, that's going
> to be a rather futile exercise given that this is free text, and it
> would be prohibitively expensive to look up whether the references in
> question exist in our repository.

Note that we do not ask Git at the time of displaying commit message
if the link is valid for performance reasons; we link it, and the link
may be invalid if it was a false positive.

Note that recommended way to refer to other commit in commit mesages
is (see Documentation/SubmittingPatches):

  If you want to reference a previous commit in the history of a stable
  branch, use the format "abbreviated sha1 (subject, date)",
  with the subject enclosed in a pair of double-quotes, like this:

     Commit f86a374 ("pack-bitmap.c: fix a memleak", 2015-03-30)
     noticed that ...

Hmmm... this makes previous commit even more important.

> ---
>  gitweb/gitweb.perl | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 101dbc0..3a52bc7 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2036,10 +2036,24 @@ sub format_log_line_html {
>  	my $line = shift;
>  
>  	$line = esc_html($line, -nbsp=>1);
> -	$line =~ s{\b([0-9a-fA-F]{7,40})\b}{
> +	$line =~ s{
> +        \b
> +        (
> +            # The output of "git describe", e.g. v2.10.0-297-gf6727b0
> +            # or hadoop-20160921-113441-20-g094fb7d

All right, for more complex regular expressions using in-line comments
(extended regexp in Perl) is a good idea.

> +            (?<!-) # see strbuf_check_tag_ref(). Tags can't start with -
> +            [A-Za-z0-9.-]+
> +            (?!\.) # refs can't end with ".", see check_refname_format()

If we can assume that tag name is at least two characters (instead of
at least one character), we could get rid of those extended regexp
lookaround assertions:

  (?<!pattern) - zero-width negative lookbehind assertion
  (?!pattern)  - zero-width negative lookahead  assertion

That is:

  +            [A-Za-z0-9.]   # see strbuf_check_tag_ref(). Tags can't start with -
  +            [A-Za-z0-9.-]*
  +            [A-Za-z0-9-]   # refs can't end with ".", see check_refname_format()

Also, the canonical documentation for what is allowed in refnames
is git-check-ref-format(1)... though it does not look like it includes
"tags cannot start with '-'".

Anyway, perhaps 'is it valid refname' could be passed to a subroutine,
or a named regexp (which might be more involved, like disallowing two
consecutive dots, e.g. "(?!.*\.{2})" at beginning).

> +            -g[0-9a-fA-F]{7,40}

If we are limiting to git-describe output, we can get rid of A-F here.

> +            |
> +            # Just a normal looking Git SHA1
> +            [0-9a-fA-F]{7,40}
> +        )
> +        \b
> +    }{
>  		$cgi->a({-href => href(action=>"object", hash=>$1),
>  					-class => "text"}, $1);
> -	}eg;
> +	}egx;
>  
>  	return $line;
>  }
> 

Good work. 

I assume that you are using git-describe output in commit messages
a lot, isn't it?
-- 
Jakub Narębski

