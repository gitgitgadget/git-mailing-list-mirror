From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/5] t3301: use test_must_fail instead of !
Date: Tue, 17 Feb 2009 11:34:13 -0500
Message-ID: <20090217163413.GB31297@sigill.intra.peff.net>
References: <200902142056.42198.trast@student.ethz.ch> <8c50889d27e5baec1cbbd9a5775fa80b986c6df6.1234642638.git.trast@student.ethz.ch> <7vvdrcnnl0.fsf@gitster.siamese.dyndns.org> <200902151711.45099.trast@student.ethz.ch> <20090215181818.GA2291@coredump.intra.peff.net> <e2b179460902170129s7ae613cehe237619be5e84936@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 17:36:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZSvC-0007gx-7k
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 17:35:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752482AbZBQQeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 11:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752361AbZBQQeS
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 11:34:18 -0500
Received: from peff.net ([208.65.91.99]:55052 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752088AbZBQQeS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 11:34:18 -0500
Received: (qmail 30100 invoked by uid 107); 17 Feb 2009 16:34:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 17 Feb 2009 11:34:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Feb 2009 11:34:13 -0500
Content-Disposition: inline
In-Reply-To: <e2b179460902170129s7ae613cehe237619be5e84936@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110409>

On Tue, Feb 17, 2009 at 09:29:57AM +0000, Mike Ralphson wrote:

> posh? http://packages.debian.org/lenny/posh
> 
> I've heard that if you unset POSIXLY_CORRECT it just sits there and
> hums until you set it again. 8-)

Hmm. I tried "make SHELL_PATH=/bin/posh test", and posh segfaulted during
t0005. So I don't think it's quite ready for mainstream use. ;)

-Peff
