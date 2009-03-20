From: Jeff King <peff@peff.net>
Subject: Re: ref name troubles, was Re: [PATCH v2] Introduce %<branch> as
	shortcut to the tracked branch
Date: Fri, 20 Mar 2009 02:05:45 -0400
Message-ID: <20090320060545.GB27008@coredump.intra.peff.net>
References: <200903181448.50706.agruen@suse.de> <20090318182603.GM8940@machine.or.cz> <alpine.DEB.1.00.0903182210310.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903182245280.10279@pacific.mpi-cbg.de> <7vr60ubgul.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903182343580.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200121330.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200137230.10279@pacific.mpi-cbg.de> <20090320004029.GX23521@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>,
	Andreas Gruenbacher <agruen@suse.de>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 20 07:07:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkXt7-0001RP-6a
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 07:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752290AbZCTGF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 02:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbZCTGF4
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 02:05:56 -0400
Received: from peff.net ([208.65.91.99]:54895 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751583AbZCTGFz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 02:05:55 -0400
Received: (qmail 6828 invoked by uid 107); 20 Mar 2009 06:06:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 20 Mar 2009 02:06:03 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2009 02:05:45 -0400
Content-Disposition: inline
In-Reply-To: <20090320004029.GX23521@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113899>

On Thu, Mar 19, 2009 at 05:40:29PM -0700, Shawn O. Pearce wrote:

> So yea, you can create a branch named "foo@{1}".

But you can't actually refer to it:

  $ git branch foo@{1}
  $ git show foo@{1} --
  fatal: bad revision 'foo@{1}'

which implies that nobody is actually using it for anything.

-Peff
