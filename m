Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 656281F803
	for <e@80x24.org>; Wed,  9 Jan 2019 10:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729933AbfAIKca (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 05:32:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:59014 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729919AbfAIKc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 05:32:29 -0500
Received: (qmail 26016 invoked by uid 109); 9 Jan 2019 10:32:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Jan 2019 10:32:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20230 invoked by uid 111); 9 Jan 2019 10:32:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 09 Jan 2019 05:32:29 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Jan 2019 05:32:27 -0500
Date:   Wed, 9 Jan 2019 05:32:27 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Christopher =?utf-8?B?RMOtYXo=?= <christopher.diaz.riv@gmail.com>,
        Marco Paolone <marcopaolone@gmail.com>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Alessandro Menti <alessandro.menti@hotmail.it>,
        Jiang Xin <worldhello.net@gmail.com>, git@vger.kernel.org
Subject: Re: Translation of git manpages
Message-ID: <20190109103227.GB6743@sigill.intra.peff.net>
References: <1992944.NOdEsaAZKb@cayenne>
 <87lg3v6yqr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lg3v6yqr.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 08, 2019 at 02:54:36PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > There is already a kernel of translation in French, from my experiments and a
> > previous effort of German translation[6] was gettextized. If you have such
> > archives for other languages, I'd be happy to integrate them, even if they are
> > not up to date.
> 
> Thanks. This has come up on list many times before and it's great to
> have some movement on it.
> 
> I think a way to have early exposure of these to a lot more people would
> be to have these on the git-scm.com site. Jeff knows more about the
> build process there.

Actually, Jean-Noël has done as much or more work as me on the manpage
(and book) build process for the site. :)

Basically, we just pull the pages from git.git, run them through
asciidoctor with a few ugly regex tweaks, and then that goes to the
site. We should be able to do the same for translations, and I agree
that even partial translations on the site may be a good way to get
exposure. The way the book translations are handled is probably a
workable model.

-Peff
