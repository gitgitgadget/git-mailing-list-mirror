Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8615A20193
	for <e@80x24.org>; Wed,  2 Nov 2016 15:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755788AbcKBPgf (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 11:36:35 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:37496 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755728AbcKBPge (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 11:36:34 -0400
Received: by mail-it0-f46.google.com with SMTP id u205so44309143itc.0
        for <git@vger.kernel.org>; Wed, 02 Nov 2016 08:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XNHP9gMjj6IThOnYoeCxPyNBh+A8oHLVQtNEL8NqJQE=;
        b=vmClRi6bZ9ddaQrQOaSZ9ExypXOtK7jKYd4I2MSwbaXBJPtnMwJh8IRfidLIrFGQJz
         4eGquNgRGCZdDnYa+Bd6rk7C+SQyiTjIdhgTrn9Hb4uhAHhSZt6j47+wrarR9HQNxWUA
         ui7i3VFG/VfQC1wVUiLdqzY94dtso65hsp2ij2VNts0DPXa1pcfmyiwer3m/w7uWMagh
         u8YwHfXQ4qXEeiCU5jyx2zWmxoEWj+n4CQgWOZiGQT7Z7a8hek4Lr9BcWS6lSzbMIMjx
         9A6i31j6UbnyX+nTkF7DtBPJl3TDLw6in3Eo3PbjdtElzK39iht3ZaOPmzbr5MtSnVTu
         M0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XNHP9gMjj6IThOnYoeCxPyNBh+A8oHLVQtNEL8NqJQE=;
        b=OdUhkgeTVP7rkpJJnvgtqkGpmFb/wXS5eo2jvpAIaAWb32JgNqI9BcgIxNEUv/zbiS
         ggtNv8J7NdSE0lxYrCq4n4eFCMNaA6Z9src627cLTOGlfxI502fWM3GImQwVaUrOyFDU
         9SBlAZnPGy1cAkoCIVbcjOcWwrowmeA5zDLAPDFoZiuR5AtSrguUt30/gUqJN38A3IsJ
         vb+BxPqqvHfgphl4jFju9b5qKAVgJslav+6QxlVqvd8f0LuvYE4rDz4CzSgExwnT0raP
         svs4mtH/sxdN+2C2zLeuM3dWDWPm5vaCvSLjZ6cH/xGvnUZGaWeKeU3gKqdE2e1pvjm+
         rhcA==
X-Gm-Message-State: ABUngvf+EKJVJ5/2uO4mrGOdY1lZ75WW9hB74+OSS1iGBZOq2BA73a7Xbuukh3nzacJsc5DPk5d0iI8a2tfxkw==
X-Received: by 10.36.0.210 with SMTP id 201mr3468517ita.60.1478100993800; Wed,
 02 Nov 2016 08:36:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.27.209 with HTTP; Wed, 2 Nov 2016 08:36:33 -0700 (PDT)
In-Reply-To: <CAGSZTjKg1=tMYgFiwys=ePVT+3p6KTa1mQ0fP9pPns-Nvd+6fA@mail.gmail.com>
References: <CAGSZTjKg1=tMYgFiwys=ePVT+3p6KTa1mQ0fP9pPns-Nvd+6fA@mail.gmail.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Wed, 2 Nov 2016 21:06:33 +0530
Message-ID: <CAFZEwPP1XyE+X6ipes4JNsUz3JVS+ErbLfQ-zYXZ3KA75bho5Q@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IEhvdyBjYW4gSSB0ZWxsLCBmcm9tIGEgc2NyaXB0LCBpZiDigJxnaXQgY2hlcnJ5LQ==?=
        =?UTF-8?B?cGlja+KAnSBmYWlscz8=?=
To:     Kevin Layer <layer@known.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Kevin,

On Wed, Nov 2, 2016 at 8:44 PM, Kevin Layer <layer@known.net> wrote:
> If the cherry-pick fails due to a merge conflict, it just returns an
> exit status of 0.  I have a script that does a series of cherry-picks
> and I need to know if they succeed.

Well, I haven't checked what it returns in git 2.10, but you can
always redirect the stdout and stderr to the output and grep for the
text which it shows in the actual output. Here[1] is an example of how
to do it.

[1]: https://github.com/git/git/blob/master/t/t3507-cherry-pick-conflict.sh#L42-L55

Regards,
Pranit Bauva
