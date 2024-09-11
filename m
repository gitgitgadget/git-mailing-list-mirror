Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846C5156962
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 22:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726093236; cv=none; b=bx/GvjpmR4WDXpwdKIlNX9DhepA+TS9ya6yqZzgK36EGcM+2pJeV6DSxunE+lWcMc1MQKwkCUO2SV4c9KKEVaXntKXfFFgUVCztUs+9Sn1DU3LhD79fgc+nc32j02BoWc1nDPcVHLgM5TzMcyJRnCtP4By2e43lBLN/Lj+9bv80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726093236; c=relaxed/simple;
	bh=MsUIcjFf8w1rpFVpdcjK7HNfCv40qnrbn87SjRKjEx4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GthY9DN+UfLXBtaCNY1StPb5vTqGwevi6J3sGTfyAHT//ByBK2xqPKuYV45obt4mDBKUEwNni0FpQmj62/JHA1Mjn4gBZAVnQOdO6kAfkLTmIw3+/RBRRbLyefKXUjThqlFJhvJZ+2AJOHJmcVTfFN171kGDWfilPtuVnGYzwOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=ahx0ebGg; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="ahx0ebGg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1726093221; x=1726698021;
	i=johannes.schindelin@gmx.de;
	bh=+KTPctBLOEMKz4vnbcqdabS/gmV43Kz21kIJUKWY2HQ=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ahx0ebGgh4UWUZZ+snPTMoTg2v3jXJ2FeMfBnfFVJN12cu8a81Wysnl6P2SqujME
	 3HZ4AmVgTXnJxSDFOOWJSoHmeP9xIfUGg7yc2dKx4mKot0mYq6nQa0jNQRJ0xZvfY
	 d7yAHElP1nctVR8bRxOyJJXHg7tiQlwvF81Rh1a70/2N+jBdeAsX0mqvafIVnxBuM
	 Ck34bgqeFI1htAjGUV/yKr0nuI1gzGFVHH7vJypYfEZMRAujuu3yVN2Np6aalG8ct
	 lFvlIs3LU8sC/v42P3y06zlaVNXwcvcsS35SIFpDcFAQ5h5IKPW1l9hC8ykGzanr+
	 7tZSKkzIYXgQAJU54Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.102]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5mKP-1rvT261mgN-00sv5b; Thu, 12
 Sep 2024 00:20:21 +0200
Date: Thu, 12 Sep 2024 00:20:20 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
cc: Matt Burke <spraints@gmail.com>, Victoria Dye <vdye@github.com>, 
    =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>, 
    Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
    Todd Zullinger <tmz@pobox.com>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: Migration of git-scm.com to a static web site: ready for
 review/testing
In-Reply-To: <155bc141-a16a-9fd2-920b-7a8c398d5e36@gmx.de>
Message-ID: <19f553dc-a778-3ba7-b037-0a08da7e9388@gmx.de>
References: <6f7d20b4-a725-0ef9-f6d3-ff2810da9e7a@gmx.de> <155bc141-a16a-9fd2-920b-7a8c398d5e36@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1979516866-1726093221=:99"
X-Provags-ID: V03:K1:Tmb3E9KKj9ldgHREyepFmOOcMqSWZ1OeKqji6ID41/aWvvgLJBz
 9cC//RmTWowCtzpJ37yrRRE6BlvtKONimEsBBjm4LOGdkaqZaEtLB2HHuUG6f/V0kW6qXgb
 zGDG0fuih4zQ3aRWdQqcSdOQkP0hhsMUX2NKoXd74F4/q6i9EjWaYf1WXvuZUWwU6TP+Vhb
 3+MPjXN5GOPbuxd44mk5A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0OkFZvtYEdY=;V6Zs9jGf2hZyInCQS4ESzSQpT+r
 NmCb8sZa9gyD9nLd315lISZf/22gw5UXv74U91Ipw+2yAXBV9kOb5mNgggPGOyFuWYkssewZZ
 KxGFbIJnV0ZuUFyAaEv0iZhXXxVYwMErXFgRBChdwXjwgbG7rrNQKGGD3L57jkICtrw/agURD
 uphWFFNoGapFgRbtc+SlZ1b+8jFV5lYRoPl3rXVSXiLz+luj6iX1v4JmQjetFKSmdYfI8sI07
 MAeyFVwQygHKEM8pdL/3ptgbPKBdbMxWz4cix93sSYmQqhZUqy7KwInrDvnBfifQETu0n0Yb8
 AcnUFDDcUTWeXrS2Jl/1IC8PEd6tr0DZ3HaNq6gHboSWCwJQbe8rYy561QzILk7jUPqeLBu50
 wIBn2nnKjlF0/V2iErOW12J4aU89vMIIgKqG9oHx33SkhpR9W7AJ6/wO56SLasLsX0i/eE2pL
 RlI9/22c7PE/Qt0+v5ziXQmbTHieuwGkjEBdXg3BhkCGnlyQ2owrWfUjDUYGTrDIvm0acsYKO
 dS0Ma5gsQLYZ/mLt2eon6/vnl1KZ2+o9vOZT+IGRVsFPPkscHf5B1/6U/+kFuI6lh7KICkDXE
 tiy0cV9r4xOVT5d0+n7ZtetcmRBV7b7smdcBml0aOGhIPEw2LSNVH7EdsZnwhSrPRkucAhmPW
 W8CpVHPTh7a4TYWJ1gATS4BduK0ghyxFaLUg48N5Xvk0OQHpuHfRMXSgRUDU4qGSzd0GX4xif
 w550QZ0LVkLaI7U26H5DL2iW7xGwz15kv+xNvAnuY2vEnRLDVRnRMxzvoyrwDlrnF8pXSxSCu
 IH/+58MpY5J9wLLjKEhbMtZvcsat5gaUGfGpoj4hA56Jk=

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1979516866-1726093221=:99
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Once again, me,

On Thu, 12 Sep 2024, Johannes Schindelin wrote:

> I will try to reply to this mail with a range-diff that is slightly edit=
ed
> to leave out the changes made by GitHub workflows (i.e. book and manual
> pages).

Here goes:

  1:  3420701f6 <   -:  --------- Remove a bogus end tag
  2:  861766083 <   -:  --------- docs: fix a bogus <a/>
  3:  5af3129c1 <   -:  --------- Remove obsolete banner
  4:  82173f4f1 <   -:  --------- Revert "book2.rake: drop progit2-ms tran=
slation"
  5:  32795076e =3D   1:  987e733c3 Drop the Travis CI configuration
  6:  0c6f2b28b =3D   2:  247a0615a Add a Hugo-aware .gitignore file
  7:  5c522f814 !   3:  593aa9af8 Adjust the Gemfile in preparation for ge=
nerating a static site
    @@ Gemfile

      source "https://rubygems.org"
     -ruby "3.1.3"
    -
    --gem "rails", "~> 6.0"
    +-
    +-gem "rails", "~> 6.1"
     -
     -# hacks for rails6 + ruby 3.1
     -gem 'net-imap', require: false
    @@ Gemfile
     -gem 'net-smtp', require: false
     -
     -gem "asciidoctor", "~> 2.0.0"
    --gem "elasticsearch", "2.0.2"
    +-gem "elasticsearch", "7.13"
     -gem "iso8601"
     -gem "octokit"
     -gem "puma"
  8:  46233d1bb !   4:  5cddbb9a3 Add a Hugo configuration
    @@ Commit message
      ## hugo.yml (new) ##
     @@
     +---
    -+baseURL: https://git-scm.com/
     +languageCode: en
     +title: Git
     +disablePathToLower: true
    @@ hugo.yml (new)
     +    renderer:
     +      unsafe: true
     +params:
    -+  latest_version: 2.43.0
    -+  latest_relnote_url: https://raw.github.com/git/git/master/Document=
ation/RelNotes/2.43.0.txt
    -+  latest_release_date: '2023-11-20'
    ++  latest_version: 2.46.0
    ++  latest_relnote_url: https://raw.github.com/git/git/master/Document=
