Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CF911FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 18:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630AbcHJSzH (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 14:55:07 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:51071 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965077AbcHJSzF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 14:55:05 -0400
Received: (qmail 1100 invoked from network); 10 Aug 2016 13:28:23 -0000
Received: (qmail 5318 invoked from network); 10 Aug 2016 13:28:23 -0000
Received: from unknown (HELO catarina) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <gitster@pobox.com>; 10 Aug 2016 13:28:18 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
Message-ID: <1470835697.2820.3.camel@sapo.pt>
Subject: Re: [PATCH 2/3] i18n: archive: mark errors for translation
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Date:	Wed, 10 Aug 2016 13:28:17 +0000
In-Reply-To: <xmqqvaz991m0.fsf@gitster.mtv.corp.google.com>
References: <1470654961-2842-1-git-send-email-vascomalmeida@sapo.pt>
	 <1470654961-2842-2-git-send-email-vascomalmeida@sapo.pt>
	 <xmqqvaz991m0.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.4 (3.20.4-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

A Ter, 09-08-2016 às 12:35 -0700, Junio C Hamano escreveu:
> Hmm, this function is called by write_archive(), which can be called
> by the upload-archive process running on the remote end, whose
> locale certainly is different from that of your local environment.
> 
> If I do not read English and got one of these messages from the
> remote end, I can copy that into a search engine to read more about
> the error, but if I got it translated into, say, Portuguese, I'd
> have a (slightly) harder time dealing with the error, I would think.
> 
> Having said that, I expect that sites that expect internatinal
> audience to come would run these services in C locale, and other
> sites that target audiences in a single locale would choose to use
> their favourite single locale, so probably we do not have to worry
> about it.

I don't know what is the best. I trust you to decide. I'm happy with
whatever you decide.

When I marked those string I did not noticed what you did, just spot
the string and marked them. So I submitted this without taking that
into consideration.
