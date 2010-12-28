From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] diff: funcname and word patterns for perl
Date: Mon, 27 Dec 2010 22:52:11 -0500
Message-ID: <20101228035210.GA11735@sigill.intra.peff.net>
References: <20101222234843.7998.87068.stgit@localhost.localdomain>
 <201012252314.22541.jnareb@gmail.com>
 <20101226090731.GA21588@burratino>
 <201012270014.09962.jnareb@gmail.com>
 <7vmxnrxhgm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"J.H." <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 28 04:57:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXQgg-0007k5-Rw
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 04:57:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753246Ab0L1DwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Dec 2010 22:52:20 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:51251 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752409Ab0L1DwU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Dec 2010 22:52:20 -0500
Received: (qmail 18825 invoked by uid 111); 28 Dec 2010 03:52:18 -0000
Received: from pool-74-108-55-63.nycmny.fios.verizon.net (HELO sigill.intra.peff.net) (74.108.55.63)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 28 Dec 2010 03:52:18 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Dec 2010 22:52:11 -0500
Content-Disposition: inline
In-Reply-To: <7vmxnrxhgm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164230>

On Mon, Dec 27, 2010 at 09:18:17AM -0800, Junio C Hamano wrote:

> Jonathan's pattern set allows them to be indented, and followed by some
> garbage at the end., which we might want to tighten.  How many people
> start 'package' and the outermost 'sub' indented?

FWIW, I sometimes do:

{
  my $static;
  sub foo {
    ... use $static ...
  }
}

so perhaps allowing whitespace in front of the keyword is worthwhile
there. I have never indented "package", though.

-Peff