ation/RelNotes/2.46.0.txt
    ++  latest_release_date: '2024-07-29'
  9:  ed4e92165 !   5:  8de703d8c Drop the Ruby app
    @@ Gemfile.lock (deleted)
     -GEM
     -  remote: https://rubygems.org/
     -  specs:
    --    actioncable (6.1.7.3)
    --      actionpack (=3D 6.1.7.3)
    --      activesupport (=3D 6.1.7.3)
    +-    actioncable (6.1.7.7)
    +-      actionpack (=3D 6.1.7.7)
    +-      activesupport (=3D 6.1.7.7)
     -      nio4r (~> 2.0)
     -      websocket-driver (>=3D 0.6.1)
    --    actionmailbox (6.1.7.3)
    --      actionpack (=3D 6.1.7.3)
    --      activejob (=3D 6.1.7.3)
    --      activerecord (=3D 6.1.7.3)
    --      activestorage (=3D 6.1.7.3)
    --      activesupport (=3D 6.1.7.3)
    +-    actionmailbox (6.1.7.7)
    +-      actionpack (=3D 6.1.7.7)
    +-      activejob (=3D 6.1.7.7)
    +-      activerecord (=3D 6.1.7.7)
    +-      activestorage (=3D 6.1.7.7)
    +-      activesupport (=3D 6.1.7.7)
     -      mail (>=3D 2.7.1)
    --    actionmailer (6.1.7.3)
    --      actionpack (=3D 6.1.7.3)
    --      actionview (=3D 6.1.7.3)
    --      activejob (=3D 6.1.7.3)
    --      activesupport (=3D 6.1.7.3)
    +-    actionmailer (6.1.7.7)
    +-      actionpack (=3D 6.1.7.7)
    +-      actionview (=3D 6.1.7.7)
    +-      activejob (=3D 6.1.7.7)
    +-      activesupport (=3D 6.1.7.7)
     -      mail (~> 2.5, >=3D 2.5.4)
     -      rails-dom-testing (~> 2.0)
    --    actionpack (6.1.7.3)
    --      actionview (=3D 6.1.7.3)
    --      activesupport (=3D 6.1.7.3)
    +-    actionpack (6.1.7.7)
    +-      actionview (=3D 6.1.7.7)
    +-      activesupport (=3D 6.1.7.7)
     -      rack (~> 2.0, >=3D 2.0.9)
     -      rack-test (>=3D 0.6.3)
     -      rails-dom-testing (~> 2.0)
     -      rails-html-sanitizer (~> 1.0, >=3D 1.2.0)
    --    actiontext (6.1.7.3)
    --      actionpack (=3D 6.1.7.3)
    --      activerecord (=3D 6.1.7.3)
    --      activestorage (=3D 6.1.7.3)
    --      activesupport (=3D 6.1.7.3)
    +-    actiontext (6.1.7.7)
    +-      actionpack (=3D 6.1.7.7)
    +-      activerecord (=3D 6.1.7.7)
    +-      activestorage (=3D 6.1.7.7)
    +-      activesupport (=3D 6.1.7.7)
     -      nokogiri (>=3D 1.8.5)
    --    actionview (6.1.7.3)
    --      activesupport (=3D 6.1.7.3)
    +-    actionview (6.1.7.7)
    +-      activesupport (=3D 6.1.7.7)
     -      builder (~> 3.1)
     -      erubi (~> 1.4)
     -      rails-dom-testing (~> 2.0)
     -      rails-html-sanitizer (~> 1.1, >=3D 1.2.0)
    --    activejob (6.1.7.3)
    --      activesupport (=3D 6.1.7.3)
    +-    activejob (6.1.7.7)
    +-      activesupport (=3D 6.1.7.7)
     -      globalid (>=3D 0.3.6)
    --    activemodel (6.1.7.3)
    --      activesupport (=3D 6.1.7.3)
    --    activerecord (6.1.7.3)
    --      activemodel (=3D 6.1.7.3)
    --      activesupport (=3D 6.1.7.3)
    --    activestorage (6.1.7.3)
    --      actionpack (=3D 6.1.7.3)
    --      activejob (=3D 6.1.7.3)
    --      activerecord (=3D 6.1.7.3)
    --      activesupport (=3D 6.1.7.3)
    +-    activemodel (6.1.7.7)
    +-      activesupport (=3D 6.1.7.7)
    +-    activerecord (6.1.7.7)
    +-      activemodel (=3D 6.1.7.7)
    +-      activesupport (=3D 6.1.7.7)
    +-    activestorage (6.1.7.7)
    +-      actionpack (=3D 6.1.7.7)
    +-      activejob (=3D 6.1.7.7)
    +-      activerecord (=3D 6.1.7.7)
    +-      activesupport (=3D 6.1.7.7)
     -      marcel (~> 1.0)
     -      mini_mime (>=3D 1.1.0)
    --    activesupport (6.1.7.3)
    +-    activesupport (6.1.7.7)
     -      concurrent-ruby (~> 1.0, >=3D 1.0.2)
     -      i18n (>=3D 1.6, < 2)
     -      minitest (>=3D 5.1)
    @@ Gemfile.lock (deleted)
     -    builder (3.2.4)
     -    byebug (11.1.3)
     -    coderay (1.1.3)
    --    concurrent-ruby (1.2.2)
    +-    concurrent-ruby (1.2.3)
     -    crack (0.4.5)
     -      rexml
     -    crass (1.0.6)
    @@ Gemfile.lock (deleted)
     -    dotenv-rails (2.7.6)
     -      dotenv (=3D 2.7.6)
     -      railties (>=3D 3.2)
    --    elasticsearch (2.0.2)
    --      elasticsearch-api (=3D 2.0.2)
    --      elasticsearch-transport (=3D 2.0.2)
    --    elasticsearch-api (2.0.2)
    +-    elasticsearch (7.13.0)
    +-      elasticsearch-api (=3D 7.13.0)
    +-      elasticsearch-transport (=3D 7.13.0)
    +-    elasticsearch-api (7.13.0)
     -      multi_json
    --    elasticsearch-transport (2.0.2)
    --      faraday
    +-    elasticsearch-transport (7.13.0)
    +-      faraday (~> 1)
     -      multi_json
     -    erubi (1.12.0)
     -    execjs (2.8.1)
    @@ Gemfile.lock (deleted)
     -    factory_bot_rails (6.2.0)
     -      factory_bot (~> 6.2.0)
     -      railties (>=3D 5.0.0)
    --    faraday (1.8.0)
    +-    faraday (1.10.3)
     -      faraday-em_http (~> 1.0)
     -      faraday-em_synchrony (~> 1.0)
     -      faraday-excon (~> 1.1)
    --      faraday-httpclient (~> 1.0.1)
    +-      faraday-httpclient (~> 1.0)
    +-      faraday-multipart (~> 1.0)
     -      faraday-net_http (~> 1.0)
    --      faraday-net_http_persistent (~> 1.1)
    +-      faraday-net_http_persistent (~> 1.0)
     -      faraday-patron (~> 1.0)
     -      faraday-rack (~> 1.0)
    --      multipart-post (>=3D 1.2, < 3)
    +-      faraday-retry (~> 1.0)
     -      ruby2_keywords (>=3D 0.0.4)
     -    faraday-em_http (1.0.0)
     -    faraday-em_synchrony (1.0.0)
     -    faraday-excon (1.1.0)
     -    faraday-httpclient (1.0.1)
    --    faraday-net_http (1.0.1)
    +-    faraday-multipart (1.0.4)
    +-      multipart-post (~> 2)
    +-    faraday-net_http (1.0.2)
     -    faraday-net_http_persistent (1.2.0)
     -    faraday-patron (1.0.0)
     -    faraday-rack (1.0.0)
    +-    faraday-retry (1.0.3)
     -    ffi (1.15.4)
     -    foreman (0.87.2)
    --    globalid (1.1.0)
    --      activesupport (>=3D 5.0)
    +-    globalid (1.2.1)
    +-      activesupport (>=3D 6.1)
     -    hashdiff (1.0.1)
    --    i18n (1.12.0)
    +-    i18n (1.14.4)
     -      concurrent-ruby (~> 1.0)
     -    iso8601 (0.13.0)
     -    json (2.6.2)
     -    listen (3.7.0)
     -      rb-fsevent (~> 0.10, >=3D 0.10.3)
     -      rb-inotify (~> 0.9, >=3D 0.9.10)
    --    loofah (2.19.1)
    +-    loofah (2.22.0)
     -      crass (~> 1.0.2)
    --      nokogiri (>=3D 1.5.9)
    +-      nokogiri (>=3D 1.12.0)
     -    mail (2.8.1)
     -      mini_mime (>=3D 0.1.1)
     -      net-imap
     -      net-pop
     -      net-smtp
    --    marcel (1.0.2)
    +-    marcel (1.0.4)
     -    method_source (1.0.0)
    --    mini_mime (1.1.2)
    --    mini_portile2 (2.8.1)
    --    minitest (5.18.0)
    +-    mini_mime (1.1.5)
    +-    mini_portile2 (2.8.6)
    +-    minitest (5.22.3)
     -    multi_json (1.15.0)
    --    multipart-post (2.1.1)
    +-    multipart-post (2.4.1)
     -    net-imap (0.3.1)
     -      net-protocol
     -    net-pop (0.1.2)
     -      net-protocol
    --    net-protocol (0.1.3)
    +-    net-protocol (0.2.2)
     -      timeout
     -    net-smtp (0.3.2)
     -      net-protocol
    --    nio4r (2.5.9)
    --    nokogiri (1.14.3)
    --      mini_portile2 (~> 2.8.0)
    +-    nio4r (2.7.3)
    +-    nokogiri (1.16.5)
    +-      mini_portile2 (~> 2.8.2)
     -      racc (~> 1.4)
     -    octokit (4.21.0)
     -      faraday (>=3D 0.9)
    @@ Gemfile.lock (deleted)
     -      byebug (~> 11.0)
     -      pry (~> 0.13.0)
     -    public_suffix (4.0.6)
    --    puma (5.6.7)
    +-    puma (5.6.8)
     -      nio4r (~> 2.0)
    --    racc (1.6.2)
    --    rack (2.2.6.4)
    +-    racc (1.7.3)
    +-    rack (2.2.8.1)
     -    rack-test (2.1.0)
     -      rack (>=3D 1.3)
     -    rack-timeout (0.6.0)
    --    rails (6.1.7.3)
    --      actioncable (=3D 6.1.7.3)
    --      actionmailbox (=3D 6.1.7.3)
    --      actionmailer (=3D 6.1.7.3)
    --      actionpack (=3D 6.1.7.3)
    --      actiontext (=3D 6.1.7.3)
    --      actionview (=3D 6.1.7.3)
    --      activejob (=3D 6.1.7.3)
    --      activemodel (=3D 6.1.7.3)
    --      activerecord (=3D 6.1.7.3)
    --      activestorage (=3D 6.1.7.3)
    --      activesupport (=3D 6.1.7.3)
    +-    rails (6.1.7.7)
    +-      actioncable (=3D 6.1.7.7)
    +-      actionmailbox (=3D 6.1.7.7)
    +-      actionmailer (=3D 6.1.7.7)
    +-      actionpack (=3D 6.1.7.7)
    +-      actiontext (=3D 6.1.7.7)
    +-      actionview (=3D 6.1.7.7)
    +-      activejob (=3D 6.1.7.7)
    +-      activemodel (=3D 6.1.7.7)
    +-      activerecord (=3D 6.1.7.7)
    +-      activestorage (=3D 6.1.7.7)
    +-      activesupport (=3D 6.1.7.7)
     -      bundler (>=3D 1.15.0)
    --      railties (=3D 6.1.7.3)
    +-      railties (=3D 6.1.7.7)
     -      sprockets-rails (>=3D 2.0.0)
     -    rails-controller-testing (1.0.5)
     -      actionpack (>=3D 5.0.1.rc1)
     -      actionview (>=3D 5.0.1.rc1)
     -      activesupport (>=3D 5.0.1.rc1)
    --    rails-dom-testing (2.0.3)
    --      activesupport (>=3D 4.2.0)
    +-    rails-dom-testing (2.2.0)
    +-      activesupport (>=3D 5.0.0)
    +-      minitest
     -      nokogiri (>=3D 1.6)
    --    rails-html-sanitizer (1.5.0)
    --      loofah (~> 2.19, >=3D 2.19.1)
    +-    rails-html-sanitizer (1.6.0)
    +-      loofah (~> 2.21)
    +-      nokogiri (~> 1.14)
     -    rails_12factor (0.0.3)
     -      rails_serve_static_assets
     -      rails_stdout_logging
     -    rails_serve_static_assets (0.0.5)
     -    rails_stdout_logging (0.0.5)
    --    railties (6.1.7.3)
    --      actionpack (=3D 6.1.7.3)
    --      activesupport (=3D 6.1.7.3)
    +-    railties (6.1.7.7)
    +-      actionpack (=3D 6.1.7.7)
    +-      activesupport (=3D 6.1.7.7)
     -      method_source
     -      rake (>=3D 12.2)
     -      thor (~> 1.0)
     -    rainbow (3.0.0)
    --    rake (13.0.6)
    +-    rake (13.1.0)
     -    rb-fsevent (0.11.0)
     -    rb-inotify (0.10.1)
     -      ffi (~> 1.0)
    @@ Gemfile.lock (deleted)
     -    redis-store (1.9.0)
     -      redis (>=3D 4, < 5)
     -    regexp_parser (2.1.1)
    --    rexml (3.2.5)
    +-    rexml (3.2.8)
    +-      strscan (>=3D 3.0.9)
     -    rspec-core (3.10.1)
     -      rspec-support (~> 3.10.0)
     -    rspec-expectations (3.10.1)
    @@ Gemfile.lock (deleted)
     -    shoulda-context (2.0.0)
     -    shoulda-matchers (4.5.1)
     -      activesupport (>=3D 4.2.0)
    --    sprockets (4.2.0)
    +-    sprockets (4.2.1)
     -      concurrent-ruby (~> 1.0)
     -      rack (>=3D 2.2.4, < 4)
     -    sprockets-rails (3.4.2)
    @@ Gemfile.lock (deleted)
     -      activesupport (>=3D 5.2)
     -      sprockets (>=3D 3.0.0)
     -    sqlite3 (1.4.2)
    --    thor (1.2.1)
    +-    strscan (3.1.0)
    +-    thor (1.3.1)
     -    tilt (2.0.10)
    --    timeout (0.3.0)
    +-    timeout (0.4.1)
     -    tzinfo (2.0.6)
     -      concurrent-ruby (~> 1.0)
     -    uglifier (4.2.0)
    @@ Gemfile.lock (deleted)
     -      addressable (>=3D 2.8.0)
     -      crack (>=3D 0.3.2)
     -      hashdiff (>=3D 0.4.0, < 2.0.0)
    --    websocket-driver (0.7.5)
    +-    websocket-driver (0.7.6)
     -      websocket-extensions (>=3D 0.1.0)
     -    websocket-extensions (0.1.5)
    --    zeitwerk (2.6.7)
    +-    zeitwerk (2.6.13)
     -
     -PLATFORMS
     -  ruby
    @@ Gemfile.lock (deleted)
     -  database_cleaner
     -  diffy
     -  dotenv-rails
    --  elasticsearch (=3D 2.0.2)
    +-  elasticsearch (=3D 7.13)
     -  fabrication
     -  factory_bot_rails
     -  foreman
    @@ Gemfile.lock (deleted)
     -  pry-byebug
     -  puma
     -  rack-timeout
    --  rails (~> 6.0)
    +-  rails (~> 6.1)
     -  rails-controller-testing
     -  rails_12factor
     -  redis-rails
    @@ Rakefile (deleted)
      ## app.json (deleted) ##
     @@
     -{
    +-  "stack": "heroku-24",
     -  "scripts": {
     -  },
     -  "env": {
    @@ lib/searchable.rb (deleted)
     -        "query" =3D> {
     -          "bool" =3D> {
     -            "should" =3D> [],
    --            "minimum_number_should_match" =3D> 1
    +-            "minimum_should_match" =3D> 1
     -          },
     -        },
     -        "highlight" =3D> {
 10:  7865f2051 =3D   6:  24844c72e In preparation for using Hugo, move th=
e "blog has moved" page
 11:  4effd55ad =3D   7:  5830b2c27 Hugo-ify the "blog has moved" page
 12:  6a09add78 =3D   8:  34580a126 Move the favicon to the `static/` dire=
ctory
 13:  a79b9c844 =3D   9:  9f96eea1f Drop the robots.txt file
 14:  32a4eb168 =3D  10:  47cbca3c8 Hugo'ify the 404 page
 15:  906bb0235 =3D  11:  7a1f5bdac Drop the custom pages for HTML codes 4=
22 and 500
 16:  bff32d315 !  12:  340558bd1 ci: switch to building with Hugo
    @@ .github/workflows/ci.yml
      name: CI
     -on: pull_request
     +on: [pull_request]
    -+
    -+env:
    -+  HUGO_VERSION: 0.120.3

      jobs:
        build:
          runs-on: ubuntu-latest
          steps:
     -    - uses: actions/checkout@v2
    -+    - uses: actions/checkout@v3
    ++    - uses: actions/checkout@v4

     -    - name: ruby setup
     -      uses: ruby/setup-ruby@v1
     -      with:
     -        bundler-cache: true
    ++    - name: configure Hugo version
    ++      run: |
    ++        set -x &&
    ++        echo "HUGO_VERSION=3D$(sed -n 's/^ *hugo_version: *//p' <hug=
o.yml)" >>$GITHUB_ENV
    ++
     +    - name: install Hugo ${{ env.HUGO_VERSION }}
     +      run: |
     +        set -x &&
    @@ .github/workflows/ci.yml

     -    - name: rubocop
     -      run: bundle exec rubocop -P
    -+    - name: run Pagefind to build the search index
    -+      run: npx -y pagefind --site public
    ++    - name: build tar archive
    ++      run: cd public && tar czvf ../pages.tar.gz *

     -    - name: rspec
     -      run: bundle exec rspec
    -+    - name: build tar archive
    -+      run: cd public && tar czvf ../pages.tar.gz *
    -+
     +    - name: Upload build artifact
    -+      uses: actions/upload-artifact@v3
    ++      uses: actions/upload-artifact@v4
     +      with:
     +        name: pages
     +        path: pages.tar.gz
    +
    + ## hugo.yml ##
    +@@ hugo.yml: markup:
    +     renderer:
    +       unsafe: true
    + params:
    ++  hugo_version: 0.134.1
    +   latest_version: 2.46.0
    +   latest_relnote_url: https://raw.github.com/git/git/master/Document=
ation/RelNotes/2.46.0.txt
    +   latest_release_date: '2024-07-29'
 17:  f685a732d !  13:  2b1735089 README: reflect that this is now a Hugo =
site
    @@ README.md
     +## Local development setup

     -You'll need a Ruby environment to run Rails.  First do:
    -+You'll need the extended version of [Hugo](https://gohugo.io/). On W=
indows, we recommend using the Windows Subsystem for Linux (WSL). You can =
serve the site locally via
    ++It is highly recommended to clone this repository using [`scalar`](h=
ttps://git-scm.com/docs/scalar); This allows to work only on the parts of =
the repository relevant to your interests. You can select which directorie=
s are checked out using the [`git sparse-checkout add <directory>...`](htt=
ps://git-scm.com/docs/git-sparse-checkout) command. The relevant directori=
es are:

     -    $ rvm use .
     -    $ bundle install
    -+    $ hugo serve -w
    ++- If you want to test any page rendering using Hugo:
    ++  - layouts/
    ++  - content/
    ++  - static/
    ++  - assets/

     -Then you need to create the database structure:
    -+The site should be running on http://127.0.0.1:1313. Note that it ma=
y be advisable to do this in a sparse checkout that excludes large parts o=
f `content/`, to speed up the rendering time.
    ++- To add new GUIs:
    ++  - data/

     -    $ rake db:migrate
    -+## Update manual pages
    ++- To work on pre-rendering pages that originate from other repositor=
ies (such as the ProGit book):
    ++  - script/

     -Alternatively you can run the script at `script/bootstrap` which wil=
l set up Ruby dependencies and the local SQLite database.
    --
    ++- To work on the GitHub workflows that perform the automated, schedu=
led pre-rendering:
    ++  - .github/
    +
     -Now you'll want to populate the man pages.  You can do so from a loc=
al Git
     -source clone like this:
    ++- The pre-rendered pages (ProGit book, its translated versions, the =
manual pages, their translated versions):
    ++  - external/book/
    ++  - external/docs/
    ++  You will want to avoid editing these directly, as they contain pag=
es that are pre-rendered via GitHub workflows, sourcing content from other=
 repositories.
    ++
    ++To render the site locally, you'll need the extended version of [Hug=
o](https://gohugo.io/). On Windows, we recommend using the Windows Subsyst=
em for Linux (WSL). You can serve the site locally via
    ++
    ++    $ hugo serve -w
    ++
    ++The site should be running on http://127.0.0.1:1313. Note that it ma=
y be advisable to do this in a sparse checkout that excludes large parts o=
f `content/`, to speed up the rendering time.
    ++
    ++## Update manual pages
    ++
     +(TODO!)
     +You can do so using a local Git source clone like this:

    @@ README.md: Alternatively, you can get the book content from a repos=
itory on your
     -
      ## Contributing

    - If you wish to contribute to this website, please [fork it on GitHub=
](https://github.com/git/git-scm.com), push your
    -@@ README.md: be accepted. If it involves code, please also write tes=
ts for it.
    +-If you wish to contribute to this website, please [fork it on GitHub=
](https://github.com/git/git-scm.com), push your
    +-change to a named branch, then send a pull request. If it is a big f=
eature,
    +-you might want to [start an issue](https://github.com/git/git-scm.co=
m/issues/new) first to make sure it's something that will
    +-be accepted. If it involves code, please also write tests for it.
    +-
    +-## Adding new GUI
    ++If you wish to contribute to this website, please [fork it on GitHub=
](https://github.com/git/git-scm.com).

    - The [list of GUI clients](https://git-scm.com/downloads/guis) has be=
en constructed by the community for a long time. If you want to add anothe=
r tool you'll need to follow a few steps:
    +-The [list of GUI clients](https://git-scm.com/downloads/guis) has be=
en constructed by the community for a long time. If you want to add anothe=
r tool you'll need to follow a few steps:
    ++Then, clone it using [`scalar`](https://git-scm.com/docs/scalar) (th=
is avoids long clone times) and then use [`git sparse-checkout add <direct=
ory>`](https://git-scm.com/docs/git-sparse-checkout) to check out the file=
s relevant to your work.

     -1. Add the GUI client details at the YAML file: https://github.com/g=
it/git-scm.com/blob/main/resources/guis.yml
     -    1. The fields `name`, `url`, `price`, `license` should be very s=
traightforward to fill.
    @@ README.md: be accepted. If it involves code, please also write test=
s for it.
     -    3. `platforms` is a list of at least 1 platform in which the too=
l is supported. The possibilities are: `Windows`, `Mac`, `Linux`, `Android=
`, and `iOS`
     -    4. `order` can be filled with the biggest number already existin=
g, plus 1 (Adding to the bottom - this will be covered in the following st=
eps)
     -    5. `trend_name` is an optional field that can be used for helpin=
g sorting the clients (also covered in the next steps)
    --
    ++After making the changes, commit and push to a named branch in your =
fork, then open a pull request. If it is a big feature, you might want to =
[start an issue](https://github.com/git/git-scm.com/issues/new) first to m=
ake sure it's something that will be accepted.
    +
     -2. Add the image to `public/images/guis/<GUI_CLIENT_NAME>@2x.png` an=
d `public/images/guis/<GUI_CLIENT_NAME>.png` making sure the aspect ratio =
matches a 588:332 image.
    --
    ++## Adding a new GUI
    +
     -3. Sort the tools
     -    1. From the root of the repository, run: `$ ./script/sort-gui`
     -    2. A list of google trends url's will be displayed at the bottom=
 if everything went well.
    @@ README.md: be accepted. If it involves code, please also write test=
s for it.
     -    7. The script makes some basic verifications. If there was some =
problem, it should be easily visible in the output
     -      1. If you have more than 1 tool with the same name, a warning =
will appear: `=3D=3D=3D=3D=3D=3D=3D WARNING: THERE ARE DUPLICATED GUIS =3D=
=3D=3D=3D=3D=3D=3D`
     -      2. If you are using the same `order` value for more than 1 too=
l, a warning will appear: `=3D=3D=3D=3D=3D=3D=3D WARNING: THERE ARE DUPLIC=
ATED ORDERS (value: <VALUE>) =3D=3D=3D=3D=3D=3D=3D`
    --
    ++The [list of GUI clients](https://git-scm.com/downloads/guis) has be=
en constructed by the community for a long time. If you want to add anothe=
r tool you'll need to follow a few steps:
    +
     -## FAQ
    --
    --While setting the repo if you find any error, check if it's a known =
issue and the corresponding solution bellow.
    -+1. Add a new `.md` file with the GUI client details: https://github.=
com/git/git-scm.com/tree/main/content/data/guis
    ++1. Add a new `.md` file with the GUI client details: data/guis
     +    1. The fields need to be enclosed within `---` lines
     +    2. The fields `name`, `project_url`, `price`, `license` should b=
e very straightforward to fill.
     +    3. The field `image_tag` corresponds to the path of the image of=
 the tool (should start with `images/guis/`).
     +    4. `platforms` is a list of at least 1 platform in which the too=
l is supported. The possibilities are: `Windows`, `Mac`, `Linux`, `Android=
`, and `iOS`
    -+    5. `order` can be filled with the biggest number already existin=
g, plus 1 (Adding to the bottom - this will be covered in the following st=
eps). This is the only field whose value should _not_ be enclosed in doubl=
e-quote characters.
    -+    6. `trend_name` is an optional field that can be used for helpin=
g sorting the clients (also covered in the next steps)
    ++    5. `order` can be filled with the biggest number already existin=
g, plus 1 (this number determines the order in which the GUIs are rendered=
). This is the only field whose value should _not_ be enclosed in double-q=
uote characters.
    ++    6. `trend_name` is an optional field that can be used for helpin=
g sorting the clients.

    --### An error occurred while installing pg (1.2.3), and Bundler canno=
t continue.
    +-While setting the repo if you find any error, check if it's a known =
issue and the corresponding solution bellow.
     +2. Add the image to `static/images/guis/<GUI_CLIENT_NAME>@2x.png` an=
d `static/images/guis/<GUI_CLIENT_NAME>.png` making sure the aspect ratio =
matches a 588:332 image.

    +-### An error occurred while installing pg (1.2.3), and Bundler canno=
t continue.
    ++## Useful links
    +
     -If you got this error when running `bundle install`, then you need t=
o install postgresql on your OS. Check [this stackoverflow topic](https://=
stackoverflow.com/questions/52339221/rails-gem-error-while-installing-pg-1=
-1-3-and-bundler-cannot-continue) for more details.
    -+## Useful link regarding working with Hugo
    ++### Hugo (static site generator)

     +* https://gohugo.io/
     +* https://gohugo.io/content-management/shortcodes/
 18:  ae9a0d82e =3D  14:  e53e639b5 Move stylesheets to `assets/sass/`
 19:  faab827f4 !  15:  11ab6559e Move the images to `static/images/`
    @@ public/images/guis/git-glint@2x.png =3D> static/images/guis/git-gli=
nt@2x.png

      ## public/images/guis/git-kraken.png =3D> static/images/guis/git-kra=
ken.png ##

    - ## public/images/guis/git-kraken@2x.png =3D> static/images/guis/git-=
kraken@2x.png ##
    -
      ## public/images/guis/git2go.png =3D> static/images/guis/git2go.png =
##

      ## public/images/guis/git2go@2x.png =3D> static/images/guis/git2go@2=
x.png ##
    @@ public/images/guis/gitklient.png =3D> static/images/guis/gitklient.=
png

      ## public/images/guis/gitklient@2x.png =3D> static/images/guis/gitkl=
ient@2x.png ##

    + ## public/images/guis/gitkraken-2024@2x.png =3D> static/images/guis/=
gitkraken-2024@2x.png ##
    +
      ## public/images/guis/gitonic.png =3D> static/images/guis/gitonic.pn=
g ##

      ## public/images/guis/gitonic@2x.png =3D> static/images/guis/gitonic=
@2x.png ##
    @@ public/images/guis/gitx.png =3D> static/images/guis/gitx.png

      ## public/images/guis/gitx@2x.png =3D> static/images/guis/gitx@2x.pn=
g ##

    + ## public/images/guis/gk-cli-keifs@2x.png =3D> static/images/guis/gk=
-cli-keifs@2x.png ##
    +
      ## public/images/guis/gmaster.png =3D> static/images/guis/gmaster.pn=
g ##

      ## public/images/guis/gmaster@2x.png =3D> static/images/guis/gmaster=
@2x.png ##
    @@ public/images/guis/pragmagit.png =3D> static/images/guis/pragmagit.=
png

      ## public/images/guis/pragmagit@2x.png =3D> static/images/guis/pragm=
agit@2x.png ##

    + ## public/images/guis/relagit.png =3D> static/images/guis/relagit.pn=
g ##
    +
    + ## public/images/guis/relagit@2x.png =3D> static/images/guis/relagit=
@2x.png ##
    +
      ## public/images/guis/repoz.png =3D> static/images/guis/repoz.png ##

      ## public/images/guis/repoz@2x.png =3D> static/images/guis/repoz@2x.=
png ##
    @@ public/images/guis/snailgit.png =3D> static/images/guis/snailgit.pn=
g

      ## public/images/guis/snailgit@2x.png =3D> static/images/guis/snailg=
it@2x.png ##

    + ## public/images/guis/sourcegit.png =3D> static/images/guis/sourcegi=
t.png ##
    +
    + ## public/images/guis/sourcegit@2x.png =3D> static/images/guis/sourc=
egit@2x.png ##
    +
      ## public/images/guis/sourcetree.png =3D> static/images/guis/sourcet=
ree.png ##

      ## public/images/guis/sourcetree@2x.png =3D> static/images/guis/sour=
cetree@2x.png ##
 20:  34a9aafae =3D  16:  b379241b1 Move Javascripts to the `static/` dire=
ctory
 21:  1e7d57b39 =3D  17:  add38c971 Remove the layout for the error pages
 22:  3775916fa =3D  18:  0929494dc Migrate the primary layout to the Hugo=
 world
 23:  03da9c6ea !  19:  817c49726 Adjust the layouts
    @@ layouts/_default/baseof.html

     -  <%=3D stylesheet_link_tag "application" %>
     -  <%=3D javascript_include_tag "modernize" %>
    -+  {{ $style :=3D resources.Get "sass/application.scss" | resources.E=
xecuteAsTemplate "application.scss" . | resources.ToCSS | resources.Minify=
 }}
    ++  {{ $style :=3D resources.Get "sass/application.scss" | resources.E=
xecuteAsTemplate "application.scss" . | css.Sass | resources.Minify }}
     +  <link rel=3D"stylesheet" href=3D"{{ $style.RelPermalink }}">
     +  <script src=3D"/js/modernizr.js"></script>
     +  <script src=3D"/js/modernize.js"></script>
    @@ layouts/_default/baseof.html
     +        {{ partial "sidebar.html" . }}
              <div id=3D"content">
     -          <%=3D yield %>
    -+          {{ .Content }}
    ++          {{ if (eq .Page.Path "/docs") }}
    ++            {{ partial "ref/index.html" . }}
    ++          {{ else }}
    ++            {{ .Content }}
    ++          {{ end }}
              </div>
            </div>
     -      <%=3D render partial: "shared/footer" %>
 24:  b721d0a20 =3D  20:  f2546f28f Remove some includable bits that won't=
 be needed in the future
 25:  25b0a2330 =3D  21:  e465a5ae6 Move some includable bits to `layouts/=
`
 26:  c9fd7e391 =3D  22:  b4a98bee7 Make Javascript imports explicit
 27:  3b33bf0de =3D  23:  68e705c49 Inline the taglines on the top
 28:  79ffa61fc =3D  24:  3558e3570 Move the main index.html to the `conte=
nt/` directory
 29:  1991470d8 =3D  25:  d23fd0543 Migrate the top-level page of the site=
 to Hugo
 30:  e308db418 =3D  26:  4d5b58b58 CSS: quote URLs consistently
 31:  f55cae009 =3D  27:  37497edb9 Explicitly include 'normalize' in appl=
ication CSS
 32:  61a203caf =3D  28:  4ac41f786 Use the base URL in partial .scss file=
s
 33:  c3730b407 !  29:  6b2d46049 Add a script to update the latest Git ve=
rsion
    @@ Commit message

      ## Gemfile ##
     @@
    + # frozen_string_literal: true

      source "https://rubygems.org"
    -
    ++
     +gem "octokit"

      ## script/update-git-version.rb (new) ##
 34:  79e745184 =3D  30:  02abe2c42 update-git-version: skip -rc versions
 35:  0e8a57fab =3D  31:  115ebbebf Allow redirecting from `list` pages
 36:  ac13d76df !  32:  1118b8eaf Define and use sections in a flexible wa=
y
    @@ layouts/_default/baseof.html
     +{{ $section :=3D "" }}
     +{{ if isset .Params "section" }}
     +{{ $section =3D .Params.section }}
    -+{{ else if isset .Page "Section" }}
    ++{{ else if (eq .Page.Path "/docs") }}
    ++{{ $section =3D "documentation" }}
    ++{{ else if (isset .Page "Section") }}
     +{{ $section =3D .Page.Section }}
    -+{{ else if or (eq .Page.Type "doc") (eq .Page.Type "docs") (eq .Page=
.Type "video") }}
    ++{{ else if (or (eq .Page.Type "doc") (eq .Page.Type "docs") (eq .Pag=
e.Type "video")) }}
     +{{ $section =3D "documentation" }}
    -+{{ else if isset .Page "Type" }}
    ++{{ else if (isset .Page "Type") }}
     +{{ $section =3D .Page.Type }}
     +{{ else }}
    -+{{ warnf "No section found in %s" (.File | jsonify) }}
    ++{{ warnf "No section found in %s" (.Page.Path | jsonify) }}
     +{{ end }}
     +{{ .Scratch.Set "section" $section }}
     +
 37:  894f2cef3 =3D  33:  fffd7a142 Move the "About" pages to `content/abo=
ut/`
 38:  1f7ef75b7 !  34:  3f3dd9823 Convert 'About' pages to Hugo
    @@ content/about/trademark.html

      ## layouts/_default/baseof.html ##
     @@
    -       <div id=3D"content-wrapper">
    -         {{ partial "sidebar.html" . }}
              <div id=3D"content">
    --          {{ .Content }}
    -+          {{ if eq $section "about" }}
    -+	    <div id=3D"main">
    +           {{ if (eq .Page.Path "/docs") }}
    +             {{ partial "ref/index.html" . }}
    ++          {{ else if eq $section "about" }}
    ++            <div id=3D"main">
     +              <h1>About</h1>
     +
     +              <ol id=3D"about-nav">
    @@ layouts/_default/baseof.html
     +              </ol>
     +              {{ .Content }}
     +            </div>
    -+          {{ else }}
    -+            {{ .Content }}
    -+          {{ end }}
    -         </div>
    -       </div>
    -       {{ partial "footer.html" . }}
    +           {{ else }}
    +             {{ .Content }}
    +           {{ end }}

      ## layouts/partials/sidebar.html ##
     @@
 39:  c139f5c1f =3D  35:  e743fb5cc about/trademark: add back old redirect
 40:  ded625e52 =3D  36:  b68954145 Install redirects for two `About` page=
s
 41:  14843ae22 =3D  37:  a5f2b8be5 Remove dynamic About navigation code
 42:  20e420d65 =3D  38:  100808034 Migrate the community page from the we=
b app to the static site
 43:  dd4f0b599 !  39:  7a4f64d25 Adjust the community page
    @@ content/community/_index.html
      <div id=3D"main">
        <h1> Community</h1>

    -   <h2> Mailing List</h2>
    -
    -   <p>
    --    General questions or comments for the Git community can be sent =
to the mailing list by using the email address <a href=3D"mailto:git@vger.=
kernel.org">git@vger.kernel.org</a>.
    -+    General questions or comments for the Git community can be sent =
to the mailing list by using the email address <a href=3D"mailto:git@vger.=
kernel.org">git@vger.kernel.org</a>.
    -   </p>
    --
    -+
    -   <p>
    -     <strong>If you wish to report any possible bug for Git, please u=
se this mailing list as well.</strong>
    -   </p>
     @@
        <p>
          The <a href=3D"https://git.github.io/">Git Developer Pages</a> h=
ave a <a href=3D"https://git.github.io/Hacking-Git/">Hacking Git page</a> =
which lists useful development resources. They also have <a href=3D"https:=
//git.github.io/General-Application-Information/">information</a> for peop=
le applying to work on Git as part of programs like <a href=3D"https://www=
.outreachy.org/">Outreachy</a> or the <a href=3D"https://summerofcode.with=
google.com/">Google Summer of Code</a>.
 44:  6625d81dd =3D  40:  6767a083e Adjust the GUI clients link in the sid=
ebar
 45:  293e57ba7 =3D  41:  4a2f13d4b Move the GUI Clients page into the loc=
ation expected by Hugo
 46:  45c7d59a6 !  42:  df1b23221 Adapt the GUI Clients page to Hugo
    @@ Commit message
         the JSON containing the list of GUI Clients into individual files=
 inside
         `data/`.

    +    The files in `data/guis/` were written via:
    +
    +      git show HEAD:resources/guis.yml |
    +      ruby -e '
    +        # cannot use YAML.load because that would lose comments
    +        $filename =3D nil
    +        $content =3D ""
    +        def write
    +          return if $filename.nil?
    +          File.open($filename, "w") { |f| f.write("---\n#{$content}--=
-\n") } unless $filename.nil?
    +          $filename =3D nil
    +          $content =3D ""
    +        end
    +        ARGF.each do |line|
    +          if line.start_with?("-") then
    +            write
    +            line[0] =3D " "
    +          end
    +          if line.start_with?("  ") then
    +            $filename =3D "data/guis/#{line[8..].chomp.gsub(/ *\(.*\)=
$/, "").gsub(/ /, "-").downcase}.yml" if line.start_with?("  name: ")
    +            $content +=3D line[2..]
    +              .gsub(/^image_tag: /, "\\0images/")
    +              .gsub(/^url:/, "project_url:")
    +              .gsub(/([-:] )([^"]*[^"0-9][^"]*)\n$/, "\\1\"\\2\"\n")
    +              .gsub(/^-/, "  -")
    +            end
    +        end
    +        write
    +      '
    +
         Signed-off-by: Victoria Dye <vdye@github.com>
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

    @@ data/guis/anchorpoint.yml (new)
      ## data/guis/aurees.yml (new) ##
     @@
     +---
    -+name: "Aurees"
    ++name: "Aurees (no longer under active development)"
     +project_url: "https://aurees.com/"
     +image_tag: "images/guis/aurees@2x.png"
     +platforms:
    @@ data/guis/gitahead.yml (new)
     +  - "Linux"
     +price: "Free"
     +license: "MIT"
    -+order: 13
    ++order: 17
     +---

      ## data/guis/gitatomic.yml (new) ##
    @@ data/guis/gitbreeze.yml (new)
     +  - "Linux"
     +price: "Free"
     +license: "Proprietary"
    -+trend_name: "git breeze"
     +order: 53
     +---

    @@ data/guis/gitdrive.yml (new)
     +image_tag: "images/guis/gitdrive@2x.png"
     +platforms:
     +  - "iOS"
    -+# No details what the $6.99 in-app purchase does, all it says is 'Un=
limited Version'
    ++# No details what the $6.99 in-app purchase does, all it says is "Un=
limited Version"
     +price: "Free / $6.99"
     +license: "Proprietary"
     +order: 37
    @@ data/guis/github-desktop.yml (new)
     +order: 1
     +---

    - ## data/guis/gitkraken.yml (new) ##
    + ## data/guis/gitkraken-cli.yml (new) ##
     @@
     +---
    -+name: "GitKraken"
    -+project_url: "https://www.gitkraken.com/"
    -+image_tag: "images/guis/git-kraken@2x.png"
    ++name: "GitKraken CLI"
    ++project_url: "https://www.gitkraken.com/cli"
    ++image_tag: "images/guis/gk-cli-keifs@2x.png"
    ++platforms:
    ++  - "Windows"
    ++  - "Mac"
    ++  - "Linux"
    ++price: "Free / $48.00+/user annually"
    ++license: "Proprietary"
    ++order: 55
    ++---
    +
    + ## data/guis/gitkraken-desktop.yml (new) ##
    +@@
    ++---
    ++name: "GitKraken Desktop"
    ++project_url: "https://www.gitkraken.com/git-client"
    ++image_tag: "images/guis/gitkraken-2024@2x.png"
     +platforms:
     +  - "Windows"
     +  - "Mac"
     +  - "Linux"
     +# Free tier only works with local and public repositories
    -+price: "Free / $59+/user annually"
    ++price: "Free / $48+/user annually"
     +license: "Proprietary"
     +order: 5
     +---
    @@ data/guis/gitnuro.yml (new)
     @@
     +---
     +name: "Gitnuro"
    -+project_url: "https://gitnuro.jetpackduba.com/"
    ++project_url: "https://gitnuro.com/"
     +image_tag: "images/guis/Gitnuro@2x.png"
     +platforms:
     +  - "Windows"
    @@ data/guis/gitui.yml (new)
     @@
     +---
     +name: "GitUI"
    -+project_url: "https://extrawurst.itch.io/gitui"
    ++project_url: "http://gitui.org"
     +image_tag: "images/guis/gitui@2x.png"
     +platforms:
     +  - "Windows"
    @@ data/guis/glint.yml (new)
     +  - "Windows"
     +  - "Mac"
     +  - "Linux"
    -+price: "Free (can only open up to two repositories at once)/ $35/use=
r annually"
    ++# Free tier can only open up to two repositories at once
    ++price: "Free / $35/user annually"
     +license: "Proprietary"
     +trend_name: "git glint"
    -+order: 52
    ++order: 13
     +---

      ## data/guis/guitar.yml (new) ##
    @@ data/guis/pragma-git.yml (new)
     +license: "MIT"
     +trend_name: "pragma github"
     +order: 54
    ++---
    +
    + ## data/guis/relagit.yml (new) ##
    +@@
    ++---
    ++name: "RelaGit"
    ++project_url: "https://rela.dev"
    ++image_tag: "images/guis/relagit@2x.png"
    ++platforms:
    ++  - "Windows"
    ++  - "Mac"
    ++  - "Linux"
    ++price: "Free"
    ++license: "LGPL-3.0-or-later"
    ++order: 57
     +---

      ## data/guis/repoz.yml (new) ##
    @@ data/guis/snailgit.yml (new)
     +price: "Free (limited) / $9.99"
     +license: "Proprietary"
     +order: 32
    ++---
    +
    + ## data/guis/sourcegit.yml (new) ##
    +@@
    ++---
    ++name: "SourceGit"
    ++project_url: "https://sourcegit-scm.github.io"
    ++image_tag: "images/guis/sourcegit@2x.png"
    ++platforms:
    ++  - "Windows"
    ++  - "Mac"
    ++  - "Linux"
    ++price: "Free"
    ++license: "MIT"
    ++trend_name: "SourceGit"
    ++order: 56
     +---

      ## data/guis/sourcetree.yml (new) ##
    @@ resources/guis.yml (deleted)
     -  price: Free
     -  license: GNU GPL
     -  order: 4
    --- name: GitKraken
    --  url: https://www.gitkraken.com/
    --  image_tag: guis/git-kraken@2x.png
    +-- name: GitKraken Desktop
    +-  url: https://www.gitkraken.com/git-client
    +-  image_tag: guis/gitkraken-2024@2x.png
     -  platforms:
     -  - Windows
     -  - Mac
     -  - Linux
     -  # Free tier only works with local and public repositories
    --  price: Free / $59+/user annually
    +-  price: Free / $48+/user annually
     -  license: Proprietary
     -  order: 5
     -- name: Magit
    @@ resources/guis.yml (deleted)
     -  license: GNU GPL
     -  trend_name: Git giggle
     -  order: 27
    --- name: Aurees
    +-- name: Aurees (no longer under active development)
     -  url: https://aurees.com/
     -  image_tag: guis/aurees@2x.png
     -  platforms:
    @@ resources/guis.yml (deleted)
     -  - Linux
     -  price: Free
     -  license: MIT
    --  order: 13
    +-  order: 17
     -- name: Gittyup
     -  url: https://murmele.github.io/Gittyup/
     -  image_tag: guis/gittyup@2x.png
    @@ resources/guis.yml (deleted)
     -  license: Proprietary
     -  order: 42
     -- name: GitUI
    --  url: https://extrawurst.itch.io/gitui
    +-  url: http://gitui.org
     -  image_tag: guis/gitui@2x.png
     -  platforms:
     -  - Windows
    @@ resources/guis.yml (deleted)
     -  trend_name: gitonic
     -  order: 50
     -- name: Gitnuro
    --  url: https://gitnuro.jetpackduba.com/
    +-  url: https://gitnuro.com/
     -  image_tag: guis/Gitnuro@2x.png
     -  platforms:
     -    - Windows
    @@ resources/guis.yml (deleted)
     -  price: Free / $35/user annually
     -  license: Proprietary
     -  trend_name: git glint
    --  order: 52
    +-  order: 13
     -- name: GitBreeze
     -  url: https://gitbreeze.dev/
     -  image_tag: guis/gitbreeze@2x.png
    @@ resources/guis.yml (deleted)
     -  license: MIT
     -  trend_name: pragma github
     -  order: 54
    --
    +-- name: GitKraken CLI
    +-  url: https://www.gitkraken.com/cli
    +-  image_tag: guis/gk-cli-keifs@2x.png
    +-  platforms:
    +-  - Windows
    +-  - Mac
    +-  - Linux
    +-  price: Free / $48.00+/user annually
    +-  license: Proprietary
    +-  order: 55
    +-- name: SourceGit
    +-  url: https://sourcegit-scm.github.io
    +-  image_tag: guis/sourcegit@2x.png
    +-  platforms:
    +-    - Windows
    +-    - Mac
    +-    - Linux
    +-  price: Free
    +-  license: MIT
    +-  trend_name: SourceGit
    +-  order: 56
    +-- name: RelaGit
    +-  url: https://rela.dev
    +-  image_tag: guis/relagit@2x.png
    +-  platforms:
    +-    - Windows
    +-    - Mac
    +-    - Linux
    +-  price: Free
    +-  license: LGPL-3.0-or-later
    +-  order: 57
 47:  5b1e9a6de =3D  43:  ad17fe7f0 downloads/guis: adjust the Javascript =
for filtering
 48:  579cf46a3 =3D  44:  e6208d5ed Move logos page to the new location
 49:  99766e6fd =3D  45:  ea70f19f1 Migrate logos page
 50:  1a42a0157 =3D  46:  bc0d9409a Create base Downloads page
 51:  07c392bd8 =3D  47:  3d22dc37c Move the OS-specific Downloads pages i=
nto the location needed for Hugo
 52:  6d315ee76 =3D  48:  17c567019 Implement the `site-param` shortcode
 53:  c2cbcaf82 =3D  49:  1812362c7 Hugo-ify Linux & Mac download pages
 54:  d55dfbd55 !  50:  58a155e45 Add a script to store download data in `=
hugo.yml`
    @@ README.md: Or you can do it from GitHub (much slower) like this:

      ## hugo.yml ##
     @@ hugo.yml: params:
    -   latest_version: 2.43.0
    -   latest_relnote_url: https://raw.github.com/git/git/master/Document=
ation/RelNotes/2.43.0.txt
    -   latest_release_date: '2023-11-20'
    +   latest_version: 2.46.0
    +   latest_relnote_url: https://raw.github.com/git/git/master/Document=
ation/RelNotes/2.46.0.txt
    +   latest_release_date: '2024-07-29'
     +  macos_installer:
     +    url: https://sourceforge.net/projects/git-osx-installer/files/gi=
t-2.33.0-intel-universal-mavericks.dmg/download?use_mirror=3Dautoselect
     +    version: 2.33.0
    @@ hugo.yml: params:
     +    filename: git-2.33.0-intel-universal-mavericks.dmg
     +  windows_installer:
     +    portable32:
    -+      filename: PortableGit-2.43.0-32-bit.7z.exe
    -+      release_date: '2023-11-20'
    -+      version: 2.43.0
    -+      url: https://github.com/git-for-windows/git/releases/download/=
v2.43.0.windows.1/PortableGit-2.43.0-32-bit.7z.exe
    ++      filename: PortableGit-2.45.2-32-bit.7z.exe
    ++      release_date: '2024-06-03'
    ++      version: 2.45.2
    ++      url: https://github.com/git-for-windows/git/releases/download/=
v2.45.2.windows.1/PortableGit-2.45.2-32-bit.7z.exe
     +    portable64:
    -+      filename: PortableGit-2.43.0-64-bit.7z.exe
    -+      release_date: '2023-11-20'
    -+      version: 2.43.0
    -+      url: https://github.com/git-for-windows/git/releases/download/=
v2.43.0.windows.1/PortableGit-2.43.0-64-bit.7z.exe
    ++      filename: PortableGit-2.45.2-64-bit.7z.exe
    ++      release_date: '2024-06-03'
    ++      version: 2.45.2
    ++      url: https://github.com/git-for-windows/git/releases/download/=
v2.45.2.windows.1/PortableGit-2.45.2-64-bit.7z.exe
     +    installer32:
    -+      filename: Git-2.43.0-32-bit.exe
    -+      release_date: '2023-11-20'
    -+      version: 2.43.0
    -+      url: https://github.com/git-for-windows/git/releases/download/=
v2.43.0.windows.1/Git-2.43.0-32-bit.exe
    ++      filename: Git-2.45.2-32-bit.exe
    ++      release_date: '2024-06-03'
    ++      version: 2.45.2
    ++      url: https://github.com/git-for-windows/git/releases/download/=
v2.45.2.windows.1/Git-2.45.2-32-bit.exe
     +    installer64:
    -+      filename: Git-2.43.0-64-bit.exe
    -+      release_date: '2023-11-20'
    -+      version: 2.43.0
    -+      url: https://github.com/git-for-windows/git/releases/download/=
v2.43.0.windows.1/Git-2.43.0-64-bit.exe
    ++      filename: Git-2.45.2-64-bit.exe
    ++      release_date: '2024-06-03'
    ++      version: 2.45.2
    ++      url: https://github.com/git-for-windows/git/releases/download/=
v2.45.2.windows.1/Git-2.45.2-64-bit.exe

      ## app/services/download_service.rb =3D> script/update-download-data=
.rb ##
     @@
 55:  d58f20885 =3D  51:  cce79c1a0 Downloads (MacOS): show relative date
 56:  85d109ff6 =3D  52:  c0340b223 Convert the Windows downloads page to =
Hugo
 57:  5599b85a8 =3D  53:  5ae935edb download(win): white-space fix
 58:  6d1b7c7f3 =3D  54:  0b69e8c0c Add 'Downloads' page aliases
 59:  2f572e985 =3D  55:  8a9b19d16 Move the documentation landing page in=
 place for Hugo
 60:  1a96900f1 =3D  56:  fc28e03d2 Migrate the 'Documentation' landing pa=
ge to Hugo
 61:  2f53db947 <   -:  --------- Move the "references" landing page to `c=
ontent/`
  -:  --------- >  57:  49631dde3 Move the "references" landing page to `l=
ayouts/partials/`, in preparation for using it as a Hugo partial template.
 62:  dd874d4c7 =3D  58:  59972c75f Move the files defining the documentat=
ion categories
 63:  60f601394 !  59:  5ecc96a9a Adjust the "references" page to Hugo
    @@ Commit message
         Signed-off-by: Victoria Dye <vdye@github.com>
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

    - ## content/docs/_index.html ##
    -@@
    --<%- @section    =3D 'documentation' %>
    --<%- @subsection =3D 'reference' %>
    --<%- @page_title =3D "Git - Reference" %>
    -+---
    -+section: "documentation"
    -+subsection: "reference"
    -+title: "Git - Reference"
    -+url: /docs.html
    -+aliases:
    -+- /docs/index.html
    -+---
    -
    - <div id=3D'main'>
    -   <h1>Reference</h1>
    -   <div class=3D'callout quickref'>
    -     <p>
    -       Quick reference guides:
    --      <%=3D link_to "GitHub Cheat Sheet", "https://github.github.com=
/training-kit/" %>
    -+      <a href=3D"https://github.github.com/training-kit/">GitHub Che=
at Sheet</a>
    -       |
    --      <%=3D link_to "Visual Git Cheat Sheet", "https://ndpsoftware.c=
om/git-cheatsheet.html" %>
    -+      <a href=3D"https://ndpsoftware.com/git-cheatsheet.html">Visual=
 Git Cheat Sheet</a>
    -     </p>
    -   </div>
    -   <div class=3D"callout all-commands">
    -@@
    -   <div class=3D'reference-menu'>
    -     <div class=3D'two-column'>
    -       <div class=3D'column-left'>
    --        <%=3D render 'shared/ref/setup' %>
    --        <%=3D render 'shared/ref/creating' %>
    --        <%=3D render 'shared/ref/snapshot' %>
    --        <%=3D render 'shared/ref/branching' %>
    --        <%=3D render 'shared/ref/sharing' %>
    --        <%=3D render 'shared/ref/inspection' %>
    --        <%=3D render 'shared/ref/patching' %>
    --        <%=3D render 'shared/ref/debugging' %>
    -+        {{< category "setup" >}}
    -+        {{< category "projects" >}}
    -+        {{< category "snapshotting" >}}
    -+        {{< category "branching" >}}
    -+        {{< category "sharing" >}}
    -+        {{< category "inspection" >}}
    -+        {{< category "patching" >}}
    -+        {{< category "debugging" >}}
    -       </div>
    -       <div class=3D'column-right'>
    --        <%=3D render 'shared/ref/guides' %>
    --        <%=3D render 'shared/ref/email' %>
    --        <%=3D render 'shared/ref/external' %>
    --        <%=3D render 'shared/ref/admin' %>
    --        <%=3D render 'shared/ref/server' %>
    --        <%=3D render 'shared/ref/plumbing' %>
    -+        {{< category "guides" >}}
    -+        {{< category "email" >}}
    -+        {{< category "external" >}}
    -+        {{< category "admin" >}}
    -+        {{< category "server-admin" >}}
    -+        {{< category "plumbing" >}}
    -       </div>
    -     </div>
    -   </div>
    -
      ## data/doc_categories/admin.yml ##
     @@
     -<h3 class=3D'admin'>Administration</h3>
    @@ data/doc_categories/setup.yml
     -  <li><%=3D man('git-config') %></li>
     -  <li><%=3D man('git-help') %></li>
     -  <li><%=3D man('git-bugreport') %></li>
    --  <%=3D link_to "Credential helpers", "/doc/credential-helpers", sid=
ebar_link_options("credential-helpers") %>
    +-  <li><%=3D link_to "Credential helpers", "/doc/credential-helpers",=
 sidebar_link_options("credential-helpers") %></li>
     -</ul>
     +---
     +category_id: "setup"
    @@ layouts/partials/ref/category.html (new)
     +<ul class=3D'unstyled'>
     +  {{ range $doc :=3D $category.commands }}
     +  <li>
    -+    <a href=3D"{{ print "docs/" $doc.doc (cond (and (ne .Params.lang=
 nil) (ne $doc.no_append_lang true)) (print "/" .Params.lang) "") }}">
    ++    <a href=3D"{{ print "/docs/" $doc.doc (cond (and (ne $.Page.Para=
ms.lang nil) (ne $doc.no_append_lang true) (isset (index $.Site.Data.docs.=
pages $doc.doc) "languages") (isset (index $.Site.Data.docs.pages $doc.doc=
 "languages") $.Page.Params.lang)) (print "/" $.Page.Params.lang) "") }}">
     +      {{ if (eq $doc.title nil) }}
     +        {{ replace $doc.doc "git-" "" }}
     +      {{ else }}
    @@ layouts/partials/ref/category.html (new)
     +  {{ end }}
     +</ul>

    - ## layouts/shortcodes/category.html (new) ##
    + ## layouts/partials/ref/index.html ##
     @@
    -+{{ .Scratch.Set "category_id" (.Get 0) }}
    -+{{ partial "ref/category.html" . }}
    +-<%- @section    =3D 'documentation' %>
    +-<%- @subsection =3D 'reference' %>
    +-<%- @page_title =3D "Git - Reference" %>
    +-
    ++{{ $context :=3D . }}
    + <div id=3D'main'>
    +   <h1>Reference</h1>
    +   <div class=3D'callout quickref'>
    +     <p>
    +       Quick reference guides:
    +-      <%=3D link_to "GitHub Cheat Sheet", "https://github.github.com=
/training-kit/" %>
    ++      <a href=3D"https://github.github.com/training-kit/">GitHub Che=
at Sheet</a>
    +       |
    +-      <%=3D link_to "Visual Git Cheat Sheet", "https://ndpsoftware.c=
om/git-cheatsheet.html" %>
    ++      <a href=3D"https://ndpsoftware.com/git-cheatsheet.html">Visual=
 Git Cheat Sheet</a>
    +     </p>
    +   </div>
    +   <div class=3D"callout all-commands">
    +@@
    +   <div class=3D'reference-menu'>
    +     <div class=3D'two-column'>
    +       <div class=3D'column-left'>
    +-        <%=3D render 'shared/ref/setup' %>
    +-        <%=3D render 'shared/ref/creating' %>
    +-        <%=3D render 'shared/ref/snapshot' %>
    +-        <%=3D render 'shared/ref/branching' %>
    +-        <%=3D render 'shared/ref/sharing' %>
    +-        <%=3D render 'shared/ref/inspection' %>
    +-        <%=3D render 'shared/ref/patching' %>
    +-        <%=3D render 'shared/ref/debugging' %>
    ++        {{ range slice "setup" "projects" "snapshotting" "branching"=
 "sharing" "inspection" "patching" "debugging" }}
    ++        {{ $context.Scratch.Set "category_id" . }}
    ++        {{ partial "ref/category.html" $context }}
    ++        {{ end }}
    +       </div>
    +       <div class=3D'column-right'>
    +-        <%=3D render 'shared/ref/guides' %>
    +-        <%=3D render 'shared/ref/email' %>
    +-        <%=3D render 'shared/ref/external' %>
    +-        <%=3D render 'shared/ref/admin' %>
    +-        <%=3D render 'shared/ref/server' %>
    +-        <%=3D render 'shared/ref/plumbing' %>
    ++        {{ range slice "guides" "email" "external" "admin" "server-a=
dmin" "plumbing" }}
    ++        {{ $context.Scratch.Set "category_id" . }}
    ++        {{ partial "ref/category.html" $context }}
    ++        {{ end }}
    +       </div>
    +     </div>
    +   </div>
 64:  a3b5464d2 =3D  60:  10c090f35 Migrate 'Videos' page
 65:  ebbf2dc93 !  61:  9bc68f7dd Migrate individual video pages
    @@ app/views/doc/watch.html.erb (deleted)

      ## layouts/_default/baseof.html ##
     @@
    -       <div id=3D"content-wrapper">
    -         {{ partial "sidebar.html" . }}
              <div id=3D"content">
    --          {{ if eq $section "about" }}
    -+          {{ if isset .Params "video_title" }}
    -+	    <div id=3D"main">
    +           {{ if (eq .Page.Path "/docs") }}
    +             {{ partial "ref/index.html" . }}
    ++          {{ else if isset .Params "video_title" }}
    ++            <div id=3D"main">
     +              <h1>{{ .Params.category }} Episode {{ .Params.episode =
}}</h1>
     +              <h2>{{ .Params.video_title }}</h2>
     +
    @@ layouts/_default/baseof.html
     +                <iframe src=3D"https://player.vimeo.com/video/{{ .Pa=
rams.ext_id }}?title=3D0&amp;byline=3D0&amp;portrait=3D0&amp;color=3Df14e3=
2" width=3D"635" height=3D"360" frameborder=3D"0" webkitAllowFullScreen mo=
zallowfullscreen allowFullScreen></iframe>
     +              </div>
     +            </div>
    -+          {{ else if eq $section "about" }}
    - 	    <div id=3D"main">
    +           {{ else if eq $section "about" }}
    +             <div id=3D"main">
                    <h1>About</h1>
    -
 66:  d97d6afea !  62:  f0e2dad52 Migrate external links page to Hugo
    @@ app/views/doc/_ext_tutorials.erb =3D> layouts/shortcodes/external/t=
utorials.html
              </p>
     -      </li>
     +      </li>
    -     </ul>
    -   </div>
    -   <div class=3D'column-right'>
    +       <li>
    +         <h4><a href=3D"https://www.python4data.science/en/latest/pro=
ductive/git/index.html">Git for Data Science</a></h4>
    +         <p class=3D'description'>
     @@
              <p class=3D'description'>
                Learn the basics of Git and Version Control through detail=
ed and easy to follow steps.
 67:  9549255ef =3D  63:  b4755928a Migrate the 'About this site' page to =
Hugo
 68:  4114ef8f4 =3D  64:  593d99e18 Migrate the Software Freedom Conservan=
cy page
 69:  d05bb21d4 !  65:  976c2b5c1 Hugo'ify the "credential helpers" page
    @@ layouts/partials/ref/category.html
      <ul class=3D'unstyled'>
        {{ range $doc :=3D $category.commands }}
        <li>
    --    <a href=3D"{{ print "docs/" $doc.doc (cond (and (ne .Params.lang=
 nil) (ne $doc.no_append_lang true)) (print "/" .Params.lang) "") }}">
    +-    <a href=3D"{{ print "/docs/" $doc.doc (cond (and (ne $.Page.Para=
