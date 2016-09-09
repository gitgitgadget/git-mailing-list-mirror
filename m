Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EFD01F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 17:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751574AbcIIRKU (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 13:10:20 -0400
Received: from [195.159.176.226] ([195.159.176.226]:58480 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1750953AbcIIRKT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 13:10:19 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1biPJW-0006qW-Uv
        for git@vger.kernel.org; Fri, 09 Sep 2016 19:10:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Christian Neukirchen <chneukirchen@gmail.com>
Subject: Re: git commit -p with file arguments
Date:   Fri, 09 Sep 2016 19:05:47 +0200
Message-ID: <87poodatqs.fsf@juno.home.vuxu.org>
References: <87zinmhx68.fsf@juno.home.vuxu.org>
        <CA+P7+xoN+q_Kst=qXG_HRznxbN7cbyi5uZe15zq1c16EifeK1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
In-Reply-To: <CA+P7+xoN+q_Kst=qXG_HRznxbN7cbyi5uZe15zq1c16EifeK1Q@mail.gmail.com>
        (Jacob Keller's message of "Fri, 9 Sep 2016 09:57:44 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> It wants to commit bar too because you already added bar before. It works like:
>
> "git add bar && git add -p foo && git commit" does it not?
>
> I fail to see why "git commit -p <path>" would unstage the bar you
> already added? Or am I missing some assumption here?

Yet the commit message comment says:
# Explicit paths specified without -i or -o; assuming --only paths...

But files are committed which were not given on the command line.

My confusion is that I use "git commit" with explicit files, yet other
files are committed.  AFAICS, this only happens with -p.

-- 
Christian Neukirchen  <chneukirchen@gmail.com>  http://chneukirchen.org

