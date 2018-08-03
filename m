Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 935191F597
	for <e@80x24.org>; Fri,  3 Aug 2018 08:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbeHCKow (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 06:44:52 -0400
Received: from ao2.it ([92.243.12.208]:56112 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727866AbeHCKov (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 06:44:51 -0400
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1flVkp-0005rD-8F; Fri, 03 Aug 2018 10:48:11 +0200
Date:   Fri, 3 Aug 2018 10:49:32 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        Daniel =?ISO-8859-1?Q?Gra=F1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: [RFC PATCH v2 11/12] dir: move is_empty_file() from
 builtin/am.c to dir.c and make it public
Message-Id: <20180803104932.e22c45fdc007e5884944696b@ao2.it>
In-Reply-To: <CAGZ79kYpsYbg8nkE+8hTPM=Bg_3-p3EzoRfJ1y7f+Dz-3hT-HA@mail.gmail.com>
References: <20180802134634.10300-1-ao2@ao2.it>
        <20180802134634.10300-12-ao2@ao2.it>
        <CAGZ79kYpsYbg8nkE+8hTPM=Bg_3-p3EzoRfJ1y7f+Dz-3hT-HA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2 Aug 2018 13:50:55 -0700
Stefan Beller <sbeller@google.com> wrote:

> On Thu, Aug 2, 2018 at 6:47 AM Antonio Ospite <ao2@ao2.it> wrote:
> >
> > The is_empty_file() function can be generally useful, move it to dir.c
> > and make it public.
> >
> > Signed-off-by: Antonio Ospite <ao2@ao2.it>
> 
> Makes sense,
> 
> Thanks,
> Stefan
> 
> > +++ b/dir.c
> > @@ -2412,6 +2412,22 @@ int is_empty_dir(const char *path)
> >         return ret;
> >  }
> >
> > +/**
> > + * Returns 1 if the file is empty or does not exist, 0 otherwise.
> > + */
> 
> Please move the comment to the header instead.
> /* possibly as a oneliner ? */

Will do.

Thanks,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
