Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6E0320986
	for <e@80x24.org>; Tue, 27 Sep 2016 20:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936255AbcI0U4j (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 16:56:39 -0400
Received: from mail.pdinc.us ([67.90.184.27]:53588 "EHLO mail.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934907AbcI0U4h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 16:56:37 -0400
Received: from black7 (66.sub-97-34-205.myvzw.com [97.34.205.66])
        (authenticated bits=0)
        by mail.pdinc.us (8.14.4/8.14.4) with ESMTP id u8RKuY8h009766;
        Tue, 27 Sep 2016 16:56:34 -0400
Reply-To: <git@vger.kernel.org>
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>
References: <66A60DA77398CD439FA676CEF593977D692508@exchange.1.internal.pdinc.us>        <62E3FC352BE4428A90D7E4E9B137A9FB@black7>        <50DEA1C222E449F59BC8488C921D6F95@black7> <xmqqlgydqqk0.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqlgydqqk0.fsf@gitster.mtv.corp.google.com>
Subject: RE: git-upload-pack hangs
Date:   Tue, 27 Sep 2016 16:56:43 -0400
Organization: PD Inc
Message-ID: <0BEA07EEEA54435BB0124C8F02D156D2@black7>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AdIY2Iwe24IV7lW8SimL4NLEg77K+QAKF7EQ
X-MimeOLE: Produced By Microsoft MimeOLE V6.1.7601.17609
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Junio C Hamano
> Sent: Tuesday, September 27, 2016 12:02
> 
> Jason Pyeron writes:
> 
> > This is a very, very first draft.
> >
> > It is allowing IIS to work right now.
> >
> > I still need to address chunked issues, where there is no 
> content length (see 
> http://www.gossamer-threads.com/lists/apache/users/373042)
> >
> > Any comments, sugestions?
> 
> Does this have any relation to another thread earlier this year,
> which seems to have ended here:
> 
> https://public-inbox.org/git/20160401235532.GA27941@sigill.intra.peff.net/

Looks like the same. Did not (don't know why I was unsubscribed a few months ago?!) see that one and gmane is killing me on my
searches...

I will read the full thread, digest and fold what I can glean in to my (in production right now) patch.

-Jason

