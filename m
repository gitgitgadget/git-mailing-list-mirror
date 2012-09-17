From: Jeff King <peff@peff.net>
Subject: Re: How do I run tests under Valgrind?
Date: Mon, 17 Sep 2012 13:57:26 -0400
Message-ID: <20120917175726.GE1179@sigill.intra.peff.net>
References: <CALkWK0m_9OsAfG_pF3hUDW+EKCyZCn9NiDKKEW6AEOMmAw=yuA@mail.gmail.com>
 <20120917172022.GA1179@sigill.intra.peff.net>
 <CALkWK0m378ApSwa1xiYUqEjMny5m0wt3KacqdDRU1qt=cw6k8g@mail.gmail.com>
 <20120917173531.GB1179@sigill.intra.peff.net>
 <CALkWK0kDPGY_3v5SLPtyf+azUwA7msvQOvA+MaCgueZ71i2yGw@mail.gmail.com>
 <20120917174439.GD1179@sigill.intra.peff.net>
 <5057640C.80402@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Sep 17 19:57:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDfZi-0002bi-Kl
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 19:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080Ab2IQR5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 13:57:30 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:46676 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756043Ab2IQR5a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 13:57:30 -0400
Received: (qmail 9758 invoked by uid 107); 17 Sep 2012 17:57:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 17 Sep 2012 13:57:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Sep 2012 13:57:26 -0400
Content-Disposition: inline
In-Reply-To: <5057640C.80402@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205725>

On Mon, Sep 17, 2012 at 07:55:24PM +0200, Johannes Sixt wrote:

> Am 17.09.2012 19:44, schrieb Jeff King:
> > Oh, bleh. Stupid automatic --tee for valgrind. Try this:
> > 
> >   SHELL="/usr/bin/zsh -x" ./t0000-basic.sh --valgrind
> > 
> > I am also doing my tests with "dash" as my shell. You might try setting
> > your SHELL to /bin/sh to see if it makes a difference.
> 
> Shouldn't -v be used as well? Or is --valgrind different?

It turns "-v" on automatically.

-Peff
