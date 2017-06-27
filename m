Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0126120401
	for <e@80x24.org>; Tue, 27 Jun 2017 17:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbdF0RWc (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 13:22:32 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35959 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751919AbdF0RWb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 13:22:31 -0400
Received: by mail-pf0-f196.google.com with SMTP id z6so5559526pfk.3
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 10:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=owcuHDwz01/tDuXwqZAv9hB6qtJUnCtfkYDkbzJw6gM=;
        b=tIG1sVZxEuafyzQe4iXEGY0v645lo4XG4tjCAE3ZPNElg0w3hNZWmDTWPdsphfHhyv
         ykqeELeABnifHrWbhGomadkKHc9uvIbQvp3OGGZ9xJhFX5tCopxhOgEcxP/D5XKus1+c
         /lsmUXiPGtH7S1yaTqEZbbpIP7QogUqfKkxEVX1atxtxjzcd8+h1cVcbSLwzYkvcyKls
         Fs7vA93YHOetujzhDKHcE9e+atsout/FWmuQGQqyXfmBiHPTm8rJ4oGMO+uORZsP7fY2
         8j+8u+2855vsZ/WE8BRuDsL/Het1tbUK91JuqH0p930epo5a/A/fBCU2nTw79tctoJ5g
         UbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=owcuHDwz01/tDuXwqZAv9hB6qtJUnCtfkYDkbzJw6gM=;
        b=WqicrfijDmRmWxEh51KtZC2BcF5IXSbyyRVXW/VR7tiXDeFAi+49fb5PoVj4LpXRSg
         BVfH7CD4juMBFiuuPI3VlzsnPGL/9+o3+OLW+VMKZTQzQu6tMV2RwrzuFXgoG5+y8If2
         H9B8N/XCF2ezJpl+2Y3Gt8VzArsqILr6HQJm1HseYQKUiIw1B3iEMefwC++hKDGG2+TI
         btl3/lLCsxNxdhcbnpROCV48l1aFhIsFmfeCkXjDHIrYogk8DW4WtWu+Eh7tRTT6F+kJ
         4bQQ8JcDd8JF5dg/s/GPuljQUMQKJYo861BaTyMoAfAp6x82UJ9qi0k1TiXFhyTzYAL4
         eLKw==
X-Gm-Message-State: AKS2vOzZvKtyJGeKeByQeB+TX3kJPFg/+9rfp6Ste+Gg2sYfCt60kZqr
        ZDSIMiCGLciXOw==
X-Received: by 10.84.178.101 with SMTP id y92mr6903344plb.116.1498584150435;
        Tue, 27 Jun 2017 10:22:30 -0700 (PDT)
Received: from unique-pc ([42.111.175.240])
        by smtp.googlemail.com with ESMTPSA id x64sm8107176pfk.20.2017.06.27.10.22.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Jun 2017 10:22:29 -0700 (PDT)
Message-ID: <1498584144.2737.7.camel@gmail.com>
Subject: Re: [PATCH/RFC] commit-template: improve readability of commit
 template
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Tue, 27 Jun 2017 22:52:24 +0530
In-Reply-To: <xmqqefu64dgz.fsf@gitster.mtv.corp.google.com>
References: <20170626172433.19785-1-kaarticsivaraam91196@gmail.com>
         <xmqqefu64dgz.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2017-06-26 at 14:59 -0700, Junio C Hamano wrote:
> We don't usually make a bullet list in log message.  Please stick to
> a plain prose.  
> 
> "Previously" is superflous.  Say what it does (e.g. "The commit
> template adds optional parts without extra blank lines to its normal
> output") in present tense and explain the ramifications of it
> (e.g. "I personally find that this makes it harder to find the
> optional bit").
> 
Corrected it.

> Perhaps you would want to ensure that this change (if you find it
> valuable) will not get broken by other people in the future by
> writing a new test that ensures that these extra blank lines are
> always there when you think they are needed?
> 
See comment below.

> I personally do not find these new blank lines are necessary, and
> this change wastes vertical screen real estate which is a limited
> resource, but that may be just me.  I on the other hand do not think
> the result of this patch is overly worse than the status quo, either.
> 
I thought it's not good to trade-off readability for vertical space as
the ultimate aim of the commit template (at least to me) is to convey
information to the user about the commit that he's going to make. For
which, I thought it made more sense to improve it's readability by
adding new lines between different sections rather than constrain the
output within a few lines.

In case it's not worth it, I'll revert it back which isn't that big an
issue, anyway. In case it's not suggested to revert this back, I'll add
the tests.

> We do not use // comment in most parts of our codebase that are
> supposed to be platform neutral (iow, compat/ is exempt).
> 
It seems to be a result of my ignorance that C allowed '//' comments
only recently.

> > @@ -877,8 +879,7 @@ static int prepare_to_commit(const char
> > *index_file, const char *prefix,
> >  				(int)(ci.name_end -
> > ci.name_begin), ci.name_begin,
> >  				(int)(ci.mail_end -
> > ci.mail_begin), ci.mail_begin);
> >  
> > -		if (ident_shown)
> > -			status_printf_ln(s, GIT_COLOR_NORMAL,
> > "%s", "");
> > +		status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
> > // Add new line for clarity
> 
> This does ensure that an extra blank line appears after the optional
> section (either after the "only/include assumed" message, or "writing
> for somebody else" message).
> 
> If we were to go with this sparser output, I think we also should
> give an extra blank line before and after the "HEAD detached from
> cafebabe" message you would see:
> 
> 	$ git checkout HEAD^0
> 	$ git commit --allow-empty -o
> 
> or "On branch blah" if you are on a branch.  I think your change
> adds a blank before, but it does not have a separation before
> "Changes not staged for commit" line.
> 
I actually didn't think of modifying that in order to keep it in line
with the output of `git status`. Further, to me, adding *this* new line
before the "Changes not staged for commit" (or something in it's place)
seems to be wasting some vertical space with an added drawback that
it's not in line with `git status`.

> Having said that, to be quite honest, I think this "assuming --only"
> message outlive
> d its usefulness.  This was necessary in very early
> days of Git because originally "git commit foo" did "git add foo &&
> git commit" (i.e. "-i" was the default) and then later when we made
> "--only" the new default in order to match everybody else's SCM, we
> needed to remind users of older versions of Git that "git commit foo"
> now means "git commit --only foo", not "git commit -i foo" which they
> may have been used to.  These days, hopefully nobody expects the "-i"
> semantics when they do "git commit foo", so perhaps it may be a
> better
> change to _remove_ the message altogether.
> 
> And with that done, I wouldn't have reservations on this change
> (i.e. "is it worth wasting extra screen real estate, especially in
> the vertical direction?"), as instead of wasting 2 lines to give a
> message that is no longer useful in today's world, it will be
> removing one line ;-)
> 
You're right! It is worth saving lines if it's not useful these days.

I have sent another mail to the mailing list to get any other possible
improvements to the status.
http://public-inbox.org/git/1498583779.2737.4.camel@gmail.com/

-- 
Regards,
Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
