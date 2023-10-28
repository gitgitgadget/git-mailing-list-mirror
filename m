Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3406644
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 02:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q32V0HmL"
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE0F90
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 19:20:51 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-7789577b53fso190134285a.3
        for <git@vger.kernel.org>; Fri, 27 Oct 2023 19:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698459651; x=1699064451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PzG+5PoWGB5mpriuGf/TmcRjgQbcjeL3FNiJNwunpdw=;
        b=Q32V0HmLL0wECio4VXQ96gQLOKOi9sW9YXHY5CIVhag1x53O/O+c++KsScLTcFSmEA
         iPYdLdbbx/AMM69pr6NxoFxmMbZ6UEBRnnwAomqmCW85tKy3o5wPABWkGj0x/YQulq3W
         0ekb78aZZg4+f6KJ8beG2WHyVocl8W4hXIh1ZsWmvPj2psiszD8hq6Fw5Om74jgykuF9
         Wo92Hn3jAYJmhmCu2qjg1t+F7rVraR4qpULRBaRIbHlJJ8vdZquV6cOqm/yGVcqhOfhm
         5AfFwxaE7GNJVv522fGywqw95kEA1HSTKSy0sFWySUAbgGVQrkKov52Dl8UueJ7yu0AK
         wE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698459651; x=1699064451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzG+5PoWGB5mpriuGf/TmcRjgQbcjeL3FNiJNwunpdw=;
        b=Wwp54sEfRUzd81sAHE8eOkFaGbV4BkHwrffwb91Amfps9NXOKmJktlGS3umxVnb2To
         SiuQyax8Utr+q0u0vKAjYVp0/zcBDeCtSc3bT5+qsGe1yU+c4thFhB17F1Vzmi9vRDA+
         Dmx95q4h4469+0yx2Z7vnGEwGHxHaxaFo52NRJhTZ7sd4UDTw2c9UckD/6YL4hZMIm3z
         frPAH9VwQbjITPZYRmCds4zFqxDK1kFrr+RO7Y6rlhtbrzlOt3jsnmBI3Q0iHlQIOOB2
         C9HD+26YDVyHUxElTo1pjwZgb5KDgEBA4pz2kUYM7msnTnOUHFzLoEKy8kcH8a88uF7q
         9BPg==
X-Gm-Message-State: AOJu0YxgrqqlxPk13goOm4lcnqo5ROVQyG4Rdx1NBJcYDqAf2vU+VF9a
	t916HDTYQeJHe3UWumt5Obw=
X-Google-Smtp-Source: AGHT+IEfpcQKP2FgjfEKFWbMUfeUf0+/+pHJeCEq9eFZDpOn431SnMa/bJzyfI/dPG1ByThzQYDwAA==
X-Received: by 2002:a05:620a:44d2:b0:767:261d:1ef6 with SMTP id y18-20020a05620a44d200b00767261d1ef6mr4674716qkp.59.1698459650671;
        Fri, 27 Oct 2023 19:20:50 -0700 (PDT)
Received: from shaak (modemcable063.135-226-192.mc.videotron.ca. [192.226.135.63])
        by smtp.gmail.com with ESMTPSA id v23-20020a05620a091700b0076f18be9a64sm1118866qkv.81.2023.10.27.19.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 19:20:49 -0700 (PDT)
Date: Fri, 27 Oct 2023 22:20:48 -0400
From: Liam Beguin <liambeguin@gmail.com>
To: Kousik Sanagavarapu <five231003@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] pretty: add '%aA' to show domain-part of email
 addresses
Message-ID: <20231028022048.GA1784118@shaak>
References: <20231026-pretty-email-domain-v1-2-5d6bfa6615c0@gmail.com>
 <20231027184357.21049-1-five231003@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027184357.21049-1-five231003@gmail.com>

Hi Kousik,

On Sat, Oct 28, 2023 at 12:10:30AM +0530, Kousik Sanagavarapu wrote:
> Hi Liam,
> 
> Liam Beguin <liambeguin@gmail.com> wrote:
> > Subject: Re: [PATCH 2/2] pretty: add '%aA' to show domain-part of email addresses
> 
> Since we are adding both '%aa' and '%aA', it would be better to
> to include both in the commit subject, but since it is already long
> enough, in my opinion
> 
> 	pretty: add formats for domain-part of email address
> 
> would convey the gist of the commit to the reader better.

