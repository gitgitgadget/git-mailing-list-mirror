From: Jeff King <peff@peff.net>
Subject: Re: bug: "fatal: cannot pread pack file", version 1.7.5.4
Date: Thu, 16 Aug 2012 18:45:26 -0700
Message-ID: <20120817014526.GA447@sigill.intra.peff.net>
References: <5638dec6e156f83385a3baa01cf9ac4d@localhost>
 <20120702215736.GA5790@sigill.intra.peff.net>
 <m2vci5n5r5.fsf@igel.home>
 <20120703032345.GA7143@sigill.intra.peff.net>
 <CACsJy8AmCo82YxHA_6+rkbuJOjOG-HqCgjoP2tz753SXH5w8_Q@mail.gmail.com>
 <20120703051426.GA12965@sigill.intra.peff.net>
 <7vvcgizesm.fsf@alter.siamese.dyndns.org>
 <fd74d7233b4b29fe06afad23fb87552a@localhost>
 <7v4no2zbd9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lars Winterfeld <lars.winterfeld@tu-ilmenau.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 03:46:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2Bdb-0006Ug-K2
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 03:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309Ab2HQBpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 21:45:30 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39529 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932143Ab2HQBp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 21:45:29 -0400
Received: (qmail 23226 invoked by uid 107); 17 Aug 2012 01:45:40 -0000
Received: from 1153ahost142.starwoodbroadband.com (HELO sigill.intra.peff.net) (12.144.188.142)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Aug 2012 21:45:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Aug 2012 18:45:26 -0700
Content-Disposition: inline
In-Reply-To: <7v4no2zbd9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 16, 2012 at 04:05:22PM -0700, Junio C Hamano wrote:

> Lars Winterfeld <lars.winterfeld@tu-ilmenau.de> writes:
> 
> >> Hrm, has this ever been resolved?
> >
> > Thank you for asking.
> > My local git version is 1.7.5.4, the server version that I actually
> > ended up pushing the files to was however still some 1.6.x.
> > So it was a false alarm. Sorry about that.
> 
> Not really.  Pushing or fetching by a new version of Git against old
> version of Git *should* work; otherwise it is a bug.

Yes, but there may be old bugs in the server version that have since
been fixed. For example, the bug fixed by 838cd346 might be the cause of
this (that fix went into 1.6.0.3).

-Peff
