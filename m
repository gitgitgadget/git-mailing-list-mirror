Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7741120248
	for <e@80x24.org>; Wed, 17 Apr 2019 16:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732105AbfDQQLU (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 12:11:20 -0400
Received: from mout.gmx.net ([212.227.15.18]:57485 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729641AbfDQQLU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 12:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555517476;
        bh=J8/GGibJno//tGaiOoM6mAEMy8sdvUh4fa4/OZxH7eY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WtDnRd+2Hp42OL8ceHvh8bj72iIpyu5MVpiFJlJDVVfLevg2DC5+SuqxJL+n4Dl1/
         ugQ6s+xqpsYgOleBbJkO/Wbm409P5lHHM03lfXVqtl0DYgA6SKbmxNDAvoRl0Qdcdk
         H3EFF9sX6ZByNRNOfbPjajeh2hBLIPHbXt8oqyaU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M9K5G-1h8ak62QSE-00Cjkb; Wed, 17
 Apr 2019 18:11:16 +0200
Date:   Wed, 17 Apr 2019 18:11:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Drew DeVault <sir@cmpwn.com>
cc:     git@vger.kernel.org
Subject: Re: Generating a todo file for non-interactive rebasing
In-Reply-To: <20190416153709.GA19000@homura.localdomain>
Message-ID: <nycvar.QRO.7.76.6.1904171754060.46@tvgsbejvaqbjf.bet>
References: <20190416153709.GA19000@homura.localdomain>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:8F269zqfDFyIzce9E8hSsP36NLwaqB9V2jnjfTjjlOejMl+qYuZ
 p7mAuGK3PcIFtHa7Engsf4gWvtqnABn+w8S/4nsIZux9nJrnpj+QLCIFdIUV5go1Em1l8Ug
 NDSj+I5XItLAtoE4jaUXQpufJzupCVmQwEyAkwSn3yrLZctf40xMpL1tfWQalbWqbIYgCBp
 WRVQqACkm2G1krml4J/2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GcPj48FmNso=:nMKl1X+h2ThOI+3OF4rzoI
 AP24nL7jvg9yHsMTQl1wY3FKfzVUpIpkm/F7/4eyw5K5hw09nQ6Q4CSX5/KJEdba5ty7rsPRP
 me+Yvp7S5Qq5O9lF+5hKu03mDbXS5EcwKiW+6AY7iZu+uGhs5b8MaP2ryyff5eSYNH9KmKZ8N
 Ag65b/1m9jCb3Ez3zzW0agPeZwOATh35S1JasH80XnrodljfxrvAzXcfv4CTZKcuy8iibMdnK
 TY+pgfIjSNFW34VSlFnmJPdqXUkeTh46paTPAgrRJm2XyfllBF1yZQABKS9Jp03Jd2V+DsdAQ
 Zzqr9c6+z6qWFq87wIYNXt6QKiklQKTLJgxETUsxF7I9gQ4yMjgFQRoMJTHipKkJUP753wrOU
 Yno5e2BSwK3KsDy8AgOYWxnDUIQIO5gga6QEEdomiXGwuPANWjd+d3E8nd6lezLhjb2U6vRkj
 G3OTplRT3ei8YIMRdaXK3DJUlYewYJzCFxTr41JFZY+Jp3jl8dn4bvDOhCdaeIcGte2thC6E2
 hiqrExdlEkDkh/598J+0kNyd2zdzVDQYoT5riuFDrmN+M6H5K40TaHUTZ9qJIdBLoWU9FNsoP
 30a13+bJj1QtEwngfPaV2eGzOJ4Jn6QNi0szey0XXH60vmt98rIp413rBY0gg9hX+SJGNRJnj
 lQ0qbAetXneU6AzY++lEFrSxTLKADnoFhVC//LW+F9L3KncpbZ3W8cR5UcE14GrNudYQT9qOm
 sFF0dTzUC+gd+4aS1hId9ikS8Q81lNMTfYxX6nKJHwaGuRWpFgxtXuHTFYsS7FyaRJHnXqkpM
 zymD/ZnBdEIVQmzNM6XgYBxHYs7Na9p1U4f9N/mgINlcHIdsYJ52BkFd9Z4ouwoIiRjxyR+C5
 FdSuKDNs5MKMVa9+ZfVCPiW3CK3jX8rkAaIlf1nfp/qW1CIFFa0ZgeTnxdus48sN+4B3pzOx3
 UqCCfQrxfwQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Drew,

On Tue, 16 Apr 2019, Drew DeVault wrote:

> Whenever I do a particularly long rebase on a branch, sorting out
> conflicts from upstream, I find that it's often useful to have the
> additional context that you get during an interactive rebase, such as
> recent commands run, commands planned to run, and so on, to get a better
> idea of where I'm at during the rebase. These show when you run `git
> status` during an interactive rebase.
>
> However, the code that generates this report relies on a todo list being
> generated in the rebase state directory. A todo list which consists only
> of "pick" commands is functionally equivalent to a non-interactive
> rebase, the only difference being that the editor isn't shown to the
> user.
>
> Is there any reason not to refactor the rebase command to always
> generate a todo list? This would simplify the internals and provide more
> context to the user during hairy rebases. It might also be useful to run
> --edit-todo if you realize your rebase strategy needs to change partway
> through a rebase which was initially non-interactive.

The default mode of the rebase command is actually not based on picks, but
internally generates mails, puts them into an mbox, and then pretends to
apply those patches from a mailing list.

That mode is obviously very different from the interactive rebase, so
there is not quite the simplification in store that you hoped for.

However, we recently changed the way the --merge backend works, and it is
now indeed backed by the same machinery as the interactive rebase.
Meaning: if you call `git rebase -m <options>...`, you have what you
wished for. This change is part of v2.21.0.

To my surprise, Elijah Newren (who authored that change) then demonstrated
that in most cases, the `--merge` backend is actually *faster* than the
default (`--am`) backend. There were patches floating around to make it
the default rebase backend for that reason, but those patches were not
picked up yet.

Short version: if you add `--merge` or `-m` to your `git rebase`
invocations, you already get what you want.

Ciao,
Johannes
