From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Avoid segfault with 'git branch' when the HEAD is
	detached
Date: Wed, 18 Feb 2009 22:33:29 -0500
Message-ID: <20090219033329.GA13666@coredump.intra.peff.net>
References: <cover.1234980819u.git.johannes.schindelin@gmx.de> <ad680bce413ddea084d84b3fcd7c4cc356c3cb0e.1234980819u.git.johannes.schindelin@gmx.de> <20090219004504.GB25808@coredump.intra.peff.net> <alpine.DEB.1.00.0902190212290.10279@pacific.mpi-cbg.de> <20090219032420.GA26488@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Jay Soffian <jaysoffian@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 19 04:35:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZzgk-00010X-Nn
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 04:35:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123AbZBSDde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 22:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752058AbZBSDdd
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 22:33:33 -0500
Received: from peff.net ([208.65.91.99]:48557 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751953AbZBSDdd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 22:33:33 -0500
Received: (qmail 18992 invoked by uid 107); 19 Feb 2009 03:33:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 18 Feb 2009 22:33:52 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Feb 2009 22:33:29 -0500
Content-Disposition: inline
In-Reply-To: <20090219032420.GA26488@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110613>

On Wed, Feb 18, 2009 at 10:24:20PM -0500, Jeff King wrote:

> Updated series with tests to follow.

Ah, it looks like Junio picked up your original patch. But I still think
it is worth doing these on top:

  1/2: add basic branch display tests
  2/2: branch: clean up repeated strlen

-Peff
