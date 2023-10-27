Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0DD3D3A5
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 18:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFUIv+zw"
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B840C9D
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 11:44:01 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cc30cfec53so409335ad.3
        for <git@vger.kernel.org>; Fri, 27 Oct 2023 11:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698432241; x=1699037041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucP1yE2NVhrfYxuXMuWaYuODXuuKKeXSI2dHeFnwQsU=;
        b=YFUIv+zwdQz10OXn3eOpTnaaU93UieMWsc5igkMZEHWRqR1riW45aLyECrCMyuKDA4
         eJJ22yCuERFDIBvFt/krMDx4BByLq9aqgmC7exL4IrZ4ECbjrjY92gtyakD/k1zyiRSc
         OPTsDIrOXnIdZVR+1kauuXGLGcwqIxuKUsPVeDnm+ESSPcP+uhdZQJwrBDryUphbzujC
         mlX9XcTjDNtr9DrQ3il3YnR1nJyTPrTVmSCHb+4hbNLrUyDS/Nqf4rlGdh+pAksWeWaw
         ofCa9ugnCShg69loOWpFkqwA5/fi9YaGcENUfj9rGlUThAj2x+eg+/VIlhxhdSAG7gsK
         KucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698432241; x=1699037041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucP1yE2NVhrfYxuXMuWaYuODXuuKKeXSI2dHeFnwQsU=;
        b=P3C/r5viRFXmEIoTJ9IWxriAqtsz2dPE6Rb4xRLXjiw63lygCzQJeQAKheI05mzhfH
         MwOAi6ZULyz+nJdwNTxJ9UdzdOa9Hsie03po8Dy8D9D+WGWx1B6ctiwwg/FA6nay7R9V
         OaS17Rj1Y4Uvj5FsuQrtZvhTLH+kNcVkka2+8HkPUTX8K0xrvo0fgXchzReG4bAXSihI
         7IHv930jznVtTDoG2IAy5Y3OoNhlDUDaM9LHOKNRNkkkT5u5X5uarttR+rROJ89ilc10
         Lubmj29an4n48tuDxgoLh3TSMth81Om2bOUU5PsigdQDsmrnyt2qGCJxjBsF/SCZ2OB3
         T1kA==
X-Gm-Message-State: AOJu0YzL30PhwVdssMFPCYGiew70K7AEjCpnQWHwTxSbiduhmL+2SvfT
	YrVoD2p3YdQPUPEXQC63aFpL/WoL9ulagA==
X-Google-Smtp-Source: AGHT+IGrx3Yk4yGl5bHpsr+JTSDqh/z0mVqoOLbfj4GOEyW/vlvUl0qxBDCm79GcCyVY+VcGxvFNPQ==
X-Received: by 2002:a17:902:cecb:b0:1cc:30c3:3508 with SMTP id d11-20020a170902cecb00b001cc30c33508mr121480plg.52.1698432241083;
        Fri, 27 Oct 2023 11:44:01 -0700 (PDT)
Received: from kousik.local ([2405:201:c006:31fd:c14a:46ee:67a0:232c])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902c1c500b001cc1465a6f3sm1903969plc.91.2023.10.27.11.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 11:44:00 -0700 (PDT)
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Liam Beguin <liambeguin@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] pretty: add '%aA' to show domain-part of email addresses
Date: Sat, 28 Oct 2023 00:10:30 +0530
Message-ID: <20231027184357.21049-1-five231003@gmail.com>
X-Mailer: git-send-email 2.42.0.424.gceadf0f3cf.dirty
In-Reply-To: <20231026-pretty-email-domain-v1-2-5d6bfa6615c0@gmail.com>
References: <20231026-pretty-email-domain-v1-2-5d6bfa6615c0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Liam,

Liam Beguin <liambeguin@gmail.com> wrote:
> Subject: Re: [PATCH 2/2] pretty: add '%aA' to show domain-part of email addresses

Since we are adding both '%aa' and '%aA', it would be better to
to include both in the commit subject, but since it is already long
enough, in my opinion

	pretty: add formats for domain-part of email address

would convey the gist of the commit to the reader better.

> Many reports use the email domain to keep track of organizations
> contributing to projects.
> Add support for formatting the domain-part of a contributor's address so
> that this can be done using git itself, with something like:
> 
> 	git shortlog -sn --group=format:%aA v2.41.0..v2.42.0
> 
> Signed-off-by: Liam Beguin <liambeguin@gmail.com>

A very very very minor nit but the commit message would read better as

	... contributing to projects, so add support for ...

Feel free to ignore it.

