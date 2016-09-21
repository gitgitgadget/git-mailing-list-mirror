Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B73661F935
	for <e@80x24.org>; Wed, 21 Sep 2016 13:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933730AbcIUN0H (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 09:26:07 -0400
Received: from sdaoden.eu ([217.144.132.164]:39278 "EHLO sdaoden.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932964AbcIUN0H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 09:26:07 -0400
Received: by sdaoden.eu (Postfix, from userid 1000)
        id 315541604A; Wed, 21 Sep 2016 15:26:03 +0200 (CEST)
Date:   Wed, 21 Sep 2016 15:26:55 +0200
From:   Steffen Nurpmeso <steffen@sdaoden.eu>
To:     git@vger.kernel.org
Subject: v2.10.0: ls-tree exit status is always 0, this differs
 from ls(1)
Message-ID: <20160921132655.h49HMsHbp%steffen@sdaoden.eu>
Mail-Followup-To: Steffen Nurpmeso <steffen@sdaoden.eu>,
 git@vger.kernel.org
User-Agent: s-nail v14.9.0-pre1-42-g7211cd5
OpenPGP: id=95F382CE;
 url=https://www.sdaoden.eu/downloads/steffen.asc
X-BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors
 in the world can make no bugs.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think this behaviour contradicts the manual which strongly links
ls-tree to ls(1):

  ?0[steffen@wales ]$ ls NEWSS
  ls: cannot access 'NEWSS': No such file or directory
  ?2[steffen@wales ]$ git ls-tree --name-only master NEWSS                                                                                       
  ?0[steffen@wales ]$ ls NEWS                                                                                                                    
  NEWS
  ?0[steffen@wales ]$ git ls-tree --name-only master NEWS                                                                                        
  NEWS
  ?0[steffen@wales ]$ 

Ciao.

--steffen
