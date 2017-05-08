Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2876520188
	for <e@80x24.org>; Mon,  8 May 2017 01:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752031AbdEHBZP (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 May 2017 21:25:15 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35406 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751934AbdEHBZO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2017 21:25:14 -0400
Received: by mail-pf0-f195.google.com with SMTP id u26so7808297pfd.2
        for <git@vger.kernel.org>; Sun, 07 May 2017 18:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=LdD3g5u+WpiTRyc0XRL36MvKQLwE9j1rzSFC2qkCP+U=;
        b=JQFWEBTlIa8DVel3CL+XyRnj87P7hj2OaDwho3Fx3de7iKUszB+4BCKJH7gbxAMm5o
         swlLQQdofmu1rZ/Y5IMAhUkEmMxOW3I5R+P5TBzp9apotNTj/kvCnra9Bl4+oEoxpNcs
         mWC6G6cgKO5hglPbScdZE2ZB28gyNJ6aIQmgq5XomIxI1DASgEj0DTwhwy7QeFygJeIE
         AIGvVHk0g0PQ0NE69WiRVUdD1vyynnOxtWfg+8KifnXcfLOX1Z5fXa0LAp0IwDL1YBR3
         9cNAhp+pcygV9szTB1Z8svAYqYT/Ku3j2WnU4viQ4ZPCZ6v9OJCSbA6mQZLVAdqaFDCH
         AXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=LdD3g5u+WpiTRyc0XRL36MvKQLwE9j1rzSFC2qkCP+U=;
        b=sWUoEZEaPA0U1fA8+Z5QZK5Q17jWTsfH7//QvWunfNNeNjrCvuEILCEtjWhtJZVA3C
         nweGLjL813Ehdwu8bv3d90lDLTK3+Pel/aOyrUwyN1B4g9CP9uqNg3aBWUqlBXD3/eD+
         aQ0p9QI53JHMlCXfrqZGg8KCAUYuq/eKvI00Tmv/LKtMnJVLmzIDOYzjJnsBXljErfPl
         B/7akE8WNe2qy1mzGea2oO77rM5gKGVTtMCOXPR9FhKyu5d0CXPxx1YRM2vLguIVZkGq
         RGBDhe0jQzMxqKp7HiPMzWipIyvJFaun8ommni+pbCddlZKrqKCe6kZAby20hc2rUPJ7
         6MWQ==
X-Gm-Message-State: AN3rC/4o3l+PPA6kHltiUsWJfMCHEWDPtfOH6xyP1maqp9U4bLwMeyrn
        Gkq1ZNvxq83wpg==
X-Received: by 10.98.31.90 with SMTP id f87mr29240963pff.264.1494206713374;
        Sun, 07 May 2017 18:25:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3011:642f:81a0:efbd])
        by smtp.gmail.com with ESMTPSA id o5sm27192449pfk.126.2017.05.07.18.25.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 07 May 2017 18:25:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] doc: replace a couple of broken gmane links
References: <20170505100803.13238-1-avarab@gmail.com>
Date:   Mon, 08 May 2017 10:25:10 +0900
In-Reply-To: <20170505100803.13238-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 5 May 2017 10:08:03 +0000")
Message-ID: <xmqqwp9sb0nd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Replace a couple of broken links to gmane with links to other
> archives. See commit 54471fdcc3 ("README: replace gmane link with
> public-inbox", 2016-12-15) for prior art.
>
> With this change there's still 4 references left in the code:
>
>     $ git grep -E '(article|thread)\.gmane.org' -- |grep -v RelNotes|wc -l
>     4
>
> I couldn't find alternative links for those.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>
> Perhaps someone else will have better luck with the other ones, which
> are:
>
>     Documentation/git-bisect-lk2009.txt-1355-- [[[6]]] https://lwn.net/Articles/277872/[Jonathan Corbet. 'Bisection divides users and developers'. LWN.net.]

This link seems to be alive.

>     Documentation/git-bisect-lk2009.txt:1356:- [[[7]]] http://article.gmane.org/gmane.linux.scsi/36652/[Ingo Molnar. 'Re: BUG 2.6.23-rc3 can't see sd partitions on Alpha'. Gmane.]

Message-id for this message is <20071207113734.GA14598@elte.hu>
    Xref: news.gmane.org gmane.linux.scsi:36652 gmane.linux.kernel:611204

>     Documentation/git-bisect-lk2009.txt-1357-- [[[8]]] https://www.kernel.org/pub/software/scm/git/docs/git-bisect.html[Junio C Hamano and the git-list. 'git-bisect(1) Manual Page'. Linux Kernel Archives.]

There would be a corresponding git-scm.org manual page, no?

>     git-rebase--interactive.sh-7-# The original idea comes from Eric W. Biederman, in
>     git-rebase--interactive.sh:8:# http://article.gmane.org/gmane.comp.version-control.git/22407

https://public-inbox.org/git/m1odwkyuf5.fsf_-_@ebiederm.dsl.xmission.com/

FYI, https://public-inbox.org/git/ has a "search" interface that
lets you type "gmane:22047" to the box and click.


>     git-rebase--interactive.sh-9-#
>     --
>     t/t4038-diff-combined.sh-356-# Test for a bug reported at
>     t/t4038-diff-combined.sh:357:# http://thread.gmane.org/gmane.comp.version-control.git/224410

https://public-inbox.org/git/20130515143508.GO25742@login.drsnuggles.stderr.nl/

>     t/t4038-diff-combined.sh-358-# where a delete lines were missing from combined diff output when they
>     --
>     tree-walk.c-1077-                * in future, see
>     tree-walk.c:1078:                * http://thread.gmane.org/gmane.comp.version-control.git/163757/focus=163840

https://public-inbox.org/git/7vmxo5l2g4.fsf@alter.siamese.dyndns.org/

