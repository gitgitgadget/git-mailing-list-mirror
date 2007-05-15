From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: testing vger handling of charsets (part 1)
Date: Tue, 15 May 2007 20:42:58 +0200
Message-ID: <20070515184258.GA2407@steel.home>
References: <20070515test.1@coredump.intra.peff.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, kha@treskal.com, bfields@fieldses.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 15 20:43:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho1zJ-0001g0-Tw
	for gcvg-git@gmane.org; Tue, 15 May 2007 20:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755218AbXEOSnG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 15 May 2007 14:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755118AbXEOSnG
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 14:43:06 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:45242 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755218AbXEOSnF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 14:43:05 -0400
Received: from tigra.home (Fcb17.f.strato-dslnet.de [195.4.203.23])
	by post.webmailer.de (fruni mo29) (RZmta 6.3)
	with ESMTP id H02c60j4FFXK1Y ; Tue, 15 May 2007 20:42:58 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 4A6ED277BD;
	Tue, 15 May 2007 20:42:58 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 23690D171; Tue, 15 May 2007 20:42:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070515test.1@coredump.intra.peff.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBg8DQ==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47364>

Jeff King, Tue, May 15, 2007 09:12:05 +0200:
> This is a test message to check how vger reacts to seeing 8bit
> characters (like Hasselstr=F6m) in a message without the right mime
> header. Previous attempts were eaten by the list because of a lack of=
 a
> message id.

ok here. Headers:

Received: from googlemail-pop.l.google.com [66.249.93.16]
	by steel.home with POP3 (fetchmail-6.3.6 polling pop.googlemail.com ac=
count raa.lkml)
	for <raa@localhost> (single-drop); Tue, 15 May 2007 09:21:24 +0200 (CE=
ST)
Received: by 10.100.225.3 with SMTP id x3cs2418606ang;
        Tue, 15 May 2007 00:13:44 -0700 (PDT)
Received: by 10.82.177.3 with SMTP id z3mr3288934bue.1179213217602;
        Tue, 15 May 2007 00:13:37 -0700 (PDT)
Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.176.167])
        by mx.google.com with ESMTP id j2si425607mue.2007.05.15.00.13.0=
5;
        Tue, 15 May 2007 00:13:37 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of git-own=
er@vger.kernel.org designates 209.132.176.167 as permitted sender)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754566AbXEOHMI (ORCPT <rfc822;peter.baumann@gmail.com>
	+ 56 others); Tue, 15 May 2007 03:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754600AbX=
EOHMI
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 03:12:08 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3083=
 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754566AbXEOHMH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 03:12:07 -0400
Received: (qmail 26461 invoked from network); 15 May 2007 07:12:07 -000=
0
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 15 May 2007 07:=
12:07 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 1=
5 May 2007 03:12:05 -0400
Date:	Tue, 15 May 2007 03:12:05 -0400
=46rom:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
cc:	kha@treskal.com, peff@peff.net, bfields@fieldses.org
Subject: testing vger handling of charsets (part 1)
Message-ID: <20070515test.1@coredump.intra.peff.net>
Content-Type: text/plain; charset=3Dutf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	git@vger.kernel.org
Status: RO
Content-Length: 614
