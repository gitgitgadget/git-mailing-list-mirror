Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B68720248
	for <e@80x24.org>; Fri, 22 Mar 2019 21:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfCVVig (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 17:38:36 -0400
Received: from smtp-32.italiaonline.it ([213.209.10.32]:41169 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726014AbfCVVif (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 17:38:35 -0400
Received: from DESKTOP-E4U7JCE ([5.168.27.57])
        by smtp-32.iol.local with ESMTPA
        id 7Rs2h6HR66rc57Rs2hykmA; Fri, 22 Mar 2019 22:38:34 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1553290714; bh=Ja1BXRXiEviHqw8W/jdrUQiaAEQuDLsIfJXks8xz4gY=;
        h=Subject:From:To:Date;
        b=aMWLXuOKziq3PEhsFklTzR8/aXESsg0E5fFSrxXPJ+YB80BB7py78okiux5WdQnIq
         zXPun6WTazFhGboXVjpB/cvRR0TtKrM99SeYuSPP7IvxCJiirynmbMTJaj79NNMMOg
         6/eUSfPCjKwlA1ikvLgqy1KFck+nMoGhb4JIHQa3viHbt3spe668xWAHtOVeW8JE3O
         2XldB9qhcugIEHzPJ9saZBmKjMfhlEPeLNwL2nKaCGjozF3DFLqmxyE+jgz3i0SFyV
         PrIigKu9iHIelxVLtPVSjX/tsf6K2lnkFYXN6QVAjoCuaB/St2mcjM1sv/q8IufgTJ
         ZWHHMsv5YclkA==
X-CNFS-Analysis: v=2.3 cv=d7kkNirE c=1 sm=1 tr=0
 a=Docq1LM3Rd8MKGMM10gaLw==:117 a=Docq1LM3Rd8MKGMM10gaLw==:17
 a=IkcTkHD0fZMA:10 a=B3Pr3r565CjGbK1ZghUA:9 a=QEXdDO2ut3YA:10
Message-ID: <1553290709.1481.6.camel@libero.it>
Subject: Supposed accidental install
From:   Fabio Aiuto <polinice83@libero.it>
To:     git@vger.kernel.org
Date:   Fri, 22 Mar 2019 22:38:29 +0100
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJ98acrSekxcALJAlkUVeU8jDLL2mUxnmK78AXVtMk5kVp8bQuTZVsigCcrup5rBSUgQHcjiJFUWZdw3o1Pz2JMImW5ERbpCicD8JTEkG8Rntu5t/qKD
 w2ShW94oPZPtivslfmXX4nQe//ygsqjAf1zN9pr1PwEEogapvOoTKxUp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello again,

If I run a make inside the git working directory, this will just create
binaries in the working directory. But in my home/{myname}/bin/ I have
found the following files:

git git-cvsserver gitk git-receive-pack git-shell git-upload-archive
git-upload-pack

Maybe they are deployed by a make install I run accidentally (I think
that's possible). How could I clean the effect of this accidental
install? If I don't clean this install could I have problems in the
future?

Thank you folks!!!

Fabio.
