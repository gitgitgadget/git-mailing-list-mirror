Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 460712013A
	for <e@80x24.org>; Fri, 17 Feb 2017 11:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933547AbdBQLGr (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 06:06:47 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34863 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932374AbdBQLGp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 06:06:45 -0500
Received: by mail-lf0-f68.google.com with SMTP id z127so1182463lfa.2
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 03:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TJak0NU+q0lG5ENVrzItnzwQQwicdspnBOGtepqLcAQ=;
        b=eH5SMvaZNsIAsyFvp1Mhbwmxq+Q9v3h2aG8NAy0XY2/N2tB18h7/c0NDeQoUk0yzw/
         zWvokTLsv7OG9A8QqO7DYKtsFIrAn0lrFCyKZ1XdPyPq8rhqJx2CIF32MCu9IAUtAoW6
         V4Tzeislk7b/DcEGSFJydgmy0ymEFv6fokiqPIkiV+DXEC7Zm+fKtsOliY2lo43NmE1f
         YyrazPhkXLeyPw0VDagjQ+BRB2rhlD5gm4QIcy35c7xnESSqgz0MkpowSxAKnyESbUT3
         pv9wJJ5dEDQOHchkqM8GI47R2c8uAnVgrwgot4RytIJ0i8fcpqQBkt4DmK221Mnd7Fc3
         VeSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TJak0NU+q0lG5ENVrzItnzwQQwicdspnBOGtepqLcAQ=;
        b=R33ab8i2+1iCT4qhowd9zqlCBf5iNOTIUqozcVzsDpGt8EMdbHjgAb3IBsKyz46gXe
         y/MIHJcpmmNPi7F7LN/Oa1l/ztTHTVzdDxLQU4YKTEGrz2CFQU3of/breq4z5H7F0tpw
         pbnIjDqxwOvILjygNPxZR0qB1oxFQbpllYOgtGfctWkSAjg1S+20wqjdlGi9e8jegVBH
         tJ+Nc8o8PCKYKovAjZsH1UApmxlR1VJ+1rkbquU3Tr3C7DTFOURJsyHaNaBi7g5NaEzn
         wJtxpkHfZ8AWrhTwq9SuLpGICQ2X/ujILpZg1423tjzxZRFziK5l6hYTrCyX9lNd7dPQ
         nsNg==
X-Gm-Message-State: AMke39mCjSnJUVj7LdaRD3PAJCB2ZRx4RnqFy6GzmtF9ejl7OXeamM8oGwJtGbseHHED5g==
X-Received: by 10.25.156.213 with SMTP id f204mr2155978lfe.27.1487329603771;
        Fri, 17 Feb 2017 03:06:43 -0800 (PST)
Received: from xi.terra ([84.216.234.102])
        by smtp.gmail.com with ESMTPSA id u18sm2403471lff.48.2017.02.17.03.06.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 03:06:42 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.88)
        (envelope-from <johan@kernel.org>)
        id 1cegN8-0007o4-LO; Fri, 17 Feb 2017 12:06:42 +0100
Date:   Fri, 17 Feb 2017 12:06:42 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     Johan Hovold <johan@kernel.org>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Kevin Daudt <me@ikke.info>,
        Junio C Hamano <gitster@pobox.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: body-CC-comment regression
Message-ID: <20170217110642.GD2625@localhost>
References: <20170216174924.GB2625@localhost>
 <vpqlgt6hug6.fsf@anie.imag.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vpqlgt6hug6.fsf@anie.imag.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2017 at 07:16:57PM +0100, Matthieu Moy wrote:
