Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C88551FF6D
	for <e@80x24.org>; Sun, 18 Dec 2016 13:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761021AbcLRNQw (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Dec 2016 08:16:52 -0500
Received: from mout.gmx.net ([212.227.15.19]:50362 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760876AbcLRNQv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Dec 2016 08:16:51 -0500
Received: from [192.168.178.43] ([88.71.250.242]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MCLcP-1cRi8M0x97-0098bW; Sun, 18
 Dec 2016 14:16:47 +0100
Subject: Re: Suggestion for the "Did you mean this?" feature
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        git@vger.kernel.org
References: <1482063500.10858.1.camel@gmail.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <5e1a3c4b-43b9-29f2-68fe-8149d9940123@gmx.net>
Date:   Sun, 18 Dec 2016 14:16:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.0
MIME-Version: 1.0
In-Reply-To: <1482063500.10858.1.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:bKwIMZ9TyA4dclETdWD8fdjp3UbQDbf+jnXRDUhk67BaUwABK+g
 LErexDIV56MtUlQY9zHDhzLBzbN3DsDx67zQS99MK1Q07v/v3iSUla6l7/JQnGNYjLklBfx
 qlQA/69GUBoPj7Te2IqqQm3ORKke7wjANgHqT2ZSn4duCAta83a7dLhYc827NNZzbF2X5nl
 TogJ7JSUSc3wwpmEGjZ/w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:U5pSLhyExSo=:A1hE2xsRg3uURLj7WOVezF
 wdMKraMIIeFdbTg09hqmDyWJCA4muSvq+CxPKSsA8T7lF6uPOPlfolNW65pg/KSVLTmet9xNA
 XL+iJ88Jl4+IqzTf67E3eGBjbFfFAM9KaMm1r2932XYXZvjseU8LxX2C3gd0Zd6k24V1lXpI+
 A2/yO2OgFSWEHA0qgwUsixrTQFSYYzcNOg3ORY6koZOFzR/hZabUM6EfSip6dkBcJQponUtNR
 1EyPfxmokHBiOqdC62DXlG9EOpb5G753fKMIiZhmvSA+/4EWe4FUksYasBEXypp0v527QEhNT
 REauc/joHeTNrkqXsDxggNxU0A25cHkY516DVY+69AJic7FqH5sW/Z2486kP/tmweecPnyu8B
 8GvUh1asqk8fphu7AojJMMmUnb706Rzox8lHEeyJ+WWNmR9VNuITcYTheUyt68OMCiaG3W5I+
 z1KH7lsd+L7NxqKm5VcVjDfO6tsP2LwywPJwM5k02bXms1O+KrXM1hx2OsmZ8JEX7mermmS6c
 WXUD4UZhMriTQ9pBqdrHbcZDUmzT+dRUGv/me10leqMM+aw2v1y6PhJ40QfhFVVWxlYUGRNwD
 eBGFkkHA5lt2cLhZLGK+UVndwn7Z0k17SW8VsxY5cYGTyMB9ZKwsfaC6PkPtfFkO0/5ywMPoF
 LbiteSxKrQMGz5IUozV7dLyrWpGmeKODm2RuqRbPywer4AyRRzL8HUhZUU2oCwEuUe74ECWIY
 AU35KujzRJXMU9T8nbAPCAFeh8ZF9Zahev07O1fLR6WyNsJtkDpF2TBVCtuaGfwIqSU+QO03U
 viB5J8s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 12/18/2016 01:18 PM, Kaartic Sivaraam wrote:
> I have found the "Did you mean this?" feature of git as a very good
> feature. I thought it would be even better if it took a step toward by
> asking for a prompt when there was only one alternative to the command
> that was entered. 
> 
> E.g.
> 
>> unique@unique-pc:~$ git hepl
>> git: 'hepl' is not a git command. See 'git --help'.
>>
>> Did you mean this?
>> 	help
>> [yes/No] : y
>> usage: git [--version] [--help] [-C <path>] [-c name=value]
>>            [--exec-path[=<path>]] [--html-path] [--man-path] [--info-
>> path]
>> ....
> 
> This would make it even better for the user as it would avoid having to
> correct the mistake long commands that had only a single error
> (considering history feature is enabled). 
> 
> Is this is a good idea ?

I cannot tell if this is a good idea (or why it would be a bad idea) but
why do you restrict your suggestion to the case when there is only one
alternative?

Why not also something like:

---
$ git sta
git: 'sta' is not a git command. See 'git --help'.

Did you mean one of these?
	[1] status
	[2] stage
	[3] stash
You can choose or quit [1,2,3,q]:
---


Best
  Stephan
