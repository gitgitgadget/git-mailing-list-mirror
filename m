Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3209209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 13:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbdFFNnI (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 09:43:08 -0400
Received: from [195.159.176.226] ([195.159.176.226]:54933 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751345AbdFFNnH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 09:43:07 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1dIEl9-00087D-DY
        for git@vger.kernel.org; Tue, 06 Jun 2017 15:42:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Christian Neukirchen <chneukirchen@gmail.com>
Subject: Re: Feature request: Please add support to stash specific files
Date:   Tue, 06 Jun 2017 15:42:59 +0200
Message-ID: <87o9u1cjvg.fsf@gmail.com>
References: <CACkx65CDzw64wsQ_t3YJUm_UP27fBf50n4r7mcMe1wZPW0TSjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
In-Reply-To: <CACkx65CDzw64wsQ_t3YJUm_UP27fBf50n4r7mcMe1wZPW0TSjg@mail.gmail.com>
        (rajdeep mondal's message of "Tue, 6 Jun 2017 09:23:09 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

rajdeep mondal <justrajdeep@gmail.com> writes:

> git version 2.6.3
> OS: RHEL 6
>
> Work around found in:
> https://stackoverflow.com/questions/3040833/stash-only-one-file-out-of-multiple-files-that-have-changed-with-git
>
> Workaround is not very optimal. Please add this support to git.

This has been implemented in Git 2.13:

> * "git stash push" takes a pathspec so that the local changes can be
>   stashed away only partially.

-- 
Christian Neukirchen  <chneukirchen@gmail.com>  http://chneukirchen.org