> Johan Hovold <johan@kernel.org> writes:
> 
> > Hi,
> >
> > I recently noticed that after an upgrade, git-send-email (2.10.2)
> > started aborting when trying to send patches that had a linux-kernel
> > stable-tag in its body. For example,
> >
> > 	Cc: <stable@vger.kernel.org>	# 4.4
> >
> > was now parsed as
> >
> > 	"stable@vger.kernel.org#4.4"
> >
> > which resulted in
> >
> > 	Died at /usr/libexec/git-core/git-send-email line 1332, <FIN> line 1.
> 
> This has changed in e3fdbcc8e1 (parse_mailboxes: accept extra text after
> <...> address, 2016-10-13), released v2.11.0 as you noticed:
> 
> > The problem with the resulting fixes that are now in 2.11.1 is that
> > git-send-email no longer discards the trailing comment but rather
> > shoves it into the name after adding some random white space:
> >
> > 	"# 3 . 3 . x : 1b9508f : sched : Rate-limit newidle" <stable@vger.kernel.org>"
> >
> > This example is based on the example from
> > Documentation/process/stable-kernel-rules.rst:
> >
> > 	Cc: <stable@vger.kernel.org> # 3.3.x: 1b9508f: sched: Rate-limit newidle
> >
> > and this format for stable-tags has been documented at least since 2009
> > and 8e9b9362266d ("Doc/stable rules: add new cherry-pick logic"), and
> > has been supported by git since 2012 and 831a488b76e0 ("git-send-email:
> > remove garbage after email address") I believe.
> >
> > Can we please revert to the old behaviour of simply discarding such
> > comments (from body-CC:s) or at least make it configurable through a
> > configuration option?
> 
> The problem is that we now accept list of emails instead of just one
> email, so it's hard to define what "comments after the email", for
> example
> 
> Cc: <foo@example.com> # , <boz@example.com>
> 
> Is not accepted as two emails.
> 
> So, just stripping whatever comes after # before parsing the list of
> emails would change the behavior once more, and possibly break other
> user's flow. Dropping the garbage after the email while parsing is
> possible, but only when we use our in-house parser (and we currently use
> Perl's Mail::Address when available).
> 
> So, a proper fix is far from obvious, and unfortunately I won't have
> time to work on that, at least not before a while.

There is another option, namely to only accept a single address for tags
in the body. I understand that being able to copy a CC-header to either
the header section or to the command line could be useful, but I don't
really see the point in allowing this in the tags in the body (a SoB
always has one address, and so should a CC-tag).

And since this is a regression for something that has been working for
years that was introduced by a new feature, I also think it's reasonable
to (partially) revert the feature.

> OTOH, the current behavior isn't that bad. It accepts the input, and
> extracts a valid email out of it. Just the display name is admitedly
> suboptimal ...

Yeah, but the display name can end up with so much noise that auto-cc is
effectively broken for people submitting kernel patches (with stable
tags) as the only way to avoid it is to suppress all bodycc.

So what I'm proposing is to revert to the earlier behaviour of only
allowing one address per body tag by simply discarding anything
after the address.

Something like the below seems to do the trick.

Thanks,
Johan



From f551b4ca9926624dc7af6c286d7cf0f97af39541 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 17 Feb 2017 11:55:47 +0100
Subject: [PATCH] send-email: only allow one address per body tag

Adding comments after a tag in the body is a common practise (e.g. in
the Linux kernel) and git-send-email has been supporting this for years
by removing any trailing cruft after the address.

After some recent changes, any trailing comment is now instead appended
to the recipient name (with some random white space inserted) resulting
in undesirable noise in the headers, for example:

CC: "# 3 . 3 . x : 1b9508f : sched : Rate-limit newidle" <stable@vger.kernel.org>

Revert to the earlier behaviour of discarding anything after the (first)
address in a tag while parsing the body.

Note that multiple addresses after are still allowed after a
command-line switch (and in a CC-header).

Fixes: b1c8a11c8024 ("send-email: allow multiple emails using --cc, --to
and --bcc")
Fixes: e3fdbcc8e164 ("parse_mailboxes: accept extra text after <...>
address")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 git-send-email.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 068d60b3e698..eea0a517f71b 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1563,7 +1563,7 @@ foreach my $t (@files) {
 	# Now parse the message body
 	while(<$fh>) {
 		$message .=  $_;
-		if (/^(Signed-off-by|Cc): (.*)$/i) {
+		if (/^(Signed-off-by|Cc): ([^>]*>?)/i) {
 			chomp;
 			my ($what, $c) = ($1, $2);
 			chomp $c;
-- 
2.11.1
