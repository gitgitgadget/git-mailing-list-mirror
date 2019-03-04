Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03FD520248
	for <e@80x24.org>; Mon,  4 Mar 2019 20:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfCDUT4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 15:19:56 -0500
Received: from smtp-35.italiaonline.it ([213.209.10.35]:35062 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726087AbfCDUT4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 15:19:56 -0500
Received: from DESKTOP-E4U7JCE ([5.168.24.152])
        by smtp-35.iol.local with ESMTPA
        id 0u41hIif4Ye7j0u41hvOpJ; Mon, 04 Mar 2019 21:19:53 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1551730793; bh=JfNInHJzUCpaajVcQRndwCfjB/8zGUA/TP/5j4GEMpw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=mq+jY0BD5Enq4pk9ok7jRPK8Ih2hoRxrZlH9HiK7MHqpnjOgCMPUJN3RQ0V1YiXB6
         RSiTgw+nrx+6w3X0fW3bLv9g6Ilk7dF8nZieA64ODg/s0YMmYYrP21KK2PFWPgIpCC
         VpMVB7KO5Zm7rzfX8MvOUU7iHcFhO1inRBBOts6tfb+yxcSy7PXg/4PFTobcZLkYCP
         MauRJ0lX1dntojIndLRO9ORbrMK4/w+cWDjZ+j5d+HA6GD1ZB00Nj4m1SynfZloMcS
         O5xPUwZa95mOeNbnxz/y/kk1FXRc9SAzSzCcLn212KErD9kPCh89Eqk3lxzvWBw25l
         OC+pVZKiQsMTQ==
X-CNFS-Analysis: v=2.3 cv=ea/sgIMH c=1 sm=1 tr=0
 a=6M+yewxsaZYMRRaEAwjDyg==:117 a=6M+yewxsaZYMRRaEAwjDyg==:17
 a=IkcTkHD0fZMA:10 a=V1lpufC1VQHwdg1PRCYA:9 a=QEXdDO2ut3YA:10
Message-ID: <1551730792.4573.1.camel@libero.it>
Subject: Re: Can't build first git commit
From:   Fabio Aiuto <polinice83@libero.it>
To:     Santiago Torres <santiago@nyu.edu>
Cc:     git@vger.kernel.org
Date:   Mon, 04 Mar 2019 21:19:52 +0100
In-Reply-To: <20190304201011.j7dopqp6ug66ccum@LykOS.localdomain>
References: <1551729517.4092.1.camel@libero.it>
         <20190304201011.j7dopqp6ug66ccum@LykOS.localdomain>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfERnCasuPurJmgWy6kAkW5WdscziD5J8TQu1HxzGQSrvtdZqo/PrjZezGD0lFbuQg/cC0unQ56WATuY8mME855iSqKkNO2JoyGAZ3avu/A5VQP7Hs1vM
 /GzUprS2X3guQ3eNlW+0qbP2y7ioD+1CR6RJY91prokFM266CKhY5V93b6fG7LsbGQm9+dS5i2UM7Lfta3boyJec/YUCjg4LiS4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What a pity, It would have been very useful for me, to debug around
that simple version, to understand how everithing works.
Thank you Santiago.
Fabio.
Il giorno lun, 04/03/2019 alle 15.10 -0500, Santiago Torres ha scritto:
> This commit is about 14 years old:
> 
>     Date:   Thu Apr 7 15:13:13 2005 -0700
> 
> Unless you have a toolchain from around that time, I'd be very
> surprised
> if things build. Notably, there you're having an issue with the
> symbols
> that lssl is exposing (I suspect you're not even using the openssl
> 1.0.0
> series anymore.
> 
> Thanks,
> -Santiago.
> 
> On Mon, Mar 04, 2019 at 08:58:37PM +0100, Fabio Aiuto wrote:
> > Hi to all,
> > 
> > I'm trying to build first commit of git made by Linus. I mean the
> > one
> > named e83c5163316f89bfbde7d9ab23... (I think this is enough).
> > But at building stage i have the following error:
> > 
> > make all 
> > gcc -g -o update-cache update-cache.o read-cache.o -lssl
> > /usr/bin/ld: update-cache.o: undefined reference to symbol
> > 'SHA1_Update@@OPENSSL_1_1_0'
> > //usr/lib/i386-linux-gnu/libcrypto.so.1.1: error adding symbols:
> > DSO
> > missing from command line
> > collect2: error: ld returned 1 exit status
> > make: *** [update-cache] Errore 1
> > Makefile:16: set di istruzioni per l'obiettivo "update-cache" non
> > riuscito
> > 
> > I run a debian stretch on my machine. Could anyone help me?
> > Thanks in advance.
> > Fabio.
> > 
