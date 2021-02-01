Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444EEC433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 09:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E549F64EAF
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 09:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbhBAJwl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 04:52:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:34148 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232942AbhBAJwj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 04:52:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 974DAACBA;
        Mon,  1 Feb 2021 09:51:44 +0000 (UTC)
Date:   Mon, 1 Feb 2021 10:51:43 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     =?utf-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Cc:     Hongyi Zhao <hongyi.zhao@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: Recover a git repo after accidentally deleting some hash files
 located under .git/objects.
Message-ID: <20210201095143.GO6564@kitsune.suse.cz>
References: <CAGP6POKSOaaq0A-L2RgQ+R+bJVo-KuZChEOcCuO8jP+Cm9QFPw@mail.gmail.com>
 <CAOLTT8SsmzNNvQHaP3+vQmuq0fdRbFNL8ukOvPW5Zw9+nPk32Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOLTT8SsmzNNvQHaP3+vQmuq0fdRbFNL8ukOvPW5Zw9+nPk32Q@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 01, 2021 at 01:56:55PM +0800, 胡哲宁 wrote:
> Hi，I don't think so unless you have the commit
>  in github or gitlab which include this file，
> maybe you can use git pull to get it.
How?

fetch/pull complains that the hashes are missing.

In this situation I just delete the repository but it is kind of stupid
that git rells you exactly what is wrong but won't fix it.

Thanks

Michal
