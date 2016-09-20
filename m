Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 057F01F4FF
	for <e@80x24.org>; Tue, 20 Sep 2016 16:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755070AbcITQ3D (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 12:29:03 -0400
Received: from sdaoden.eu ([217.144.132.164]:39266 "EHLO sdaoden.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753964AbcITQ3C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2016 12:29:02 -0400
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Sep 2016 12:29:01 EDT
Received: by sdaoden.eu (Postfix, from userid 1000)
        id 05A6A1604A; Tue, 20 Sep 2016 18:22:20 +0200 (CEST)
Date:   Tue, 20 Sep 2016 18:23:09 +0200
From:   Steffen Nurpmeso <steffen@sdaoden.eu>
To:     git@vger.kernel.org
Subject: v2.9.3 and v2.10.0: `name-ref' HEAD gives wrong branch
 name
Message-ID: <20160920162309.l0neYMQ3l%steffen@sdaoden.eu>
User-Agent: s-nail v14.9.0-pre1-42-g7211cd5
OpenPGP: id=95F382CE;
 url=https://www.sdaoden.eu/downloads/steffen.asc
X-BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors
 in the world can make no bugs.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello again,

yah, sorry, i'm back again..
I try to find a way to find the name of the current branch in an
automated way, because i need to ensure that a commit happens on
it and no other branch.  Now the problem arises that the commit
ref at the time of that commit maybe shared in between several
different branches, but no more thereafter, of course:

  ?0[steffen@wales ]$ git branch|grep '^*'
  * stable/v14.9
  ?0[steffen@wales ]$ git name-rev --name-only HEAD
  stable/v14.8

Is there another way except looking into .git/HEAD or using sed(1)
on the output of `branch' to find the right name?
Thank you.
Ciao!

--steffen
