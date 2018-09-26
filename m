Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3096A1F453
	for <e@80x24.org>; Wed, 26 Sep 2018 21:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbeI0D4Y (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 23:56:24 -0400
Received: from mx.sdf.org ([205.166.94.20]:51698 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbeI0D4X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 23:56:23 -0400
Received: from sdf.org (IDENT:aedifex@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id w8QLfJR0007507
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO)
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 21:41:19 GMT
Received: (from aedifex@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id w8QLfIM5019268
        for git@vger.kernel.org; Wed, 26 Sep 2018 21:41:18 GMT
Date:   Wed, 26 Sep 2018 21:41:18 +0000
From:   Tacitus Aedifex <aedifex@sdf.org>
To:     Git List <git@vger.kernel.org>
Subject: Re: GPG signing is bent on WIndows
Message-ID: <20180926214118.GA14431@SDF.ORG>
Mail-Followup-To: Git List <git@vger.kernel.org>
References: <CAH8yC8ngjy_NGhgepRu+331L_=QQ4bpvMe5T4OtjLXJR3OZ-NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH8yC8ngjy_NGhgepRu+331L_=QQ4bpvMe5T4OtjLXJR3OZ-NQ@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 04:05:02PM -0400, Jeffrey Walton wrote:
>I got to look at it today. On Windows:
>
>$ cat ~/.gnupg/gpg-agent.conf
>pinentry-program
>/usr/local/MacGPG2/libexec/pinentry-mac.app/Contents/MacOS/pinentry-mac

Do you have this app on your system? That path looks like one for a mac 
pinentry program and won't work on Windows. There are several tutorials on the 
web that explain how to get GPG working on windows. I suggest starting there.  
Get so that you can sign normal files from the command line on Windows and then 
try again.

//tæ
