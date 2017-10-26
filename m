Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1110F20560
	for <e@80x24.org>; Thu, 26 Oct 2017 11:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932255AbdJZLGU (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 07:06:20 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:46680 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932141AbdJZLGT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 07:06:19 -0400
Received: by mail-wm0-f52.google.com with SMTP id m72so7213998wmc.1
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 04:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=roQJ7QGKWP3AWX7rgNr/eBBWJI6APNUfGVgZh6OhSN0=;
        b=ZOuuGOWDDrfgUgO3e+6t3bpMakQDdw+uVisFXvqIVG/EOpnKuDg4tXylSK9SDM96kg
         PIcIh+4nKT4rik0OhBt79TUFVITE05XadQrwkO5L7WgVOZt0fFvPei0EA3i3VE1Wk0ux
         4CF8fCav1axluShaTr/Zcj5LwFAlsPN/8nhTwB9enbA+pJbluPLscRzIEXSAs2m8qTWO
         VHr2z1vVi0pSMsxsBVFs25KppuOcmCx+rIoaZ5JlFsgsy5nGP9LDJiWK0CMXtt09fJ0j
         LZAVUovJfb86i1rbnwMe46KKF1P2gx5YBf270dktLMo6jI6J9TNSLPkeiMWWggyPNNeh
         Mb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=roQJ7QGKWP3AWX7rgNr/eBBWJI6APNUfGVgZh6OhSN0=;
        b=B4WMwhAtpoHzbSGCF1TzPkc9deV5KUjGPgktjVzz0c/5um3A/cqOhgumNjXjuM8Oce
         O7pfQfnAIL9OyIuVoR8tVF6bU+n3DqLxj9I4KVzhn6HMcYrNO9teSjKqz2/BCJ7o5bFS
         p8lvmtrQQv+B0ct3GOyUilu0GFGzrsP0opk1Gv9SM2m1IJ1dX7hfgvrJlxGL64spIdC6
         2OuiiSX0VoG0ZqWt9E5UvzWXdqThRTbQJBlxpCkOZwqdVkLcsTJu5cZmCHf/OrxmTovQ
         KqvituFZbp4oaIkV3VlVRtbMyWhUSPPCnKWR0mUDqOh7BXwDCDMJF6qDyGhjHHkBYN4B
         iI8Q==
X-Gm-Message-State: AMCzsaVvJqNE8S87/w0tozOsuJ+2dYaAv+5+QFBwIdIsH6a8J7V7eCMD
        12bLw9htoMzTLR1JrR7Cx18=
X-Google-Smtp-Source: ABhQp+TlWNL7NsfN2Hp7uX2EiA0TrSTV01Rake5h4ROedrKLgoKqvc/lFJ0VrQvoIFs9Z0DOgM8GPw==
X-Received: by 10.28.180.130 with SMTP id d124mr1251604wmf.95.1509015978181;
        Thu, 26 Oct 2017 04:06:18 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 5sm4079919wrj.22.2017.10.26.04.06.16
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Oct 2017 04:06:17 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Consequences of CRLF in index?
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20171025171357.4nk4aj2c4m4b6kl3@aiede.mtv.corp.google.com>
Date:   Thu, 26 Oct 2017 13:06:15 +0200
Cc:     git <git@vger.kernel.org>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Transfer-Encoding: 7bit
Message-Id: <0B4CDE3E-86E1-4919-980B-048577EDCBEE@gmail.com>
References: <D0A67AD8-2D63-4683-9F2A-20B0E8E65D4B@gmail.com> <20171024181415.3tvmc36aqi335v66@aiede.mtv.corp.google.com> <07309D89-F536-4DA8-9214-B605007845C6@gmail.com> <20171025171357.4nk4aj2c4m4b6kl3@aiede.mtv.corp.google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 25 Oct 2017, at 19:13, Jonathan Nieder <jrnieder@gmail.com> wrote:
> 
> Hi again,
> 
> Lars Schneider wrote:
>>> On 24 Oct 2017, at 20:14, Jonathan Nieder <jrnieder@gmail.com> wrote:
> 
>>> In any event, you also probably want to declare what you're doing
>>> using .gitattributes.  By checking in the files as CRLF, you are
>>> declaring that you do *not* want Git to treat them as text files
>>> (i.e., you do not want Git to change the line endings), so something
>>> as simple as
>>> 
>>> 	* -text
>> 
>> That's sounds good. Does "-text" have any other implications?
>> For whatever reason I always thought this is the way to tell
>> Git that a particular file is binary with the implication that
>> Git should not attempt to diff it.
> 
> No other implications.  You're thinking of "-diff".  There is also a
> shortcut "binary" which simply means "-text -diff".

Yeah. Well, when I read "-text" then I think "no text" and that makes
me think "is binary".


> Ideas for wording improvements to gitattributes(5) on this subject?

I think the wording in the docs is good. It is just the "text" keyword
that confused me. Maybe this could have been names "eolnorm" and
"-eolnorm" or something. But it is too late for that now I guess :-)

Thanks,
Lars
