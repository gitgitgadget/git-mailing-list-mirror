Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FED81F859
	for <e@80x24.org>; Sun, 14 Aug 2016 09:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752496AbcHNJQP (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 05:16:15 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:34355 "EHLO
	mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841AbcHNJQO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 05:16:14 -0400
Received: by mail-qt0-f181.google.com with SMTP id u25so11033038qtb.1
        for <git@vger.kernel.org>; Sun, 14 Aug 2016 02:16:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xypW1eiLOTN3Yh468gj8NubwmRKvYHM6lOgNjzroPZo=;
        b=oSW67Qv/IcC3NcEV09KCdXcYbOtk7tabtVFMh1v3Qa34imS4IIoXcnUHQkfhHtNu9e
         DSetpRAxQv6VoR2/WfrBtuedR2o2x8faCpus81RS27l6cNOM9bgL/eG3xCaMyKM57R9J
         eIe5Odswq3JjOhY7Ufbyd4e1acilITY1KqoF7Czi3fPW3d508gLskvDO29O9X30BxusQ
         SlStXD2mVchOUxE+waKtwp8NsDmPQfymlQjhrDpWwEJ0cFll7oeIUAH8JSNW0L/7q602
         kYgVuFDlm1Sj+0lB5VYDOMDjzF5duazoX/t8VKU0+LiP+nB66r4nfNGx8SjPa/UI4+cC
         3ItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xypW1eiLOTN3Yh468gj8NubwmRKvYHM6lOgNjzroPZo=;
        b=WzTbxC/ywPmvu+eH6+GUv0YaDPUDsiCL37WCbEcB3nT/6gpyXRMd7urLB8pb2apy/s
         pBNplHKXzR+cyw0SdglzNFAVPEYEX+xX1EWwRnlh8unyNJArODR0qxI+2qmMmQjgwIA0
         87p8uQm2/YsPXEWWrW0HDoIhG6RRDVT+fD+H0hN4BiJ4nwO5+H+b/yTJarAps///uSl7
         iePF7XYZMy9qjZEDdf7/EtwkGsGVEWOQ+c++IbdRLf1iLBypWXoR1DScNqw+EZM58g/t
         zcU2ZjBMHxErTycofJwxLVut35+kMJA3b3sPrC4bd/+gmA8t5RXFHxlM0OmzabmXVzuM
         +KKg==
X-Gm-Message-State: AEkoouvgGeLz4Air+3tdq9xuM4REKTHMSP+iUwYqLeqKoVVgWNFU5CmefhG4Kfs/H2tfQw==
X-Received: by 10.200.55.137 with SMTP id d9mr25604079qtc.46.1471146146145;
        Sat, 13 Aug 2016 20:42:26 -0700 (PDT)
Received: from gmail.com ([200.125.245.158])
        by smtp.gmail.com with ESMTPSA id c26sm8867053qte.1.2016.08.13.20.42.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Aug 2016 20:42:25 -0700 (PDT)
Date:	Sat, 13 Aug 2016 20:42:21 -0700
From:	David Aguilar <davvid@gmail.com>
To:	Luis Gutierrez <luisgutz@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: git-mergetool reverse file ordering
Message-ID: <20160814034221.GB21057@gmail.com>
References: <CAD8hE_yzNZDPkxRy8s4Fy2_dZN5ppWzLM_2xc01C-VAdR1Pj_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD8hE_yzNZDPkxRy8s4Fy2_dZN5ppWzLM_2xc01C-VAdR1Pj_g@mail.gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 27, 2016 at 11:14:28AM +0100, Luis Gutierrez wrote:
> Hi,
> 
> Attached is a potential patch for reversing the order on which
> git-mergetool presents the files to merge.
> 
> Currently, when running git-mergetool, it performs a sort of the files
> to merge by alphabetical ordering. When working on C, this has the
> annoying effect of presenting the merge for a .c* files before the
> header files; which is always a bit harder to do. Reading the header
> first to figure out what the other dude changed is usually preferred.
> 
> The attach patch reverse the order (-r flag to sort) so *.h* are
> merged before  *.c* files
> 
> PS, given the simplicity of the patch, I have not tested it.
> 
> Regards
> 
> Luis

Thanks for the sug, this is an interesting idea and I definitely
see why we would want something like this...

> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index bf86270..cce3b0d 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -453,10 +453,10 @@ then
>  	then
>  		files=$(git rerere remaining)
>  	else
> -		files=$(git ls-files -u | sed -e 's/^[^	]*	//' | sort -u)
> +		files=$(git ls-files -u | sed -e 's/^[^	]*	//' | sort -u -r)
>  	fi
>  else
> -	files=$(git ls-files -u -- "$@" | sed -e 's/^[^	]*	//' | sort -u)
> +	files=$(git ls-files -u -- "$@" | sed -e 's/^[^	]*	//' | sort -u -r)
>  fi
>  
>  if test -z "$files"

While we won't take this patch as-is (please see
Documentation/SubmittingPatches for details about the patch
submission process), I am interested in the use case you've
described.

This use case makes me wonder whether the sorting we do here is
something that should be opened up a bit so that the it's not
quite so set in stone.

For example, an extension to the approach taken by this patch
would be to have `mergetool.reverseOrder` git config boolean
option that would tell us whether or not to use the "-r" flag
when calling sort.

But, IMO that is too rigid, and only addresses this narrow use
case.  What if users want a case-insensitive sort, or some other
preferred ordering?

We can address these concerns, and your use case, by opening it
up. Something like,

	sort=$(git config mergetool.sort || echo sort -u)

That preserves the existing behavior, and it opens it up so that
we can accomplish the same result as this patch by doing:

	git config mergetool.sort "sort -u -r"

Then, if someone later writes a nicer C/C++-specific sort that
sorts in the natural order but also keeps .h files before .c,
.cpp, etc. files with the same basename, then they could do:

	git config mergetool.sort crescent-fresh-sort

...and it'll be totally crescent.

Thoughts?  Would you be interested in helping work up a patch
for this idea?  At a minimum we should also write a test case in
t/t7610-mergetool.sh to verify that it works as advertised.

Let me know if you have any questions.

cheers,
-- 
David
