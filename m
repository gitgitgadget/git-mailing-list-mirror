Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54AB920706
	for <e@80x24.org>; Tue,  5 Jul 2016 17:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754599AbcGERxH (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 13:53:07 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36026 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbcGERxG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 13:53:06 -0400
Received: by mail-wm0-f48.google.com with SMTP id f126so146708910wma.1
        for <git@vger.kernel.org>; Tue, 05 Jul 2016 10:53:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=syhpgYpYvFTOf+IyU8w4tlADvMa5DU9KS1Rel0InVoo=;
        b=RMFV9AIpne0n3fnwrJBBMicXW4NbskvfIqz/gLIXBBLLPHlyA4bSPZAn3ZSMh1x3DM
         MMX5N25wqs3KXwHq57TFCSm0WSzYjygDBGSJTZGthpjty8VYdrw9ZmvJ//MaXTyJojB/
         w0lSJdjHwbjlONQLuGA3bMAripAWOmJuQzPxWh7vfuPsXkv4Hp/4v0PsDsBka9hhT0EK
         m/SqZOuPKrm/wqj3NBaXvAp9cB48x6fs2zVSGBSko+ptcZGfxxQq0aIrjSqmP0u2nHJQ
         MhXAXDyd7p2w9kWgFiyK517eS+RzpvTCqJCPJgXIoBPcw5qTUNYJh0iu7w5T8xjuXO8G
         GlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=syhpgYpYvFTOf+IyU8w4tlADvMa5DU9KS1Rel0InVoo=;
        b=QW/8qZA6Dm3nJVcQ/Tp1negRS5pQk4z4UBT16aep9yurO6QEQ7/Ko9MR3cTX5dRsa6
         9qpZMxN3m/11Vcg4nWjYtZQjm5TxnN0AZi9cRkG2mj/0zukTBzWQ8zhVGg7a6UOz646a
         Nlmk2iLKhE8/B7NcxbCmfQTyt70y+5igsXAtyMt2lFgeof+V8Bwa/sG4SXSvA1lGZ5QJ
         /zKOK3xLPHxLEJM2x4v5O1eTfwrxkkmmmOmgX3AQZTY4J0LRYNVybNlUSwvDoHIHuoky
         a3eO3yeUgt11pO7vaRBG098pSyDDj86jhzn48ES2pXfNcPyz6NgLuWmHt9913oaiAQZ5
         d5eg==
X-Gm-Message-State: ALyK8tImPFOFihOvwIcdU7JLiVhtHACOJT6BrpRaEx+9gbwqRImVfJxqxJ51nHa0ZiGq6w==
X-Received: by 10.28.176.129 with SMTP id z123mr16222071wme.99.1467741183379;
        Tue, 05 Jul 2016 10:53:03 -0700 (PDT)
Received: from hurricane.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id x83sm5178828wmx.9.2016.07.05.10.53.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jul 2016 10:53:02 -0700 (PDT)
Message-ID: <1467741182.14863.6.camel@kaarsemaker.net>
Subject: Re: Dependencies required for offline installation
From:	Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:	kpaxton@paxdesigns.com, git@vger.kernel.org
Date:	Tue, 05 Jul 2016 19:53:02 +0200
In-Reply-To: <CAOkrQrwH=Rj4OS4WphGqzc07hjFBB4B9BFy92qPWdJfB70KPnA@mail.gmail.com>
References: <CAOkrQrwH=Rj4OS4WphGqzc07hjFBB4B9BFy92qPWdJfB70KPnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On di, 2016-07-05 at 07:45 -0400, Kevin Paxton wrote:
> Hi,
> 
> I’m looking to install git on a separate network that is running
> Redhat 5.5. 

That's ancient and unsupported. If you insist on using rhel 5, at least
do 5.11 so you get the security updates.

> I need to know what is the list of packages that I need to
> download to be able to install git-all? I plan on using git-svn to
> migrate an existing svn repo over to git as well. Svn version we have
> installed is 1.9.3.

There are rpms for git 1.8 in EPEL. git-all is probably overkill, but
you'll need at least git, perl-Git, perl-Git-SVN and perl-Error.

> Does the tarball contain all dependencies already? Should I go that
> route? Or should I try and find all the rpm's required?

The source tarball of git contains no dependencies. Also be aware that
building git from source requires even more dependencies.

D.
