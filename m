Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 564991F859
	for <e@80x24.org>; Tue,  9 Aug 2016 12:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752504AbcHIMIE (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 08:08:04 -0400
Received: from mout.gmx.net ([212.227.15.19]:53298 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045AbcHIMID (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 08:08:03 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LdHqj-1aoiSe04VF-00iW3w; Tue, 09 Aug 2016 14:07:45
 +0200
Date:	Tue, 9 Aug 2016 14:07:41 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Michael Haggerty <mhagger@alum.mit.edu>
cc:	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Richard Ipsum <richard.ipsum@codethink.co.uk>,
	Eric Wong <e@80x24.org>, Josh Triplett <josh@joshtriplett.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16] merge_recursive:
 abort properly upon errors
In-Reply-To: <6c937f79-2b82-619d-51fe-adccbe09bd66@alum.mit.edu>
Message-ID: <alpine.DEB.2.20.1608091402540.5786@virtualbox>
References: <cover.1469547160.git.johannes.schindelin@gmx.de> <cover.1470051326.git.johannes.schindelin@gmx.de> <8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de> <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608021004080.79248@virtualbox> <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608031021050.79248@virtualbox> <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com> <alpine.DEB.2.20.1608031753431.107993@virtualbox>
 <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com> <alpine.DEB.2.20.1608041730130.5786@virtualbox> <6c937f79-2b82-619d-51fe-adccbe09bd66@alum.mit.edu>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:v/H/x6IkCmGRjIE7VdK2eQf224bUnODnlGVaaqxbAsT2nqAZIPZ
 G3RZowDC0YwAGlvjE6HALSVVCcuhuOI1w138VuYr09BDHk14Se4X2S/OMOaG3eX9WrEr7F1
 4Uvf/lu8+5Bbec5uNLXgoLPbZdZ2+U+NOPtVMHBPa+PzzASFs6pM+EswgQPFqHVRhTrqrra
 oda8rkmeX/GFp6q6XscEw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:pgBy6fdVoTE=:QReXvMDoKNMcqZbOizpzXI
 4hHdmRIgzkTDRZtBRpzUdPhCz8/QNeBXkGB867wUtzOQGjbin4de/e1kkcw7cb/H3L0AIzEYG
 iUpcjoAdv0vFpyqWbFlLWBwasdaF1yL0u8IWoneNDrADW7rzxsg3UXxfiIPGSkVxkdnT5/xZY
 TfdqwqzRTr0M1N36tqfdkimU0Ho+jCzpBrVorGXR5bVMccwgndzFg76zQ8zPKpcXNzJadDUac
 bx6k9fTuUBiMiYZO846D57obbdUFjnHlT9sH2wre8O4xGIm7dYH3NaIHHRMUnaWPnBkifc3eq
 WBmsdUR2R5zmaLdeEXD1RPKSS7/nYtdFGyP5GOToyHamJI+RcbmHaLc2dXM9P81Mpu6M+VWQw
 uxvda14X0wBzF4x9Hd2L0RGzbp/EGFlU2VDA9kBivk1n8BLNmQfO9i0ld7wWrPL1czKEIQigq
 L8oZ7Fd1tivAwc9SssxbmbUGkS93tmd7E+5WyymiBIItqELtLhpuH1AJbcOh/H8fzcNiKdfak
 C2eD0joR54DKAlRMxkz4Jcte7edcFdvqBK9V3IJirW4BKfa8fpm+qoX2Rv4e3FOXc2W//exvB
 KjeBjva4dEUYTHiayQY7Zus42mGcw4LAf35tY0XRBKmLMs/qTmGB/Tsl3KXbjuiSGRj7vNi4R
 NnWo1HBGokxZLV0OOYx/0dGgqIzgxR0LVkTs3WJtdaqFwxKYqlx6D9Qil7gAvtjNviJLkiSbk
 K8WNkQ5P17HXPHRizOoo4p/Qs9vGVtqm0UU5WfpxSldyuJ210hxfjgULkFKBhr8OEuRLDn/Vk
 CAwN0mb
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Michael,

On Tue, 9 Aug 2016, Michael Haggerty wrote:

> On 08/04/2016 05:58 PM, Johannes Schindelin wrote:
> > [...]
> > Even requiring every contributor to register with GitHub would be too
> > much of a limitation, I would wager.
> > [...]
> 
> Is it *really* so insane to consider moving collaboration on the Git
> project to GitHub or some other similar platform?

Speaking for myself, I do prefer GitHub's UI to mail, by a lot. Not only
because it is more focused on the code, but because it integrates so
nicely with Git, which email distinctly does not.

So I personally would not have the least bit of a problem to switch to
GitHub (that's indeed what Git for Windows did, getting substantially more
contributions than we would otherwise have).

And of course I use the email notifications quite a bit. They are really
convenient: I get my updates via my mail program, still, and the
discussion I want to participate in is just one click away.

The reason why I stated that GitHub is out of the question is that I
expected resistance against it. But you are right: I should not have ruled
it out so categorically, it is not at all my call to make.

Ciao,
Dscho
