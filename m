Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D521BC433DB
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 16:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D35864E0D
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 16:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbhA1Quh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 11:50:37 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:32965 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbhA1QuH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 11:50:07 -0500
Received: from localhost (unknown [103.82.80.236])
        (Authenticated sender: me@yadavpratyush.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 46D0B200016;
        Thu, 28 Jan 2021 16:49:16 +0000 (UTC)
Date:   Thu, 28 Jan 2021 22:19:14 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     =?utf-8?B?0JrQu9GO0YjQuNC9INCc0LjRhdCw0LjQuw==?= 
        <klyushinmisha@gmail.com>
Cc:     Mikhail Klyushin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
Subject: Re: [PATCH] git-gui: fix typo in russian locale
Message-ID: <20210128164914.ppfjof5sit2zdin7@yadavpratyush.com>
References: <pull.837.git.1610620750894.gitgitgadget@gmail.com>
 <20210114173750.gc4ibqzt4ghhwkpj@yadavpratyush.com>
 <CADN2PDZG_yCtxsuNuLCpcPH9zykefHBAOH7k3K6fAGWbTZooYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADN2PDZG_yCtxsuNuLCpcPH9zykefHBAOH7k3K6fAGWbTZooYQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/01/21 07:47PM, Клюшин Михаил wrote:
> Hi!
> 
> It seems there is no progress on the patch. So maybe there is another way
> to validate it because the patch itself is so trivial? Maybe attached
> screenshots from Google Translate can help?
> You can see a spellchecker showing alerts on text.

Since no one has objected, and Dimitriy has not replied, I will pick it 
up in the next release.
 
> Best regards,
> Mikhail Klyushin
> 
> чт, 14 янв. 2021 г. в 20:38, Pratyush Yadav <me@yadavpratyush.com>:
> 
> > +Cc Dimitriy since he is the last person to touch the Russian
> > translation.
> >
> > On 14/01/21 10:39AM, Mikhail Klyushin via GitGitGadget wrote:
> > > From: Mikhail Klyushin <klyushinmisha@gmail.com>
> > >
> > > Fixed typo in russian locale: издекса -> индекса
> >
> > Thanks for the patch. Dimitriy can you please acknowledge/review that
> > the change is sane?
> >
> > >
> > > Signed-off-by: Mikhail Klyushin <klyushinmisha@gmail.com>
> > > ---
> > >     git-gui: fix typo in russian locale
> > >
> > > Published-As:
> > https://github.com/gitgitgadget/git/releases/tag/pr-837%2Fklyushinmisha%2Ffix%2Ftypo-in-russian-locale-v1
> > > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git
> > pr-837/klyushinmisha/fix/typo-in-russian-locale-v1
> > > Pull-Request: https://github.com/gitgitgadget/git/pull/837
> > >
> > >  git-gui/po/ru.po | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/git-gui/po/ru.po b/git-gui/po/ru.po
> > > index 161ee1ac8cb..7aebaf809d0 100644
> > > --- a/git-gui/po/ru.po
> > > +++ b/git-gui/po/ru.po
> > > @@ -331,7 +331,7 @@ msgstr "Добавить изменённые файлы в индекс"
> > >
> > >  #: git-gui.sh:2936
> > >  msgid "Unstage From Commit"
> > > -msgstr "Убрать из издекса"
> > > +msgstr "Убрать из индекса"
> > >
> > >  #: git-gui.sh:2942 lib/index.tcl:521
> > >  msgid "Revert Changes"
> > >
> > > base-commit: 72c4083ddf91b489b7b7b812df67ee8842177d98
> > > --
> > > gitgitgadget
> >
> > --
> > Regards,
> > Pratyush Yadav
> >




-- 
Regards,
Pratyush Yadav
