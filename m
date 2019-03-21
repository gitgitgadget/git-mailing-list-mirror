Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CCC720248
	for <e@80x24.org>; Thu, 21 Mar 2019 19:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbfCUTGP (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 15:06:15 -0400
Received: from smtp-32.italiaonline.it ([213.209.10.32]:58475 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727991AbfCUTGO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 15:06:14 -0400
Received: from DESKTOP-E4U7JCE ([158.148.82.31])
        by smtp-32.iol.local with ESMTPA
        id 7312hv8Yr6rc57312hs5YT; Thu, 21 Mar 2019 20:06:12 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1553195172; bh=3FPJp1ac3qtQ43Q2A2WZx2C/5HYvDjJ3tJepWHbPpLI=;
        h=Subject:From:To:Date;
        b=Or09Zy/AEDyUAVYihoAHMIFe2nzkeC2BMCQoJfULhUMyUOn6lO6xjuqzAaMtruuiG
         q0Wfn0l4Zf5LK/8RqujG0NVue0CdoMm3htEALK0OMcBpgihRNan2/6uyse/Q7QTfZf
         S+ObFtl4SrTtwiS+IhAyrIejsze/N5TWYK0jHfCzc56k4sbGh0stuNzq6PfXTxZXFf
         4M77FHot9cjPOmp7OTjWO4g0NB/nsTSbpi+LJH0BQ+cy+Dn9Vd0EwZdSBt3lYlcdIQ
         LTx9LxymiIwtnkSaorMYKCi9qb6rCrup+U0b9poFDGe75A0yYbDEVE5J9gd5BNfMEl
         M7FiHi5spNtjw==
X-CNFS-Analysis: v=2.3 cv=d7kkNirE c=1 sm=1 tr=0
 a=Yl0R8IIxZDOUFwKtadnq+A==:117 a=Yl0R8IIxZDOUFwKtadnq+A==:17
 a=IkcTkHD0fZMA:10 a=7Fg1ZC3fdB-_FwuUqgQA:9 a=QEXdDO2ut3YA:10
Message-ID: <1553195171.1436.1.camel@libero.it>
Subject: Semantic errors
From:   Fabio Aiuto <polinice83@libero.it>
To:     git@vger.kernel.org
Date:   Thu, 21 Mar 2019 20:06:11 +0100
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLipAW1k+eoN5m+q7096q41QdiSGB3b3MnAsqpiExF2UNDymCr85B57XeinMwyLf5wQNlBq1WMKuI/QjStjACOC8yaC7uBjg8mGxcm5Im93wZTvnTzzI
 gfpnnB1WwC0+UE87IUmD1+a7ZzWASKEZqWzDLCdP0MTIoUxV4iJ7eKfX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello to all,
I'm browsins git code with Eclipse. I'm on a local branch called
"studio" based on master (last public commit e902e9b by Junio C Hamano
on Monday March 11 2019). I've built everything by changing:
CFLAGS = -g -Wall (removing -O2 to have smooth trace in debugging).
But the environment detects the following semantic errors (I made no
edits!!!):
Description	Resource	Path	Location	Type
Symbol 'GIT_HTML_PATH' could not be resolved	git.c	/git	
line 154	Semantic Error
Symbol 'GIT_MAN_PATH' could not be resolved	git.c	/git	
line 158	Semantic Error
Symbol 'GIT_INFO_PATH' could not be resolved	git.c	/git	
line 162	Semantic Error
Symbol 'active_cache' could not be resolved	commit.c	/git
/builtin	line 899	Semantic Error
Field 'ce_intent_to_add(active_cache[i])' could not be resolved	
commit.c	/git/builtin	line 899	Semantic Error
Symbol 'active_nr' could not be resolved	commit.c	/git/bu
iltin	line 889	Semantic Error
Symbol 'active_nr' could not be resolved	commit.c	/git/bu
iltin	line 898	Semantic Error
Field 'oid' could not be resolved	commit.c	/git/builtin	
line 1654	Semantic Error
Symbol 'active_nr' could not be resolved	commit.c	/git/bu
iltin	line 901	Semantic Error
Symbol 'active_cache_tree' could not be resolved	commit.c	
/git/builtin	line 1654	Semantic Error
Symbol 'active_cache_changed' could not be resolved	commit.c	
/git/builtin	line 418	Semantic Error
Symbol 'active_cache_tree' could not be resolved	commit.c	
/git/builtin	line 419	Semantic Error
Symbol 'active_nr' could not be resolved	commit.c	/git/bu
iltin	line 254	Semantic Error
Symbol 'active_cache' could not be resolved	commit.c	/git
/builtin	line 255	Semantic Error

I can debug without problems, but what if I should trece through one of
those errors?
How can I fix them?
Thanks in advance!!!
Fabio.

