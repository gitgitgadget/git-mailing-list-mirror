From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Fix buffer overflow in config parser
Date: Wed, 15 Apr 2009 03:53:52 -0400
Message-ID: <20090415075352.GB23332@coredump.intra.peff.net>
References: <49E50003.2040907@intra2net.com> <alpine.DEB.1.00.0904142340350.10279@pacific.mpi-cbg.de> <49E50480.5060005@intra2net.com> <20090415075035.GA23332@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	gitster@pobox.com, git@vger.kernel.org, markus.heidelberg@web.de
To: Thomas Jarosch <thomas.jarosch@intra2net.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 09:55:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ltzxx-00058i-0k
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 09:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582AbZDOHx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 03:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752443AbZDOHx4
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 03:53:56 -0400
Received: from peff.net ([208.65.91.99]:42667 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752201AbZDOHx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 03:53:56 -0400
Received: (qmail 14678 invoked by uid 107); 15 Apr 2009 07:54:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 15 Apr 2009 03:54:00 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Apr 2009 03:53:52 -0400
Content-Disposition: inline
In-Reply-To: <20090415075035.GA23332@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116594>

On Wed, Apr 15, 2009 at 03:50:35AM -0400, Jeff King wrote:

>   2. Tests which happen to require perl as part of the testing.
> [...]
> Your usage falls into (2), none of which are marked (and if they are to
> be marked, then all of them should be, since there is otherwise no
> point).

I meant to add: it is still nice to avoid the use of perl in the test
scripts if we can (and I think we can in this instance, as other
responses have noted). If a patch were made to skip tests which use
perl, then the fewer tests we have to skip, the better.

-Peff