ms.lang nil) (ne $doc.no_append_lang true) (isset (index $.Site.Data.docs.=
pages $doc.doc) "languages") (isset (index $.Site.Data.docs.pages $doc.doc=
 "languages") $.Page.Params.lang)) (print "/" $.Page.Params.lang) "") }}">
     +    {{ if (eq $doc.doc "credential-helpers") }}
     +      <a href=3D"doc/credential-helpers">
     +    {{ else }}
    -+      <a href=3D"{{ print "docs/" $doc.doc (cond (and (ne .Params.la=
ng nil) (ne $doc.no_append_lang true)) (print "/" .Params.lang) "") }}">
    ++      <a href=3D"{{ print "/docs/" $doc.doc (cond (and (ne $.Page.Pa=
rams.lang nil) (ne $doc.no_append_lang true) (isset (index $.Site.Data.doc=
s.pages $doc.doc) "languages") (isset (index $.Site.Data.docs.pages $doc.d=
oc "languages") $.Page.Params.lang)) (print "/" $.Page.Params.lang) "") }}=
">
     +    {{ end }}
            {{ if (eq $doc.title nil) }}
              {{ replace $doc.doc "git-" "" }}
 70:  00a42808e =3D  66:  ccecdf517 Move the search results page
 71:  5a183e236 !  67:  00d2b544f Implement client-side search using Pagef=
