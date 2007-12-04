From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Make Git accept absolute path names for files within the work tree
Date: Tue, 4 Dec 2007 07:42:23 +0100
Message-ID: <200712040742.24728.robin.rosenberg.lists@dewire.com>
References: <3665a1a00712021652tbdfe9d1tdc4575d225bfed36@mail.gmail.com> <20071204014326.GA21358@coredump.intra.peff.net> <Pine.LNX.4.64.0712040216220.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Anatol Pomozov <anatol.pomozov@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 04 07:41:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzRSl-0000Pc-BB
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 07:40:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184AbXLDGka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 01:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752049AbXLDGk2
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 01:40:28 -0500
Received: from [83.140.172.130] ([83.140.172.130]:13994 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751934AbXLDGk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 01:40:26 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 14851802675;
	Tue,  4 Dec 2007 07:31:03 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 27284-08; Tue,  4 Dec 2007 07:31:02 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id A21D880264D;
	Tue,  4 Dec 2007 07:31:02 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <Pine.LNX.4.64.0712040216220.27959@racer.site>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67009>

tisdag 04 december 2007 skrev Johannes Schindelin:
> Hi,
> 
> On Mon, 3 Dec 2007, Jeff King wrote:
> 
> > On Mon, Dec 03, 2007 at 09:53:30PM +0100, Robin Rosenberg wrote:
> > 
> > > code did not pass). Like Linus, this code does not resolve symlinks,
> > > but I forgot to state that it is by design. It solves my problem and
> > 
> > By design meaning "I didn't feel like implemening it because I do not
> > personally care" or "I have some reason not to resolve symlinks"?
> 
> IMHO those symlinks would be a nice thing in some corner cases, but 
> penalise the common case.  So I tend to believe the latter.  (See also 
> Linus' message why he talks about his preference for the die() code path.)

Actually the forme.... I don't mind it being fixed if it doesn't cost too much.

-- robin
