From: Jeff King <peff@peff.net>
Subject: Re: Incorrect git-blame result if I use full path to file
Date: Sun, 2 Dec 2007 21:28:31 -0500
Message-ID: <20071203022831.GE8322@coredump.intra.peff.net>
References: <3665a1a00712021652tbdfe9d1tdc4575d225bfed36@mail.gmail.com> <7vhcj0seok.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anatol Pomozov <anatol.pomozov@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 03:28:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz13G-00010W-0z
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 03:28:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbXLCC2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 21:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbXLCC2e
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 21:28:34 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2879 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750955AbXLCC2d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 21:28:33 -0500
Received: (qmail 25446 invoked by uid 111); 3 Dec 2007 02:28:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 02 Dec 2007 21:28:32 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Dec 2007 21:28:31 -0500
Content-Disposition: inline
In-Reply-To: <7vhcj0seok.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66847>

On Sun, Dec 02, 2007 at 06:19:23PM -0800, Junio C Hamano wrote:

> I think it is rather a sloppy error checking than a bug.  It should be
> throwing a stone back at you when you feed it a full path, or converting
> it back to work tree relative path before using.

I think it's not the only place. Doing "git diff /path/to/repo/file"
silently produces an empty diff, even if there are changes in the file.

-Peff
