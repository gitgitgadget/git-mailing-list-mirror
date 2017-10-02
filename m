Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4878120281
	for <e@80x24.org>; Mon,  2 Oct 2017 17:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751236AbdJBRNF (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 13:13:05 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:45048 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751065AbdJBRNE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 13:13:04 -0400
Received: by mail-pf0-f170.google.com with SMTP id t62so2008148pfd.1
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 10:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kc6RAyx915S4Dd4rV12LDn2Bq1uvVuGVrM2K+mCOEkA=;
        b=uDL+SIOER/ZLdaWlb3HjauV3es1lzdiJoHRFePyUXkLlLQUyTBYJaDw9G3tWXpgdI9
         WNxIr+Y6IxIzJHFM0vQ3eMBp0oMRFY5K0ZFasF4ffhDrJLdC0qzCCabdbZjUDDIuKlIh
         2nJFk+ZsNJNTu/tPrPsb15yoeba6tvPYOruG2m1F4S2FMRpbhls5fwWiH6GHncnpqPIf
         2EOGS8R1Sbj5nXBl/8YzUdDR4VTRp/zUEOgjxSDCWm3H6GbG4Ythprt+J1dsosnE6gX4
         5F6GbqVEatSjhmmIDuURlRX/bwc5XNz2ZFoSVIIuzEHQch6EkSEU+/4JV13JA4uh9bs8
         M2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kc6RAyx915S4Dd4rV12LDn2Bq1uvVuGVrM2K+mCOEkA=;
        b=fDFVgHh9xZoL1s9A/+1VI5ivga8hVucs2psFmJBPvBCTexabybhZa6VSWHnNF8e65h
         JoR8iwhoMgO4rdCqu2AzuIpcC8jgeSlvxBYtWcUEvk+u15oDwBaDJzSO1y+EMi/pXMtp
         RyyyIbhWyXj2VdHI+bNUIrnBHAWBGVR5EX3ezmds2aWQzmJw/fQM3DKFcDroGZlzhqBC
         9BYBBhTIZHXu3udlBpC/X+UB6B/9m2h7CIaxYB6u4EPZK+1DH2BgAOfSd0v7zg1LpiXI
         Q+jGzzu9wnw/TAuCnMXCiYO63aH0hifYkHo1Xknkwc4EP1p9kx16HnzLB3IihJZQHLPj
         evBg==
X-Gm-Message-State: AHPjjUhwm6f5PAd+7o6GBeKzLHvNdm0c1QhRR7nX0yQWQC4iH9UGiM3Y
        M9RXP7830880seCn3Eg+YjzSRXDU
X-Google-Smtp-Source: AOwi7QDPSNmK5PfJiLZ2rRufn1T1DezPP4F7rTnxRWlYoBLq9NaBAMk9fcxRfoqz796pASpuD4Y9gw==
X-Received: by 10.98.79.157 with SMTP id f29mr15084483pfj.9.1506964383522;
        Mon, 02 Oct 2017 10:13:03 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:c1fd:a9ac:f156:8142])
        by smtp.gmail.com with ESMTPSA id a29sm17922355pfj.88.2017.10.02.10.13.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 02 Oct 2017 10:13:02 -0700 (PDT)
Date:   Mon, 2 Oct 2017 10:13:00 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     rpjday@crashcourse.ca
Cc:     git@vger.kernel.org
Subject: Re: What means "git config bla ~/"?
Message-ID: <20171002171300.GP19555@aiede.mtv.corp.google.com>
References: <20171002061303.Horde.SL92grZCqTRV9oQkBFPELQ7@crashcourse.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171002061303.Horde.SL92grZCqTRV9oQkBFPELQ7@crashcourse.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

rpjday@crashcourse.ca wrote:

> i'm sure i'm about to embarrass myself but, in "man git-config",
> OPTIONS, one reads:
>
>   --path
>
> git-config will expand leading ~ to the value of $HOME, and ~user
> to the   home directory for the specified user. This option has no
> effect when setting the value (but you can use git config bla ~/
> from the command line to let your shell do the expansion).
>
> what's with that "git config bla ~/"? is this some config keyword
> or something?

No need to be embarrased.  Here "bla" is a placeholder.  That is,
for example, I can run

	git config --global include.path ~/.config/git/more-config

or

	git config --global include.path $HOME/.config/git/more-config

to cause

	[include]
		path = /home/me/.config/git/more-config

to be added to my global configuration.  The expansion of ~ or $HOME
is performed by my shell, not Git.  For comparison, if I had run

	git config --global include.path '~/.config/git/more-config'

then that would cause

	[include]
		path = ~/.config/git/more-config

to be added to my global configuration, but it would still have the
same effect at run time, since Git is also able to expand ~ to my home
directory.

The wording comes from

	commit 1349484e341a3ec2ba02a86c8fbd97ea9dc8c756
	Author: Matthieu Moy <Matthieu.Moy@imag.fr>
	Date:   Wed Dec 30 17:51:53 2009 +0100

	    builtin-config: add --path option doing ~ and ~user expansion.

I agree with you that it is less clear than it could be.  Ideas for
clarifying it?

Thanks,
Jonathan
