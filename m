Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C13D820281
	for <e@80x24.org>; Wed,  1 Nov 2017 10:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751286AbdKAKRM (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 06:17:12 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:47111 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750729AbdKAKRL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 06:17:11 -0400
Received: by mail-wr0-f196.google.com with SMTP id y39so1507925wrd.4
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 03:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dU8Pg8Mnhc9aM9ykonvB6AZSbFh2LDwESRvgC3lyc00=;
        b=gef2kgZXNNTYj681x6peMYigBhGVpL/YVxQpThn3s95pRlvSnof31gx292yUd7OUhO
         g2fTY1LyzeT3LlSVu+uMuPQ0CKZVVZbXTAnyY3tjbcd9YWbuH+uPDikeQo7StknZ4W5s
         idK4dF6pZxu8cEX46ugu8hrgSiAWSmDRrXrUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dU8Pg8Mnhc9aM9ykonvB6AZSbFh2LDwESRvgC3lyc00=;
        b=QdAwiUEE94sm78+QiaVHUz+9ZVEgwYmeEquBd1mmeQvZg2npWVrVdblyDhZJc3ytSC
         YJdAvA1OqT9F6xUySSuBlGuEwtSH4DSVgKCIj3Kp2J4ht9tPtMK8ywYNW3rXwDsaS9V+
         9GHwZoKLGKtSOfTKFfPuJ/Kel3BtDBTKyWbzI1RpbsURHiGcmjKn8R1FFb0w2QX+adeE
         KNBeLvNZQ8WBYeIouUhHpLWH0W7pw4EGg+dO4vMsUgjMBQbyzZNpWUBpLYpF6CQ3PPaP
         aw06cxcvi4FmkfZhlPXZI9ajNQTfAaIJYRFHyt1VYV9p9Iv0OpOFDzu8obZeaOlFrX4r
         rOQQ==
X-Gm-Message-State: AMCzsaX0vbMYBST5p1OoxocF+6VYJr3mhz64/bTaE8/ExN/mcEm16npl
        apefZ5w+ZPBxvHQowGcbASHVzCVkgfU=
X-Google-Smtp-Source: ABhQp+RMRok8wThze3xXA+fopM7T3GtpENyg3VqEJtzc3jB50qp7N+2W3sEXXiLlZ67TcP2EumRRSQ==
X-Received: by 10.223.161.25 with SMTP id o25mr4324259wro.265.1509531429816;
        Wed, 01 Nov 2017 03:17:09 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id a13sm154801wrf.48.2017.11.01.03.17.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Nov 2017 03:17:09 -0700 (PDT)
Date:   Wed, 1 Nov 2017 10:17:07 +0000
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] t5580: add Cygwin support
Message-ID: <20171101101707.GD20681@dinwoodie.org>
References: <20171031131903.10496-1-adam@dinwoodie.org>
 <xmqq1sliydqh.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1sliydqh.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 01, 2017 at 10:44:22AM +0900, Junio C Hamano wrote:
> Adam Dinwoodie <adam@dinwoodie.org> writes:
> 
> > t5580 tests that specifying Windows UNC paths works with Git.  Cygwin
> > supports UNC paths, albeit only using forward slashes, not backslashes,
> > so run the compatible tests on Cygwin as well as MinGW.
> >
> > The only complication is Cygwin's `pwd`, which returns a *nix-style
> > path, and that's not suitable for calculating the UNC path to the
> > current directory.  Instead use Cygwin's `cygpath` utility to get the
> > Windows-style path.
> >
> > Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
> > ---
> >  t/t5580-clone-push-unc.sh | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/t/t5580-clone-push-unc.sh b/t/t5580-clone-push-unc.sh
> > index b322c2f72..47a9a7cda 100755
> > --- a/t/t5580-clone-push-unc.sh
> > +++ b/t/t5580-clone-push-unc.sh
> > @@ -3,12 +3,16 @@
> >  test_description='various Windows-only path tests'
> >  . ./test-lib.sh
> >  
> > -if ! test_have_prereq MINGW; then
> > +if test_have_prereq CYGWIN; then
> > +	alias winpwd='cygpath -aw .'
> > +elif test_have_prereq MINGW; then
> > +	alias winpwd=pwd
> > +else
> >  	skip_all='skipping Windows-only path tests'
> >  	test_done
> >  fi
> 
> The fact that UNCPATH matters only on windows-related platforms
> justifies the name used for this alias, I guess ;-)

I think I was going for "Windows-style pwd" or similar, given in both
cases the alias produces something that looks like "C:\path\to\dir".
