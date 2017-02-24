Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC88E201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 17:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751221AbdBXRGD (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 12:06:03 -0500
Received: from mail-qt0-f180.google.com ([209.85.216.180]:33312 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbdBXRGC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 12:06:02 -0500
Received: by mail-qt0-f180.google.com with SMTP id b16so21664437qte.0
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 09:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jNyBRumpzpFErmzupqFLpImLJvDa4JHdnYsbnaNqrBw=;
        b=KzBQYsgk4AQvO0tI+4ptmj6kUhQE1Rb+Hl2BPb7qgWMByYmlOhi0okxiNnqK81+u9T
         l9Uf3ezmY/eueMZjvvatFHJekwL01odPb3v9tw8UIysbp1BQk6cwG3tlRZ3F/x7696l5
         d0oHnoYwPzS2xvSysh9d9vxbZOpuau3+uReVJHE5YBhb0CuZhmLPjiQ5a99HG85yNdOE
         gfGblXhSjEVAREf5XG0WPDzlyMkCGkjX18mCcxNTb0QVNzqeYOOhqbzRzSjn/N/402Pn
         KtFVQm/I+qoOiqfSXFr1McD3xQ8wVuC6qrpcvVzv0gGdU4UCCxOLH21yN1Tw3mJViAjP
         IeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jNyBRumpzpFErmzupqFLpImLJvDa4JHdnYsbnaNqrBw=;
        b=Oqaf8XF8dgt6Be+K57cjRZ5zM7et35hadPRkH5BJQgJ3szJlBYWq5OLysWkhc0RGtk
         J7Lmso3SdCe3XxHkqH303rwQ8QMvaiXzoKwVF8weol7gTPF5YrceMXQMKzfVZ31wUKqs
         WjfwEadyxntLR/7kU8XTGDVm1hBqjQ4ruXBwWDscbTul5mhyfIsrX5qz/FXs+UKxZjZg
         4AAvf1qjQFHJnfjMPDoN+0kCJATxa8Q/uE5FEogajNjUXE9nI9BWQbE+eQVrcuYQTeo8
         DFI/gmMrIsHn1NOCsu9QqLpB1diwE8lLh3ETev+MIfUAgSZZ07GIHpkbMMXmDUEuzfw7
         2cmA==
X-Gm-Message-State: AMke39lmqCq9odQ4Fqy/xIO7e1mEF1f2dY5+trpx1rsEmFXnLKpGIoUkFYslpsJlu+dFcuu1m87hagUyrAIO3g==
X-Received: by 10.237.57.164 with SMTP id m33mr2512486qte.293.1487955883005;
 Fri, 24 Feb 2017 09:04:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.218 with HTTP; Fri, 24 Feb 2017 09:04:12 -0800 (PST)
In-Reply-To: <22704.19873.860148.22472@chiark.greenend.org.uk>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net> <22704.19873.860148.22472@chiark.greenend.org.uk>
From:   ankostis <ankostis@gmail.com>
Date:   Fri, 24 Feb 2017 18:04:12 +0100
Message-ID: <CA+dhYEUfdHAeKwE4Sx4RivX2Vxv55xCxnsPUrPBPZWWbp=d_eA@mail.gmail.com>
Subject: Re: SHA1 collisions found
To:     Ian Jackson <ijackson@chiark.greenend.org.uk>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24 February 2017 at 16:13, Ian Jackson
<ijackson@chiark.greenend.org.uk> wrote:
>
> Joey Hess writes ("SHA1 collisions found"):
> > https://shattered.io/static/shattered.pdf
> > https://freedom-to-tinker.com/2017/02/23/rip-sha-1/
> >
> > IIRC someone has been working on parameterizing git's SHA1 assumptions
> > so a repository could eventually use a more secure hash. How far has
> > that gotten? There are still many "40" constants in git.git HEAD.
>
> I have been thinking about how to do a transition from SHA1 to another
> hash function.
>
> I have concluded that:
>
>  * We can should avoid expecting everyone to rewrite all their
>    history.
>
>  * Unfortunately, because the data formats (particularly, the commit
>    header) are not in practice extensible (because of the way existing
>    code parses them), it is not useful to try generate new data (new
>    commits etc.) containing both new hashes and old hashes: old
>    clients will mishandle the new data.
>
>  * Therefore the transition needs to be done by giving every object
>    two names (old and new hash function).  Objects may refer to each
>    other by either name, but must pick one.  The usual shape of
>    project histories will be a pile of old commits referring to each
>    other by old names, surmounted by new commits referrring to each
>    other by new names.
>
>  * It is not possible to solve this problem without extending the
>    object name format.  Therefore all software which calls git and
>    expects to handle object names will need to be updated.
>
> I have been writing a more detailed transition plan.  I hope to post
> this within a few days.

It would be great to have a rough plan of the transition to a new hash
function.

We are writing a git-based application to store electronic-files for
legislative purposes for EU.
And one of the great questions we face is about git's SHA-1 validity in 5
or 20 years of time from now.

Is it possible to have an assessment of the situation for this transition?

Best regards for your efforts,
  Kostis
