Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_BCC,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5D49209F1
	for <e@80x24.org>; Mon, 10 Apr 2017 07:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752750AbdDJHyQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 03:54:16 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:35888 "EHLO
        mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752829AbdDJHyP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 03:54:15 -0400
Received: from tigra.domain007.com (tigra.domain007.com [192.168.2.102])
        by hermes.domain007.com (Postfix) with SMTP id 6025ED400BA;
        Mon, 10 Apr 2017 10:54:13 +0300 (MSK)
Date:   Mon, 10 Apr 2017 10:13:36 +0300
From:   Konstantin Khomoutov <kostix+git@007spb.ru>
To:     Samuel =?UTF-8?B?w4VzbHVuZA==?= <samuel@update.uu.se>
Message-Id: <20170410101336.c93a423e7d3a8594151bebef@domain007.com>
In-Reply-To: <3563ee7a-1175-2010-7176-0339cd3e60ee@update.uu.se>
References: <3563ee7a-1175-2010-7176-0339cd3e60ee@update.uu.se>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: Re: Git documentation on branching.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 10 Apr 2017 08:56:30 +0200
Samuel Åslund <samuel@update.uu.se> wrote:

> I just started playing around with branching in git.
> I have been using it more or less as Subversion until now.
> 
> One feature with "git branch xyz" and "git checkout xyz" that is
> rather obvious if you know them but bit me a little since I did not,
> is that uncommitted work in progress is not affected or saved when
> switching between branches.
[...]

But neither is uncommitted work saved anywhere when you do
`svn switch` in Subversion which is analogous to `git checkout`.

While I do know quite many people expect Git to somehow "preserve"
their work when switching branches without having them do anything,
I wonder what in Subversion workflow makes you think Git should have
had the behaviour you expected?
