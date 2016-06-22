Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D382A1FF40
	for <e@80x24.org>; Wed, 22 Jun 2016 04:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbcFVElL (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 00:41:11 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36054 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbcFVElK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 00:41:10 -0400
Received: by mail-pf0-f173.google.com with SMTP id t190so13528155pfb.3
        for <git@vger.kernel.org>; Tue, 21 Jun 2016 21:41:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aYNfR8we1eehJq0SoCN1AHFYL0EOwvukCpS+xlQUk2Y=;
        b=EdJW+IOd+oNLfUoCYL8xYVMhxk9Xj5phn61olCPjEYtFCJgQtkIhbZE2ky7/n0Tjt7
         RQ31H8GiOmCftMWl7fhzw3uMYwZYvq/bD0MOx0Y+eTetP5Nb9sBPgTLb7XCu1oh5jUG+
         f/3R+g4Bm6XegDbF/56VROGI1C0/SoehvTAi9pg2nwuPugI9ig6VaioiLGYnnmLMFq/f
         JMdZijHvR3eT6kB1C7gxqy+sIMN7FWtEoME86nX5AaZpJRZ5WOttQzfjp8JUDhISRY7I
         yKviL4+tQcOTKuNyVU3lf01vERo5nXXX0Nk8MFbdxS0Ck1yWzWDru6h4QDe/eyWriAmS
         xgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aYNfR8we1eehJq0SoCN1AHFYL0EOwvukCpS+xlQUk2Y=;
        b=l+Sn2WNV/qLqzrD4vZ7H86SHUEMV2nrhcio7ljZN56TH6gxoKqeDt50Ov0m45C3Knk
         iwvIM5qG+5Y+UpZ5JXcHgFdY70gKRoxY9ccbEG5N+QymGC0GcP+HkBf2s/lydnN3koVN
         3uA16qReLn/PPr1rHevJv3D+ReoIWxPPm3EPbIHTLf6X2ZbjCRShvpWO+yw3DfdUQXVg
         Q9IaglwQwh0stlf/TWZhixCkovXNov724rWugldEXUreVWLGt3/3gEY7d/Ynq7LpdR+O
         /MKMDkBXvpvK8lnr98w82VjguKRDpe16QTfUOGTC1Y7DglXl5s3l2BBGv9yabqm+B3zL
         ALSQ==
X-Gm-Message-State: ALyK8tL6pS8HpzYqqCeJYYjK+OQGdrK4M/ADhX6CbZbYWUC4cjoAD+dGaUKjFieOAGa0LA==
X-Received: by 10.98.134.196 with SMTP id x187mr32349388pfd.21.1466570013111;
        Tue, 21 Jun 2016 21:33:33 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id 64sm71635535pfj.96.2016.06.21.21.33.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jun 2016 21:33:31 -0700 (PDT)
Date:	Tue, 21 Jun 2016 21:33:29 -0700
From:	David Aguilar <davvid@gmail.com>
To:	Vasco Almeida <vascomalmeida@sapo.pt>
Cc:	git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 11/11] i18n: difftool: mark warnings for translation
Message-ID: <20160622043329.GA31643@gmail.com>
References: <20160621114413.9467-1-vascomalmeida@sapo.pt>
 <20160621114413.9467-11-vascomalmeida@sapo.pt>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160621114413.9467-11-vascomalmeida@sapo.pt>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jun 21, 2016 at 11:44:13AM +0000, Vasco Almeida wrote:
> --- a/git-difftool.perl
> +++ b/git-difftool.perl
> @@ -451,11 +452,11 @@ sub dir_diff
>  		}
>  
>  		if (exists $wt_modified{$file} and exists $tmp_modified{$file}) {
> -			my $errmsg = "warning: Both files modified: ";
> -			$errmsg .= "'$workdir/$file' and '$b/$file'.\n";
> -			$errmsg .= "warning: Working tree file has been left.\n";
> -			$errmsg .= "warning:\n";
> -			warn $errmsg;
> +			warn sprintf __(
> +"warning: Both files modified:
> +'%s/%s' and '%s/%s'.
> +warning: Working tree file has been left.
> +warning:\n"), $workdir, $file, $b, $file;


Sorry for the nit, but this seems a little hard to read.

It's unfortunate that we have to lose the flow of the code here.
Perhaps we can do something like this to make it flow more like
the original instead?

+			warn sprintf(__(
+				"warning: Both files modified:\n" .
+				"'%s/%s' and '%s/%s'.\n" .
+				"warning: Working tree file has been left.\n" .
+				"warning:\n"), $workdir, $file, $b, $file);

I tend to also prefer parens on the sprintf so that the
parameter grouping is easier to see.

> @@ -467,8 +468,9 @@ sub dir_diff
>  		}
>  	}
>  	if ($error) {
> -		warn "warning: Temporary files exist in '$tmpdir'.\n";
> -		warn "warning: You may want to cleanup or recover these.\n";
> +		warn sprintf __(
> +"warning: Temporary files exist in '%s'.
> +warning: You may want to cleanup or recover these.\n"), $tmpdir;

Ditto, perhaps something like...

+		warn sprintf(__(
+			"warning: Temporary files exist in '%s'.\n" .
+			"warning: You may want to cleanup or recover these.\n"
+			), $tmpdir);

I'm assuming that the i18n infrastructure is prepared to deal
with perl's . dot syntax for string concatenation, though, and
I don't know whether that's true.  Does that work?

What do you think?

ciao,
-- 
David
