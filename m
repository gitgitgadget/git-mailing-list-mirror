Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35B5E1FA14
	for <e@80x24.org>; Sat, 15 Apr 2017 12:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752985AbdDOMx3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Apr 2017 08:53:29 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:36821 "EHLO
        mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751582AbdDOMx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2017 08:53:27 -0400
Received: from tigra.domain007.com (tigra.domain007.com [192.168.2.102])
        by hermes.domain007.com (Postfix) with SMTP id 7EA5ED400AE;
        Sat, 15 Apr 2017 15:53:24 +0300 (MSK)
Date:   Sat, 15 Apr 2017 15:53:24 +0300
From:   Konstantin Khomoutov <kostix+git@007spb.ru>
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>, KES <kes-kes@yandex.ru>
Subject: Re: Git allow to unconditionaly remove files on other developer
 host
Message-Id: <20170415155324.8b011f5a0e524f8b46a235c9@domain007.com>
In-Reply-To: <c09e2447-a528-9da1-9936-9b0ebfdddd78@kdbg.org>
References: <4747541492256174@web25g.yandex.ru>
        <c09e2447-a528-9da1-9936-9b0ebfdddd78@kdbg.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 15 Apr 2017 14:27:00 +0200
Johannes Sixt <j6t@kdbg.org> wrote:

> > That curious, but git allow to unconditionally delete files on
> > other developer host when he do `git pull`
[...]
> Know that Git regards everything mentioned in .gitignore as
> dispensible; IOW, by mentioning a file in .gitignore you actually
> give permission to remove the file if necessary. Git does not have a
> feature to say "ignore this file, but it is precious".

KES, you might also be interested in this recent thread [1].

1. http://public-inbox.org/git/CAPUVn2u0Uos2mT5+4ejj8m0okNK6XwerL6ce2miHfhtuEs-ZnQ@mail.gmail.com/