ind
    @@ Commit message

         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

    + ## .github/workflows/ci.yml ##
    +@@ .github/workflows/ci.yml: jobs:
    +     steps:
    +     - uses: actions/checkout@v4
    +
    +-    - name: configure Hugo version
    ++    - name: configure Hugo and Pagefind version
    +       run: |
    +         set -x &&
    +         echo "HUGO_VERSION=3D$(sed -n 's/^ *hugo_version: *//p' <hug=
o.yml)" >>$GITHUB_ENV
    ++        echo "PAGEFIND_VERSION=3D$(sed -n 's/^ *pagefind_version: */=
/p' <hugo.yml)" >>$GITHUB_ENV
    +
    +     - name: install Hugo ${{ env.HUGO_VERSION }}
    +       run: |
    +@@ .github/workflows/ci.yml: jobs:
    +     - name: run Hugo to build the pages
    +       run: hugo
    +
    ++    - name: run Pagefind ${{ env.PAGEFIND_VERSION }} to build the se=
arch index
    ++      run: npx -y pagefind@${{ env.PAGEFIND_VERSION }} --site public
    ++
    +     - name: build tar archive
    +       run: cd public && tar czvf ../pages.tar.gz *
    +
    +
      ## README.md ##
    -@@ README.md: You'll need the extended version of [Hugo](https://gohu=
go.io/). On Windows, we r
    +@@ README.md: To render the site locally, you'll need the extended ve=
rsion of [Hugo](https://g

      The site should be running on http://127.0.0.1:1313. Note that it ma=
y be advisable to do this in a sparse checkout that excludes large parts o=
f `content/`, to speed up the rendering time.

    @@ README.md: You'll need the extended version of [Hugo](https://gohug=
o.io/). On Wi

      (TODO!)
     @@ README.md: The [list of GUI clients](https://git-scm.com/downloads=
/guis) has been construct
    -
    - 2. Add the image to `static/images/guis/<GUI_CLIENT_NAME>@2x.png` an=
d `static/images/guis/<GUI_CLIENT_NAME>.png` making sure the aspect ratio =
matches a 588:332 image.
    -
    --## Useful link regarding working with Hugo
    -+## Useful links regarding working with Hugo and Pagefind
    -
      * https://gohugo.io/
      * https://gohugo.io/content-management/shortcodes/
    -+* https://pagefind.app/

    ++### Pagefind (client-side search)
    ++
    ++* https://pagefind.app/
    ++
      ## License

    + The source code for the site is licensed under the MIT license, whic=
h you can find in

      ## assets/sass/search.scss ##
     @@
    @@ content/search/results.html
     +  <ol class=3D"full-search-results"></ol>
      </div>

    + ## hugo.yml ##
    +@@ hugo.yml: markup:
    +       unsafe: true
    + params:
    +   hugo_version: 0.134.1
    ++  pagefind_version: 1.1.1
    +   latest_version: 2.46.0
    +   latest_relnote_url: https://raw.github.com/git/git/master/Document=
ation/RelNotes/2.46.0.txt
    +   latest_release_date: '2024-07-29'
    +
      ## static/js/application.js ##
     @@ static/js/application.js: var Search =3D {
        selectedIndex: 0,
 72:  1c55e8995 !  68:  fd440ba66 Implement "live search" using Pagefind
    @@ static/js/application.js: var Search =3D {
     -    })
     +    (async () =3D> {
     +      Search.pagefind =3D await import(`${baseURLPrefix}pagefind/pag=
efind.js`);
    -+      Search.pagefind.init();
    ++      await Search.pagefind.init();
     +      await callback();
     +    })().catch(console.log);
        },
 73:  99046a762 =3D  69:  03d63b90d Mark pages with the correct language
 74:  3d70c728b !  70:  a12108c7f Direct Pagefind what parts of the pages =
to index
    @@ layouts/_default/baseof.html
              {{ partial "sidebar.html" . }}
     -        <div id=3D"content">
     +        <div id=3D"content" data-pagefind-body>
    -           {{ if isset .Params "video_title" }}
    - 	    <div id=3D"main">
    -               <h1>{{ .Params.category }} Episode {{ .Params.episode =
}}</h1>
    +           {{ if (eq .Page.Path "/docs") }}
    +             {{ partial "ref/index.html" . }}
    +           {{ else if isset .Params "video_title" }}
 75:  1b6bb3c10 =3D  71:  23433ad6d Live search: only load 10 results at a=
 time
 76:  cd28ebbe1 !  72:  a688de393 Respect the language in non-live search
    @@ static/js/application.js: var Search =3D {
          }
          (async () =3D> {
            Search.pagefind =3D await import(`${baseURLPrefix}pagefind/pag=
efind.js`);
    ++      const options =3D {}
     +      const language =3D this.getQueryValue('language');
    -+      if (language) Search.pagefind.options({language});
    -       Search.pagefind.init();
    ++      if (language) options.language =3D language;
    ++      await Search.pagefind.options(options);
    +       await Search.pagefind.init();
            await callback();
          })().catch(console.log);
 77:  338a2e6c0 !  73:  2a357df65 Use Pagefind's UI for the full search
    @@ layouts/_default/baseof.html
        <link href=3D'/favicon.ico' rel=3D'shortcut icon' type=3D'image/x-=
icon'>

     +  {{ if eq $section "search" }}<link href=3D"{{ relURL "pagefind/pag=
