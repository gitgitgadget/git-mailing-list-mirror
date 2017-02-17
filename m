Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FEE520136
	for <e@80x24.org>; Fri, 17 Feb 2017 16:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934551AbdBQQmo (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 11:42:44 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34719 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933900AbdBQQmn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 11:42:43 -0500
Received: by mail-lf0-f66.google.com with SMTP id q89so4236801lfi.1
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 08:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OrpYRJKmHaLXJOFD8hnCkTvvFpt89oEwBdUjxq/FpR4=;
        b=MpGf5uMOTHLNPayztxpCeDISrFCF3+Oy8VcLPRfqEficHhQHUzrueKuMbaGz9SNk/2
         PZUki0eSD7aaekoS5g/mK2UNxEXxC3qmVBgMojRJKUGCIOBQpJgSiYy7pDo1v6MYiFvL
         2Y9xM2+W0BM/A0ABTUS+/HIZYpTB5smRRAkTtY9fpYNQJZmTMyYwF3sQyUCsibGvJ8cp
         oZ+b72BnK9KZ2BO9GnBkYo7E8NL+HdmCkAACohHabEkazQw0J9zVeFcg1komOMgP7NGE
         Iu65+H2+by7MftF9tT++q6luAC7ujqYIXuNZjGaoBJpRh8LDlnQfvsDzYPrpQ9Yurnm5
         6Igg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OrpYRJKmHaLXJOFD8hnCkTvvFpt89oEwBdUjxq/FpR4=;
        b=q/FSNtnfjapnX+2tB/BZgLOcp4nNt+vsVPXPS2dC8aeQ8sxWzgoiHSM9DvjfqCVOEw
         4yV3+YlWYaf2z7K16DVsG+Ezkkjtx6u6BXOqKZFBX342yvSGtghjbWlBKstiFGEUPQSD
         QOm9e0UIsIFMgomVZPCwim4LKa41SLZyLtZG9GEaTyshA4/iC9t9LS+niTABOhBKNlwG
         5CluXo8aM6B6pv1n7PskNwbVknpqSKfs2JLSq2r8ZH49B0o+vC73KtqIaKkTXhT18F9T
         ZCqD5mcfQ1/UYsIjltQenrGq3lbx3OPdHSbuWTJIUg9LODXOWBvVYkXobnQLUZvTtD96
         h64g==
X-Gm-Message-State: AMke39mnzzFHKn3r1iDtY83N6UfSX8jWTpAqOKEkqKLBE/g+bNOMVMO7zZ61lLl1Pz/Bpw==
X-Received: by 10.25.74.72 with SMTP id x69mr2541237lfa.66.1487349761703;
        Fri, 17 Feb 2017 08:42:41 -0800 (PST)
Received: from xi.terra ([84.216.234.102])
        by smtp.gmail.com with ESMTPSA id h41sm2670675lji.59.2017.02.17.08.42.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 08:42:41 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.88)
        (envelope-from <johan@kernel.org>)
        id 1celcH-0008JZ-Ej; Fri, 17 Feb 2017 17:42:41 +0100
Date:   Fri, 17 Feb 2017 17:42:41 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     Johan Hovold <johan@kernel.org>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Kevin Daudt <me@ikke.info>,
        Junio C Hamano <gitster@pobox.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: body-CC-comment regression
Message-ID: <20170217164241.GE2625@localhost>
References: <20170216174924.GB2625@localhost>
 <vpqlgt6hug6.fsf@anie.imag.fr>
 <20170217110642.GD2625@localhost>
 <vpq7f4pdkjp.fsf@anie.imag.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vpq7f4pdkjp.fsf@anie.imag.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2017 at 02:16:42PM +0100, Matthieu Moy wrote:
> Johan Hovold <johan@kernel.org> writes:
> 
> > There is another option, namely to only accept a single address for tags
> > in the body. I understand that being able to copy a CC-header to either
> > the header section or to the command line could be useful, but I don't
> > really see the point in allowing this in the tags in the body (a SoB
> > always has one address, and so should a CC-tag).
> 
> I mostly agree for the SoB, but why should a Cc tag have only one email?

For symmetry (with SoB) and readability reasons (one tag per line).
These are body tags, not mail headers, after all.

> The "multiple emails per Cc: field" has been there for a while already
> (b1c8a11c8024 released in 2.6.0, sept 2015), some users may have got
> used to it. What you are proposing breaks their flow.

Note that that commit never mentions multiple addresses in either
headers or body-tags -- it's all about being able to specify multiple
entries on the command line.

There does not seem to be single commit in the kernel where multiple
address are specified in a CC tag since after git-send-email started
allowing it, but there are ten commits before (to my surprise), and that
should be contrasted with at least 4178 commits with trailing comments
including a # sign.

> > And since this is a regression for something that has been working for
> > years that was introduced by a new feature, I also think it's reasonable
> > to (partially) revert the feature.
> 
> I'd find it rather ironic to fix your case by breaking a feature that
> has been working for more than a year :-(. What would you answer to a
> contributor comming one year from now and proposing to revert your
> reversion because it breaks his flow?

Such conflicts are not uncommon when dealing with regressions introduced
by new features, and need to be dealt with on a case-by-case basis. But
the fact that trailing comments have been properly supported for more
than four years should carry some weight.

> All that said, I think another fix would be both satisfactory for
> everyone and rather simple:
> 
> 1) Stop calling Mail::Address even if available. It used to make sense
>    to do that when our in-house parser was really poor, but we now have
>    something essentially as good as Mail::Address. We test our parser
>    against Mail::Address and we do have a few known differences (see
>    t9000), but they are really corner-cases and shouldn't matter.
>
>    A good consequence of this is that we stop depending on the way Perl
>    is installed to parse emails. Regardless of the current issue, I
>    think it is a good thing.

Right, that sounds like the right thing to do regardless.

> 2) Modify our in-house parser to discard garbage after the >. The patch
>    should look like (untested):
> 
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -903,11 +903,11 @@ sub parse_mailboxes {
>         my (@addr_list, @phrase, @address, @comment, @buffer) = ();
>         foreach my $token (@tokens) {
>                 if ($token =~ /^[,;]$/) {
> -                       # if buffer still contains undeterminated strings
> -                       # append it at the end of @address or @phrase
> -                       if ($end_of_addr_seen) {
> -                               push @phrase, @buffer;
> -                       } else {
> +                       # if buffer still contains undeterminated
> +                       # strings append it at the end of @address,
> +                       # unless we already saw the closing >, in
> +                       # which case we discard it.
> +                       if (!$end_of_addr_seen) {
>                                 push @address, @buffer;
>                         }
>  
> What do you think?

Sounds perfectly fine to me, and seems to work too after quick test.

Note however that there's another minor issue with using multiple
addresses in a Cc-tag in that it breaks --suppress-cc=self, but I guess
that can be fixed separately.

Thanks,
Johan
