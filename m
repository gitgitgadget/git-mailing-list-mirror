Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 293B51F954
	for <e@80x24.org>; Sat, 18 Aug 2018 12:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbeHRPTH (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 11:19:07 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39483 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeHRPTH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 11:19:07 -0400
Received: by mail-ed1-f66.google.com with SMTP id h4-v6so5919401edi.6
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 05:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZYNf8IauZJe6h4PEGCKp2B/0iww/2/toNmB2ua7mJOw=;
        b=YY1QxC3Zel6OGaXIypm08Qb51SfNk1QK0NG9glr7rN+fza2fuL7PQyQ4yGiV0qIvb1
         mTj6tcMTOk4xwl5Kgx9nLiUKXxkXmRnOiX+QWau777WOtEyTw1p1M9NKUsAnmzVihSQ+
         Wk5Fl54/qG/70fyhnOBT0z2vNlE6CZJIpIAeHAge91pnH57ejb3wzytfj6Oql87w0pGY
         XDHvWmVRvQhUNs4uZITkyloV9gwJ9kE6XixvBEkR+ewtRCY2lOvJpOtWe61rcXPw+yQh
         CM+yPOQ9fjB8TpJKdAIokWgHdR6VN7jTXBHbADB0AWA9JcjbQwjEeHE5Wug2hYCqzuTC
         9LIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZYNf8IauZJe6h4PEGCKp2B/0iww/2/toNmB2ua7mJOw=;
        b=EP74rHDuy+kdcp0F6yyAdGMU1YzTvbbEUKju8UbJ2N5NKmQttOI8CyQ2JcqyKnUipN
         SzkzrRTzXVwxJsrq4lHN5AW8uoyZm7vV5ihqobRvJM6A7lz49agmUISZ62SilJqa3OzA
         6llTCMID/cX+6Uy30YVWJHvrYMIx/FqYcJcbTJ9cCIJ8MNwm6W/YfGzGH9hj5B4s7Yu0
         /Uxleb/je9HZkiKOzToB6O01nXleZPib06m1HHaa0CxFX/1c04jshopSx3jMg1azqJ8e
         nAA//AQDDeJMFaKZ5XeipIKyda7x7i27IoRZLkd7eGo2VF33eqmZK2OWxx/SLZOUyBFc
         BU6A==
X-Gm-Message-State: AOUpUlFQHpZh+JshjW9zyxI49RwToI6ZrdlzX1QX1MS0qg+mHYwMLMnl
        Ihc+AbTx5sAcIB/jD3NDiQ+EoF3ewJXYiGN/vHB7Yw==
X-Google-Smtp-Source: AA+uWPxp7zbJwV+0jp3hla3PkIylLT9EwTl3cN9ChHls383nZkefKmYoSa0qJ6PadggymfC+3I9OFb7Mz4kXzWvKt7M=
X-Received: by 2002:a50:9069:: with SMTP id z38-v6mr47651866edz.79.1534594296326;
 Sat, 18 Aug 2018 05:11:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:2642:0:0:0:0 with HTTP; Sat, 18 Aug 2018 05:11:35
 -0700 (PDT)
In-Reply-To: <20180815202010.GL2734@hank.intra.tgummerer.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
 <05246e813c810156c07385052ec59d6dec34623e.1533753605.git.ungureanupaulsebastian@gmail.com>
 <20180815202010.GL2734@hank.intra.tgummerer.com>
From:   Paul Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Date:   Sat, 18 Aug 2018 15:11:35 +0300
Message-ID: <CADzBBBbBVKCiGXtZi=OPD7szApTeA56bmt-kUmRv=LaAbsCk+g@mail.gmail.com>
Subject: Re: [GSoC][PATCH v7 10/26] stash: convert show to builtin
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 15, 2018 at 11:20 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> '--quiet' doesn't make too much sense to use with 'git stash show', so
> I'm not sure whether or not it makes sense to support it at all.  But
> we do promise to pass all options through to in our documentation, so
> the new behaviour is what we are documenting.

Indeed, I guess it doesn't make sense at all. I cannot come up
with a situation where `--quiet` would be useful. I will think more
about it and come back with a reply if I find any good example
where it would be useful.