efind-ui.css" }}" rel=3D"stylesheet">{{ end }}
    -   {{ $style :=3D resources.Get "sass/application.scss" | resources.E=
xecuteAsTemplate "application.scss" . | resources.ToCSS | resources.Minify=
 }}
    +   {{ $style :=3D resources.Get "sass/application.scss" | resources.E=
xecuteAsTemplate "application.scss" . | css.Sass | resources.Minify }}
        <link rel=3D"stylesheet" href=3D"{{ $style.RelPermalink }}">
        <script src=3D"/js/modernizr.js"></script>

    @@ layouts/partials/header.html
     +
     +  {{ if ne (.Scratch.Get "section") "search" }}
        <form id=3D"search" action=3D"/search/results">
    -     <input id=3D"search-text" name=3D"search" placeholder=3D"Search =
entire site..." autocomplete=3D"off" type=3D"text" />
    +     <input id=3D"search-text" name=3D"search" placeholder=3D"Type / =
to search entire site=E2=80=A6" autocomplete=3D"off" type=3D"text" />
        </form>
        <div id=3D"search-results"></div>
     +  {{ end }}
    @@ static/js/application.js: var Search =3D {
     -    this.initializeSearchIndex(async () =3D> {
     -      const results =3D await Search.pagefind.search(searchTerm);
     -      if (!results || !results.results || !results.results.length) r=
eturn;
    -+    new PagefindUI({ element: "#search-div", showSubResults: true, l=
anguage });
    -
    +-
     -      const list =3D (await Promise.all(results.results.map(async e =
=3D> {
     -        const result =3D await e.data();
     -        const href =3D result.url;
    @@ static/js/application.js: var Search =3D {
     -          <a class=3D"url" href=3D"${href}">${href}</a>
     -          <p>${result.excerpt}</p></li>`;
     -      }))).join('');
    --
    ++    new PagefindUI({
    ++      element: "#search-div",
    ++      showSubResults: true,
    ++      language
    ++    });
    +
     -      searchResultsElements[0].innerHTML =3D list || '<li>No results=
 found</li>';
     -    })
     +    const searchTerm =3D this.getQueryValue('search');
  -:  --------- >  74:  c7ff8dad0 Add a helper script to run Pagefind
  -:  --------- >  75:  c32fdf3dc ci: verify the order of the search resul=
ts
 78:  8147144aa =3D  76:  26ff8cb61 Implement the `relurl` shortcode
 79:  61d1610e4 !  77:  c8a20dffc Use relative URLs
    @@ content/community/_index.html: aliases:
        <h2> Contributing to Git </h2>

        <p>
    --    The <a href=3D"https://github.com/git/git/tree/master/Documentat=
ion">Documentation directory</a> in the Git source code has several files =
of interest to developers who are looking to help contribute. After readin=
g the <a href=3D"https://github.com/git/git/blob/master/Documentation/Codi=
ngGuidelines">coding guidelines</a>, you can learn <a href=3D"/docs/Submit=
tingPatches">how to submit patches</a>. If you are just starting out, you =
can read the <a href=3D"/docs/MyFirstContribution">My First Contribution t=
utorial</a>. For those looking to get more deeply involved, there is a <a =
href=3D"https://github.com/git/git/blob/master/Documentation/howto/maintai=
n-git.txt">howto for Git maintainers</a>.
    -+    The <a href=3D"https://github.com/git/git/tree/master/Documentat=
ion">Documentation directory</a> in the Git source code has several files =
of interest to developers who are looking to help contribute. After readin=
g the <a href=3D"https://github.com/git/git/blob/master/Documentation/Codi=
ngGuidelines">coding guidelines</a>, you can learn <a href=3D"{{< relurl "=
docs/SubmittingPatches" >}}">how to submit patches</a>. If you are just st=
arting out, you can read the <a href=3D"{{< relurl "docs/MyFirstContributi=
on" >}}">My First Contribution tutorial</a>. For those looking to get more=
 deeply involved, there is a <a href=3D"https://github.com/git/git/blob/ma=
ster/Documentation/howto/maintain-git.txt">howto for Git maintainers</a>.
    +-    The <a href=3D"https://github.com/git/git/tree/master/Documentat=
ion">Documentation directory</a> in the Git source code has several files =
of interest to developers who are looking to help contribute. After readin=
g the <a href=3D"https://github.com/git/git/blob/master/Documentation/Codi=
ngGuidelines">coding guidelines</a> and <a href=3D"https://github.com/git/=
git/blob/master/CODE_OF_CONDUCT.md">code of conduct</a>, you can learn <a =
href=3D"/docs/SubmittingPatches">how to submit patches</a>. If you are jus=
t starting out, you can read the <a href=3D"/docs/MyFirstContribution">My =
First Contribution tutorial</a>. For those looking to get more deeply invo=
lved, there is a <a href=3D"https://github.com/git/git/blob/master/Documen=
tation/howto/maintain-git.txt">howto for Git maintainers</a>.
    ++    The <a href=3D"https://github.com/git/git/tree/master/Documentat=
ion">Documentation directory</a> in the Git source code has several files =
of interest to developers who are looking to help contribute. After readin=
g the <a href=3D"https://github.com/git/git/blob/master/Documentation/Codi=
ngGuidelines">coding guidelines</a> and <a href=3D"https://github.com/git/=
git/blob/master/CODE_OF_CONDUCT.md">code of conduct</a>, you can learn <a =
href=3D"{{< relurl "docs/SubmittingPatches" >}}">how to submit patches</a>=
. If you are just starting out, you can read the <a href=3D"{{< relurl "do=
cs/MyFirstContribution" >}}">My First Contribution tutorial</a>. For those=
 looking to get more deeply involved, there is a <a href=3D"https://github=
.com/git/git/blob/master/Documentation/howto/maintain-git.txt">howto for G=
it maintainers</a>.
        </p>

        <p>
    @@ content/doc/_index.html: aliases:

        </div>

    - ## content/docs/_index.html ##
    -@@ content/docs/_index.html: aliases:
    -     </p>
    -   </div>
    -   <div class=3D"callout all-commands">
    --    <a href=3D"/docs/git#_git_commands">Complete list of all command=
s</a>
    -+    <a href=3D"{{< relurl "docs/git#_git_commands" >}}">Complete lis=
t of all commands</a>
    -   </div>
    -   <div class=3D'reference-menu'>
    -     <div class=3D'two-column'>
    -
      ## content/downloads/_index.html ##
     @@ content/downloads/_index.html: aliases:
              <table class=3D"binaries">
    @@ layouts/_default/baseof.html
     +  <link href=3D"{{ relURL "favicon.ico" }}" rel=3D'shortcut icon' ty=
pe=3D'image/x-icon'>

        {{ if eq $section "search" }}<link href=3D"{{ relURL "pagefind/pag=
efind-ui.css" }}" rel=3D"stylesheet">{{ end }}
    -   {{ $style :=3D resources.Get "sass/application.scss" | resources.E=
xecuteAsTemplate "application.scss" . | resources.ToCSS | resources.Minify=
 }}
    +   {{ $style :=3D resources.Get "sass/application.scss" | resources.E=
xecuteAsTemplate "application.scss" . | css.Sass | resources.Minify }}
        <link rel=3D"stylesheet" href=3D"{{ $style.RelPermalink }}">
     -  <script src=3D"/js/modernizr.js"></script>
     -  <script src=3D"/js/modernize.js"></script>
    @@ layouts/partials/header.html
        {{ if ne (.Scratch.Get "section") "search" }}
     -  <form id=3D"search" action=3D"/search/results">
     +  <form id=3D"search" action=3D"{{ relURL "search/results" }}">
    -     <input id=3D"search-text" name=3D"search" placeholder=3D"Search =
entire site..." autocomplete=3D"off" type=3D"text" />
    +     <input id=3D"search-text" name=3D"search" placeholder=3D"Type / =
to search entire site=E2=80=A6" autocomplete=3D"off" type=3D"text" />
        </form>
        <div id=3D"search-results"></div>

    @@ layouts/partials/ref/category.html
     -      <a href=3D"doc/credential-helpers">
     +      <a href=3D"{{ relURL "doc/credential-helpers" }}">
          {{ else }}
    --      <a href=3D"{{ print "docs/" $doc.doc (cond (and (ne .Params.la=
ng nil) (ne $doc.no_append_lang true)) (print "/" .Params.lang) "") }}">
    -+      <a href=3D"{{ relURL (print "docs/" $doc.doc (cond (and (ne .P=
arams.lang nil) (ne $doc.no_append_lang true)) (print "/" .Params.lang) ""=
)) }}">
    +-      <a href=3D"{{ print "/docs/" $doc.doc (cond (and (ne $.Page.Pa=
rams.lang nil) (ne $doc.no_append_lang true) (isset (index $.Site.Data.doc=
s.pages $doc.doc) "languages") (isset (index $.Site.Data.docs.pages $doc.d=
oc "languages") $.Page.Params.lang)) (print "/" $.Page.Params.lang) "") }}=
">
    ++      <a href=3D"{{ relURL (print "docs/" $doc.doc (cond (and (ne $.=
Page.Params.lang nil) (ne $doc.no_append_lang true) (isset (index $.Site.D=
ata.docs.pages $doc.doc) "languages") (isset (index $.Site.Data.docs.pages=
 $doc.doc "languages") $.Page.Params.lang)) (print "/" $.Page.Params.lang)=
 "")) }}">
          {{ end }}
            {{ if (eq $doc.title nil) }}
              {{ replace $doc.doc "git-" "" }}

    + ## layouts/partials/ref/index.html ##
    +@@
    +     </p>
    +   </div>
    +   <div class=3D"callout all-commands">
    +-    <a href=3D"/docs/git#_git_commands">Complete list of all command=
s</a>
    ++    <a href=3D"{{ relURL "docs/git#_git_commands" }}">Complete list =
of all commands</a>
    +   </div>
    +   <div class=3D'reference-menu'>
    +     <div class=3D'two-column'>
    +
      ## layouts/partials/sidebar.html ##
     @@
        <nav>
 80:  199ad72ad =3D  78:  943375d44 Accommodate for base URLs other than `=
/`
 81:  905f3d1b1 !  79:  312d96605 ci: ensure that there are only relative =
URLs
    @@ .github/workflows/ci.yml: jobs:
     +          exit 1
     +        fi
     +
    -     - name: run Pagefind to build the search index
    -       run: npx -y pagefind --site public
    +     - name: run Pagefind ${{ env.PAGEFIND_VERSION }} to build the se=
arch index
    +       run: npx -y pagefind@${{ env.PAGEFIND_VERSION }} --site public

 82:  efccaef38 =3D  80:  f54c9f6af Drop the Rails version of the ProGit b=
ook
 83:  046ae69cf =3D  81:  05158a866 Move the ProGit book related Ruby code=
 to a new location
 84:  1b6c1ef2c !  82:  34b4c74b9 Transmogrify the Rake script to generate=
 the Pro Git book sections
    @@ README.md: Now you need to get the latest downloads for the downloa=
ds pages:
     +If you have 2FA enabled, you'll need to create a [Personal Access To=
ken](https://help.github.com/articles/creating-an-access-token-for-command=
-line-use/).

     -Alternatively, you can get the book content from a repository on you=
r computer by specifying the path in the `GENPATH` environment variable to=
 the `local_genbook2` target:
    -+If you want to build the book for all available languages, just skip=
 the language code:
    ++If you want to build the book for all available languages, just omit=
 the language code parameter:

     -    $ GENLANG=3Dfr GENPATH=3D../progit2-fr rake local_genbook2
     +    $ ruby ./script/update-book2.rb
    @@ README.md: Now you need to get the latest downloads for the downloa=
ds pages:
      ## Contributing


    + ## hugo.yml ##
    +@@ hugo.yml: markup:
    +   goldmark:
    +     renderer:
    +       unsafe: true
    ++module:
    ++  mounts:
    ++  - source: content
    ++    target: content
    ++  - source: static
    ++    target: static
    ++  - source: data
    ++    target: data
    ++  - source: external/book/data/book
    ++    target: data/book
    ++  - source: external/book/content/book
    ++    target: content/book
    ++  - source: external/book/static/book
    ++    target: static/book
    + params:
    +   hugo_version: 0.134.1
    +   pagefind_version: 1.1.1
    +
      ## layouts/_default/baseof.html ##
     @@
            </div> <!-- .inner -->
    @@ script/book.rb: class Book < ApplicationRecord
     +    }
     +  end
     +
    ++  def content_note
    ++    "### DO NOT EDIT! Generated by script/update-book2.rb"
    ++  end
    ++
    ++  def wrap_front_matter(front_matter)
    ++    "#{front_matter.to_yaml.sub("---\n", "---\n#{self.content_note}\=
n")}---\n"
    ++  end
    ++
     +  def absolute_path(path)
    -+    File.absolute_path(File.join(File.dirname(__FILE__), "..", "cont=
ent", "book", @language_code, "v#{@edition}", path))
    ++    File.absolute_path(File.join(File.dirname(__FILE__), "..", "exte=
rnal", "book", "content", "book", @language_code, "v#{@edition}", path))
     +  end
     +
     +  def removeAllFiles
    @@ script/book.rb: class Book < ApplicationRecord
     +    return front_matter
     +  end
     +
    ++  def wrap_front_matter(front_matter)
    ++    @book.wrap_front_matter(front_matter)
    ++  end
    ++
     +  attr_accessor :title
     +  attr_accessor :chapter_type
     +  attr_accessor :chapter_number
    @@ script/book.rb: class Book < ApplicationRecord
     +  def save
     +    return if self.slug.nil?
     +
    -+    front_matter =3D "#{self.front_matter.to_yaml}\n---\n"
    -+
     +    path =3D self.absolute_path(self.slug)
     +    FileUtils.mkdir_p(File.dirname(path))
     +    File.open("#{path}.html", 'w') do |file|
    -+      file.write(front_matter)
    ++      file.write(@chapter.wrap_front_matter(self.front_matter))
     +      file.write(self.html.strip)
     +    end
        end
 85:  cdb7f4377 !  83:  803869e33 update-book2: adjust navigation
    @@ layouts/shortcodes/previous-section.html (new)

      ## script/book.rb ##
     @@ script/book.rb: class Book
    -     File.absolute_path(File.join(File.dirname(__FILE__), "..", "cont=
ent", "book", @language_code, "v#{@edition}", path))
    +     File.absolute_path(File.join(File.dirname(__FILE__), "..", "exte=
rnal", "book", "content", "book", @language_code, "v#{@edition}", path))
        end

     +  def relative_url(path)
 86:  44c163eaa !  84:  f6734888d update-book2: also include the images
    @@ Commit message

      ## script/book.rb ##
     @@ script/book.rb: class Book
    -     }
    +     "#{front_matter.to_yaml.sub("---\n", "---\n#{self.content_note}\=
n")}---\n"
        end

     -  def absolute_path(path)
    --    File.absolute_path(File.join(File.dirname(__FILE__), "..", "cont=
ent", "book", @language_code, "v#{@edition}", path))
    +-    File.absolute_path(File.join(File.dirname(__FILE__), "..", "exte=
rnal", "book", "content", "book", @language_code, "v#{@edition}", path))
     +  def absolute_path(path, top_level =3D "content")
    -+    File.absolute_path(File.join(File.dirname(__FILE__), "..", top_l=
evel, "book", @language_code, "v#{@edition}", path))
    ++    File.absolute_path(File.join(File.dirname(__FILE__), "..", "exte=
rnal", "book", top_level, "book", @language_code, "v#{@edition}", path))
        end

        def relative_url(path)
 87:  7d0edee4b =3D  85:  dcff0ad8c update-book2: show the chapter/section=
 numbers in the titles
 88:  eb4e84dfd !  86:  91531feee Generate the front page of the Pro Git b=
ook
    @@ script/book.rb: class Book
     +      front_matter["book"]["ebook_mobi"] =3D self.ebook_mobi
     +    end
     +
    -+    front_matter =3D "#{front_matter.to_yaml}\n---"
    -+
     +    path =3D self.absolute_path("_index.html")
     +    FileUtils.mkdir_p(File.dirname(path))
     +    File.open(path, 'w') do |file|
    -+      file.write(front_matter)
    ++      file.write(self.wrap_front_matter(front_matter))
     +    end
     +
    ++    front_matter =3D { "redirect_to" =3D> "book/#{@language_code}/v#=
{@edition}" }
     +    File.open(self.absolute_path("../_index.html"), 'w') do |file|
    -+      file.write("---\nredirect_to: \"book/#{@language_code}/v#{@edi=
tion}\"\n---\n")
    ++      file.write(self.wrap_front_matter(front_matter))
     +    end
    ++
     +    if @language_code =3D=3D "en"
     +      File.open(self.absolute_path("../../_index.html"), 'w') do |fi=
le|
    -+        file.write("---\nredirect_to: \"book/#{@language_code}/v#{@e=
dition}\"\n---\n")
    ++        file.write(self.wrap_front_matter(front_matter))
     +      end
     +    end
     +  end
 89:  714b23ec6 !  87:  419be615f book: also generate the URLs for the dow=
nloadable formats of the book
    @@ Commit message
         ... but do this only for the English version, as the other versio=
ns are
         not available in downloadable formats.

    +    As the idea is to run this script in a GitHub workflow on a shall=
ow
    +    clone, let's be prepared for the situation where the tip commit o=
f the
    +    default branch is _not_ (yet?) tagged and therefore no tag is pre=
sent in
    +    the clone. In this situation, let's just go ahead and fetch all t=
ags,
    +    then move along and update the URLs accordingly.
    +
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

      ## script/update-book2.rb ##
    @@ script/update-book2.rb: def local_genbook2(language_code, worktree_=
path)
          end
     +    if language_code =3D=3D 'en'
     +      latest_tag =3D `git -C "#{worktree_path}" for-each-ref --forma=
t '%(refname:short)' --sort=3D-committerdate --count=3D1 refs/tags/`.chomp
    ++      if latest_tag.empty?
    ++        puts "No tag found in #{worktree_path}, trying to fetch tags=
"
    ++        latest_tag =3D `git -C "#{worktree_path}" fetch --tags origi=
n && git -C "#{worktree_path}" for-each-ref --format '%(refname:short)' --=
sort=3D-committerdate --count=3D1 refs/tags/`.chomp
    ++	raise "Still no tags in #{worktree_path}?" if latest_tag.empty?
    ++      end
     +      book.ebook_pdf =3D "https://github.com/progit/progit2/releases=
/download/#{latest_tag}/progit.pdf"
     +      book.ebook_epub =3D "https://github.com/progit/progit2/release=
s/download/#{latest_tag}/progit.epub"
     +      book.ebook_mobi =3D "https://github.com/progit/progit2/release=
s/download/#{latest_tag}/progit.mobi"
 90:  68e96e524 <   -:  --------- Record SHA of the Pro Git book even when=
 generating it locally
  -:  --------- >  88:  406254667 update-book2.rb: gracefully warn about m=
issing files, but continue
  -:  --------- >  89:  9f7d416f5 Record SHA of the Pro Git book even when=
 generating it locally
 91:  915329bc2 !  90:  e6e83c127 Pro Git book: populate the `Chapters` dr=
op-down
    @@ layouts/_default/baseof.html
            {{ partial "footer.html" . }}
          </div> <!-- #content-wrapper -->
        {{ else if (isset .Params "book") }}
    -+    {{ .Scratch.Set "book" (index .Site.Data (print "book-" .Params.=
book.language_code)) }}
    ++    {{ .Scratch.Set "book" (index .Site.Data.book .Params.book.langu=
age_code) }}
          <div class=3D"inner">
            <div id=3D"content-wrapper">
              {{ partial "sidebar.html" . }}
    @@ script/book.rb: class Book
     +      "language_code" =3D> @language_code,
     +      "chapters" =3D> chapters
     +    }
    -+    path =3D File.join(File.dirname(__FILE__), "..", "data", "book-#=
{@language_code}.yml")
    ++    path =3D File.join(File.dirname(__FILE__), "..", "external", "bo=
ok", "data", "book", "#{@language_code}.yml")
     +    FileUtils.mkdir_p(File.dirname(path))
     +    File.open(path, 'w') do |file|
    ++      file.write("#{self.content_note}\n")
     +      file.write(data.to_yaml.strip)
     +    end
     +
 92:  6156ecfdd =3D  91:  1a51fcc94 book: keep colons and other special ch=
aracters in URLs
 93:  2dd98a59e =3D  92:  e492c9c63 book: fix translated labels
 94:  289ee87b7 !  93:  7f3b191a3 book: generate cross-references correctl=
y
    @@ script/book.rb: class Book

        def front_matter
     @@ script/book.rb: class Book
    -         file.write("---\nredirect_to: \"book/#{@language_code}/v#{@e=
dition}\"\n---\n")
    +         file.write(self.wrap_front_matter(front_matter))
            end
          end
     +
    @@ script/book.rb: class Book
     +    @xrefs.each do |id_xref, section|
     +      path =3D self.absolute_path("ch00/#{id_xref}.html")
     +      relurl =3D "#{section.relative_url(nil)}##{id_xref}"
    ++      front_matter =3D { "redirect_to" =3D> relurl }
     +      File.open(path, 'w') do |file|
    -+        file.write("---\nredirect_to: \"#{relurl}\"\n---\n")
    ++        file.write(self.wrap_front_matter(front_matter))
     +      end
     +    end
        end
 95:  ded726a6c =3D  94:  4a31646bc book-tl: work around an incorrect imag=
e reference
 96:  4078053ef =3D  95:  01b1dd71f book: work around lagging translations=
' image paths
 97:  8f4d3d8a3 !  96:  731b6b686 book(xrefs): maintain question marks tha=
t are part of the URL path
    @@ Commit message
         sections' titles; These need to be (URL-)encoded in the URL and n=
ot be
         mistaken for the separator between path and GET parameter(s).

    +    While at it, also install redirects for URLs containing a questio=
n mark
    +    so that incorrect URLs that contain a literal question mark (whic=
h is
    +    interpreted as separator between the URL path and the `GET`
    +    parameter(s)) redirect to the correct ones.
    +
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

      ## script/book.rb ##
    @@ script/book.rb: class Section
          }
          if @slug =3D~ /:|[^-A-Za-z0-9_]/
     -      front_matter["url"] =3D self.relative_url(@slug)
    -+      front_matter["url"] =3D self.relative_url(@slug).gsub(/%3F/, '=
?')
    ++      relative_url =3D self.relative_url(@slug)
    ++      front_matter["url"] =3D "/#{relative_url.gsub(/%3F/, '?')}.htm=
l"
    ++      if relative_url =3D~ /%3F/
    ++        front_matter["aliases"] =3D [
    ++	  "/#{relative_url.gsub(/%3F.*/, '')}.html"
    ++	]
    ++      end
          end
          return front_matter
        end
 98:  b99c5d1d5 !  97:  0343bf0ab book: redirect missing xrefs to the Engl=
ish book
    @@ script/book.rb: class Book
          @xrefs.each do |id_xref, section|
            path =3D self.absolute_path("ch00/#{id_xref}.html")
     -      relurl =3D "#{section.relative_url(nil)}##{id_xref}"
    +-      front_matter =3D { "redirect_to" =3D> relurl }
     +      if section =3D=3D 'redirect-to-en'
     +        url =3D "book/en/v2/ch00/#{id_xref}"
     +      else
     +        url =3D "#{section.relative_url(nil)}##{id_xref}"
     +      end
    ++      front_matter =3D { "redirect_to" =3D> url }
            File.open(path, 'w') do |file|
    --        file.write("---\nredirect_to: \"#{relurl}\"\n---\n")
    -+        file.write("---\nredirect_to: \"#{url}\"\n---\n")
    +         file.write(self.wrap_front_matter(front_matter))
            end
    -     end
    -   end

      ## script/update-book2.rb ##
     @@ script/update-book2.rb: def genbook(language_code, &get_content)
 99:  c3f723764 =3D  98:  8b30c3748 book: handle footnotes gracefully
100:  58dcc1d03 =3D  99:  bedb26d29 book: fix a couple of broken redirects
101:  be1163d71 =3D 100:  f890fa149 docs: prepare for `index.rake` to beco=
me a proper Ruby script
102:  73280317a ! 101:  990ac016c Turn what used to be the `index.rake` fi=
le into a proper Ruby script
    @@ README.md: Note that this will take about 7 times as long, and the =
site will not
      Similarly, you can also populate the localized man pages. From a loc=
al clone of https://github.com/jnavila/git-html-l10n :


    + ## hugo.yml ##
    +@@ hugo.yml: module:
    +     target: content/book
    +   - source: external/book/static/book
    +     target: static/book
    ++  - source: external/docs/data
    ++    target: data
    ++  - source: external/docs/content
    ++    target: content
    + params:
    +   hugo_version: 0.134.1
    +   pagefind_version: 1.1.1
    +
      ## layouts/_default/baseof.html ##
     @@
            </div>
    @@ script/update-docs.rb
     +require_relative "version"
     +
     +SITE_ROOT =3D File.join(File.expand_path(File.dirname(__FILE__)), '.=
./')
    -+DATA_FILE =3D "#{SITE_ROOT}data/docs.yml"
    ++DOCS_INDEX_FILE =3D "#{SITE_ROOT}external/docs/content/docs/_index.h=
tml"
    ++DATA_FILE =3D "#{SITE_ROOT}external/docs/data/docs.yml"
     +
     +def read_data
     +  if File.exists?(DATA_FILE)
    @@ script/update-docs.rb

      def make_asciidoc(content)
        Asciidoctor::Document.new(content,
    +@@ script/update-docs.rb: def make_asciidoc(content)
    +                             doctype: "book")
    + end
    +
    ++def content_note
    ++  "### DO NOT EDIT! Generated by script/update-docs.rb\n"
    ++end
    ++
    ++def wrap_front_matter(front_matter)
    ++  "#{front_matter.to_yaml.sub("---\n", "---\n#{content_note}\n")}---=
\n"
    ++end
    ++
    + def expand_l10n(path, content, get_f_content, categories)
    +   content.gsub!(/include::(\S+)\.txt/) do |line|
    +     line.gsub!("include::", "")
     @@ script/update-docs.rb: def expand_l10n(path, content, get_f_conten=
t, categories)
      end

    @@ script/update-docs.rb: def index_doc(filter_tags, doc_list, get_con=
tent)
              next if doc_limit && path !~ /#{doc_limit}/

     -        file =3D DocFile.where(name: docname).first_or_create
    -+        doc_path =3D "#{SITE_ROOT}content/docs/#{docname}"
    ++        doc_path =3D "#{SITE_ROOT}external/docs/content/docs/#{docna=
me}"

              puts "   build: #{docname}"

    @@ script/update-docs.rb: def index_doc(filter_tags, doc_list, get_con=
tent)
     +
     +        FileUtils.mkdir_p(doc_path)
     +        File.open("#{doc_path}/#{tagname}.html", "w") do |out|
    -+          out.write("#{front_matter.to_yaml}\n---\n", out)
    ++          out.write(wrap_front_matter(front_matter))
     +          out.write(html, out)
     +        end

    @@ script/update-docs.rb: def index_doc(filter_tags, doc_list, get_con=
tent)
     +          FileUtils.mkdir_p(File.dirname(doc_path))
     +          File.open("#{doc_path}.html", "w") do |out|
     +            front_matter["aliases"] =3D ["/docs/#{docname}/index.htm=
l"]
    -+            out.write("#{front_matter.to_yaml}\n---\n")
    ++            out.write(wrap_front_matter(front_matter))
     +            out.write(html)
     +          end
     +        end
    @@ script/update-docs.rb: def index_doc(filter_tags, doc_list, get_con=
tent)
     -    Rails.cache.write("latest-version", Version.latest_version.name)
     +    data["latest-version"] =3D tagname
     +  end
    ++
    ++  front_matter =3D {
    ++    "section" =3D> "documentation",
    ++    "subsection" =3D> "reference",
    ++    "title" =3D> "Git - Reference",
    ++    "url" =3D> "/docs.html",
    ++    "aliases" =3D> ["/docs/index.html"]
    ++  }
    ++
    ++  File.open(DOCS_INDEX_FILE, "w") do |out|
    ++    out.write(wrap_front_matter(front_matter))
    ++  end
    ++
     +  File.open(DATA_FILE, "w") do |out|
     +    YAML.dump(data, out)
        end
103:  e34a4915b =3D 102:  c7eb81c73 Highlight the `Reference` nav item for=
 manual pages
104:  42a90c22a ! 103:  5d5bfe56a update-docs: install redirects for the v=
arious versions
    @@ script/update-docs.rb: def index_doc(filter_tags, doc_list, get_con=
tent)

              FileUtils.mkdir_p(doc_path)
     -        File.open("#{doc_path}/#{tagname}.html", "w") do |out|
    --          out.write("#{front_matter.to_yaml}\n---\n", out)
    +-          out.write(wrap_front_matter(front_matter))
     -          out.write(html, out)
     +        front_matter_with_redirects =3D front_matter.clone
     +        front_matter_with_redirects["aliases"] =3D
    @@ script/update-docs.rb: def index_doc(filter_tags, doc_list, get_con=
tent)
     +            ["/docs/#{docname}/#{v}/index.html"]
     +          end
     +        File.open("#{doc_path}/#{doc_versions[changed_in]}.html", "w=
") do |out|
    -+          out.write("#{front_matter_with_redirects.to_yaml}\n---\n")
    ++          out.write(wrap_front_matter(front_matter_with_redirects))
     +          out.write(html)
              end

105:  6a68ca809 ! 104:  1fc1b2d4b Show the different versions of the manua=
l pages
    @@ script/update-docs.rb: def index_doc(filter_tags, doc_list, get_con=
tent)
     -            anchor +=3D "-1" while ids.include?(anchor)
     -            ids.add(anchor)
     -            "<dt class=3D\"hdlist1\" id=3D\"#{anchor}\"> <a class=3D=
\"anchor\" href=3D\"##{anchor}\"></a>#{$1} </dt>"
    -+        if !File.exists?("#{SITE_ROOT}_generated-asciidoc/#{asciidoc=
_sha}")
    -+          FileUtils.mkdir_p("#{SITE_ROOT}_generated-asciidoc")
    -+          File.open("#{SITE_ROOT}_generated-asciidoc/#{asciidoc_sha}=
", "w") do |out|
    ++        if !File.exists?("#{SITE_ROOT}external/docs/asciidoc/#{ascii=
doc_sha}")
    ++          FileUtils.mkdir_p("#{SITE_ROOT}external/docs/asciidoc")
    ++          File.open("#{SITE_ROOT}external/docs/asciidoc/#{asciidoc_s=
ha}", "w") do |out|
     +            out.write(content)
                end
              end
    @@ script/update-docs.rb: def index_doc(filter_tags, doc_list, get_con=
tent)
     +            page_data["diff-cache"] =3D {} if !page_data["diff-cache=
"]
     +            cached_diff =3D page_data["diff-cache"]["#{pre_sha}..#{p=
ost_sha}"]
     +            if !cached_diff
    -+              pre_content =3D File.read("#{SITE_ROOT}_generated-asci=
idoc/#{pre_sha}")
    -+              post_content =3D File.read("#{SITE_ROOT}_generated-asc=
iidoc/#{post_sha}")
    ++              pre_content =3D File.read("#{SITE_ROOT}external/docs/a=
sciidoc/#{pre_sha}")
    ++              post_content =3D File.read("#{SITE_ROOT}external/docs/=
asciidoc/#{post_sha}")
     +              cached_diff =3D page_data["diff-cache"]["#{pre_sha}..#=
{post_sha}"] =3D diff(pre_content, post_content)
     +            end
     +            page_versions.unshift({
    @@ script/update-docs.rb: def index_doc(filter_tags, doc_list, get_con=
tent)
     -    data["latest-version"] =3D tagname
     +    data["latest-version"] =3D version if !data["latest-version"] ||=
 Version.version_to_num(data["latest-version"]) < Version.version_to_num(v=
ersion)
        end
    -   File.open(DATA_FILE, "w") do |out|
    -     YAML.dump(data, out)
    +
    +   front_matter =3D {
106:  1ab0c772b ! 105:  9953afacd search: exclude older manual page versio=
ns
    @@ layouts/_default/baseof.html

     -          <div id=3D"main" data-pagefind-body>
     +          <!-- older manual page versions are less interesting and n=
eed to be excluded from the search -->
    -+          {{ $include_in_search :=3D (or (not (isset .Params "docnam=
e")) (isset .Params "latest-changes")) }}
    ++          {{ $include_in_search :=3D (or (not (isset .Params "docnam=
e")) (isset .Params "latest-changes") (isset .Params "lang")) }}
     +          <div id=3D"main"{{ if $include_in_search }} data-pagefind-=
body{{ end }}>
                  {{ .Content }}
                </div>
    @@ script/update-docs.rb: def index_doc(filter_tags, doc_list, get_con=
tent)
                File.open("#{doc_path}.html", "w") do |out|
     +            front_matter["latest-changes"] =3D version
                  front_matter["aliases"] =3D ["/docs/#{docname}/index.htm=
l"]
    -             out.write("#{front_matter.to_yaml}\n---\n")
    +             out.write(wrap_front_matter(front_matter))
                  out.write(html)
107:  c1948441b ! 106:  ec44e3010 search: offer the section as a filter
    @@ layouts/_default/baseof.html
     @@

                <!-- older manual page versions are less interesting and n=
eed to be excluded from the search -->
    -           {{ $include_in_search :=3D (or (not (isset .Params "docnam=
e")) (isset .Params "latest-changes")) }}
    +           {{ $include_in_search :=3D (or (not (isset .Params "docnam=
e")) (isset .Params "latest-changes") (isset .Params "lang")) }}
     -          <div id=3D"main"{{ if $include_in_search }} data-pagefind-=
body{{ end }}>
     +          <div id=3D"main"{{ if $include_in_search }} data-pagefind-=
filter=3D"category:{{ $section }}" data-pagefind-body{{ end }}>
                  {{ .Content }}
    @@ layouts/_default/baseof.html
              {{ partial "sidebar.html" . }}
     -        <div id=3D"content" data-pagefind-body>
     +        <div id=3D"content" data-pagefind-filter=3D"category:{{ $sec=
tion }}" data-pagefind-body>
    -           {{ if isset .Params "video_title" }}
    - 	    <div id=3D"main">
    -               <h1>{{ .Params.category }} Episode {{ .Params.episode =
}}</h1>
    +           {{ if (eq .Page.Path "/docs") }}
    +             {{ partial "ref/index.html" . }}
    +           {{ else if isset .Params "video_title" }}
108:  ad3768be5 <   -:  --------- search: give the manual pages' titles ma=
ximal weight
  -:  --------- > 107:  5e6f328ce search: give the manual pages' titles ma=
ximal weight
109:  05a15df77 ! 108:  25906cd41 search: reintroduce the categories in th=
e live search
    @@ Commit message
         We do this by specifically adding metadata indicating the categor=
y of
         manual pages as well as for the sections of the book (for details=
, see
         https://pagefind.app/docs/metadata/). Then, we use that informati=
on to
    -    sort the results as they arrive into the correct table row (and
    -    displaying it when necessary, as the empty rows are initially hid=
den).
    +    sort the results into the correct table row. Due to the `async` n=
ature
    +    of the search results coming in, we need to be
    +    careful to process them in order when doing that.

         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

    @@ layouts/_default/baseof.html
                    2nd Edition
                  </span>
                </div>
    --          <div id=3D"main" data-pagefind-filter=3D"category:{{ $sect=
ion }}" data-pagefind-body class=3D"book edition2">
    -+          <div id=3D"main" data-pagefind-filter=3D"category:{{ $sect=
ion }}" data-pagefind-meta=3D"category:Book" data-pagefind-body class=3D"b=
ook edition2">
    +-          <div id=3D"main" data-pagefind-filter=3D"category:{{ $sect=
ion }}" data-pagefind-weight=3D"0.05" data-pagefind-body class=3D"book edi=
tion2">
    ++          <div id=3D"main" data-pagefind-filter=3D"category:{{ $sect=
ion }}" data-pagefind-meta=3D"category:Book" data-pagefind-weight=3D"0.05"=
 data-pagefind-body class=3D"book edition2">
                  <h1>{{ .Params.book.section.cs_number }} {{ .Params.book=
.chapter.title }} - {{ .Params.book.section.title }}</h1>
                  <div>
                    {{ .Content }}
     @@

                <!-- older manual page versions are less interesting and n=
eed to be excluded from the search -->
    -           {{ $include_in_search :=3D (or (not (isset .Params "docnam=
e")) (isset .Params "latest-changes")) }}
    --          <div id=3D"main"{{ if $include_in_search }} data-pagefind-=
filter=3D"category:{{ $section }}" data-pagefind-body{{ end }}>
    -+          <div id=3D"main"{{ if $include_in_search }} data-pagefind-=
filter=3D"category:{{ $section }}" data-pagefind-meta=3D"category:Referenc=
e" data-pagefind-body{{ end }}>
    -             {{ safe.HTML (replaceRE "(?s:>NAME</h2>.*?<p)" "$0 data-=
pagefind-weight=3D\"7\"" .Content) }}
    -           </div>
    -         </div>
    +           {{ $include_in_search :=3D (or (not (isset .Params "docnam=
e")) (isset .Params "latest-changes") (isset .Params "lang")) }}
    +-          <div id=3D"main"{{ if $include_in_search }} data-pagefind-=
filter=3D"category:{{ $section }}" data-pagefind-weight=3D"0.05" data-page=
find-body{{ end }}>
    ++          <div id=3D"main"{{ if $include_in_search }} data-pagefind-=
filter=3D"category:{{ $section }}" data-pagefind-meta=3D"category:Referenc=
e" data-pagefind-weight=3D"0.05" data-pagefind-body{{ end }}>
    +             {{ .Content }}
    +             {{ $match :=3D findRESubmatch "(?s)>NAME</h2>.*?<p[^>]*>=
(git-)?([^ ]+)" .Content 1 }}
    +             {{ if (eq ($match | len) 1) }}

      ## static/js/application.js ##
     @@ static/js/application.js: var Search =3D {
    @@ static/js/application.js: var Search =3D {
     +
                const chunkLength =3D 10;
                let displayCount =3D 0;
    ++
    ++          const categorizeResult =3D (i) =3D> {
    ++            while (i < displayCount && typeof results.results[i].dat=
a =3D=3D=3D 'object') {
    ++              const result =3D results.results[i++];
    ++              if (result.data.meta.category =3D=3D=3D 'Reference') {
    ++                if (ulReference.children().length =3D=3D=3D 0) ulRef=
erence.parent().parent().css("display", "table-row")
    ++                ulReference.append(result.li)
    ++              } else if (result.data.meta.category =3D=3D=3D 'Book')=
 {
    ++                if (ulBook.children().length =3D=3D=3D 0) ulBook.par=
ent().parent().css("display", "table-row")
    ++                ulBook.append(result.li)
    ++              }
    ++            }
    ++          };
    ++
                const loadResultsChunk =3D () =3D> {
    -@@ static/js/application.js: var Search =3D {
    +             if (loadButton.loading || displayCount >=3D results.resu=
lts.length) return;
    +
    +             loadButton.loading =3D true;
    +             const n =3D displayCount + chunkLength;
    +             while (displayCount < n) {
    +-              const li =3D $("<li><a>&hellip;</a></li>");
    +-              li.insertBefore(loadButton);
    ++              const result =3D results.results[displayCount]
    ++              result.li =3D $("<li><a>&hellip;</a></li>");
    ++              result.li.insertBefore(loadButton);
    +
                    // load the result lazily
    -               (async () =3D> {
    -                 const result =3D await results.results[displayCount]=
.data();
    -+                if (result.meta.category =3D=3D=3D 'Reference') {
    -+                  if (ulReference.children().length =3D=3D=3D 0) ulR=
eference.parent().parent().css("display", "table-row")
    -+                  ulReference.append(li)
    -+                } else if (result.meta.category =3D=3D=3D 'Book') {
    -+                  if (ulBook.children().length =3D=3D=3D 0) ulBook.p=
arent().parent().css("display", "table-row")
    -+                  ulBook.append(li)
    -+                }
    -                 li.html(`<a href =3D "${result.url}">${result.meta.t=
itle}</a>`);
    -               })().catch(console.log);
    +-              (async () =3D> {
    +-                const result =3D await results.results[displayCount]=
.data();
    +-                li.html(`<a href =3D "${result.url}">${result.meta.t=
itle}</a>`);
    +-              })().catch(console.log);
    ++              (async (i) =3D> {
    ++                result.data =3D await results.results[displayCount].=
data();
    ++                if (!i || typeof results.results[i - 1].data =3D=3D=
=3D 'object') categorizeResult(i);
    ++                result.li.html(`<a href =3D "${result.data.url}">${r=
esult.data.meta.title}</a>`);
    ++              })(displayCount).catch((err) =3D> {
    ++                console.log(err);
    ++                result.li.html(`<i>Error loading result</i>`);
    ++              });

    +               if (++displayCount >=3D results.results.length) {
    +                 loadButton.remove();
110:  49f58f182 <   -:  --------- search: show manual pages' short title i=
n the live search
  -:  --------- > 109:  4f239bc08 search: show manual pages' short title i=
n the live search
  -:  --------- > 110:  347830d09 search: link to "pretty" URLs
111:  6fc0f8e9e =3D 111:  cb68f3611 docs: handle multiple `linkgit:` in th=
e same line
112:  1f9dc5079 =3D 112:  687183039 docs: correctly handle `{litdd}` in `l=
inkgit` values
113:  44dca56fe =3D 113:  2b061bf40 docs: handle `gitlink:` gracfully
114:  702ce1711 =3D 114:  149872c37 docs: handle double colon in `linkgit:=
:` gracefully
115:  26a84723f =3D 115:  25d0d5463 docs: handle `linkgit:curl[1]` gracefu=
lly
116:  9cb3ff53a =3D 116:  187843aba Allow `redirect_to` with fully-qualifi=
ed URLs
117:  412391840 ! 117:  f20b1c76d docs: add fall-back redirects for unrend=
ered pages
    @@ script/update-docs.rb: def index_doc(filter_tags, doc_list, get_con=
tent)
     +      # that are not populated. Let's redirect to the source files i=
n the
     +      # git/git repository.
     +      check_paths.each do |path|
    -+        doc_path =3D "#{SITE_ROOT}content/#{path}.html"
    ++        doc_path =3D "#{SITE_ROOT}external/docs/content/#{path}.html=
"
     +        if !File.exists?(doc_path)
     +          type =3D 'blob'
     +          target =3D path.sub(/^docs\//, '')
    @@ script/update-docs.rb: def index_doc(filter_tags, doc_list, get_con=
tent)
     +          front_matter =3D { "redirect_to" =3D> "https://github.com/=
git/git/#{type}/HEAD/Documentation/#{target}" } # ltrim `docs/`
     +          FileUtils.mkdir_p(File.dirname(doc_path))
     +          File.open(doc_path, "w") do |out|
    -+            out.write("#{front_matter.to_yaml}\n---\n")
    ++            out.write(wrap_front_matter(front_matter))
     +          end
     +        end
     +      end
118:  55c7b5f48 ! 118:  fcbfb1f1d docs: work around a `link:` bug in older=
 versions
    @@ Metadata
     Author: Johannes Schindelin <johannes.schindelin@gmx.de>

      ## Commit message ##
    -    docs: work around a `link:` bug in older versions
    +    docs: work around `link:`/`linkgit:` bugs in older versions

         Since we want to build older Git versions' manual pages, too, we =
have to
         work around bugs since fixed.
    @@ script/update-docs.rb: def index_doc(filter_tags, doc_list, get_con=
tent)
     +        # Handle erroneous `link:api-trace2.txt`, see 4945f046c7f5 (=
api docs:
     +        # link to html version of api-trace2, 2022-09-16)
     +        content.gsub!(/link:api-trace2.txt/, 'link:api-trace2.html')
    ++	# Handle `linkgit:git-config.txt` mistake, fixed in ad52148a7d0
    ++	# (Documentation: fix broken linkgit to git-config, 2016-03-21)
    ++        content.gsub!(/linkgit:git-config.txt/, 'linkgit:git-config'=
)
              content.gsub!(/link:(?:technical\/)?(\S*?)\.html(\#\S*?)?\[(=
.*?)\]/m, "link:/docs/\\1\\2[\\3]")

              asciidoc =3D make_asciidoc(content)
119:  a7344a9d2 ! 119:  5b1d692eb Migrate the translated manual pages to t=
he Hugo world
    @@ layouts/_default/baseof.html
              <div id=3D"content">
                <div id=3D'reference-version'>
     +            {{ partial "ref/languages.html" . }}
    -+            {{ partialCached "ref/topics.html" . }}
    ++            {{ partial "ref/topics.html" . }}
                  {{ partial "ref/versions.html" . }}
                </div>

    @@ script/update-docs.rb: def index_l10n_doc(filter_tags, doc_list, ge=
t_content)
            path =3D File.basename(full_path, ".txt")

     -      file =3D DocFile.where(name: path).first_or_create
    -+      doc_path =3D "#{SITE_ROOT}content/docs/#{path}"
    ++      doc_path =3D "#{SITE_ROOT}external/docs/content/docs/#{path}"

            puts "   build: #{path} for #{lang}"

    @@ script/update-docs.rb: def index_l10n_doc(filter_tags, doc_list, ge=
t_content)
     -        html.gsub!(/linkgit:(\S+?)\[(\d+)\]/) do |line|
     -          x =3D /^linkgit:(\S+?)\[(\d+)\]/.match(line)
     -          "<a href=3D'/docs/#{x[1].gsub(/&#x2d;/, '-')}/#{lang}'>#{x=
[1]}[#{x[2]}]</a>"
    -+      if !File.exists?("#{SITE_ROOT}_generated-asciidoc/#{asciidoc_s=
ha}")
    -+        FileUtils.mkdir_p("#{SITE_ROOT}_generated-asciidoc")
    -+        File.open("#{SITE_ROOT}_generated-asciidoc/#{asciidoc_sha}",=
 "w") do |out|
    ++      if !File.exists?("#{SITE_ROOT}external/docs/asciidoc/#{asciido=
c_sha}")
    ++        FileUtils.mkdir_p("#{SITE_ROOT}external/docs/asciidoc")
    ++        File.open("#{SITE_ROOT}external/docs/asciidoc/#{asciidoc_sha=
}", "w") do |out|
     +          out.write(content)
              end
     -        # HTML anchor on hdlist1 (i.e. command options)
    @@ script/update-docs.rb: def index_l10n_doc(filter_tags, doc_list, ge=
t_content)
     +
     +      FileUtils.mkdir_p(doc_path)
     +      File.open("#{doc_path}/#{lang}.html", "w") do |out|
    -+        out.write("#{front_matter.to_yaml}\n---\n")
    ++        out.write(wrap_front_matter(front_matter))
     +        out.write(html)
     +      end
     +
120:  dd2d5016c =3D 120:  b88d2bef6 docs(zh_HANS-CN): a trailing "full sto=
p" character is not part of a URL
121:  9c93bfdec <   -:  --------- redirect_to: keep the anchor, if any was=
 specified
  -:  --------- > 121:  968e6e25b redirect_to/aliases: keep the anchor, if=
 any was specified
122:  6ef6dbe2f ! 122:  f2e7a5ffa docs(translated): add redirects for miss=
ing files
    @@ script/update-docs.rb: def index_l10n_doc(filter_tags, doc_list, ge=
t_content)
     +      end
            asciidoc =3D make_asciidoc(content)
            asciidoc_sha =3D Digest::SHA1.hexdigest(asciidoc.source)
    -       if !File.exists?("#{SITE_ROOT}_generated-asciidoc/#{asciidoc_s=
ha}")
    +       if !File.exists?("#{SITE_ROOT}external/docs/asciidoc/#{asciido=
c_sha}")
     @@ script/update-docs.rb: def index_l10n_doc(filter_tags, doc_list, g=
et_content)
            html.gsub!(/linkgit:(\S+?)\[(\d+)\]/) do |line|
              x =3D /^linkgit:(\S+?)\[(\d+)\]/.match(line)
    @@ script/update-docs.rb: def index_l10n_doc(filter_tags, doc_list, ge=
t_content)
     +    # translated manual pages may point to other translated manual p=
ages that do
     +    # not exist. In these cases, redirect to the English version.
     +    check_paths.each do |path|
    -+      doc_path =3D "#{SITE_ROOT}content/#{path}.html"
    ++      doc_path =3D "#{SITE_ROOT}external/docs/content/#{path}.html"
     +      if !File.exists?(doc_path)
     +        front_matter =3D { "redirect_to" =3D> "#{path.sub(/\/[^\/]*$=
/, '')}" } # rtrim `/<lang>`
     +        FileUtils.mkdir_p(File.dirname(doc_path))
     +        File.open(doc_path, "w") do |out|
    -+          out.write("#{front_matter.to_yaml}\n---\n")
    ++          out.write(wrap_front_matter(front_matter))
     +        end
     +      end
     +    end
123:  e7e038a32 ! 123:  19d453f94 ci: update the books via a GitHub workfl=
ow
    @@ Commit message
         This information is then used by a scheduled workflow to determin=
e what
         needs to be updated (if anything) and then performing that task.

    +    When GitHub workflows push new changes, they cannot trigger other=
 GitHub
    +    workflows (to avoid infinite loops). Therefore, this new GitHub w=
orkflow
    +    not only synchronizes the books, but also builds the site and dep=
loys
    +    it.
    +
    +    Note: The code to build the site and to deploy it is provided in =
a
    +    custom Action, to make it reusable. It will come in handy over th=
e next
    +    commits, where other GitHub workflows are added that likewise nee=
d
    +    to synchronize changes that desire a site rebuild & deployment.
    +
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

      ## .github/actions/deploy-to-github-pages/action.yml (new) ##
    @@ .github/actions/deploy-to-github-pages/action.yml (new)
     +
     +    - name: setup GitHub Pages
     +      id: pages
    -+      uses: actions/configure-pages@v3
    ++      uses: actions/configure-pages@v5
     +
    -+    - name: install Hugo
    -+      env:
    -+        HUGO_VERSION: 0.120.3
    ++    - name: configure Hugo and Pagefind version
    ++      shell: bash
    ++      run: |
    ++        set -x &&
    ++        echo "HUGO_VERSION=3D$(sed -n 's/^ *hugo_version: *//p' <hug=
o.yml)" >>$GITHUB_ENV
    ++        echo "PAGEFIND_VERSION=3D$(sed -n 's/^ *pagefind_version: */=
/p' <hugo.yml)" >>$GITHUB_ENV
    ++
    ++    - name: install Hugo ${{ env.HUGO_VERSION }}
     +      shell: bash
     +      run: |
     +        set -x &&
    @@ .github/actions/deploy-to-github-pages/action.yml (new)
     +      env:
     +        HUGO_RELATIVEURLS: false
     +      shell: bash
    -+      run: hugo --minify --baseURL "${{ steps.pages.outputs.base_url=
 }}/"
    ++      run: hugo config && hugo --minify --baseURL "${{ steps.pages.o=
utputs.base_url }}/"
     +
    -+    - name: run Pagefind to build the search index
    ++    - name: run Pagefind ${{ env.PAGEFIND_VERSION }} to build the se=
arch index
     +      shell: bash
    -+      run: npx -y pagefind --site public
    ++      run: npx -y pagefind@${{ env.PAGEFIND_VERSION }} --site public
     +
     +    - name: upload GitHub Pages artifact
    -+      uses: actions/upload-pages-artifact@v2
    ++      uses: actions/upload-pages-artifact@v3
     +      with:
     +        path: ./public
     +
     +    - name: deploy
     +      id: deploy
    -+      uses: actions/deploy-pages@v2
    ++      uses: actions/deploy-pages@v4

      ## .github/workflows/update-book.yml (new) ##
     @@
    @@ .github/workflows/update-book.yml (new)
     +  check-for-updates:
     +    runs-on: ubuntu-latest
     +    steps:
    -+      - uses: actions/checkout@v3
    ++      - uses: actions/checkout@v4
     +        with:
     +          sparse-checkout: |
    -+            _sync_state
    ++            external/book/sync
     +            script
    -+      - uses: actions/github-script@v6
    ++      - uses: actions/github-script@v7
     +        id: get-pending
     +        with:
     +          script: |
    @@ .github/workflows/update-book.yml (new)
     +        language: ${{ fromJson(needs.check-for-updates.outputs.matri=
x) }}
     +      fail-fast: false
     +    steps:
    -+      - uses: actions/checkout@v3
    ++      - uses: actions/checkout@v4
     +        with:
     +          sparse-checkout: |
    -+            _sync_state
     +            script
    -+            data
    -+            content/book/${{ matrix.language.lang }}
    -+            static/book/${{ matrix.language.lang }}
    ++            external/book/sync
    ++            external/book/data
    ++            external/book/content/book/${{ matrix.language.lang }}
    ++            external/book/static/book/${{ matrix.language.lang }}
     +      - name: clone ${{ matrix.language.repository }}
     +        run: |
     +          printf '%s\n' /progit-clone/ /vendor >>.git/info/exclude &=
&
    @@ .github/workflows/update-book.yml (new)
     +      - name: commit changes
     +        run: |
     +          # record the commit hash
    -+          mkdir -p _sync_state &&
    -+          git -C progit-clone rev-parse HEAD >_sync_state/book-${{ m=
atrix.language.lang }}.sha &&
    ++          mkdir -p external/book/sync &&
    ++          git -C progit-clone rev-parse HEAD >external/book/sync/boo=
k-${{ matrix.language.lang }}.sha &&
     +
     +          # commit it all
    -+          git add -A \
    -+            _sync_state \
    -+            data/book-${{ matrix.language.lang }}.yml \
    -+            content/book &&
    -+          # there might be images
    -+          if test -d static/book
    -+          then
    -+            git add -A static/book
    -+          fi &&
    ++          git add -A external/book &&
     +          git -c user.name=3D${{ github.actor }} \
     +            -c user.email=3D${{ github.actor }}@noreply.github.com \
     +            commit -m 'book: update ${{ matrix.language.lang }}' \
    @@ .github/workflows/update-book.yml (new)
     +        run: |
     +          git branch -m book-${{ matrix.language.lang }}
     +          git bundle create ${{ matrix.language.lang }}.bundle refs/=
remotes/origin/${{ github.ref_name }}..book-${{ matrix.language.lang }}
    -+      - uses: actions/upload-artifact@v3
    ++      - uses: actions/upload-artifact@v4
     +        with:
     +          name: bundle-${{ matrix.language.lang }}
     +          path: ${{ matrix.language.lang }}.bundle
    @@ .github/workflows/update-book.yml (new)
     +      url: ${{ steps.deploy.outputs.url }}
     +    runs-on: ubuntu-latest
     +    steps:
    -+      - uses: actions/checkout@v3
    -+      - uses: actions/download-artifact@v3
    ++      - uses: actions/checkout@v4
    ++      - uses: actions/download-artifact@v4
     +      - name: apply updates
     +        id: apply
     +        run: |
    @@ .github/workflows/update-book.yml (new)
     +        id: deploy
     +        uses: ./.github/actions/deploy-to-github-pages

    - ## _sync_state/.gitignore (new) ##
    -
      ## script/ci-helper.js (new) ##
     @@
     +const fs =3D require('fs')
    @@ script/ci-helper.js (new)
     +  const result =3D []
     +  for (const lang of Object.keys(books)) {
     +    try {
    -+      const localSha =3D await getFileContents(`_sync_state/book-${l=
ang}.sha`)
    ++      const localSha =3D await getFileContents(`external/book/sync/b=
ook-${lang}.sha`)
     +
     +      const [owner, repo] =3D books[lang].split('/')
     +      const { data: { default_branch: remoteDefaultBranch } } =3D
124:  c7c4d347d ! 124:  1ace765fc Update the download data via a GitHub wo=
rkflow
    @@ .github/workflows/update-download-data.yml (new)
     +      name: github-pages
     +      url: ${{ steps.deploy.outputs.url }}
     +    steps:
    -+      - uses: actions/checkout@v3
    ++      - uses: actions/checkout@v4
     +        with:
     +          sparse-checkout: |
     +            .github/actions
    -+            _sync_state
     +            script
     +      - name: ruby setup
     +        uses: ruby/setup-ruby@v1
    @@ .github/workflows/update-download-data.yml (new)
     +          git \
     +            -c user.name=3D${{ github.actor }} \
     +            -c user.email=3D${{ github.actor }}@noreply.github.com \
    -+            commit -m "$commit_message" -- hugo.yml
    ++            commit -m "$commit_message" \
    ++              -m 'Updated via the `update-download-data.yml` GitHub =
workflow.' \
    ++              -- hugo.yml
     +      - name: verify that there are no uncommitted changes
     +        run: |
     +          git update-index --refresh &&
125:  3bd0e53a3 ! 125:  775c1d220 update-book: allow force-rebuilding
    @@ .github/workflows/update-book.yml: jobs:
                  const { getPendingBookUpdates } =3D require('./script/ci=
-helper.js')

     -            const pending =3D await getPendingBookUpdates(github)
    -+            const pending =3D await getPendingBookUpdates(github, ${=
{ inputs.force-rebuild }})
    ++            const pending =3D await getPendingBookUpdates(github, ${=
{ inputs.force-rebuild =3D=3D true }})
                  // an empty matrix is invalid and makes the workflow run=
 fail, unfortunately
                  return pending.length ? pending : ['']
            - name: ruby setup
    @@ script/ci-helper.js: const getAllBooks =3D async () =3D> {
        const result =3D []
        for (const lang of Object.keys(books)) {
     -    try {
    --      const localSha =3D await getFileContents(`_sync_state/book-${l=
ang}.sha`)
    +-      const localSha =3D await getFileContents(`external/book/sync/b=
ook-${lang}.sha`)
     +    if (!forceRebuild) {
     +      try {
    -+        const localSha =3D await getFileContents(`_sync_state/book-$=
{lang}.sha`)
    ++        const localSha =3D await getFileContents(`external/book/sync=
/book-${lang}.sha`)

     -      const [owner, repo] =3D books[lang].split('/')
     -      const { data: { default_branch: remoteDefaultBranch } } =3D
126:  835105745 ! 126:  2193295a0 Add a workflow to update the Git version=
 and manual pages
    @@ .github/workflows/update-git-version-and-manual-pages.yml (new)
     +      name: github-pages
     +      url: ${{ steps.deploy.outputs.url }}
     +    steps:
    -+      - uses: actions/checkout@v3
    ++      - uses: actions/checkout@v4
     +        with:
     +          sparse-checkout: |
     +            .github/actions
    -+            _sync_state
     +            script
     +      - name: ruby setup
     +        uses: ruby/setup-ruby@v1
    @@ .github/workflows/update-git-version-and-manual-pages.yml (new)
     +          git \
     +            -c user.name=3D${{ github.actor }} \
     +            -c user.email=3D${{ github.actor }}@noreply.github.com \
    -+            commit -m "Update git-version ($version)" -- hugo.yml
    ++            commit -m "Update git-version ($version)" \
    ++              -m 'Updated via the `update-git-version-and-manual-pag=
es.yml` GitHub workflow.' \
    ++              -- hugo.yml
     +      - name: prepare worktree
     +        if: steps.commit.outputs.result !=3D ''
     +        run: git sparse-checkout disable
    @@ .github/workflows/update-git-version-and-manual-pages.yml (new)
     +      - name: commit manual pages
     +        if: steps.commit.outputs.result !=3D ''
     +        run: |
    -+          git add -A _generated-asciidoc data/docs.yml content/docs =
&&
    ++          git add -A external/docs &&
     +          git \
     +            -c user.name=3D${{ github.actor }} \
     +            -c user.email=3D${{ github.actor }}@noreply.github.com \
    -+            commit -m "Update manual pages (${{ steps.commit.outputs=
.result }})"
    ++            commit -m "Update manual pages (${{ steps.commit.outputs=
.result }})" \
    ++              -m 'Updated via the `update-git-version-and-manual-pag=
es.yml` GitHub workflow.'
     +      - name: verify that there are no uncommitted changes
     +        run: |
     +          git update-index --refresh &&
127:  15a7705ad ! 127:  93af22a96 update-manual-pages: optionally force a =
complete rebuild
    @@ .github/workflows/update-git-version-and-manual-pages.yml: name: Sy=
nchronize wit
          # check daily for updates
          - cron: '37 17 * * *'
     @@ .github/workflows/update-git-version-and-manual-pages.yml: jobs:
    -             -c user.email=3D${{ github.actor }}@noreply.github.com \
    -             commit -m "Update git-version ($version)" -- hugo.yml
    +               -m 'Updated via the `update-git-version-and-manual-pag=
es.yml` GitHub workflow.' \
    +               -- hugo.yml
            - name: prepare worktree
     -        if: steps.commit.outputs.result !=3D ''
    -+        if: steps.commit.outputs.result !=3D '' || inputs.force-rebu=
ild
    ++        if: steps.commit.outputs.result !=3D '' || inputs.force-rebu=
ild =3D=3D true
              run: git sparse-checkout disable
            - name: clone git.git
     -        if: steps.commit.outputs.result !=3D ''
    -+        if: steps.commit.outputs.result !=3D '' || inputs.force-rebu=
ild
    ++        if: steps.commit.outputs.result !=3D '' || inputs.force-rebu=
ild =3D=3D true
              run: git clone --bare https://github.com/git/git '${{ runner=
.temp }}/git'
            - name: update manual pages
     -        if: steps.commit.outputs.result !=3D ''
     -        run: bundle exec ruby script/update-docs.rb '${{ runner.temp=
 }}/git' en
    -+        if: steps.commit.outputs.result !=3D '' || inputs.force-rebu=
ild
    ++        if: steps.commit.outputs.result !=3D '' || inputs.force-rebu=
ild =3D=3D true
     +        run: |
    -+          test false =3D '${{ inputs.force-rebuild }}' || export RER=
UN=3Dtrue
    ++          if test true =3D '${{ inputs.force-rebuild }}'
    ++          then
    ++            export RERUN=3Dtrue
    ++          fi
     +          bundle exec ruby script/update-docs.rb '${{ runner.temp }}=
/git' en
            - name: commit manual pages
     -        if: steps.commit.outputs.result !=3D ''
     +        id: manual-pages
    -+        if: steps.commit.outputs.result !=3D '' || inputs.force-rebu=
ild
    ++        if: steps.commit.outputs.result !=3D '' || inputs.force-rebu=
ild =3D=3D true
              run: |
    -           git add -A _generated-asciidoc data/docs.yml content/docs =
&&
    -+          if test false !=3D '${{ inputs.force-rebuild }}' && git di=
ff-index --cached --quiet HEAD --
    +           git add -A external/docs &&
    ++          if test true =3D '${{ inputs.force-rebuild }}' && git diff=
-index --cached --quiet HEAD --
     +          then
     +            echo '::notice::A manual pages rebuild was requested but=
 resulted in no changes' >&2
     +            exit 0
    @@ .github/workflows/update-git-version-and-manual-pages.yml: jobs:
                git \
                  -c user.name=3D${{ github.actor }} \
                  -c user.email=3D${{ github.actor }}@noreply.github.com \
    --            commit -m "Update manual pages (${{ steps.commit.outputs=
.result }})"
    -+            commit -m "Update manual pages (${version:-manually forc=
ed rebuild})" &&
    +-            commit -m "Update manual pages (${{ steps.commit.outputs=
.result }})" \
    +-              -m 'Updated via the `update-git-version-and-manual-pag=
es.yml` GitHub workflow.'
    ++            commit -m "Update manual pages (${version:-manually forc=
ed rebuild})" \
    ++              -m 'Updated via the `update-git-version-and-manual-pag=
es.yml` GitHub workflow.' &&
     +          echo "result=3Dmodified" >>$GITHUB_OUTPUT
            - name: verify that there are no uncommitted changes
              run: |
128:  21f13a6ef ! 128:  9ccb08bb2 Add a GitHub workflow to deploy `gh-page=
s` to GitHub Pages
    @@ .github/workflows/deploy.yml (new)
     +      name: github-pages
     +      url: ${{ steps.deploy.outputs.url }}
     +    steps:
    -+      - uses: actions/checkout@v3
    ++      - uses: actions/checkout@v4
     +      - name: deploy to GitHub Pages
     +        id: deploy
     +        uses: ./.github/actions/deploy-to-github-pages
129:  6a53852f0 ! 129:  ac51259a9 Add a GitHub workflow to update the tran=
slated manual pages regularly
    @@ .github/workflows/update-translated-manual-pages.yml (new)
     +  check-for-updates:
     +    runs-on: ubuntu-latest
     +    steps:
    -+      - uses: actions/checkout@v3
    ++      - uses: actions/checkout@v4
     +        with:
     +          sparse-checkout: |
    -+            _sync_state
    ++            external/docs/sync
     +            script
    -+      - uses: actions/github-script@v6
    ++      - uses: actions/github-script@v7
     +        id: get-pending
     +        with:
     +          script: |
    @@ .github/workflows/update-translated-manual-pages.yml (new)
     +      up-to-date: ${{ steps.get-pending.outputs.result }}
     +  update-translated-manual-pages:
     +    needs: [check-for-updates]
    -+    if: inputs.force-rebuild || needs.check-for-updates.outputs.up-t=
o-date =3D=3D 'false'
    ++    if: inputs.force-rebuild =3D=3D true || needs.check-for-updates.=
outputs.up-to-date =3D=3D 'false'
     +    runs-on: ubuntu-latest
     +    permissions:
     +      contents: write # to push changes (if any)
    @@ .github/workflows/update-translated-manual-pages.yml (new)
     +      name: github-pages
     +      url: ${{ steps.deploy.outputs.url }}
     +    steps:
    -+      - uses: actions/checkout@v3
    ++      - uses: actions/checkout@v4
     +      - name: ruby setup
     +        uses: ruby/setup-ruby@v1
     +        with:
    @@ .github/workflows/update-translated-manual-pages.yml (new)
     +        run: git clone --bare https://github.com/jnavila/git-html-l1=
0n '${{ runner.temp }}/git-html-l10n'
     +      - name: update translated manual pages
     +        run: |
    -+          test false =3D '${{ inputs.force-rebuild }}' || export RER=
UN=3Dtrue
    ++          if test true =3D '${{ inputs.force-rebuild }}'
    ++          then
    ++            export RERUN=3Dtrue
    ++          fi
     +          bundle exec ruby script/update-docs.rb '${{ runner.temp }}=
/git-html-l10n' l10n
     +      - name: commit translated manual pages
     +        id: manual-pages
     +        run: |
    -+          git -C '${{ runner.temp }}/git-html-l10n' rev-parse HEAD >=
_sync_state/git-html-l10n.sha &&
    -+          git add _sync_state/git-html-l10n.sha &&
    ++          mkdir -p external/docs/sync &&
    ++          git -C '${{ runner.temp }}/git-html-l10n' rev-parse HEAD >=
external/docs/sync/git-html-l10n.sha &&
    ++          git add external/docs/sync/git-html-l10n.sha &&
     +
    -+          git add -A _generated-asciidoc/ data/docs.yml content/docs=
 &&
    -+          if test false !=3D '${{ inputs.force-rebuild }}' && git di=
ff-index --cached --quiet HEAD --
    ++          git add -A external/docs &&
    ++          if test true =3D '${{ inputs.force-rebuild }}' && git diff=
-index --cached --quiet HEAD --
     +          then
     +            echo '::notice::Rebuild of the translated manual pages w=
as requested but resulted in no changes' >&2
     +            exit 0
    @@ .github/workflows/update-translated-manual-pages.yml (new)
     +          git \
     +            -c user.name=3D${{ github.actor }} \
     +            -c user.email=3D${{ github.actor }}@noreply.github.com \
    -+            commit -m "Update translated manual pages" &&
    ++            commit -m "Update translated manual pages" \
    ++              -m 'Updated via the `update-translated-manual-pages.ym=
l` GitHub workflow.' &&
     +          echo "result=3Dmodified" >>$GITHUB_OUTPUT
     +      - name: verify that there are no uncommitted changes
     +        run: |
    @@ script/ci-helper.js: const getPendingBookUpdates =3D async (octokit=
, forceRebuild)

     +const areTranslatedManualPagesUpToDate =3D async (octokit) =3D> {
     +  try {
    -+    const localSha =3D await getFileContents(`_sync_state/git-html-l=
10n.sha`)
    ++    const localSha =3D await getFileContents(`external/docs/sync/git=
-html-l10n.sha`)
     +
     +    const [owner, repo] =3D 'jnavila/git-html-l10n'.split('/')
     +    const { data: { default_branch: remoteDefaultBranch } } =3D
  -:  --------- > 130:  28b147af1 deploy: check for broken links
  -:  --------- > 131:  c9dae6afc deploy(linkcheck): deal with stray "seco=
ndary rate limits"
130:  bff0ab61c ! 132:  2b63bbb71 Adjust `ARCHITECTURE.md` to the Hugo rea=
lity
    @@ Commit message
         https://github.com/git/git-scm.com/issues/942.

         However, I aborted that migration when it turned out that Jekyll
    -    required 20 minutes to process the files while Hugo spent less th=
an half
    -    a minute on them.
    +    required 20 minutes to process the files while Hugo spent less th=
an
    +    half a minute on them.

         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

    @@ ARCHITECTURE.md
     +  - original content from this repository

        - community book content brought in from https://github.com/progit=
;
    -     see the `lib/tasks/book2.rake` file.
    -@@ ARCHITECTURE.md: The content is a mix of:
    -   - manpages from releases of the git project, imported and formatte=
d
    -     via asciidoctor; see the `lib/tasks/index.rake` task.
    +-    see the `lib/tasks/book2.rake` file.
    ++    see the `script/update-book2.rb` and `script/book.rb` files.

    -+To deploy to GitHub Pages, it is necessary to turn off the default s=
etting to
    -+"publish from a branch" and instead change the setting to "publish w=
ith a
    -+custom GitHub Actions workflow":
    -+https://docs.github.com/en/pages/getting-started-with-github-pages/c=
onfiguring-a-publishing-source-for-your-github-pages-site#publishing-with-=
a-custom-github-actions-workflow
    +-  - manpages from releases of the git project, imported and formatte=
d
    +-    via asciidoctor; see the `lib/tasks/index.rake` task.
    ++    The content is pre-rendered and tracked in the `external/book/` =
directory
    ++    tree.
    +
    ++  - manual pages from releases of the git project, imported and form=
atted via
    ++    AsciiDoctor, and translated versions of the manual pages from
    ++    https://github.com/jnavila/git-manpages-l10n/ (which itself cont=
ains
    ++    pre-rendered pages from https://github.com/jnavila/git-manpages-=
l10n/); see
    ++    the `script/update-docs.rb` file.

     -## Heroku
    -+## Non-static parts
    ++    The pre-rendered pages are tracked in the `external/docs/` direc=
tory tree.

     -The app itself is served by Heroku. The app name is `git-scm` (so yo=
u
     -can visit it directly as https://git-scm.herokuapp.com). The site is
     -owned by the git-scm.com team. If you want to be involved in managin=
g
     -uptime/deploys/etc, you'll need a Heroku account and request to be a=
dded
     -to that team.
    ++To deploy to GitHub Pages, it is necessary to turn off the default s=
etting to
    ++"publish from a branch" and instead change the setting to "publish w=
ith a
    ++custom GitHub Actions workflow":
    ++https://docs.github.com/en/pages/getting-started-with-github-pages/c=
onfiguring-a-publishing-source-for-your-github-pages-site#publishing-with-=
a-custom-github-actions-workflow
    ++With this change, the site can be tested in the fork by pushing to t=
he
    ++`gh-pages` branch (which will trigger the `deploy.yml` workflow) and=
 then
    ++navigating to https://git-scm.<user>.github.io/.
    +
    +-We use a few Heroku add-ons:
    ++## Non-static parts
    +
    +-  - Bonsai elasticsearch (see below)
     +While the site consists mostly of static content, there are a couple=
 of
     +parts that are sort of dynamic.

    --We use a few Heroku add-ons:
    +-  - Heroku Postgres as the database
     +The search is implemented client-side, via [Pagefind](https://pagefi=
nd.app/).

    --  - Bonsai elasticsearch (see below)
    +-  - Heroku Redis for rails caching
     +A few scheduled GitHub workflows keep the content up to date:

    --  - Heroku Postgres as the database
    +-  - Heroku scheduler for cron jobs
     +  - `update-git-version-and-manual-pages` and `update-download-data`=
 (pick
     +    up newly released git versions)

    --  - Heroku Redis for rails caching
    +-The nightly scheduled jobs are:
     +  - `update-translated-manual-pages` (fetch and format translated ma=
nual
     +    pages from the jnavila/git-html-l10n repository)

    --  - Heroku scheduler for cron jobs
    --
    --The nightly scheduled jobs are:
    --
     -  - `rake downloads` (pick up newly released git versions)
     -
     -  - `rake preindex` (pull in and format manpages for released git
    @@ ARCHITECTURE.md: The content is a mix of:
     -dyno. So we have Cloudflare sitting in front of it, aggressively cac=
hing
     -everything. That also should make the site faster to serve to region=
s
     -far away from Heroku's servers.
    +-
    +-The Cloudflare setup is mostly pretty simple:
     +These workflows are also marked as `workflow_dispatch`, i.e. they ca=
n be run
     +manually (e.g. to update the download links just after Git for Windo=
ws
     +published a new release).

    --The Cloudflare setup is mostly pretty simple:
    --
     - - they serve DNS for the whole domain (that's where they insert the=
 CDN
     -   magic)
     -
    @@ ARCHITECTURE.md: The content is a mix of:
     +`deploy` GitHub workflow.

     +Note that some of the formatting of manual pages and book content ha=
ppens
    -+when they are imported by the GitHub workflows. Therefore, after fix=
ing some
    -+formatting, these workflows may need the force-rebuild flag to be to=
ggled (see
    -+the individual workflows for details).
    ++when they are imported by the GitHub workflows. Therefore, whenever =
there are
    ++changes to the scripts/workflows/automation that affect formatting, =
these
    ++workflows may need to be triggered using the force-rebuild flag to b=
e toggled
    ++(see the individual workflows for details).

      ## DNS

    @@ ARCHITECTURE.md: The content is a mix of:

      Note that we own both git-scm.com and git-scm.org; the latter redire=
cts
      to the former.
    -@@ ARCHITECTURE.md: The site mostly just runs without intervention:

    -   - code merged to `main` is auto-deployed
    +-
    + ## Manual Intervention
    +
    + The site mostly just runs without intervention:
    +
    +-  - code merged to `main` is auto-deployed
    ++  - code merged to `gh-pages` is auto-deployed

     -  - new git versions are detected daily and manpages and download li=
nks
     +  - new git versions are detected daily and manual pages and downloa=
d links
    @@ ARCHITECTURE.md: The site mostly just runs without intervention:
     -    `lib/tasks/book2.rake`
     +    `script/book.rb`

    -   - forced re-imports of content (e.g., a formatting fix to imported
    +-  - forced re-imports of content (e.g., a formatting fix to imported
     -    manpages) must be triggered manually
    -+    manual pages) must be triggered manually with `force-rebuild` to=
ggled
    ++  - forced re-imports of content (e.g., when fixing formatting in th=
e
    ++    imported manual pages) must be triggered manually with `force-re=
build`
    ++    toggled
  -:  --------- > 133:  e91c406fa Add Playwright-based UI tests
  -:  --------- > 134:  a43cdff2c playwright: add a few platform-specific =
tests
  -:  --------- > 135:  f6b7ccd21 playwright: let the UI tests pass with t=
he Rails app
  -:  --------- > 136:  e7db6d766 playwright: add a regression test for th=
e `git remote renom` issue
  -:  --------- > 137:  87609ac77 playwright: add a GitHub workflow to run=
 the tests
  -:  --------- > 138:  5facfdaee playwright: auto-start a web server for =
the special URL localhost:5000
  -:  --------- > 139:  b54046816 playwright: verify that URLs with questi=
on marks work
  -:  --------- > 140:  4210b9bba ci: run the Playwright tests in every Pu=
ll Request
  -:  --------- > 141:  ffb957b5f ci: run the Playwright tests on every de=
ployment

Ciao,
Johannes

--8323328-1979516866-1726093221=:99--
