From: Hanspeter Kunz <hp@edelkunz.ch>
Subject: Re: git-send-email is omitting author and date lines
Date: Mon, 24 Sep 2007 09:16:22 +0200
Message-ID: <1190618182.6916.1.camel@localhost>
References: <1190585633.29937.44.camel@localhost>
	 <7v4phlc668.fsf@gitster.siamese.dyndns.org>
	 <1190590538.12557.1.camel@localhost>
	 <Pine.LNX.4.64.0709240129450.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 24 09:16:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZiBR-0000n3-1q
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 09:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbXIXHQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 03:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbXIXHQj
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 03:16:39 -0400
Received: from seamus.madduck.net ([213.203.238.82]:36017 "EHLO
	seamus.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835AbXIXHQi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 03:16:38 -0400
Received: from [192.168.2.102] (84-72-80-233.dclient.hispeed.ch [84.72.80.233])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: hp@edelkunz.ch)
	by seamus.madduck.net (postfix) with ESMTP id 1B1244060A7;
	Mon, 24 Sep 2007 09:16:28 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.64.0709240129450.28395@racer.site>
X-Mailer: Evolution 2.10.3 
X-Virus-Scanned: ClamAV 0.91.2/4376/Mon Sep 24 04:15:24 2007 on seamus.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59025>

On Mon, 2007-09-24 at 01:30 +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 24 Sep 2007, Hanspeter Kunz wrote:
> 
> > On Sun, 2007-09-23 at 16:29 -0700, Junio C Hamano wrote:
> > > Hanspeter Kunz <hp@edelkunz.ch> writes:
> > > 
> > > > When sending a patch to myself using `git-send-email` I realized that
> > > > the lines containing the author and the date (lines 5 and 6 in the patch
> > > > file) were not in the sent email.
> > > 
> > > Was the commit authored by yourself?
> > 
> > yes. does this make a difference?
> 
> Yes, it does.  The author is usually inferred from the sender of the mail, 
> and therefore git-send-email strips that information from the message 
> (IIRC).

Ah, I see. And this applies also to the date, I guess.

Many thanks,
Hp.
