From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Sat, 1 Dec 2007 16:26:56 -0500
Message-ID: <20071201212655.GA22349@coredump.intra.peff.net>
References: <7vzlwwsgkp.fsf@gitster.siamese.dyndns.org> <20071130005852.GA12224@coredump.intra.peff.net> <alpine.LFD.0.9999.0711291821220.8458@woody.linux-foundation.org> <5E2A9E2B-8B9A-46B0-99D0-DB3798F10119@zib.de> <20071130151223.GB22095@coredump.intra.peff.net> <8aa486160711300728x70f591f1hf8884a78f2b15806@mail.gmail.com> <20071130152942.GA22489@coredump.intra.peff.net> <alpine.LFD.0.9999.0711300745330.8458@woody.linux-foundation.org> <fcaeb9bf0711302234l32460a1fqbf9825fc8055f99d@mail.gmail.com> <7vve7i43ec.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Santi B?jar <sbejar@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 01 22:27:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyZru-0005dn-9Z
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 22:27:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbXLAV1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 16:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbXLAV1A
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 16:27:00 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3263 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751055AbXLAV07 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 16:26:59 -0500
Received: (qmail 17098 invoked by uid 111); 1 Dec 2007 21:26:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 01 Dec 2007 16:26:57 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Dec 2007 16:26:56 -0500
Content-Disposition: inline
In-Reply-To: <7vve7i43ec.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66738>

On Sat, Dec 01, 2007 at 11:32:27AM -0800, Junio C Hamano wrote:

> > We already have "git show", now we gonna get "git view", git trainers
> > may have hard time explaining this one shows you a particular object
> > while the other one shows you history. How about "git lshistory" (from
> > clearcase land) or git show --history?
> 
> Heh, we have "bisect visualize".  How about "git visualize"?

Yes, in retrospect "view" is probably not the best. "lshistory" just
looks awful, and I think it's wrong for an option to "git show" to
change it from a terminal application into a GUI application.

"visualize" is actually pretty good, except that it would be painful to
type. On the other hand, I will probably still just type "gitk". I
actually think these sorts of aliases may be most useful for user-facing
scripts to say "and now show the dataset in the user's graphical history
browser of choice."

-Peff
