From: Jeff King <peff@peff.net>
Subject: Re: valgrind patches, was Re: What's cooking in git.git (Jan 2009,
	#04; Mon, 19)
Date: Wed, 21 Jan 2009 18:57:57 -0500
Message-ID: <20090121235757.GA9668@sigill.intra.peff.net>
References: <20090120141932.GB10688@sigill.intra.peff.net> <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302> <20090120232439.GA17746@coredump.intra.peff.net> <alpine.DEB.1.00.0901210105470.19014@racer> <20090121001551.GB18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210119510.19014@racer> <20090121003739.GA18373@coredump.intra.peff.net> <alpine.DEB.1.00.0901210216440.19014@racer> <20090121190757.GB21686@coredump.intra.peff.net> <alpine.DEB.1.00.0901212259420.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 22 00:59:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPmyj-0004im-VN
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 00:59:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754255AbZAUX6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 18:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754089AbZAUX6B
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 18:58:01 -0500
Received: from peff.net ([208.65.91.99]:37294 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753016AbZAUX6B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 18:58:01 -0500
Received: (qmail 22603 invoked by uid 107); 21 Jan 2009 23:58:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 21 Jan 2009 18:58:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Jan 2009 18:57:57 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901212259420.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106704>

On Wed, Jan 21, 2009 at 11:17:35PM +0100, Johannes Schindelin wrote:

> Phew.  A lot of time, a lot of braincycles, and a lot of keystrokes wasted 
> on that subject, don't you think?

Yes, especially considering my other email that said I had dropped the
subject. ;P

But thank you for discussing it. There is still some part of me that
says "if you have no races, you don't have to worry about analyzing
them." But I think your analysis is correct, and I am willing to let it
go in the name of practicality.

As for braincycles, I don't think they were necessarily wasted. The
point of review is to double-check, and the discussion is how we resolve
(even if we resolve that it is OK as-is). Of course there is such a
thing as useless, annoying pedantry, but I hope this didn't count... :)

-Peff
