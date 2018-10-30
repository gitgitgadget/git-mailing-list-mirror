Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A232C1F453
	for <e@80x24.org>; Tue, 30 Oct 2018 07:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbeJ3QtU (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 12:49:20 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:33479 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeJ3QtU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 12:49:20 -0400
Received: by mail-it1-f194.google.com with SMTP id p11-v6so2365349itf.0
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 00:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Khpe4x0O7LEqz0T/O3xP4JgOiC4VTot2iiXsB5D0pqc=;
        b=exRztOZMZZIZ6vpKLf/9f49LoaZ6YP6hS6bO0GENYUorhHL33QBfSQcE+3Hx8n6wMo
         U0l8Qee6A0hRMoHzGGYKCI64SArvK9qhQNZrflSYarlk42udStIjm3ko+ifewMC/U+Uj
         gOPNcJkYHADS2WXr/6cLJ+ijNC4p+ea/ewvZbU07GvS175SEScw7z/exwYB9BQxzjuhP
         XvygH2sOOT0XtiFGHsksQhN8ovr9vVgXDzewMfE8zZAjrbfofX8YoU0WJ5U2V3734WMs
         0srDIMnqDIgTmzH/ETIfMbXmafcsCiNi5lJRp1wZ8+GFt+iwqPrYnyevOgTWZH8iN45S
         4pug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Khpe4x0O7LEqz0T/O3xP4JgOiC4VTot2iiXsB5D0pqc=;
        b=iwdLKqc01t7+/Y5jPnb8vI8VThXNy3w2IHK6TPHu2RBjp/b4AI/cnQJlD8nguY7emQ
         XIK6RenRz2Nmjx2j5anpXeAzMSwtAlbOTuJRiq1of/LgmCk105ukYDbLTqGzRI8K5tqb
         ZJNlY68y8jIpqtaOnwKzxnTFBnJmMXyrFNGtXCiAP5DmGgXGW5imvGni6Be6n8oEfCaN
         1qlNJ/pZFFICp4RWy5eHAHfjQ18iKLejTXirijEDBS01KeI3YTdyM7MRE1d6BeKe7kkX
         IM4wrWDlJogQd0aw0qCN+py4b6y8ZV62PwpogOuIrzkp/P0Vo6BwwkYJuj2QbjuI9Ko6
         FXAA==
X-Gm-Message-State: AGRZ1gKgvKcEXlW6qZvLVncLbmWp3cprz7MetTMu9iXx+fYJaDmAVcXd
        8b1WcmWTswwz5ujv9CtaGkU=
X-Google-Smtp-Source: AJdET5fMTlVB2i94j3rkSoUZ9Q5kSAl8ica5goDRmsnfhge1OLnJIgHiFwwQvpqBlXG7CIalqa62kQ==
X-Received: by 2002:a24:4207:: with SMTP id i7-v6mr675358itb.4.1540886216076;
        Tue, 30 Oct 2018 00:56:56 -0700 (PDT)
Received: from archbookpro.localdomain ([216.1.133.205])
        by smtp.gmail.com with ESMTPSA id b2-v6sm8774435ioc.51.2018.10.30.00.56.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 00:56:55 -0700 (PDT)
Date:   Tue, 30 Oct 2018 03:56:53 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, anmolmago@gmail.com, briankyho@gmail.com,
        david.lu97@outlook.com, shirui.wang@hotmail.com,
        f.francet@hotmail.com
Subject: Re: [RFC PATCH] remote: add --fetch option to git remote set-url
Message-ID: <20181030075653.GA4114@archbookpro.localdomain>
References: <1d1b0fe85ddd89cf8172e730e8886d5b4a9ea7eb.1540627720.git.liu.denton@gmail.com>
 <xmqqftwp47nb.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqftwp47nb.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 29, 2018 at 02:57:28PM +0900, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > This adds the --fetch option to `git remote set-url` such that when
> > executed we move the remote.*.url to remote.*.pushurl and set
> > remote.*.url to the given url argument.
> >
> 
> I suspect this is a horrible idea from end-user's point of view.
> "set-url --push" is used to SET pushURL instead of setting URL and
> does not MOVE anything.  Why should the end user expect and remember
> "set-url --fetch" works very differently?  
>

I agree, `--fetch` is a terrible name for this. Perhaps a better name
would be something like `--fetch-behavior` or `--keep-push` so that the
behaviour is more transparent for the end-user. Either way, I think we
can decide on the name later.

> If there is a need for a "--move-URL-to-pushURL-and-set-pushURL"
> short-hand to avoid having to use two commands
> 
> 	git remote set-url --push $(git remote --get-url origin) origin
> 	git remote set-url $there origin
> 
> it should not be called "--fetch", which has a strong connotation of
> being an opposite of existing "--push", but something else.  And
> then we need to ask ourselves if we also need such a short-hand to
> "--move-pushURL-to-URL-and-set-URL" operation.  The answer to the
> last question would help us decide if (1) this combined operation is
> a good idea to begin with and (2) what is the good name for such an
> operation.
> 
> Assuming that the short-hand operation is a good idea in the first
> place, without deciding what the externally visible good name for it
> is, let's read on.
> 
> > +	/*
> > +	 * If add_mode, we will be appending to remote.*.url so we shouldn't move the urls over.
> > +	 * If pushurls exist, we don't need to move the urls over to pushurl.
> > +	 */
> > +	move_fetch_to_push = fetch_mode && !add_mode && !remote->pushurl_nr;
> 
> Should this kind of "the user asked for --fetch, but sometimes it is
> not appropriate to honor that request" be done silently like this?
> 
> Earlier you had a check like this:
> 
> > +	if (push_mode && fetch_mode)
> > +		die(_("--push --fetch doesn't make sense"));
> 
> If a request to "--fetch" is ignored when "--add" is given, for
> example, shouldn't the combination also be diagnosed as "not making
> sense, we'd ignore your wish to use the --fetch option"?  Similarly
> for the case where there already is pushurl defined for the remote.
> 
> This is a different tangent on the same line, but it could be that
> the user wants to have two (or more) pushURLs because the user wants
> to push to two remotes at the same time with "git push this-remote",
> so silently ignoring "--force" may not be the right thing in the
> first place.  We may instead need to make the value of URL to an
> extra pushURL entry (if we had one, we now have two).
>

Perhaps I should motivate the use-case for this option. There have been
times when I've had the URL set to something but no pushURL. I've
wanted to only change the fetching URL and keep the pushing URL the same
but unfortunately, there's no way to do that because of the url/pushurl
split is set up.

My implementation of --fetch is supposed to emulate what would happen if
git were implemented with fetchurl/pushurl instead. Does the patch make
more sense in this context?

Please let me know if you think that the concept behind this patch is a
good idea. Thanks!
