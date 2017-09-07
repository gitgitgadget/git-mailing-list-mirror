Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4670A20286
	for <e@80x24.org>; Thu,  7 Sep 2017 19:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755794AbdIGTzf convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 7 Sep 2017 15:55:35 -0400
Received: from mail.pdinc.us ([67.90.184.27]:50184 "EHLO mail1.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755161AbdIGTzf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 15:55:35 -0400
Received: from blackfat (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail1.pdinc.us (8.14.4/8.14.4) with ESMTP id v87JtXHt006831
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Sep 2017 15:55:33 -0400
Reply-To: =?iso-8859-1?Q?Martin_=C5gren?= <martin.agren@gmail.com>,
          "Git Mailing List" <git@vger.kernel.org>
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     "=?iso-8859-1?Q?'Martin_=C5gren'?=" <martin.agren@gmail.com>,
        "'Git Mailing List'" <git@vger.kernel.org>
References: <DF5E912A0E6343DF8C3E984A165490EF@blackfat> <CAN0heSpT=W=5LiQL0SPOffkUO94uTGB-Aatn1fUc07aGqLG16A@mail.gmail.com>
In-Reply-To: <CAN0heSpT=W=5LiQL0SPOffkUO94uTGB-Aatn1fUc07aGqLG16A@mail.gmail.com>
Subject: RE: Git diff --no-index and file descriptor inputs
Date:   Thu, 7 Sep 2017 15:55:32 -0400
Organization: PD Inc
Message-ID: <F65D91595838434A963FC2EE26D62CB8@blackfat>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AdMoAWZIJYrjvSROQ8q6PnshCZ6nJwADVWuw
X-MimeOLE: Produced By Microsoft MimeOLE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Martin Ågren
> Sent: Thursday, September 7, 2017 1:48 PM
> 
> On 7 September 2017 at 18:00, Jason Pyeron <jpyeron@pdinc.us> wrote:
> >
> > I was hoping to leverage --word-diff-regex, but the 
> --no-index option 
> > does not seem to work with <(...) notation.
> >
> > I am I doing something wrong or is this a bug?
> 
> There were some patches floating around half a year ago, I 
> don't know what happened to them.
> 

| From: Dennis Kaarsemaker
| Sent: Friday, January 13, 2017 5:20 AM
| Subject: [PATCH v2 0/2] diff --no-index: support symlinks and pipes

> https://public-inbox.org/git/20170324213110.4331-1-dennis@kaarsemaker.net/

I see, it goes back to 2016...

| From: Dennis Kaarsemaker
| Subject: [RFC/PATCH 0/2] git diff <(command1) <(command2)
| Date: Fri, 11 Nov 2016 21:19:56 +0100

https://public-inbox.org/git/20161111201958.2175-1-dennis@kaarsemaker.net/

I will read up on those threads weekend, then try to apply the patches and
see what happens.

Thanks for the google fu help.

-Jason 

--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- 

