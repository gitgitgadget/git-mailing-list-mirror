Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B9521F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 20:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754760AbcIIUwq (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 16:52:46 -0400
Received: from [195.159.176.226] ([195.159.176.226]:44986 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1754598AbcIIUwq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 16:52:46 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1biSmw-0005xs-Hb
        for git@vger.kernel.org; Fri, 09 Sep 2016 22:52:42 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Christian Neukirchen <chneukirchen@gmail.com>
Subject: Re: git commit -p with file arguments
Date:   Fri, 09 Sep 2016 22:52:36 +0200
Message-ID: <87inu4bxt7.fsf@juno.home.vuxu.org>
References: <87zinmhx68.fsf@juno.home.vuxu.org>
        <CA+P7+xoN+q_Kst=qXG_HRznxbN7cbyi5uZe15zq1c16EifeK1Q@mail.gmail.com>
        <xmqq8tv1c5nb.fsf@gitster.mtv.corp.google.com>
        <23de5ffe-eaf8-2d62-2202-f1bf6087d44b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
In-Reply-To: <23de5ffe-eaf8-2d62-2202-f1bf6087d44b@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Fri, 9 Sep 2016 22:39:13 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Narębski <jnareb@gmail.com> writes:

> Which means that with "git add -p <pathspec> && git commit <pathspec>",
> the "git add -p <pathspec>" would carefully craft the <pathspec> state
> in the index... and "git commit <pathspec>" would take worktree version
> of <pathspec> for commit, ignoring what was in the index :-(
>
> Currently there is no way to create commit out of subset of the index,
> e.g. with "git commit :0:<path>"

I played around with creating a new index just for "add -p" and then
committing that one.  Seems to have worked...

Perhaps I'll just wrap git-commit myself then.

cu,
-- 
Christian Neukirchen  <chneukirchen@gmail.com>  http://chneukirchen.org

