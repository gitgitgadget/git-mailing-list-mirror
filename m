Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AFEF1F667
	for <e@80x24.org>; Wed, 16 Aug 2017 12:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751620AbdHPMzO (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 08:55:14 -0400
Received: from mout.web.de ([212.227.15.4]:50321 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751287AbdHPMzO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 08:55:14 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MfYXz-1dy9I52PT1-00P4Nl; Wed, 16
 Aug 2017 14:55:10 +0200
Date:   Wed, 16 Aug 2017 14:55:10 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     CHEVALLIER Yves <Yves.CHEVALLIER@csem.ch>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug with ignorecase on Git and Cygwin
Message-ID: <20170816125510.GA26384@tor.lan>
References: <078108E7D0BA58498F61BC8C1ED2D10933E86F@srvne111.csem.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <078108E7D0BA58498F61BC8C1ED2D10933E86F@srvne111.csem.local>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:xUG9HPACH+ArMoZgj51j9dQbGBXPhcST7H1H3TmTA2acV4NIscj
 tRoeRjzfrxH8Up2gMDsZowUZFtF1gF8TZQi2BPgOXIAR2e6mNeFaL7Iq4P5GO1Fbr3vYNjh
 410M9nOi/3jq5j/OZtEZy5ka5vp7DAOQRBsoBjjfjHonolGWvgHXoe0mQhGbwjW7FQkdPZx
 8PrLu/bloa9TVNv56eEJA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/0EOX4OJNzs=:Ngesado4Hn0ynrpjPUqpDa
 jQRDkFMTSHlE+7oArfEOUg3BkfnlHJ+Fm6LrKlqk/Kw/Fd9E9tYbk7aRmzPClk8LevU7h7Zp7
 XaVbhFGAfC9Y8WKaXBJwA96ldaDAf2e1uVSAJyac5cHMSs+URVfOSZqKPBXq0rHkKiiABkWE/
 bRrFbnsZuhdi9gRDJ87el2d5Zx/7dw8qvfwG7rgum4rfbDJU7beiVzL3VQOxX1VO4GmYSRywf
 cCHeVR6ZHU1lq/9ZmUVL3nFtbBTU32MoKke60xS9g0t6UdCaVhsqwWCSAqfVqGQ58KYqPjYHw
 brGDKoW534MT3fY6xNuCjO4StVb7VCQrIN5qyJGUL2/SlV13TVfOYGpJBIQok6JJJm7zBKIqW
 kZXi0Xs6wh9Xs7EvOhy83ORc/IRx5Z93VOcIXyC24CWUGacBYogoByjx3xrsKMyuhpoOuzlOh
 iskUqqQ0pZ3Hk1I8raXZRHuBC6cHSFIoINq60urHe+VU3PWVARDdu1si7QRs/9JhCwtjPcMKB
 XlwEWuQR+e8XjnXsTQXx0sGpxM6r7AA/oH8S0GtpQgmXwGiY7bN03s7o8ZJ9R7gFxW/FycGP7
 xLvXFMk+lkcYgwvDpj6Z9+yy2odbxsuSONpiPiysif4CX9+XxIpNquPWLTx1WYdTQxNfRjcsb
 KTAwShcjUsZ+xZjX5GGbK3PQFowcD01paOVrBSGKAq5yw/K7BWSsMkimPZ11DaJygg7QZJVGD
 nnxsD+MymHiocGvuiC1Mp5nattXoYXhhf5KRpRj+5lO4Gh26+bms1RP3BCd45+lTyFF45SbVt
 qQ1MlWC/6VhFJ1FoQTTirPDqOb1fQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 16, 2017 at 11:50:47AM +0000, CHEVALLIER Yves wrote:
> Hi, 
> 
> On Cygwin, the config value `ignorecase` is set to `true` during `git init` and it is not possible to change the default value using templates. 
> 
> The issue was discovered while I was tracking a bunch of source files of a SDK. To track the changes I simply rm all the working directory, unzip the new SDK, then git add . and git commit -am "new sdk". In this process an issue with an assembly file with preprocessing was incorrectly named .s instead of .S. In the next version the correction was made, but Git was unable to detect it. 
> 
> That said I've tried to manually change ignorecase from true to false and I still have the issue. Git on Cygwin cannot detect files renamed with a case change. 
> 
> Is it a bug?
> 

The thing is that the underlying file system (under cygwin, Windows in general, or MacOs)  treats a.s the same as a.S
So Git can not do better than the file system.
What you can do:

git mv a.S a.s
git commit

(This can be done by a script)

> # It works on Ubuntu
[]
