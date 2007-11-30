From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Fri, 30 Nov 2007 10:09:48 -0500
Message-ID: <20071130150948.GA22095@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0711292218240.27959@racer.site> <20071129231444.GA9616@coredump.intra.peff.net> <alpine.LFD.0.9999.0711291527090.8458@woody.linux-foundation.org> <7veje8twt2.fsf@gitster.siamese.dyndns.org> <20071130003512.GB11683@coredump.intra.peff.net> <7vzlwwsgkp.fsf@gitster.siamese.dyndns.org> <20071130005852.GA12224@coredump.intra.peff.net> <alpine.LFD.0.99999.0711292004340.9605@xanadu.home> <20071130011748.GC11683@coredump.intra.peff.net> <474FB938.3040209@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Nov 30 16:10:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iy7VN-0001ak-DJ
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 16:10:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759679AbXK3PJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 10:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758650AbXK3PJx
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 10:09:53 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4000 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751325AbXK3PJx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 10:09:53 -0500
Received: (qmail 2835 invoked by uid 111); 30 Nov 2007 15:09:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 30 Nov 2007 10:09:49 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Nov 2007 10:09:48 -0500
Content-Disposition: inline
In-Reply-To: <474FB938.3040209@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66643>

On Fri, Nov 30, 2007 at 08:18:16AM +0100, Andreas Ericsson wrote:

>> The only reason I have heard to remove them entirely is that Windows
>> doesn't properly support hardlinks, which I addressed in my other mails
>> (and to which I have seen no rebuttal).
>>
> It would provide a ui inconsistency between platforms. Several people
> pointed that out. It's decidedly a Bad Thing.

Which, as I said, I have already addressed (and which Linus has also
expanded upon in this thread). Since those hardlinks would be hidden
from users who did not go to some trouble to find them, there will not
be inconsistency problems. Scripts will have to either go to some effort
to change their PATH, or simply use the correct form, and I expect them
to do the latter.

-Peff
