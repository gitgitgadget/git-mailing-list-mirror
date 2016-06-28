Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E422F1FF40
	for <e@80x24.org>; Tue, 28 Jun 2016 08:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbcF1Ibw (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 04:31:52 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37786 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752065AbcF1Ibv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 04:31:51 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u5S8VY80016616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 28 Jun 2016 10:31:34 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u5S8VZ0Y015141;
	Tue, 28 Jun 2016 10:31:35 +0200
From:	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:	Jeff King <peff@peff.net>
Cc:	gitster@pobox.com, git@vger.kernel.org,
	Jordan DE GEA <jordan.de-gea@ensimag.grenoble-inp.fr>,
	Samuel GROOT <samuel.groot@ensimag.grenoble-inp.fr>,
	Erwan MATHONIERE <erwan.mathoniere@ensimag.grenoble-inp.fr>,
	Tom RUSSELLO <tom.russello@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH 1/6] doc: typeset short command-line options as literal
References: <20160627174623.11084-1-Matthieu.Moy@imag.fr>
	<20160627185715.GB9594@sigill.intra.peff.net>
Date:	Tue, 28 Jun 2016 10:31:35 +0200
In-Reply-To: <20160627185715.GB9594@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 27 Jun 2016 14:57:15 -0400")
Message-ID: <vpq60stzpco.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Tue, 28 Jun 2016 10:31:36 +0200 (CEST)
X-IMAG-MailScanner-Information:	Please contact MI2S MIM  for more information
X-MailScanner-ID: u5S8VY80016616
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check:	1467707499.38144@4Ftlva24Z0MSKA0BAomPjQ
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Jun 27, 2016 at 07:46:18PM +0200, Matthieu Moy wrote:
>
>> diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
>> index e453132..cbae886 100644
>> --- a/Documentation/git-mv.txt
>> +++ b/Documentation/git-mv.txt
>> @@ -35,7 +35,7 @@ OPTIONS
>>          Skip move or rename actions which would lead to an error
>>  	condition. An error happens when a source is neither existing nor
>>  	controlled by Git, or when it would overwrite an existing
>> -        file unless '-f' is given.
>> +        file unless `-f` is given.
>
> git-am complains about the space indentation in the post-image. I know
> it was there before your patch, but the indentation for that paragraph
> is off. I wonder if it makes sense to fix it as a preliminary patch.

There were just 2 mis-indented lines, I've added a preliminary patch to
fix them.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
