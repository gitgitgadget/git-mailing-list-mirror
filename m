Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 214A21FA14
	for <e@80x24.org>; Tue, 18 Apr 2017 17:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757536AbdDRRDh (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 13:03:37 -0400
Received: from ikke.info ([178.21.113.177]:39486 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753293AbdDRRDe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 13:03:34 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id DAD7C4400BD; Tue, 18 Apr 2017 18:53:30 +0200 (CEST)
Date:   Tue, 18 Apr 2017 18:53:30 +0200
From:   Kevin Daudt <me@ikke.info>
To:     "Bonk, Gregory" <gbonk@icct.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: FW: Issue in gitbash changing directory
Message-ID: <20170418165330.GB24697@alpha.ikke.info>
References: <DM5PR04MB061907F6F650E56FE2ECBCD5C7190@DM5PR04MB0619.namprd04.prod.outlook.com>
 <DM5PR04MB06197EF8FA0344708A69C842C7190@DM5PR04MB0619.namprd04.prod.outlook.com>
 <DM5PR04MB061992BA437ACAD18A5F44DBC7190@DM5PR04MB0619.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM5PR04MB061992BA437ACAD18A5F44DBC7190@DM5PR04MB0619.namprd04.prod.outlook.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2017 at 12:48:09PM +0000, Bonk, Gregory wrote:
> 
> I accidently typed 'cd //'  and it worked.
> 
> gbonk@ICC11167 MINGW64 /c/git/mtb-messagehub-information-radiator (master)
> $ cd //
> 
> gbonk@ICC11167 MINGW64 //
> $ cd ..

This has very little to do with git, but more with bash (the shell that
is interpretting the command. From a bash FAQ [1]:

> E10) Why does `cd //' leave $PWD as `//'?
> 
> POSIX.2, in its description of `cd', says that *three* or more leading
> slashes may be replaced with a single slash when canonicalizing the
> current working directory.
> 
> This is, I presume, for historical compatibility.  Certain versions of
> Unix, and early network file systems, used paths of the form
> //hostname/path to access `path' on server `hostname'.

So this is kind of intentional.


[1]: https://tiswww.case.edu/php/chet/bash/FAQ
