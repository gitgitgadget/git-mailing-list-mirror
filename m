Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 463701FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 23:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933440AbcLGX12 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 18:27:28 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34309 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932983AbcLGX11 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 18:27:27 -0500
Received: by mail-pg0-f52.google.com with SMTP id x23so166948342pgx.1
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 15:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VePvmZnmp/bWBYpDbxnd+IXpLAvE2RibFBONBkxYCCU=;
        b=pGW3AZl7DWk8GB706IbJ9BuX49x5m1UTk0JhqywZWwuKwZM9bVZWzzdW8aighB4CMX
         mfYYgw8o/YppKEF8n7NFxpBFa/XIAkXKamI3r6tCwrz6tSnCQSICGkYEHH2NGsbajVbw
         SKF1tUOAVeR/aSRGedsPpv36C4CR84oVS4vnoYomGu0Y0zzkB9aGZDvMdAwhWxcXHiNY
         HfJNTRbWRi54qP3UezzjVy44NANKt9eEia0WOUoAzWp6DDW0MdNYPiw54aMtwUjbLY8Z
         xJZuAXJVuPjacNAGnrpuamoIP2H2uHgTVg4d8+3LJLGoJlVK/sHUObmMp0ZVN7i3T5Vs
         GX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VePvmZnmp/bWBYpDbxnd+IXpLAvE2RibFBONBkxYCCU=;
        b=cSbc2ko3r5N08BA1QvAR/nV+w3HNhJja6i+0EzQCvFMV4+wwUjTHB1ZWjLeQSZQiZK
         CwSPZjQbm/jGA9mg5J6sQnNPphz6ts7lNBd9rSSZuZE5Vo/Gusvpl03PB6nDT8aTopdI
         QCUtvSPReRITE4tI5eEHK/481snT5lePfwNr2UfpfzYQpyCI4bxh6fbQt0IITnbh30X9
         6shnT97W51JLVLC51lWiiVpkXzwTQFCph5wkPJXgaMnoDijcYjMsU2fAmmFGER38uHA1
         qwdX5sRrPemdQK8n4q0ZQa8TYoVsR8ihZYNyHVNbQ9Fr98yS/c4ZKbQqmw33Y3WynIo4
         6neQ==
X-Gm-Message-State: AKaTC01+FKKUh2FnBlEnzELdmtuhFnwhGwlTIeZRH58WXr7BANdQhYQAwwkzHiSHDa88yCU6
X-Received: by 10.98.141.74 with SMTP id z71mr70372669pfd.53.1481153246784;
        Wed, 07 Dec 2016 15:27:26 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:ccae:4719:31da:e07d])
        by smtp.gmail.com with ESMTPSA id p13sm45116696pgf.47.2016.12.07.15.27.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Dec 2016 15:27:25 -0800 (PST)
Date:   Wed, 7 Dec 2016 15:27:24 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 16/17] pathspec: small readability changes
Message-ID: <20161207232724.GI116201@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481061106-117775-17-git-send-email-bmwill@google.com>
 <CACsJy8ChJ_H3gDOuKVYGAKYumG0u2WkBVpNr_3ePyAJ9NojvEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8ChJ_H3gDOuKVYGAKYumG0u2WkBVpNr_3ePyAJ9NojvEg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/07, Duy Nguyen wrote:
> On Wed, Dec 7, 2016 at 4:51 AM, Brandon Williams <bmwill@google.com> wrote:
> > A few small changes to improve readability.  This is done by grouping related
> > assignments, adding blank lines, ensuring lines are <80 characters, etc.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  pathspec.c | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/pathspec.c b/pathspec.c
> > index 41aa213..8a07b02 100644
> > --- a/pathspec.c
> > +++ b/pathspec.c
> > @@ -334,6 +334,7 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
> >         if ((magic & PATHSPEC_LITERAL) && (magic & PATHSPEC_GLOB))
> >                 die(_("%s: 'literal' and 'glob' are incompatible"), elt);
> >
> > +       /* Create match string which will be used for pathspec matching */
> >         if (pathspec_prefix >= 0) {
> >                 match = xstrdup(copyfrom);
> >                 prefixlen = pathspec_prefix;
> > @@ -341,11 +342,16 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
> >                 match = xstrdup(copyfrom);
> >                 prefixlen = 0;
> >         } else {
> > -               match = prefix_path_gently(prefix, prefixlen, &prefixlen, copyfrom);
> > +               match = prefix_path_gently(prefix, prefixlen,
> > +                                          &prefixlen, copyfrom);
> >                 if (!match)
> >                         die(_("%s: '%s' is outside repository"), elt, copyfrom);
> >         }
> > +
> >         item->match = match;
> > +       item->len = strlen(item->match);
> > +       item->prefix = prefixlen;
> > +
> >         /*
> >          * Prefix the pathspec (keep all magic) and assign to
> >          * original. Useful for passing to another command.
> > @@ -362,8 +368,6 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
> >         } else {
> >                 item->original = xstrdup(elt);
> >         }
> > -       item->len = strlen(item->match);
> > -       item->prefix = prefixlen;
> >
> >         if (flags & PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP)
> >             strip_submodule_slash_cheap(item);
> > @@ -371,13 +375,14 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
> >         if (flags & PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE)
> >             strip_submodule_slash_expensive(item);
> >
> > -       if (magic & PATHSPEC_LITERAL)
> > +       if (magic & PATHSPEC_LITERAL) {
> >                 item->nowildcard_len = item->len;
> > -       else {
> > +       } else {
> >                 item->nowildcard_len = simple_length(item->match);
> >                 if (item->nowildcard_len < prefixlen)
> >                         item->nowildcard_len = prefixlen;
> >         }
> > +
> >         item->flags = 0;
> 
> You probably can move this line up with the others too.

I didn't move the item->flags assignment up since the code immediately
following this assignment deal with setting item->flags.  I made more
sense to keep them grouped.

-- 
Brandon Williams