That reads better, I'll update the commit message.

> > Many reports use the email domain to keep track of organizations
> > contributing to projects.
> > Add support for formatting the domain-part of a contributor's address so
> > that this can be done using git itself, with something like:
> > 
> > 	git shortlog -sn --group=format:%aA v2.41.0..v2.42.0
> > 
> > Signed-off-by: Liam Beguin <liambeguin@gmail.com>
> 
> A very very very minor nit but the commit message would read better as
> 
> 	... contributing to projects, so add support for ...
> 
> Feel free to ignore it.
> 
> > ---
> >  Documentation/pretty-formats.txt |  6 ++++++
> >  pretty.c                         | 13 ++++++++++++-
> >  t/t4203-mailmap.sh               | 28 ++++++++++++++++++++++++++++
> >  t/t6006-rev-list-format.sh       |  6 ++++--
> >  4 files changed, 50 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> > index a22f6fceecdd..72102a681c3a 100644
> > --- a/Documentation/pretty-formats.txt
> > +++ b/Documentation/pretty-formats.txt
> > @@ -195,6 +195,9 @@ The placeholders are:
> >  '%al':: author email local-part (the part before the '@' sign)
> >  '%aL':: author email local-part (see '%al') respecting .mailmap, see
> >  	linkgit:git-shortlog[1] or linkgit:git-blame[1])
> > +'%aa':: author email domain-part (the part after the '@' sign)
> > +'%aA':: author email domain-part (see '%al') respecting .mailmap, see
> > +	linkgit:git-shortlog[1] or linkgit:git-blame[1])
> >  '%ad':: author date (format respects --date= option)
> >  '%aD':: author date, RFC2822 style
> >  '%ar':: author date, relative
> > @@ -213,6 +216,9 @@ The placeholders are:
> >  '%cl':: committer email local-part (the part before the '@' sign)
> >  '%cL':: committer email local-part (see '%cl') respecting .mailmap, see
> >  	linkgit:git-shortlog[1] or linkgit:git-blame[1])
> > +'%ca':: committer email domain-part (the part before the '@' sign)
> > +'%cA':: committer email domain-part (see '%cl') respecting .mailmap, see
> > +	linkgit:git-shortlog[1] or linkgit:git-blame[1])
> >  '%cd':: committer date (format respects --date= option)
> >  '%cD':: committer date, RFC2822 style
> >  '%cr':: committer date, relative
> > diff --git a/pretty.c b/pretty.c
> > index cf964b060cd1..4f5d081589ea 100644
> > --- a/pretty.c
> > +++ b/pretty.c
> > @@ -791,7 +791,7 @@ static size_t format_person_part(struct strbuf *sb, char part,
> >  	mail = s.mail_begin;
> >  	maillen = s.mail_end - s.mail_begin;
> >  
> > -	if (part == 'N' || part == 'E' || part == 'L') /* mailmap lookup */
> > +	if (part == 'N' || part == 'E' || part == 'L' || part == 'A') /* mailmap lookup */
> >  		mailmap_name(&mail, &maillen, &name, &namelen);
> >  	if (part == 'n' || part == 'N') {	/* name */
> >  		strbuf_add(sb, name, namelen);
> > @@ -808,6 +808,17 @@ static size_t format_person_part(struct strbuf *sb, char part,
> >  		strbuf_add(sb, mail, maillen);
> >  		return placeholder_len;
> >  	}
> > +	if (part == 'a' || part == 'A') {	/* domain-part */
> > +		const char *at = memchr(mail, '@', maillen);
> > +		if (at) {
> > +			at += 1;
> > +			maillen -= at - mail;
> > +			strbuf_add(sb, at, maillen);
> > +		} else {
> > +			strbuf_add(sb, mail, maillen);
> > +		}
> > +		return placeholder_len;
> > +	}
> >  
> >  	if (!s.date_begin)
> >  		goto skip;
> 
> So, if we have a domain-name, we grab it, else (the case where we don't
> have '@') we grab it as-is. Looks good.
> 
> > diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
> > index 2016132f5161..35bf7bb05bea 100755
> > --- a/t/t4203-mailmap.sh
> > +++ b/t/t4203-mailmap.sh
> > @@ -624,6 +624,34 @@ test_expect_success 'Log output (local-part email address)' '
> >  	test_cmp expect actual
> >  '
> >  
> > +test_expect_success 'Log output (domain-part email address)' '
> > +	cat >expect <<-EOF &&
> > +	Author email cto@coompany.xx has domain-part coompany.xx
> > +	Committer email $GIT_COMMITTER_EMAIL has domain-part $TEST_COMMITTER_DOMAIN
> > +
> > +	Author email me@company.xx has domain-part company.xx
> > +	Committer email $GIT_COMMITTER_EMAIL has domain-part $TEST_COMMITTER_DOMAIN
> > +
> > +	Author email me@company.xx has domain-part company.xx
> > +	Committer email $GIT_COMMITTER_EMAIL has domain-part $TEST_COMMITTER_DOMAIN
> > +
> > +	Author email nick2@company.xx has domain-part company.xx
> > +	Committer email $GIT_COMMITTER_EMAIL has domain-part $TEST_COMMITTER_DOMAIN
> > +
> > +	Author email bugs@company.xx has domain-part company.xx
> > +	Committer email $GIT_COMMITTER_EMAIL has domain-part $TEST_COMMITTER_DOMAIN
> > +
> > +	Author email bugs@company.xx has domain-part company.xx
> > +	Committer email $GIT_COMMITTER_EMAIL has domain-part $TEST_COMMITTER_DOMAIN
> > +
> > +	Author email author@example.com has domain-part example.com
> > +	Committer email $GIT_COMMITTER_EMAIL has domain-part $TEST_COMMITTER_DOMAIN
> > +	EOF
> > +
> > +	git log --pretty=format:"Author email %ae has domain-part %aa%nCommitter email %ce has domain-part %ca%n" >actual &&
> > +	test_cmp expect actual
> > +'
> > +
> >  test_expect_success 'Log output with --use-mailmap' '
> >  	test_config mailmap.file complex.map &&
> >  
> > diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
> > index 573eb97a0f7f..34c686becf2d 100755
> > --- a/t/t6006-rev-list-format.sh
> > +++ b/t/t6006-rev-list-format.sh
> > @@ -163,11 +163,12 @@ commit $head1
> >  EOF
> >  
> >  # we don't test relative here
> > -test_format author %an%n%ae%n%al%n%ad%n%aD%n%at <<EOF
> > +test_format author %an%n%ae%n%al%aa%n%ad%n%aD%n%at <<EOF
> >  commit $head2
> >  $GIT_AUTHOR_NAME
> >  $GIT_AUTHOR_EMAIL
> >  $TEST_AUTHOR_LOCALNAME
> > +$TEST_AUTHOR_DOMAIN
> >  Thu Apr 7 15:13:13 2005 -0700
> >  Thu, 7 Apr 2005 15:13:13 -0700
> >  1112911993
> > @@ -180,11 +181,12 @@ Thu, 7 Apr 2005 15:13:13 -0700
> >  1112911993
> >  EOF
> >  
> > -test_format committer %cn%n%ce%n%cl%n%cd%n%cD%n%ct <<EOF
> > +test_format committer %cn%n%ce%n%cl%ca%n%cd%n%cD%n%ct <<EOF
> >  commit $head2
> >  $GIT_COMMITTER_NAME
> >  $GIT_COMMITTER_EMAIL
> >  $TEST_COMMITTER_LOCALNAME
> > +$TEST_COMMITTER_DOMAIN
> >  Thu Apr 7 15:13:13 2005 -0700
> >  Thu, 7 Apr 2005 15:13:13 -0700
> >  1112911993
> > 
> > -- 
> > 2.39.0
> 
> The tests look good too.
> 
> I should say I'm skeptical of the new format's name though. I know '%ad' is
> taken... but maybe it's just me.
> 
> Thanks

I agree, %aa isn't the best, I'm definitly opened to suggestions.
My preference would've been for something like %ad, but that's already
taken.

Thanks for reviewing.

Cheers,
Liam
