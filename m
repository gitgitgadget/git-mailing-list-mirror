Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 912B020193
	for <e@80x24.org>; Sun, 14 Aug 2016 21:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbcHNVKy (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 17:10:54 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:44390 "EHLO
	smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745AbcHNVKx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 17:10:53 -0400
Received: from PhilipOakley ([92.22.48.2])
	by smtp.talktalk.net with SMTP
	id Z2gCb3u1xcpskZ2gCbC6UN; Sun, 14 Aug 2016 22:10:51 +0100
X-Originating-IP: [92.22.48.2]
X-Spam:	0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=dUEO/agNDYQW2w9YSFWSZw==:117
 a=dUEO/agNDYQW2w9YSFWSZw==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=NEAV23lmAAAA:8 a=5rxgeBVgAAAA:8 a=pYe7Pd5aPhnXxyEZ80UA:9 a=swXGrevaCcEA:10
 a=6kGIvZw6iX1k4Y-7sg4_:22 a=Bn2pgwyD2vrAyMmN8A2t:22 a=PwKx63F5tFurRwaNxrlG:22
Message-ID: <D5A2E231FFE74D1C891A1653E1C2D797@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"Christian Couder" <christian.couder@gmail.com>,
	"git" <git@vger.kernel.org>
Cc:	"Thomas Ferris Nicolaisen" <tfnico@gmail.com>,
	"Nicola Paolucci" <durden@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	"Eric Wong" <normalperson@yhbt.net>,
	"Nguyen Thai Ngoc Duy" <pclouds@gmail.com>,
	"Stefan Beller" <sbeller@google.com>,
	"Michael Haggerty" <mhagger@alum.mit.edu>,
	"Ramsay Jones" <ramsay@ramsayjones.plus.com>,
	"remi galan-alfonso" <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	"Johannes Sixt" <j6t@kdbg.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	"Josh Triplett" <josh@joshtriplett.org>,
	"Lars Schneider" <larsxschneider@gmail.com>
References: <CAP8UFD1iveotLsMOBnpa=hU4ohcQjZ-X7tjnzY4k+xz5KJvqBw@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 18
Date:	Sun, 14 Aug 2016 22:10:49 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfCKXmui4CHId77HlJjtCLEwLxdLPQ9xz8bW9Xq6wcI27mLa1dToqL34My8BhXGeBq0/MWsmbvn8jv2ok4UqHoDCluwheIIRzWI5i24Uo6ImVjkX3/NFi
 jCqrD95b5NzZF2ae66mm+V+M7zdLaPamwDkAQugWntuDRwX4P0tVmz6ISMXXBcxkOdpcFo4/f/9qLlzFyRhjUAIip6uLBarkWmzwW1PaAJq08gcsxrXUUJpj
 09gkw1A1SOM14o1yenqgK4i3IVQgOpzrA0dgRGcOwyuKwtcwL5q1xE+UGweyc5qe2D16KndQJhykHp1pqD+8kWHuVbcLArJT4yAZotYLCmCp92klorRP2l70
 jXu5/fmBRXHc4dMXXYD4idN26ll9PUqMsG1BmbOFccgyJXtCqtgJX5t+hQCueavMk7wABXmPb1fkqKxXrEd+AaBRox2Lc9QnIRaHvnKzhmDdt9mD0zn6mLHR
 N67UjliNT8KTFIyzKsBHBqqWUL6mM/TEsGQPWQVeHxhvJ4J0UnkH84HqvlqMaxO+vSpyL1xsJDjRqBr5WeQEIxFFrl2G7gYUKS/7wUdCuPWUeFx6q9iaFxjP
 9U4LOqbubl/ORGiyXEttGbPqNvzrynAZQMQtXZBMpZe/oc+P1DqlJXfwB3gdqfgQZX4V+qlf7nSzqXKmR72UaPPz
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Christian Couder" <christian.couder@gmail.com>
> Hi,
>
> A draft of a new Git Rev News edition is available here:
>
> 
> https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-18.md
>
> Everyone is welcome to contribute in any section either by editing the
> above page on GitHub and sending a pull request, or by commenting on
> this GitHub issue:
>
>  https://github.com/git/git.github.io/issues/170
>
> You can also reply to this email.
>
> I tried to cc everyone who appears in this edition but maybe I missed
> some people, sorry about that.
>
> Thomas, Nicola and myself plan to publish this edition on Wednesday
> August 17. Sorry for the late draft again.
>
> Thanks,
> Christian.
> --

I see you mention in passing (weel in the small headings near the bottom) 
that gmane web interface has gone away. It may be worth noting a few of the 
alternatives, and in particular Eric's newly updated public-inbox 
https://public-inbox.org/git/.

I've found it very useful and probably easier to use. (now I've seen 
https://public-inbox.org/design_www.html)

--
Philip 

