X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: git crash when cg-fetch:ing dash
Date: Thu, 23 Nov 2006 11:18:20 -0500
Message-ID: <BAYC1-PASMTP0184DDB7F3619F6158FB18AEE20@CEZ.ICE>
References: <45656B3C.4090601@lsrfire.ath.cx>
	<200611231554.kANFsv9h005228@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 23 Nov 2006 16:18:53 +0000 (UTC)
Cc: =?ISO-8859-1?B?UmVu6Q==?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061123111820.50a6488a.seanlkml@sympatico.ca>
In-Reply-To: <200611231554.kANFsv9h005228@laptop13.inf.utfsm.cl>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 23 Nov 2006 16:18:22.0403 (UTC) FILETIME=[FEEF9930:01C70F1A]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnHHO-0000oH-Fb for gcvg-git@gmane.org; Thu, 23 Nov
 2006 17:18:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755887AbWKWQSX convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006 11:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755970AbWKWQSX
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 11:18:23 -0500
Received: from bayc1-pasmtp01.bayc1.hotmail.com ([65.54.191.161]:30725 "EHLO
 bayc1-pasmtp01.bayc1.hotmail.com") by vger.kernel.org with ESMTP id
 S1755887AbWKWQSW convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>);
 Thu, 23 Nov 2006 11:18:22 -0500
Received: from linux1.attic.local ([65.93.43.81]) by
 bayc1-pasmtp01.bayc1.hotmail.com over TLS secured channel with Microsoft
 SMTPSVC(6.0.3790.1830); Thu, 23 Nov 2006 08:18:22 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1GnGLD-0003DH-HK; Thu, 23 Nov 2006 10:18:19 -0500
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Sender: git-owner@vger.kernel.org

On Thu, 23 Nov 2006 12:54:57 -0300
"Horst H. von Brand" <vonbrand@inf.utfsm.cl> wrote:

> Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:
> > Horst H. von Brand schrieb:
> > > I did:
> > >   git clone http://gondor.apana.org.au/~herbert/dash/dash.git
> > > and got:
> > >   error: Unable to start request
> > >   error: Could not interpret heads/master as something to pull
> >=20
> > It works for me with both the version of git that came with Ubuntu =
6.10
> > (1.4.1) and a self-compiled git 1.4.4.g5942. :-?
>=20
> Here it's git-1.4.4 (self-built from Junio's SRPM, on Fedora rawhide =
i686).

Works fine here with 1.4.3.3.g869c.

Horst, this is the second recent example of something not working in yo=
ur
environment that works for others.  Is it possible you have an old stra=
y
version of git installed in your ~/bin or something?  By the way, did y=
ou
ever resolve that other issue?

