Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D78AC20706
	for <e@80x24.org>; Tue,  5 Jul 2016 19:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753893AbcGETxU (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 15:53:20 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37931 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbcGETxT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 15:53:19 -0400
Received: by mail-wm0-f54.google.com with SMTP id r201so166531191wme.1
        for <git@vger.kernel.org>; Tue, 05 Jul 2016 12:53:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e1mLXZNycAZtXRQARL+Z+pkqcC1Nr7xsRLw+OZUKFaQ=;
        b=b6GN5mkKFmfmAlSvupOhBXX15JTHRYLIZiVtx4DSFdBAbrPmuztU4A+yysYUVfyu4V
         mBQYW9lLE0OQu35mvkE6mmYvJEvW9a04l2b+MXcjg/exxyc9BtLRyDTiZqqd4DFtOmgw
         RdFJTmcziuJiwsRbOB2Io54FT/zjtbGNxYCyQfI/bvBOt3eGIEjY4c3wjRy7GbebOkLo
         CnQJ68uSE1yWA/GyRoMDwxzBFVBRyUOr0HxQahx6KAeEFYBWVbpOxDu8Sx8ZcXTXTQKV
         /DZQDxqKT8TJ537njIIy6rxZvfDDEZv0+1pHpFZT4DTjF5RtV7J+2T8T7X1+xZVJi74G
         v8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e1mLXZNycAZtXRQARL+Z+pkqcC1Nr7xsRLw+OZUKFaQ=;
        b=LIH4zkTddhEcpOBo0w8bvESNRJoJQIyz6seosgkgUSDs/BL6GN45HVwmnbon+zenKW
         hLAvMVWNOeRqConyq4vOhXApIEPNAafj437NhkN7Ar7RsQK5er58kTQ4asK31uZgNsRr
         IzSXesKHAPsbmgs+jR6fUKWeF5fMH6EeAC5YAAaYVljR8eOb5nVjdlDzPH6oihTk+olU
         BwLCE9oYC5QI1lQB6a+Ie6BbeMJ8HUvZBPpAzOdmPzxGwEHGKNjpcdeLYruumuwCJEGy
         XoRnr28hPXxxOOXbeYaV9UF0U4I8UUI0y1paLj1zP8s4mY5RXo4S7OO0M7vpyeR3X33j
         zKnw==
X-Gm-Message-State: ALyK8tKgabq9WCPyNlcT6CveBJ+qZlrbXsbSTGpRRXaWHhjgt8/d0c5KcDvASRTCnMD6Rw==
X-Received: by 10.28.128.140 with SMTP id b134mr11525645wmd.37.1467748397730;
        Tue, 05 Jul 2016 12:53:17 -0700 (PDT)
Received: from hurricane.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id l4sm1379071wjk.18.2016.07.05.12.53.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jul 2016 12:53:16 -0700 (PDT)
Message-ID: <1467748395.14863.15.camel@kaarsemaker.net>
Subject: Re: Dependencies required for offline installation
From:	Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:	kpaxton@paxdesigns.com
Cc:	git@vger.kernel.org
Date:	Tue, 05 Jul 2016 21:53:15 +0200
In-Reply-To: <CAOkrQryazf=38eUMjcZzByjk=OVNfFGpFKnp5zpyML7yDKhW=A@mail.gmail.com>
References: <CAOkrQrwH=Rj4OS4WphGqzc07hjFBB4B9BFy92qPWdJfB70KPnA@mail.gmail.com>
	 <1467741182.14863.6.camel@kaarsemaker.net>
	 <CAOkrQryazf=38eUMjcZzByjk=OVNfFGpFKnp5zpyML7yDKhW=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On di, 2016-07-05 at 14:06 -0400, Kevin Paxton wrote:
> Thank you for the response.
> 
> I apologize. RHEL 6.5, not 5.5.

That's less ancient, but still not recommended. When using RHEL, try to
stay with the latest point release so you get security updates.

> Would the same version be applicable to 6.5 as well as the
> dependencies that you mentioned?

Red hat actually ships a version of git with RHEL 6.  So the 
version will be different (I believe it's a 1.7.something). The
dependencies should be similar, if not the same.

> On Tue, Jul 5, 2016 at 1:53 PM, Dennis Kaarsemaker
> <dennis@kaarsemaker.net> wrote:
> > 
> > On di, 2016-07-05 at 07:45 -0400, Kevin Paxton wrote:
> > > 
> > > Hi,
> > > 
> > > I’m looking to install git on a separate network that is running
> > > Redhat 5.5.
> > That's ancient and unsupported. If you insist on using rhel 5, at
> > least
> > do 5.11 so you get the security updates.
> > 
> > > 
> > > I need to know what is the list of packages that I need to
> > > download to be able to install git-all? I plan on using git-svn
> > > to
> > > migrate an existing svn repo over to git as well. Svn version we
> > > have
> > > installed is 1.9.3.
> > There are rpms for git 1.8 in EPEL. git-all is probably overkill,
> > but
> > you'll need at least git, perl-Git, perl-Git-SVN and perl-Error.
> > 
> > > 
> > > Does the tarball contain all dependencies already? Should I go
> > > that
> > > route? Or should I try and find all the rpm's required?
> > The source tarball of git contains no dependencies. Also be aware
> > that
> > building git from source requires even more dependencies.
> > 
> > D.
