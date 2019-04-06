Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D0AC20248
	for <e@80x24.org>; Sat,  6 Apr 2019 09:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfDFJbc (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 05:31:32 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42859 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfDFJbc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 05:31:32 -0400
Received: by mail-pl1-f196.google.com with SMTP id cv12so4363727plb.9
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 02:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3zyNvucd0jy0yfQIYriUFbCgbjRewcKI1fmwB4oxIno=;
        b=BIa7qnnH9XOf2yk4cp+Dk3qHsUHuZy3F+owvAaexfO1iCFV29T8UM2r0Ws6haoPqCz
         lc/SYsA9C5k/rvXTlDXrAfCE1yJpWNNgrGxQ9Of2R/mQXNWjztvlF1846UZZOpNaDxXi
         +L8WpImJSOSp1VtmkSpgHAVU4hdmp6RNOv2tB9HB7xqpFksHliv9l0gSkXTtRPvE/RmD
         YoiQHu98swiAT44hvdYId/uBTknyo0MA5i0BOS9CGd2WZLDE7rf+MMpbZHa09DNsKrhQ
         UoWF6vvYPuVjJLXOC0UdVPBvYaNnyXTJqYNOyyk++Qk1hxs+AY9RFtZvcKdLj3UDd+he
         AawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3zyNvucd0jy0yfQIYriUFbCgbjRewcKI1fmwB4oxIno=;
        b=AvA53ok43l+qYK8jYpXE7933GGMoLHu7cqZrNCL2PNwontnZmLwRTURH16nHAolP4T
         vtCxXuF0zsWzKlD9kRFFSgkVDV6nArHaVnwzl0oOtcEy3KHyafSIspcEAzNeaxrRFPGG
         yNylllm4WOQajlojf4DmjYUemcOp5w6SPcjSBLnnfy5xJjxjCLnnfaJBPlG/5nW+ObmE
         B7sFJJ6Tt1aCqM+9ZnzE4OMHCFLmBVvJRpFXQMlyxAU1nF6Il2LuqoMEmyx18BO8kxmW
         zNADeObfFUzra6OjgX/FXNni56kqAMecDF0KbSLk/R+vF+rL7dmrkJD0y+mibGzREaGM
         c2UA==
X-Gm-Message-State: APjAAAWsm2exLrnPuD4ZfgysTYn3UwhCNoVgNu2du7gbB0F/UQZoQQV3
        vbCZ2YHOp4YNT+UL2yy3ejZ49J6Ebltio6+Bnf4=
X-Google-Smtp-Source: APXvYqx9hpZtJXIzDWpDZ/hGm5NZvxk6TCZRIJpmaUqVK827zvnt9Av8JKj5aO/m/Ah03CRiy1szRI4oSET24JKsKAs=
X-Received: by 2002:a17:902:ab87:: with SMTP id f7mr18036222plr.85.1554543091348;
 Sat, 06 Apr 2019 02:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAN0heSrbjRExHwch0K_W+xwpERnFUJmaiHhCkAaK9nnxFnXEhw@mail.gmail.com>
 <20190405225115.3882-3-tmz@pobox.com>
In-Reply-To: <20190405225115.3882-3-tmz@pobox.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 6 Apr 2019 11:31:19 +0200
Message-ID: <CAN0heSpL_pQMtDaEdDgcsC_Sso45owHjRttrdp7cQdYOb7i9BA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Documentation/git-svn: improve asciidoctor compatibility
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 6 Apr 2019 at 00:51, Todd Zullinger <tmz@pobox.com> wrote:
>
> The second paragraph in the CONFIGURATION section intends to emphasize
> the word 'must' with bold type.  Adjust the formatting slightly to
> provide similar results between asciidoc and asciidoctor.

I don't think this explains the problem you're solving well enough. It
also doesn't make it clear enough, IMHO, how what we're doing here
solves that problem. How about something like this?

  The second paragraph in the CONFIGURATION section intends to emphasize
  the word 'must' with bold type. It does so by writing it as *must*,
  and this works fine with AsciiDoc. It usually works great with
  Asciidoctor, too, but in this particular instance, we have another "*"
  earlier in the paragraph. We do escape it, and it is rendered
  literally just like we want it to, but Asciidoctor then ends up
  tripping on the second (or third) of the asterisks in this paragraph.

  Since that asterisk is (part of) a literal example, we can set it in
  monospace, by giving it as `*`. Adjust the whole paragraph in this
  way. There's lots more monospacing to be done in this document, but
  since our main motivation is addressing AsciiDoc/Asciidoctor
  discrepancies like this one, let's just convert this one paragraph.

I think what's happening could be related to the fix in the first patch.
There, it's ok to explicitly escape only the first '. The second one is
matched to it and gets escaped implicitly. Something like that could be
happening here, too, just that we don't want it to. (Should we escape
the implicit escaping? ...) Just speculation, though.


Martin
