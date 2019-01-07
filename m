Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1EB21F803
	for <e@80x24.org>; Mon,  7 Jan 2019 20:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfAGUp3 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 7 Jan 2019 15:45:29 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:34361 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbfAGUp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 15:45:29 -0500
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:33e:2802:50eb:d77d])
        by smtp2-g21.free.fr (Postfix) with ESMTP id 3D5F12003C3;
        Mon,  7 Jan 2019 21:45:13 +0100 (CET)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Christopher =?ISO-8859-1?Q?D=EDaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?ISO-8859-1?Q?Jean=2DNo=EBl?= Avila <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Alessandro Menti <alessandro.menti@hotmail.it>,
        Jiang Xin <worldhello.net@gmail.com>
Cc:     git@vger.kernel.org
Subject: Translation of git manpages
Date:   Mon, 07 Jan 2019 21:45:12 +0100
Message-ID: <1992944.NOdEsaAZKb@cayenne>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear fellow translators,

I'm trying to put up a longstanding project of providing translated manual 
pages for Git. After several experiments, the best choice seemed to be the use 
of po4a[1] to convert the asciidoc[2] sources of git manpages into po files 
that could be processed the same way we are already doing for the translation 
of Git itself.

The text is segmented into paragraphs and structural units (titles, list 
items...) and when translated, they are reinjected into the original text 
structure. Only inline asciidoc formatting marks are passed in segments. 

The translation takes place in a dedicated repository[3]  . It simpler to not 
meddle in git main workflow while adjusting the translation workflow. If 
everybody is satisfied with it, we can maybe migrate the repo under git 
organization. Now, this repo is standalone with respect to translation content 
source, but a patch has been submitted so that the translated manpages can be 
generated and installed from the main git project[4]. Symmetrically, there's a 
script in the project to pull the manpages source files from the main git repo. 

The repository is connected to Weblate[5]  if you have collaborators who don't 
know how to process po files and prefer translating in the browser. 

The repository is also open to pull-request on the tooling. Let me know if you 
have issues. In any case, the translation work can be reused for any other 
arrangements.

There is already a kernel of translation in French, from my experiments and a 
previous effort of German translation[6] was gettextized. If you have such 
archives for other languages, I'd be happy to integrate them, even if they are 
not up to date.

--
Jean-Noël

[1]: https://po4a.org/
[2]: http://asciidoc.org/
[3]: https://github.com/jnavila/git-manpages-l10n
[4]: https://public-inbox.org/git/20190104165406.22358-1-jn.avila@free.fr/
[5]: https://hosted.weblate.org/projects/git-manpages/translations/
[6]: https://repo.or.cz/w/gitman-de.git


