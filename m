Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D27881F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 19:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfACT6p (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 14:58:45 -0500
Received: from sonic303-26.consmr.mail.gq1.yahoo.com ([98.137.64.207]:41159
        "EHLO sonic303-26.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726100AbfACT6p (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 3 Jan 2019 14:58:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1546545524; bh=1IDFeVgonh7Wse4tk4xoNFzYLD4TOSlAsYEuFhBWiaQ=; h=From:To:Cc:References:In-Reply-To:Subject:Date:From:Subject; b=fVgoC1waB6HN1cbWnOpGMupvEkrGw6n4Dxp7Ws+2yqpXxiLguGpmoRyQdxgokA8zZWB6XFeI9zxiZp8Fx+X3405/THjr/+FXmfct0EdRYypY3vSth6aKObsMEzAdurulU23TgG2cgFUKJgFaMc9nlGw5vcijFnPSBbbfq+XuEp6u67K3rjRozwMtmKQir5x6R/f3OQEkDsYVrrBDaNFLAxB04YVPP8phz4lgKC/SyXM57OpTA33nalclkEmUd227CxsIxcJ1DFJdzm8C/iXUoLYqetiafYpvpI6iprnI1Fr4deL418gJ5AtdG4OZeZorngDUVA7R40d/ftrulZ2+wQ==
X-YMail-OSG: uoIDxr4VM1mgzjTdtDl605vQ9SfsgpEPUq22r0LSBacde6ShkIKVyuOK4sFQd9s
 qR9EXjBpYx6LcuKALhGVLiMHmkufYnwPyLRD4zwUDmCxc0ukEdWzyFO65hpJp7JegSVP4om6_AHw
 yE.g2GzRyUDHYnrbkegpcglALi9qoAsvmL2IrVJJn.Y8wJU9bzvP0X7ifEq3RUoZK.lSbGDXwCEl
 aWRTJWyQvE1jOD44hLrzidiqN_SfNwHShIUhfqysy_VMySmkiceiXjLOxDSRUEURfP7MvIWlprPn
 GBGe6lj6hImoke5BoE4lVzGZ97rdqJnhvkYumXfnLZiTrrnDYDVq0XXxkw6oFiceYKmRyn8HJRr6
 qrvJc561V.cqzcvqVuWYIW3zjnXARqauZOQzv5zhDC0mNuxwuIQRAjp6Cjj8XMs6A3f.BhXoJhkT
 vTo87p8cvMpZTcILLFYUzumqAzUvy35OBvppmOOu0_1JGicjG0cJmyf6BBjr52lfcPeGLLmWC1xt
 UGhgNT8SHb7TvKSMaGHtfSkH3bOjUd6OVCXnd9bbgB7rJ7VdPEUSX8RSjThFlnw.ftp.jbVwXKEv
 hVckc1fXWbyfCKAmS9oa79zlwIhKzZQZwxbsWYGrMB1cHlax.kzR13SgwXw.NaxS3Qf.eslDAKfy
 MWlUmnQ2_Gifkh1TZI6yLI7IEo1HjntSaUk95qESf2ugcMPAQJB5OOCNUdO97hS_5BRELTVQXuIo
 iKbZP8__tqowZ6uj0gECtFtmKw5xjA0QQhPxx4G2kyxdjW2a7n5yAfPaH64S5aMP2U2qz_AD5tPs
 2bY8P2qcCAuJN.lUz0kNtKljrfvQsY1HnWMoX3eMG3VpgUqEJSMx2aBB.aerCQLabMRzA06pr2.U
 ztfu62YyE.GXje13F4owtVXlcEw4WvrSgq0UR9UKUYFDoGiwzIGBIJXD_YeI9vcOI06F3o.KjCdi
 UPXgkFosPRulonxbYun0x0XDkEkt4QeLL82qfBd5Cz.P47qQFlJLxbTSSEmfB63zrfYERglr5OZ7
 JA_8.6WqdabCCpKgS2YpolR_3UJGcuPjKKtcBagQrt4vPhX3pFDcyla4qaZsv05chH5SPBdzYr0_
 _VOWUd0PnSSO0FHfb60aMO8o-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.gq1.yahoo.com with HTTP; Thu, 3 Jan 2019 19:58:44 +0000
Received: from CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com (EHLO gnash) ([99.229.179.249])
          by smtp419.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID c1d5db669e2738c47424f09fa519ee3c;
          Thu, 03 Jan 2019 19:58:42 +0000 (UTC)
From:   <randall.s.becker@rogers.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>,
        "'Randall S. Becker'" <rsbecker@nexbridge.com>
References: <20181228200243.19728-1-randall.s.becker@rogers.com> <xmqqimz5h6et.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqimz5h6et.fsf@gitster-ct.c.googlers.com>
Subject: RE: [PATCH v4 2/4] config.mak.uname: support for modern HPE NonStop config.
Date:   Thu, 3 Jan 2019 14:58:39 -0500
Message-ID: <006501d4a39e$b99fe0d0$2cdfa270$@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHlW+szbjModhQL9tKZJBlUGYo9LAMYQ+dYpWPDLkA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 3, 2019 14:45, Junio C Hamano wrote:
> To: randall.s.becker@rogers.com
> Cc: git@vger.kernel.org; Randall S. Becker <rsbecker@nexbridge.com>
> Subject: Re: [PATCH v4 2/4] config.mak.uname: support for modern HPE
> NonStop config.
> 
> randall.s.becker@rogers.com writes:
> 
> > @@ -470,8 +489,13 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
> >  	NO_MKDTEMP = YesPlease
> >  	# Currently libiconv-1.9.1.
> >  	OLD_ICONV = UnfortunatelyYes
> > -	NO_REGEX = YesPlease
> > +	NO_REGEX=NeedsStartEnd
> >  	NO_PTHREADS = UnfortunatelyYes
> >
> >  	# Not detected (nor checked for) by './configure'.
> >  	# We don't have SA_RESTART on NonStop, unfortunalety.
> 
> The hunk header claims that the preimage has 8 lines while the postimage
> has 13 lines, adding 5 new lines in total.  But that is not what we can
see in
> the hunk.
> 
> It is unclear to me if the numbers on the hunk header are bogus, or the
patch
> text was truncated, so I cannot use these two patches with confidence.
The
> first hunk had the same issue, and 1/4 too.
> 
> I do not see v4 3/4 and v4 4/4, either.  It's not like you are the only
person
> who sends patches to the mailing list, and not having the patches as
> responses to a cover letter for proper threading makes it very hard to see
> which patches belong to the same series and if all the necessary patches
in a
> series have become available.
> Is it possible to arrange that to happen?
> 
> Thanks.

I will reissue the whole package for you. I think I hacked it badly. Will
get to it after $DAYJOB is done.


