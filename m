Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B78A1FAFB
	for <e@80x24.org>; Wed,  5 Apr 2017 10:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933466AbdDEKwX (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 06:52:23 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36226 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753477AbdDEKv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 06:51:59 -0400
Received: by mail-it0-f67.google.com with SMTP id a140so1011335ita.3
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 03:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sxTX6Lz/LgdC8ZWRM5vZX70P41xm8Quy18DV6kcGLKc=;
        b=N37IY611q4r40HHBBM5hyrv14vQLoHZd3mzBIpot5YxCN4m/ZbNOTBSZ1MJF2XLDTo
         SPj2Aji9N0aY9J1KMzR+ykrJUSe4DsYvI+0LMFnuthU0jk6Q/Tb+Nsy+L5VylZ4tQxpt
         VDrnbQMFzroG/TAdXCu+j96/IDimBAj2OWaURh+vKUN3fkeTyGy6dP1IrEXQUIJ95gcv
         PYY7OgDQQdgDL7BWA1oB3OQlTiY8XBZ+hD0kAn1GutQrPkN5+vHDRFEJIjGrQvck+5gy
         BHoSikSkWVcGabFHKClexrkDeFRWp1QfLJLk3ZaukasxeGFCfqbAr8wq6N1DVIPkMCq4
         iHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sxTX6Lz/LgdC8ZWRM5vZX70P41xm8Quy18DV6kcGLKc=;
        b=obxmgb/hOUsQWDE7KeosyQ0U44vp1+LXgKPuqV9MZAeMbcYtdH/9pAnr0EJzwB+kE9
         4HGTeWAPieNwXTeUCoQPpY/oiVoKsPmyc/wnxwgWTU1snRtvKreVsKA0S8xEIGhEhuhD
         AIg7OdSzD3GN7gF7LZSvFBhsz7BLCfJZKLynQWQp/tlLdf7OdzxfrHnsMDSUkxhu+eIN
         S9I3hKWHHuOctV6OIviCc2lq02ADgmhkiAObaNXIq4oYfSXzKVyOx3B719z+LlZnZMF0
         XkS0PMJyPy92czG5NhvM24lUbCVPsVOHSmqs13QhMmg/hCx+Q3Z4LADGBSaGWuiFEJyq
         STHg==
X-Gm-Message-State: AFeK/H2ISO35JipRLs2qh1sjtjQqhhbS1DqIZOY9NpTpRboTdZtvvhE1
        jPbXntZS6Dcc+SeCMoh3USCRlmy3cg==
X-Received: by 10.36.173.91 with SMTP id a27mr18730751itj.60.1491389519069;
 Wed, 05 Apr 2017 03:51:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Wed, 5 Apr 2017 03:51:38 -0700 (PDT)
In-Reply-To: <d6ba17f0-3da9-8699-8d5c-5ebf1eaef00e@jupiterrise.com>
References: <20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net> <d6ba17f0-3da9-8699-8d5c-5ebf1eaef00e@jupiterrise.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 5 Apr 2017 12:51:38 +0200
Message-ID: <CACBZZX450tRRsy-Sj8igZthYov7UxFMRJ51M-b1cgYBLo782jQ@mail.gmail.com>
Subject: Re: [RFC] dropping support for ancient versions of curl
To:     "Tom G. Christensen" <tgc@jupiterrise.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Todd Zullinger <tmz@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 5, 2017 at 11:33 AM, Tom G. Christensen <tgc@jupiterrise.com> wrote:
> On 04/04/17 04:54, Jeff King wrote:
>>
>> A nearby thread raised the question of whether we can rely on a version
>> of libcurl that contains a particular feature. The version in question
>> is curl 7.11.1, which came out in March 2004.
>>
>> My feeling is that this is old enough to stop caring about. Which means
>> we can drop some of the #ifdefs that clutter the HTTP code (and there's
>> a patch at the end of this mail dropping support for everything older
>> than 7.11.1). But that made wonder: how old is too old? I think it's
>> nice that we don't force people to upgrade to the latest version of
>> curl. But at some point, if you are running a 13-year-old version of
>> libcurl, how likely are you to run a brand new version of Git? :)
>>
>
> FWIW I maintain freely available updated git packages for RHEL 3, 4, 5, 6
> and 7.
>
> They can be found here:
> https://jupiterrise.com/blog/jrpms/
>
> And direct access here:
> https://jupiterrise.com/jrpms/ (for el3,el4,el5)
> https://jupiterrise.com/jrpmsplus/ (for el6, el7)
>
> They are built against system versions of curl though a few patches are
> required for 7.10.6 (el3) and 7.12.1 (el4) support.

Whoah. So my assumption in
<CACBZZX78oKU5HuBEqb9qLy7--wcwhC_mW6x7Q+tB4suxohSCsQ@mail.gmail.com>
that nobody was compiling this & thus not reporting failures was
false. Rather there's an entire community & distribution mechanism
around patching git for older EL versions, but the patches aren't
making it upstream.

$ grep -h -e ^Subject -e ^Date *patch
Date: Tue, 13 Oct 2009 11:34:11 +0200
Subject: [PATCH 1/7] Make NO_PERL_MAKEMAKER behave more like
Date: Fri, 13 Jun 2014 11:02:02 +0200
Subject: [PATCH 2/7] Install man pages when NO_PERL_MAKEMAKER is used
Date: Mon, 22 Sep 2014 13:42:50 +0200
Subject: [PATCH 3/7] Allow svnrdump_sim.py to be used with Python 2.2
Date: Tue, 8 Mar 2016 09:31:56 +0100
Subject: [PATCH 4/7] Handle missing HTTP_CONNECTCODE in curl < 7.10.7
Date: Tue, 23 Aug 2016 10:32:51 +0200
Subject: [PATCH 5/7] Add support for gnupg < 1.4
Date: Tue, 23 Aug 2016 18:15:13 +0200
Subject: [PATCH 6/7] Handle missing CURLINFO_SSL_DATA_{IN,OUT}
Date: Tue, 23 Aug 2016 18:26:54 +0200
Subject: [PATCH 7/7] Do not use curl_easy_strerror with curl < 7.12.0
Date: Wed, 2 Feb 2011 21:24:44 -0500
Subject: [PATCH] Restore vc-git.el for basic compatibility on EL-5
Date: Mon, 23 Mar 2009 00:03:36 -0400
Subject: [PATCH] git-cvsimport: Ignore cvsps-2.2b1 Branches: output

> Patches can be found in the src.rpm, though I can also post them here as
> patch series, they cover more than just curl.
>
> I don't use the el3 and el4 versions much any more and el5 use will also
> drop of now as I'm busy converting machines from el5 to el7.

It would be great to have them on-list, as far as I can tell they were
never submitted? Is there some time/administrative reason for why
you're not submitting them? Some of these are many years old, it would
be great to have them on-list for wider review & included so vanilla
git works on these platforms.
