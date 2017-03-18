Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 409DB2095B
	for <e@80x24.org>; Sat, 18 Mar 2017 22:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751284AbdCRWsp (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 18:48:45 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:36062 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751218AbdCRWsp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 18:48:45 -0400
Received: by mail-it0-f41.google.com with SMTP id w124so56052014itb.1
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 15:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=a2FgFCpL0ho6kWmGM6hjy3akrIkPMWfWzBSzanvUrts=;
        b=vFKqdjFK2koAex8xJ3Xz3848v/rU2GlfSugg1uF8Gdxc8SBcK2PLE9FSCJs+gdoYqZ
         pOCu1K/rPmijRJeOcM2FNb+uUuhxPU+sLtpkufWIQQBrvzFUU1rFdXHTm3vjKI6c3acH
         0eEnF0LKvUW6ooBKfz21d5oZ3jwDXhvYjgVAD9ibt0jhW4usWCJ0IR96kTGryvaDkjz4
         pCjUKNM8UZ9mfKwR9HHp8Xx7vdvCRXnQIGeBUSv8cRYGzaAfYC1C51O3zFXrJoPNCcHA
         mojrworIO7vudj+SH2Bh1GyHFey+sEpot/1SPLxXOt/uOJyWuT+FKVvzXByBSt6yBfkc
         DvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=a2FgFCpL0ho6kWmGM6hjy3akrIkPMWfWzBSzanvUrts=;
        b=ZCv4oiLRJOOBhaqlLv1ChrLbpxoJiJ7csd4o72YGf//2UlFWB5s1zXiBC2m0BCiDl+
         53pjuR2tUvaUO7kHitdsVxbJi4miAf+GGullYbTBG4gWt6v/PHP6B1Z+98mDWgQ4Q+F9
         UQsqAt6ZRGYyEgzEBaUtF6MeCZvk6ZjYDqDSGuNfu3H0GbtkJ0fO1JyAlGsCIOkle3zN
         NLJmTa82dD4SjvvqPGbPoVb6SX3J1uB6NWYets+QntBmW3vJUKOHvy2pOY8RAYGxpGJo
         V5VMBTzdIqa7OvDhg9hvwQyDySj5i55+S6zXIBAaDbWH5fYXJX/Zkm9yP/+MHjw9b2ya
         pykw==
X-Gm-Message-State: AFeK/H25teQE3eDNAUoQEfq5EWOw3Wt4hoRKcLJS3TBg2zU0vwkT0S5lqUVXrWiYWuxJoVfuQcTXSku8kzXGnA==
X-Received: by 10.36.224.195 with SMTP id c186mr4557572ith.24.1489877275815;
 Sat, 18 Mar 2017 15:47:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sat, 18 Mar 2017 15:47:35 -0700 (PDT)
In-Reply-To: <20170318222311.9993-1-dennis@kaarsemaker.net>
References: <451E4A46-BA43-41A5-9E68-DE0D89BE676A@csh.rit.edu> <20170318222311.9993-1-dennis@kaarsemaker.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 18 Mar 2017 23:47:35 +0100
Message-ID: <CACBZZX5j1dYk8aeRED7T7iJ=b32aFUpfUWPpMpmtofBL3QnVXQ@mail.gmail.com>
Subject: Re: [PATCH] send-email: Net::SMTP::SSL is obsolete, use only when necessary
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 18, 2017 at 11:23 PM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
> Net::SMTP itself can do the necessary SSL and STARTTLS bits just fine
> since version 1.28, and Net::SMTP::SSL is now deprecated. Since 1.28
> isn't that old yet, keep the old code in place and use it when
> necessary.
>
> Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
> ---
>  Note: I've only been able to test the starttls bits. None of the smtp servers
>  I use actually use ssl, only starttls.
>
>  git-send-email.perl | 52 ++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 34 insertions(+), 18 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index eea0a517f7..e247ea39dd 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1353,10 +1353,12 @@ EOF
>                         die __("The required SMTP server is not properly defined.")
>                 }
>
> +               require Net::SMTP;
> +               my $use_net_smtp_ssl = $Net::SMTP::VERSION lt "1.28";
> +               $smtp_domain ||= maildomain();
> +

While Net::SMTP is unlikely to change its versioning scheme, let's use
comparisons via the version module here in case they do change it to
something silly, and this ends up introducing a bug.

E.g. 04.00 would be considered a higher version by CPAN than 1.28, but
not by this code:

    $ perl -wE 'my ($x, $y) = @ARGV; my ($vx, $vy) = map {
version->parse($_) } ($x, $y); say $vx < $vy ? "vlower" : "vhigher";
say $x lt $y ? "slower" : "shigher"' 04.00 1.28
    vhigher
    slower

If we grep ::VERSION we can find other cases where we've gotten this
wrong, unlikely to bite us in practice, but version.pm is in core (so
core that you don't even need to use/require it), so let's do this
better for new code.


>[...]
> +                                       if ($smtp->code != 220) {
> +                                               die sprintf(__("Server does not support STARTTLS! %s"), $smtp->message);

Here a new message you're adding gets __(), makes sense.

> +                                       }
> +                                       require Net::SMTP::SSL;
>                                         $smtp = Net::SMTP::SSL->start_SSL($smtp,
>                                                                           ssl_verify_params())
>                                                 or die "STARTTLS failed! ".IO::Socket::SSL::errstr();
> -                                       $smtp_encryption = '';
> -                                       # Send EHLO again to receive fresh
> -                                       # supported commands
> -                                       $smtp->hello($smtp_domain);
> -                               } else {
> -                                       die sprintf(__("Server does not support STARTTLS! %s"), $smtp->message);
>                                 }
> +                               else {
> +                                       $smtp->starttls(ssl_verify_params())
> +                                               or die "STARTTLS failed! ".IO::Socket::SSL::errstr();
> +                               }

I see you just copied that from above but I wonder if it makes sense
to just mark both occurrences with __() too while we're at it.
