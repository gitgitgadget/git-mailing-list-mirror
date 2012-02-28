From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] Documentation: use {asterisk} in rev-list-options.txt when needed
Date: Wed, 29 Feb 2012 00:03:53 +0100
Message-ID: <87hayar25i.fsf@thomas.inf.ethz.ch>
References: <1330443348-5742-1-git-send-email-cmn@elego.de>
	<20120228194551.GC11725@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	<git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 29 00:04:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2W5Y-0003hb-L9
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 00:04:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757430Ab2B1XD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 18:03:58 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:50670 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754175Ab2B1XD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 18:03:57 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 29 Feb
 2012 00:03:53 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (188.155.176.28) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 29 Feb
 2012 00:03:54 +0100
In-Reply-To: <20120228194551.GC11725@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 28 Feb 2012 14:45:51 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [188.155.176.28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191790>

Jeff King <peff@peff.net> writes:

> Anyway, that is not a problem with your patch. :) I confirmed that the
> bug happens in my version of the toolchain, and your fix works (I also
> tried using `*`, but backtick does not suppress markup.

Actually it would, if it weren't for our use of '-a no-inline-literal'.
Which we are using because the "backticks do not interpret {stuff}"
feature was introduced in a backwards-incompatible way in asciidoc
8.4.1, see 71c020c (Disable asciidoc 8.4.1+ semantics for `{plus}` and
friends, 2009-07-25).

Some googling tells me the distros are currently at

  openSuSE         8.4.5   (local)
  Debian (stable)  8.5.2   packages.debian.org
  Fedora           8.4.5   admin.fedoraproject.org/pkgdb/
                           (but I can't discern whether it's actually in there...)
  Arch             8.6.6   www.archlinux.org/packages/
  Ubuntu 11.10     8.6.4   packages.ubuntu.com

so perhaps the time has come to remove that switch?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
