Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 253951F803
	for <e@80x24.org>; Wed,  9 Jan 2019 11:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730655AbfAILY4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 06:24:56 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:41149 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729843AbfAILY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 06:24:56 -0500
Received: from [192.168.3.76] (unknown [146.247.95.34])
        (Authenticated sender: jn.avila)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 5877B200415;
        Wed,  9 Jan 2019 12:24:24 +0100 (CET)
Subject: Re: Translation of git manpages
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Christopher_D=c3=adaz?= <christopher.diaz.riv@gmail.com>,
        Marco Paolone <marcopaolone@gmail.com>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Alessandro Menti <alessandro.menti@hotmail.it>,
        Jiang Xin <worldhello.net@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
References: <1992944.NOdEsaAZKb@cayenne> <87lg3v6yqr.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
Message-ID: <6513e65f-0282-10eb-fd79-059fb44a7d3e@free.fr>
Date:   Wed, 9 Jan 2019 12:24:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <87lg3v6yqr.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 09 2019, Ævar Arnfjörð Bjarmason wrote:
> > I think a way to have early exposure of these to a lot more people >
would be to have these on the git-scm.com site. Jeff knows more about >
the build process there. > > I see the general completion of French &
German is at ~10%, but > maybe there's some pages that are fully
translated already? We could > then have some UI or git-scm.com that
allows you to switch between > languages along with some general
overview page per-language.

Publishing on git-scm is on my TODO list. It' s a bit more difficult
than updating the original manpages, because the translation process
with po4a cannot be done in memory, which does not fit with the way the
publishing is done directly from gitster/git repo on github into the
database, plus the underlying data structure of the website needs to
evolve to account for new languages (and Ruby on Rails is a special beast) .



> > > Are the translations contributed through >
https://hosted.weblate.org/projects/git-manpages/translations/ >
something that license-wise (Signed-off-by etc.) we'd eventually be >
able to upstream in git.git?
I retained the same license as Git for the translation repo, to prevent
future issues with integration of the result in other projects. Right
now, there's no Signed-off-by line in Weblate issued commits. I opened
an issue to have them added. Should this policy have been enforced from
the start or is it too late for later inclusion in git.git?


> > It would be great to eventually have something we can build as part >
of our build process, so e.g. Debian can have git-man-de similar to >
manpages-de now.
I don't understand you remark. The point of the proposed patch is to
allow to build and install the translated manpages from a working tree
of git, by adding a checkout of git-manpages-l10n in a subdir of
Documentation (note to self: propose a patch to document this). From
this setup, generating proper localized manpage packages is perfectly
doable. Am I missing anything?



