From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] --pretty=format: on-demand format expansion
Date: Sat, 10 Nov 2007 15:34:35 -0500
Message-ID: <20071110203435.GB20592@sigill.intra.peff.net>
References: <4733AEA6.1040802@lsrfire.ath.cx> <20071109045040.GC31760@sigill.intra.peff.net> <4734EA4E.8070405@lsrfire.ath.cx> <20071110004635.GA14992@sigill.intra.peff.net> <47359221.7090707@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Nov 10 21:35:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqx2e-0003lE-Dl
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 21:34:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753852AbXKJUel convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Nov 2007 15:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753954AbXKJUel
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 15:34:41 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3643 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753748AbXKJUek (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 15:34:40 -0500
Received: (qmail 27640 invoked by uid 111); 10 Nov 2007 20:34:38 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 10 Nov 2007 15:34:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Nov 2007 15:34:35 -0500
Content-Disposition: inline
In-Reply-To: <47359221.7090707@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64376>

On Sat, Nov 10, 2007 at 12:12:33PM +0100, Ren=E9 Scharfe wrote:

> Yes, the two are independent.  I don't like the malloc()'s in your
> patch, though, and have cooked up a different one on top of a cleaned=
 up
> version of mine.  It plays the dirty trick of reading expansions of
> repeated placeholders from the strbuf..

Yes, the mallocs would obviously not be necessary for the commit
parsing, since we already have a buffer, but I assumed they would be fo=
r
the abbreviations.

Your solution leaves me partly disgusted at the hackishness, and partly
delighted at the cleverness. I think the way you have coded it is quite
clear, though, so I don't think anyone is likely to get confused readin=
g
it. I haven't read through it carefully yet, but a tentative Ack from
me.

-Peff
