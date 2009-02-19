From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Avoid segfault with 'git branch' when the HEAD is
	detached
Date: Wed, 18 Feb 2009 22:24:20 -0500
Message-ID: <20090219032420.GA26488@coredump.intra.peff.net>
References: <cover.1234980819u.git.johannes.schindelin@gmx.de> <ad680bce413ddea084d84b3fcd7c4cc356c3cb0e.1234980819u.git.johannes.schindelin@gmx.de> <20090219004504.GB25808@coredump.intra.peff.net> <alpine.DEB.1.00.0902190212290.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Jay Soffian <jaysoffian@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 19 04:25:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZzXu-0007Ra-EC
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 04:25:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443AbZBSDYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 22:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752543AbZBSDYX
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 22:24:23 -0500
Received: from peff.net ([208.65.91.99]:60391 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752058AbZBSDYX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 22:24:23 -0500
Received: (qmail 18890 invoked by uid 107); 19 Feb 2009 03:24:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 18 Feb 2009 22:24:44 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Feb 2009 22:24:20 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0902190212290.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110612>

On Thu, Feb 19, 2009 at 02:15:00AM +0100, Johannes Schindelin wrote:

> > Meaning that the bug was created after your valgrind testing (which 
> > takes a painfully long time to run, and so only happens occasionally), 
> > and therefore you found it by hand? Or meaning that even running the 
> > test suite with valgrind did not reveal the problem?
> 
> It bit me.
> 
> IOW I had to fix it before I could finish up the work for the day.

OK. I wasn't sure if it was "valgrind didn't find" or "valgrind wouldn't
find". And your answer is "didn't", but as it turns out, it also
"wouldn't.

Updated series with tests to follow.

-Peff
