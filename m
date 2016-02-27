Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_RECEIVED,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: (qmail 12585 invoked by uid 107); 27 Feb 2016 09:37:17 -0000
Received: from Unknown (HELO cloud.peff.net) (10.0.1.1)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 27 Feb 2016 04:37:17 -0500
Received: (qmail 7314 invoked by uid 102); 27 Feb 2016 09:37:07 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by cloud.peff.net (qpsmtpd/0.84) with ESMTP; Sat, 27 Feb 2016 04:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423407AbcB0Jgd (ORCPT <rfc822;peff@peff.net>);
	Sat, 27 Feb 2016 04:36:33 -0500
Received: from mail-lf0-f42.google.com ([209.85.215.42]:34111 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841AbcB0Jg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 04:36:29 -0500
Received: by mail-lf0-f42.google.com with SMTP id j78so66395882lfb.1
        for <git@vger.kernel.org>; Sat, 27 Feb 2016 01:36:28 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ukB8NMKBsIh0O4rZ61gb0KFZi3VcmZZyFzG9wtV1IhY=;
        b=0Ck4++9AckcEWpjmj2p9klXbB4ShyxBdiRERguQyoKdTeIUDjbkT6Ouq5CsHP9VzT8
         U1TnvCWYmCyQfLlr84sPnonq0Rya7HindU+yQ7oFaGm0/nfoJruWb4/imsgE7zFfZTet
         E9hB+hBcftES1HFKJaHUcufPP3/BYmhgEoCiA4o6QkMWKBQ9bM88LF0nPB8hK3SvJx6+
         b8H38outhc2x62a0Nm4lbfsLudOAcrC7aSy1ysUIdgXuhz0W3XzDV9L2sDkPSYFPnqXK
         TwiJX+YGEEFasqREC8cw7OErN1bjwi3NrxPRyZxlTIFM0j1T0p2Y5BvlUUPPGOZ0aVb9
         liNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ukB8NMKBsIh0O4rZ61gb0KFZi3VcmZZyFzG9wtV1IhY=;
        b=cApoFWnRjmkXoJo1FUz58ysIvFPyu6FqEIZoScIx6SVdni8XrbLnUdNaLEAVIyXbhr
         sT7KeT4s/mhBF9ClfPPVIXazlQGqpYTZtEgmSxWkesWB9TV7znWuvSPTnZ3bi1FnZ1Tf
         GIMemIaoRAFraKOrQJXNu13PKKoHM4g5a6GaUyTJKJGcdvCJKIC0QPKWT97qt8g00vR/
         YzLaHbJJNC90hJagt5/Ji4mIMYJqBGy1GBCzi5h0kBy34o7C3JwYWyv3AAStK6+FfOQY
         GelwTcu6RWQPZ+NQ9rOoF65D2N31zxA6vjHdrxfRe34NxzRhtN/gUD+b8JLc5O+SxFn/
         i5Ig==
X-Gm-Message-State: AD7BkJLlcvD+hVY6sdQsViKUfGKhL1jetbxSQ0Qewn7x8pLu9BHHqUfzf8q3eBAHCrDebJ3hQ4gPyo/tXnhiHg==
X-Received: by 10.25.157.213 with SMTP id g204mr2285234lfe.112.1456565787325;
 Sat, 27 Feb 2016 01:36:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.112.97.72 with HTTP; Sat, 27 Feb 2016 01:35:57 -0800 (PST)
In-Reply-To: <009f01d170e9$ecd5cae0$c68160a0$@optonline.net>
References: <009f01d170e9$ecd5cae0$c68160a0$@optonline.net>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sat, 27 Feb 2016 16:35:57 +0700
Message-ID: <CACsJy8A5539X+VhUAnNfn5Q_uW1pa5oYb9YAAF8=u3XfdhAeMw@mail.gmail.com>
Subject: Re: Trouble Cloning Git remote repository
To:	"Fred's Personal" <freddiewik@optonline.net>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Feb 27, 2016 at 6:03 AM, Fred's Personal
<freddiewik@optonline.net> wrote:
> $ git clone -v ssh://user1@Host2/srv/centralrepo
> Cloning into 'centralrepo'...
>>>>Lines from $HOME/.bashrc
>   + export
> PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games
> :/usr/local/games
>   +
> PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games
> :/usr/local/games
>   + PROMPT_COMMAND=
>   + CDPATH=
>   + '[' '' = yes ']'
>   + PS1='${debian_chroot:+($debian_chroot)}\u:\W\$ '
>   + export GIT_TRACE_PACKET=1
>   + GIT_TRACE_PACKET=1
>   + export GIT_TRACE=1
>   + GIT_TRACE=1
>>>>End of Lines from $HOME/.bashrc
> ## WHERE DOES The following line COME FROM????What Script spits out this
> line????
>   + user1@Host2 git-upload-pack /srv/centralrepo

Try set GIT_TRACE=1 at the clone line, I have a feeling that this line
should be "ssh user@Host2..." but "ssh" is missing.

$ export GIT_TRACE=1
$ git clone -v ssh://user1@Host2/srv/centralrepo
-- 
Duy
