Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF66C2070D
	for <e@80x24.org>; Thu,  7 Jul 2016 15:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbcGGPDZ (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 11:03:25 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36065 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395AbcGGPDX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 11:03:23 -0400
Received: by mail-wm0-f48.google.com with SMTP id f126so214352294wma.1
        for <git@vger.kernel.org>; Thu, 07 Jul 2016 08:03:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=newsgroups:to:from:subject:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=d+wqYbv5u8iAagoKIbEa0XxSYzjUkJemKaixqXUUdu8=;
        b=mD+mvymZtITL5LQs9j4I80toFe/7G0AUvJMf5RDVV7FiPPq73by2B20mwhBwwHLasK
         zwycXsDxp6cF6WyhddVWH/IjccYVUXM5C6AK3yg82t6XG07Pip9L67m8hm9sBdbnexIZ
         EPnq5g8+uWGZZ1x7Hi2POIM6VyfGK8PbqhwkQkx9VUoByc9GMUJy11BeSM6JTh4uRQ6j
         Ttgru3WA0MJ72CBVgGsGEGPYzmffunCgRGT8L5Sq8UfTaPGQQYhfebLo+IyA1c9sGHzl
         O+KNaHRwhcVWn2qBBGN12f7aHIEg+PgDabBbOkGb3JtIIe4JFWzI5Lq8TkXlHpcKVBsQ
         w7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:newsgroups:to:from:subject:cc:message-id:date
         :user-agent:mime-version:content-transfer-encoding;
        bh=d+wqYbv5u8iAagoKIbEa0XxSYzjUkJemKaixqXUUdu8=;
        b=mhgEwkLBCSRpPx/z3VBe0qA0HUcE2jxEN1QU/Rc7y39cAInj7+be4xU6PHPRrG9GXt
         2ephQf0qHiRXXj7eVhOoPFvfTjBUAi/z0uRrlKTTmjeSUah687Yd4QwBC1OsywxfxwYg
         BEMXRsWX/k6SngWxveTt7fINLAatCZ1xE//jVl1NNO3PH5uajVfeyxWGyGSYxPjzgFLh
         9KmyO5mQS+PTfVmqO3BNo+D0QS4AFp6+2+v9TGTaJ9T8bUKrpwkg7moqt1OwE6LnHb0/
         9CNpVpZWuKr6lqOTY1UgxEv2fihp/7CMexv6iwKvaXbcKMMnsmWbNnkrHZBI+TSr0eZ2
         lYJQ==
X-Gm-Message-State: ALyK8tI0eQCebkn42jyoLItH2Dy15x+l0FtlAwEmrKGoNJqcrwofjYwUiiJBvO6XDeVkbg==
X-Received: by 10.28.195.135 with SMTP id t129mr27800079wmf.78.1467903802152;
        Thu, 07 Jul 2016 08:03:22 -0700 (PDT)
Received: from [192.168.1.34] (elp79.neoplus.adsl.tpnet.pl. [83.21.209.79])
        by smtp.googlemail.com with ESMTPSA id jt1sm4161508wjc.8.2016.07.07.08.03.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jul 2016 08:03:21 -0700 (PDT)
Newsgroups: gmane.comp.version-control.git
X-Mozilla-News-Host: news://news.gmane.org:119
To:	git@vger.kernel.org
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Subject: [RFC] Questions for "Git User's Survey 2016"
Cc:	Doug Rathbone <doug@dougrathbone.com>,
	David Bainbridge <david.bainbridge@gmail.com>
Message-ID: <577E6F32.7020007@gmail.com>
Date:	Thu, 7 Jul 2016 17:03:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

I am thinking about returning to doing the Git User's Survey, and
I'd like to ask for feedback.

Thanks to generocity of Survs.com, we have been gifted with premium
annual plan (previous surveys always generated quite a large number
of responses).  This plan will last (at least; it was usually
automatically renewed at no cost) till 26 October 2016, so I am
planning on having the survey for 1 month, in September:

  1 September -- 30 September 2016

For now I would like to ask what types of questions would you want
to see in the survey, and what you want to get from it (what would
be the survey purpose).

In my opinion, the survey has (at least) threefold purpose:

1. INFORMATIONAL.  We can find out how people use Git, if the range
of people answering the survey is wide enough and diverse enough.
We can find out what are their pain points.  It might be different
from what we here on this mailing list think it is.  Hopefully
this would help direct Git development to make Git better for all.

2. EDUCATIONAL.  For example a question about which features do
one uses, or how one gets help about Git, tends to be educational
for people taking the survey.

3. ADVERTISEMENT.  Announcing Git User's Survey might be considered
advertisement for git mailing list.  Questions about hosting site
or books can also be considered advertisement for the site in question
or the book / the author, respectively.


What I'd like to see is how people use Git, which features do they
use and which tools (maybe there is some great unknown tool there?),
where they go to find help about Git.

What types of questions should there be in this year survey?

-- 
Jakub Narębski
