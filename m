Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1831208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 17:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752721AbdHJRDj (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 13:03:39 -0400
Received: from [195.159.176.226] ([195.159.176.226]:47723 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1752559AbdHJRDi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 13:03:38 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1dfqrp-00021h-Gg
        for git@vger.kernel.org; Thu, 10 Aug 2017 19:03:29 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Harry Putnam <reader@newsguy.com>
Subject: Not understanding with git wants to copy one file to another
Date:   Thu, 10 Aug 2017 13:03:30 -0400
Organization: Still searching...
Message-ID: <87mv7773tp.fsf@local.lan>
Mime-Version: 1.0
Content-Type: text/plain
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.0.50 (gnu/linux)
Cancel-Lock: sha1:l6iAQHTSqDTem6o17h3PAdXLVj0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I ran into a line in git commit ouput I had not see before

  #copied:     d0/etc/hosts -> misc/old-readerHOSTvcs-files/etc/hosts

So googling I learned that this might happen if git thinks the two
files are the same.

I was pretty sure they were not the same so checked them>

 <inside git repo>

diff d0/etc/host misc/old-readerHOSTvcs-files/etc/hosts

The output is a bit long but shows them being quite different.

Some 2 dozen or so lines that dramatically differ.

Here are two that are at least kind of similar but would never be seen
as the same:

< 192.168.1.43      m2.local.lan       m2       # 00-90-F5-A1-F9-E5
> 192.168.1.43    m2.local.lan        m2         # win 7

Not to mention they are quite different lines as well.

So what is going on and what should I be looking at?

