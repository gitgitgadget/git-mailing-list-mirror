Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB8721F453
	for <e@80x24.org>; Mon, 28 Jan 2019 16:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388367AbfA1QzU (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 11:55:20 -0500
Received: from ikke.info ([178.21.113.177]:34038 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387848AbfA1QzR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 11:55:17 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 886A44400C3; Mon, 28 Jan 2019 17:55:15 +0100 (CET)
Date:   Mon, 28 Jan 2019 17:55:15 +0100
From:   Kevin Daudt <me@ikke.info>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'COLLOMB Joris -EXT' <joris.collomb-ext@alstomgroup.com>,
        git@vger.kernel.org
Subject: Re: Git checkout multiple options issue
Message-ID: <20190128165515.GA25995@alpha>
References: <HE1PR01MB3722DCA42B6E16CB9DEEC29EA9960@HE1PR01MB3722.eurprd01.prod.exchangelabs.com>
 <000201d4b713$7edcd3d0$7c967b70$@nexbridge.com>
 <HE1PR01MB3722D90668E75E4BCDBA71F2A9960@HE1PR01MB3722.eurprd01.prod.exchangelabs.com>
 <000701d4b71c$f3ba57f0$db2f07d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <000701d4b71c$f3ba57f0$db2f07d0$@nexbridge.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 28, 2019 at 10:20:02AM -0500, Randall S. Becker wrote:
> On January 28, 2019 9:25, COLLOMB Joris wrote:
> > -----Message d'origine-----
> >> De : Randall S. Becker <rsbecker@nexbridge.com> Envoyé : lundi 28 janvier
> >> 2019 15:12 À : COLLOMB Joris -EXT <joris.collomb-ext@alstomgroup.com>;
> >> git@vger.kernel.org Objet : RE: Git checkout multiple options issue
> >> 
> >> On January 28, 2019 8:25, COLLOMB Joris wrote:
> >> > git checkout -fb "branch_name"
> >> > (force branch creation and checkout it)
> >> >
> >> > doesn't work (even if option a separated).
> >> >
> >> > I don't know if this is consider as an issue, but here it is.
> >> 
> >> I think you might mean (which works on every platform I have):
> >> 
> >> git checkout -f -b "branch_name"
> >> 
> >> There is no provision for aggregating options into one. -fb (invalid) is
> not the
> >> same as -f -b (valid).
> 
> > git checkout -f -b "branch_name"
> > gives me " Fatal: A branch named 'branch_name' already exists."
> 
> Once the branch is created, you can't force its creation, because it is
> already created. Just
> 
> git checkout "branch_name"
> 
> is sufficient at this point. git is correct to complain that you are trying
> to create a branch that already exists.

git checkout -B exists, which does exactly that: force create a branch
at a new positon if it already exists.

Kind regards, Kevin
