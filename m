Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A8FB203E1
	for <e@80x24.org>; Tue, 26 Jul 2016 06:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755273AbcGZGzO (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 02:55:14 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34900 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755074AbcGZGzM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 02:55:12 -0400
Received: by mail-wm0-f68.google.com with SMTP id i5so144429wmg.2
        for <git@vger.kernel.org>; Mon, 25 Jul 2016 23:55:11 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=W4qLCMLy73tUPfd3SDLmhqdx1S1NKREsKQ/DvhqFP+M=;
        b=aEruhzyFJHvrfizcNib20Qz2/KRUa0isAHliviTgRAjguqWi+IF4JXgszcNmqOHz3f
         YVbuQhiMYki+VQO3yuT9Z3Nw/yaMoqYCqvQuV3+/V7pa4CLFWUW3XoGYvNYiwRjVDPw6
         r3VRROApv7CDTtCRKARnQGK3D2cMuMdSKhLS+tGHVpYFv4gB8Wc5qNxBryoVK9BzICF+
         zNPRcG+lJ6p/kzCL8hdiFOOnHpdhkKdWH1XFeE/VUxNdywLdk+/ioD99QId288UPqKNt
         PQGWT7RqRku17yvyXzDhJfT3qN5a+NK7wUGXgB9H5KbTp0lLIvthVUrHAcJK/cdKIgCQ
         Q4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=W4qLCMLy73tUPfd3SDLmhqdx1S1NKREsKQ/DvhqFP+M=;
        b=IJTl0GyutFm3vKJDNjG4WKPf85VSXC8e19q9G43TEepj87IwZsmDam0Lp+DnrM4Lqj
         QPPXQxe1oXesqEK/Ozkg9hJ3cAr6BaPpVHOq5zMwKOntTZGjTA90dTk4KPMoOp030IQc
         dEPSSLOE5c5tHAF5ojAny3VoyzSrvyHQkF+if/JOJPFZ2g6QIyqspHumz5QoNxRRXpOn
         2525uIK0ObqrB4unSomj3bhUfeLyvoXq+zgvgH6g1oN8T0yh0L0ujiekK6fv7RZ+edS6
         zhpHJWIeHgL1uwzCTtk7oRw0p2kMFrWSA3j60b+PlPocC0BU1f04glahmtiJkRFvhKmA
         9RlQ==
X-Gm-Message-State: AEkoouuRYAxW4o5awtNC5LQJo7yKNdfDXdlCZdeNp6cOpg+C3LoTF1/CS8d/6EMGbh0Xig==
X-Received: by 10.194.87.101 with SMTP id w5mr20631111wjz.94.1469516110605;
        Mon, 25 Jul 2016 23:55:10 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB772A.dip0.t-ipconnect.de. [93.219.119.42])
        by smtp.gmail.com with ESMTPSA id ka6sm19465232wjb.38.2016.07.25.23.55.09
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Jul 2016 23:55:10 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: What's cooking in git.git (Jul 2016, #07; Mon, 25)
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqh9bd2uy4.fsf@gitster.mtv.corp.google.com>
Date:	Tue, 26 Jul 2016 08:55:08 +0200
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <6E620FEE-7149-4A01-9146-A480FD985499@gmail.com>
References: <xmqqh9bd2uy4.fsf@gitster.mtv.corp.google.com>
To:	Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>
X-Mailer: Apple Mail (2.1878.6)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


On 26 Jul 2016, at 00:50, Junio C Hamano <gitster@pobox.com> wrote:

> [...]
> 
> 
> * ew/git-svn-http-tests (2016-07-25) 2 commits
> - git svn: migrate tests to use lib-httpd
> - t/t91*: do not say how to avoid the tests
> 
> Reuse the lib-httpd test infrastructure when testing the subversion
> integration that interacts with subversion repositories served over
> the http:// protocol.
> 
> Will merge to 'next'.

Do I understand correctly that this patch fixes $gmane/295291 ?
Nice! Should we add "GIT_SVN_TEST_HTTPD=true" to the .travis.yml, then?

Thanks,
Lars
