From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add --filedirstat diff option
Date: Tue, 2 Sep 2008 20:12:54 -0400
Message-ID: <20080903001254.GA12263@coredump.intra.peff.net>
References: <20080901011259.GA31696@zakalwe.fi> <7vd4jnnifp.fsf@gitster.siamese.dyndns.org> <20080902115848.GA1252@jolt.modeemi.cs.tut.fi> <7vwshuglq1.fsf@gitster.siamese.dyndns.org> <7v3akigl1g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Heikki Orsila <shd@modeemi.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 02:14:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kag0Y-0000GB-VR
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 02:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882AbYICAM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 20:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751570AbYICAM5
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 20:12:57 -0400
Received: from peff.net ([208.65.91.99]:3184 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751246AbYICAM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 20:12:56 -0400
Received: (qmail 20850 invoked by uid 111); 3 Sep 2008 00:12:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 02 Sep 2008 20:12:55 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Sep 2008 20:12:54 -0400
Content-Disposition: inline
In-Reply-To: <7v3akigl1g.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94746>

On Tue, Sep 02, 2008 at 04:55:39PM -0700, Junio C Hamano wrote:

> "filedirstat" is simply too long to type, and it has a certain "Huh?"
> factor --- is it about file, or is it about directory?

I had the same thought when I saw the original patch...

> This option essentially is just the dirstat but with different logic to
> compute how big the damage is.  Conceptually, the original one gives one
> "damage point" to each added or deleted line.
> 
>         $ git show --dirstat=<one-point-per-line>

...and I thought of --dirstat-byfile. So maybe:

  --dirstat=byfile

and

  --dirstat=byline

defaulting to byline (or by-line if preferred).

-Peff
