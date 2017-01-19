Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D652D20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 18:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754202AbdASSkZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 13:40:25 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:34938 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754149AbdASSkX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 13:40:23 -0500
Received: by mail-ot0-f195.google.com with SMTP id 65so5158226otq.2
        for <git@vger.kernel.org>; Thu, 19 Jan 2017 10:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=hvIglghObk6ZOjr2o3VcAM4kpFcUCrzj76mKh22N3Ws=;
        b=U3DuKZol/wQN0vzEVj65LK0V+sk+XNIoljoZ6izipJTsCT4lPxjC3RlHGa4AJPyGjn
         AUdIJLTOqiRPP39ibTtn2EZWbJu3O/2/eLdKRaV9IgtwcFN7DejvrhiV7RKJsRQ9kh2G
         NHNgPlhiw9qM45iPX+1S/w1qMKzdE0jhkjSsEo4j9dJhOLiN87oLrrBKTBscLXaMQUSy
         MxxmnO5dzsoOjEbY+JehTmI1U6SNKXUT1n/wRWjqxYQXiwpmjJOdfvMlln/cAaH6pgRg
         76XxSHSif+ce1nYSVdUE3cFfBtYUJo0Lb+SzzkQu5jK1ABvLcH/1IUQOtP7oVcH5Sga3
         hr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=hvIglghObk6ZOjr2o3VcAM4kpFcUCrzj76mKh22N3Ws=;
        b=Ud1irUgwNXal+RNjlmTCzwil8NKKtauw/hPr1OesHjBmomdG1ESa3uWYgRK2joFE1V
         EezmLmJlV9Uafa/ob2KeNHuxxCD3gcB1PvV0WU758qmQzss95pudcCUYvJipZNW6DjQb
         5qpaV1Ji+AzF3flToRlzUh1bdX3U0xLs3HuJQmIKI/fsvnqMWKC/bZOl7sbIC1vmSWFU
         8+Ecj8z+E+SBeHEZNt5dFkPuWQNIGLUXH/vXg+JSFGcAvKUDvYMCkilEcaFOGA8qCxES
         hvD/Xq89K7tootrRusu9gSfXBXBkS1XcJ68xmVJNk7+4Yo/b0HGkTatobWQQew3jvLMu
         FyKA==
X-Gm-Message-State: AIkVDXLbMdPNS8Zx8nIHS58s3kcrnc+eoUGmWLGcJpYms1j6Rg5lCOArld/mmhswa/xpgdWPVRKVgLqyDdGUzg==
X-Received: by 10.157.14.166 with SMTP id 35mr4913423otj.136.1484851178759;
 Thu, 19 Jan 2017 10:39:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.63.13 with HTTP; Thu, 19 Jan 2017 10:39:38 -0800 (PST)
In-Reply-To: <20170119093313.ea57832dfd1bc7e0b0f1e630@domain007.com>
References: <4817eb00-6efc-e3c0-53d7-46f2509350d3@synopsys.com> <20170119093313.ea57832dfd1bc7e0b0f1e630@domain007.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Jan 2017 10:39:38 -0800
X-Google-Sender-Auth: J7bgTeGvDEBdrMLgxY4nfJDXfmk
Message-ID: <CA+55aFxAe8bH2xXkx1p5gYN+nc-D-vjNnfUeA_64Q3ttpbHq+w@mail.gmail.com>
Subject: Re: Git: new feature suggestion
To:     Konstantin Khomoutov <kostix+git@007spb.ru>
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Git Mailing List <git@vger.kernel.org>,
        "CARLOS.PALMINHA@synopsys.com" <CARLOS.PALMINHA@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2017 at 10:33 PM, Konstantin Khomoutov
<kostix+git@007spb.ru> wrote:
>
> Still, I welcome you to read the sort-of "reference" post by Linus
> Torvalds [1] in which he explains the reasoning behind this approach
> implemented in Git.

It's worth noting that that discussion was from some _very_ early days
in git (one week into the whole thing), when none of those
visualization tools were actually implemented.

Even now, ten years after the fact, plain git doesn't actually do what
I outlined. Yes, "git blame -Cw" works fairly well, and is in general
better than the traditional per-file "annotate". And yes, "git log
--follow" does another (small) part of the outlined thing, but is
really not very powerful.

Some tools on top of git do more, but I think in general this is an
area that could easily be improved upon. For example, the whole
iterative and interactive drilling down in history of a particular
file is very inconvenient to do with "git blame" (you find a commit
that change the area in some way that you don't find interesting, so
then you have to restart git blame with the parent of that
unintersting commit).

You can do it in tig, but I suspect a more graphical tool might be better.

.. and we still end up having a lot of things where we simply just
work with pathnames. For example, when doing merges, it' absolutely
_wonderful_ doing

   gitk --merge <filename>

to see what happened to that filename that has a conflict during the
merge. But it's all based on the whole-file changes, and sometimes
you'd like to see just the commits that generate one particular
conflict (in the kernel, things like the MAINTAINERS file can have
quite a lot of changes, but they are all pretty idnependent, and what
you want to see is just "changes to this area").

We do have the "-L" flag to git log, but it doesn't actually work for
this particular case because of limitations.

So what I'm trying to say is that the argument from 10+ years ago that
"you can do better with intelligent tools after-the-fact" is very much
true, but it's also true that we don't actually have all those
intelligent tools, and this is an area that could still be improved
upon. Some of them are actually available as add-ons in various
graphical IDE's that use git.

                 Linus