> ---
>  Documentation/pretty-formats.txt |  6 ++++++
>  pretty.c                         | 13 ++++++++++++-
>  t/t4203-mailmap.sh               | 28 ++++++++++++++++++++++++++++
>  t/t6006-rev-list-format.sh       |  6 ++++--
>  4 files changed, 50 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index a22f6fceecdd..72102a681c3a 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -195,6 +195,9 @@ The placeholders are:
>  '%al':: author email local-part (the part before the '@' sign)
>  '%aL':: author email local-part (see '%al') respecting .mailmap, see
>  	linkgit:git-shortlog[1] or linkgit:git-blame[1])
> +'%aa':: author email domain-part (the part after the '@' sign)
> +'%aA':: author email domain-part (see '%al') respecting .mailmap, see
> +	linkgit:git-shortlog[1] or linkgit:git-blame[1])
>  '%ad':: author date (format respects --date= option)
>  '%aD':: author date, RFC2822 style
>  '%ar':: author date, relative
> @@ -213,6 +216,9 @@ The placeholders are:
>  '%cl':: committer email local-part (the part before the '@' sign)
>  '%cL':: committer email local-part (see '%cl') respecting .mailmap, see
>  	linkgit:git-shortlog[1] or linkgit:git-blame[1])
> +'%ca':: committer email domain-part (the part before the '@' sign)
> +'%cA':: committer email domain-part (see '%cl') respecting .mailmap, see
> +	linkgit:git-shortlog[1] or linkgit:git-blame[1])
>  '%cd':: committer date (format respects --date= option)
>  '%cD':: committer date, RFC2822 style
>  '%cr':: committer date, relative
> diff --git a/pretty.c b/pretty.c
> index cf964b060cd1..4f5d081589ea 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -791,7 +791,7 @@ static size_t format_person_part(struct strbuf *sb, char part,
>  	mail = s.mail_begin;
>  	maillen = s.mail_end - s.mail_begin;
>  
> -	if (part == 'N' || part == 'E' || part == 'L') /* mailmap lookup */
> +	if (part == 'N' || part == 'E' || part == 'L' || part == 'A') /* mailmap lookup */
>  		mailmap_name(&mail, &maillen, &name, &namelen);
>  	if (part == 'n' || part == 'N') {	/* name */
>  		strbuf_add(sb, name, namelen);
> @@ -808,6 +808,17 @@ static size_t format_person_part(struct strbuf *sb, char part,
>  		strbuf_add(sb, mail, maillen);
>  		return placeholder_len;
>  	}
> +	if (part == 'a' || part == 'A') {	/* domain-part */
> +		const char *at = memchr(mail, '@', maillen);
> +		if (at) {
> +			at += 1;
> +			maillen -= at - mail;
> +			strbuf_add(sb, at, maillen);
> +		} else {
> +			strbuf_add(sb, mail, maillen);
> +		}
> +		return placeholder_len;
> +	}
>  
>  	if (!s.date_begin)
>  		goto skip;

So, if we have a domain-name, we grab it, else (the case where we don't
have '@') we grab it as-is. Looks good.

> diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
> index 2016132f5161..35bf7bb05bea 100755
> --- a/t/t4203-mailmap.sh
> +++ b/t/t4203-mailmap.sh
> @@ -624,6 +624,34 @@ test_expect_success 'Log output (local-part email address)' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'Log output (domain-part email address)' '
> +	cat >expect <<-EOF &&
> +	Author email cto@coompany.xx has domain-part coompany.xx
> +	Committer email $GIT_COMMITTER_EMAIL has domain-part $TEST_COMMITTER_DOMAIN
> +
> +	Author email me@company.xx has domain-part company.xx
> +	Committer email $GIT_COMMITTER_EMAIL has domain-part $TEST_COMMITTER_DOMAIN
> +
> +	Author email me@company.xx has domain-part company.xx
> +	Committer email $GIT_COMMITTER_EMAIL has domain-part $TEST_COMMITTER_DOMAIN
> +
> +	Author email nick2@company.xx has domain-part company.xx
> +	Committer email $GIT_COMMITTER_EMAIL has domain-part $TEST_COMMITTER_DOMAIN
> +
> +	Author email bugs@company.xx has domain-part company.xx
> +	Committer email $GIT_COMMITTER_EMAIL has domain-part $TEST_COMMITTER_DOMAIN
> +
> +	Author email bugs@company.xx has domain-part company.xx
> +	Committer email $GIT_COMMITTER_EMAIL has domain-part $TEST_COMMITTER_DOMAIN
> +
> +	Author email author@example.com has domain-part example.com
> +	Committer email $GIT_COMMITTER_EMAIL has domain-part $TEST_COMMITTER_DOMAIN
> +	EOF
> +
> +	git log --pretty=format:"Author email %ae has domain-part %aa%nCommitter email %ce has domain-part %ca%n" >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'Log output with --use-mailmap' '
>  	test_config mailmap.file complex.map &&
>  
> diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
> index 573eb97a0f7f..34c686becf2d 100755
> --- a/t/t6006-rev-list-format.sh
> +++ b/t/t6006-rev-list-format.sh
> @@ -163,11 +163,12 @@ commit $head1
>  EOF
>  
>  # we don't test relative here
> -test_format author %an%n%ae%n%al%n%ad%n%aD%n%at <<EOF
> +test_format author %an%n%ae%n%al%aa%n%ad%n%aD%n%at <<EOF
>  commit $head2
>  $GIT_AUTHOR_NAME
>  $GIT_AUTHOR_EMAIL
>  $TEST_AUTHOR_LOCALNAME
> +$TEST_AUTHOR_DOMAIN
>  Thu Apr 7 15:13:13 2005 -0700
>  Thu, 7 Apr 2005 15:13:13 -0700
>  1112911993
> @@ -180,11 +181,12 @@ Thu, 7 Apr 2005 15:13:13 -0700
>  1112911993
>  EOF
>  
> -test_format committer %cn%n%ce%n%cl%n%cd%n%cD%n%ct <<EOF
> +test_format committer %cn%n%ce%n%cl%ca%n%cd%n%cD%n%ct <<EOF
>  commit $head2
>  $GIT_COMMITTER_NAME
>  $GIT_COMMITTER_EMAIL
>  $TEST_COMMITTER_LOCALNAME
> +$TEST_COMMITTER_DOMAIN
>  Thu Apr 7 15:13:13 2005 -0700
>  Thu, 7 Apr 2005 15:13:13 -0700
>  1112911993
> 
> -- 
> 2.39.0

The tests look good too.

I should say I'm skeptical of the new format's name though. I know '%ad' is
taken... but maybe it's just me.

Thanks
