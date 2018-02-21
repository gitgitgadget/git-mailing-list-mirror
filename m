Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CA0A1F404
	for <e@80x24.org>; Wed, 21 Feb 2018 13:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965082AbeBUN56 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 08:57:58 -0500
Received: from homie.mail.dreamhost.com ([208.97.132.208]:57699 "EHLO
        homiemail-a37.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965049AbeBUN54 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 21 Feb 2018 08:57:56 -0500
Received: from homiemail-a37.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a37.g.dreamhost.com (Postfix) with ESMTP id 502EF20806B;
        Wed, 21 Feb 2018 05:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=
        mattmccutchen.net; bh=G2yfgC/eXjfMsSXipxzmZSbUNDQ=; b=FTJrf79jQu
        FUbstoSNjLZ4ne2kyzbq7DG/o4iwkmkxZ+3ZQePIPtWzJMbosaT9jCGHb5Tb2VU9
        FY/2ck5WH/5Jrq7soPU0fHR5hOj3K00VLQyK9PH4Muxqk2BdGVZ6FhArOHW+MYoJ
        yS1Rn8yxyyBSQNoQFQc12Zuqq2ujP7jhA=
Received: from main (c-73-149-22-67.hsd1.ma.comcast.net [73.149.22.67])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by homiemail-a37.g.dreamhost.com (Postfix) with ESMTPSA id D5320208069;
        Wed, 21 Feb 2018 05:57:55 -0800 (PST)
Message-ID: <1519221471.3059.23.camel@mattmccutchen.net>
Subject: Re: Duplicate safecrlf warning for racily clean index entry
From:   Matt McCutchen <matt@mattmccutchen.net>
To:     Torsten =?ISO-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
Cc:     git <git@vger.kernel.org>
Date:   Wed, 21 Feb 2018 08:57:51 -0500
In-Reply-To: <20180221075323.GA18213@tor.lan>
References: <1519134146.6055.23.camel@mattmccutchen.net>
         <20180221075323.GA18213@tor.lan>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2018-02-21 at 08:53 +0100, Torsten B=C3=B6gershausen wrote:
> I don't hava a pointer, but what should happen ?
> 2 warnings for 2 "git add" should be OK, I think.
>=20
> 1 warning is part of the optimization, that Git does to handle
> hundrets and thousands of files efficciently.
>=20
> Is the 1/2 warning  real live problem  ?

As I've suggested, my opinion is that the nondeterministic second
warning can result in significant user confusion and should be avoided.
 (If it were always shown, I'd be less concerned.)  We'll see what the
decision-makers think.

Matt
