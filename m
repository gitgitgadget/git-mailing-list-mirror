Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBA721FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 18:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933108AbdBPSOV (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 13:14:21 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34328 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933042AbdBPSOU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 13:14:20 -0500
Received: by mail-lf0-f67.google.com with SMTP id q89so2083782lfi.1
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 10:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F6TjaStrTuzbCwqUMv6/W5XmO0trNg/bUZXO2Ii0cME=;
        b=IiVrffTDDity9sdWL6ljRgvgfq6/vK5QPpsrEH8KmawEoT3JQxIfzWmy1018aeWr4J
         XEJMEcGOEq1lLrDbvw71Qp8AUVwuqECmLDiVxMYb5kT6R+o6fOt5RF5VK03DBjHUCfKs
         DA8w4Z6s2TTI+EUny3FqPW08OTgwba74ou9jHii97bwkwy3GTBzLjlIK1+u80Z+nu99c
         oiDWBYog2v37MHcSbUi6Y6v950yoNLXzEsN4FU0RMjV201/Qgp4qLeYtg5SkjivAGJ2M
         lCMvS2+Au0nwHdeiZL3EGsrUr1iZD9PSYdgXgwe/WQprksTNcR06EIQw8Sfji1dTCxw9
         KxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=F6TjaStrTuzbCwqUMv6/W5XmO0trNg/bUZXO2Ii0cME=;
        b=kStEcp699ughvuT9VzB6FTV9/VvEeNn7oJrBtxldfgnbjkEPMnERYtihBZ83Nr36Pg
         WyysEbBB4FZoiWgF8WgzqWNDl7U1RCeh9tIsPdLXgQyuuIZSU7wUMGkNW3Vv7bP9mTdJ
         pcu0cDSXLuALzNLILFNDWkGevowpQKX3Xxdbu75Irt4quhKcoAVnlAS3SH9dz6AELgWE
         nWHfV6b8to+7YGVgHzsqyl0bWPao3fYlwZ8mLzWQNEE1qzcPMj7Vzo7b4F5I/SsvYsHa
         joXMp4AtkvNVCXTqFkum0BTOgt2n0xqcj1v5hi5bkKCGEXhYnVhB/aSa446Ghd5UGd8d
         Fe/A==
X-Gm-Message-State: AMke39m169tXHjU4SB7WXzrZu3lQ+kIPVvH46BuYWzoYZUBiHpBNBCYxFI+XtVSk/LIMng==
X-Received: by 10.25.21.142 with SMTP id 14mr1160271lfv.138.1487268858854;
        Thu, 16 Feb 2017 10:14:18 -0800 (PST)
Received: from xi.terra ([84.216.234.102])
        by smtp.gmail.com with ESMTPSA id o80sm660705lff.23.2017.02.16.10.14.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 10:14:18 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.88)
        (envelope-from <johan@kernel.org>)
        id 1ceQZO-0004UW-9u; Thu, 16 Feb 2017 19:14:18 +0100
Date:   Thu, 16 Feb 2017 19:14:18 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johan Hovold <johan@kernel.org>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Kevin Daudt <me@ikke.info>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: body-CC-comment regression
Message-ID: <20170216181418.GC2625@localhost>
References: <20170216174924.GB2625@localhost>
 <xmqq60kayq2q.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq60kayq2q.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2017 at 09:59:25AM -0800, Junio C Hamano wrote:
> Johan Hovold <johan@kernel.org> writes:
> 
> > I recently noticed that after an upgrade, git-send-email (2.10.2)
> > started aborting when trying to send patches that had a linux-kernel
> > stable-tag in its body. For example,
> >
> > 	Cc: <stable@vger.kernel.org>	# 4.4
> >
> > was now parsed as
> >
> > 	"stable@vger.kernel.org#4.4"
> > ...
> 
> It sounds like a fallout of this:
> 
>   https://public-inbox.org/git/41164484-309b-bfff-ddbb-55153495d41a@lwfinger.net/#t 
> 
> and any change to "fix" you may break the other person.

Yes, that's the thread I was referring to as well, and the reported
breakage is the same even if the reporter used a non-standard stable-tag
format (e.g. a "[4.8+]" suffix).

What I'm wondering is whether the alternative fix proposed in that
thread, to revert to the old behaviour of discarding trailing comments,
should be considered instead of what was implemented.

> > Can we please revert to the old behaviour of simply discarding such
> > comments (from body-CC:s) or at least make it configurable through a
> > configuration option?
> 
> If I recall the old thread correctly, it was reported that using
> Mail::Address without forcing git-send-email fall back to its own
> non-parsing-but-paste-address-looking-things-together code would
> solve it, so can the "make it configurable" be just "install
> Mail::Address"?

I believe git-send-email's parser was changed to mimic Mail::Address,
and installing it does not seem to change the behaviour of including any
trailing comments in the name.

Thanks,
Johan
