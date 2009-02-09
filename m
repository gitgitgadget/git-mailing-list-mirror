From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Mon, 9 Feb 2009 17:22:36 -0500
Message-ID: <20090209222236.GA4166@coredump.intra.peff.net>
References: <20090205204436.GA6072@diku.dk> <20090209220750.GA27232@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 09 23:25:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWeYK-0001DM-5X
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 23:24:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755051AbZBIWWj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 17:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755030AbZBIWWj
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 17:22:39 -0500
Received: from peff.net ([208.65.91.99]:47063 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755024AbZBIWWi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 17:22:38 -0500
Received: (qmail 5918 invoked by uid 107); 9 Feb 2009 22:22:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 09 Feb 2009 17:22:54 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Feb 2009 17:22:36 -0500
Content-Disposition: inline
In-Reply-To: <20090209220750.GA27232@m62s10.vlinux.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109147>

On Mon, Feb 09, 2009 at 11:07:50PM +0100, Peter Baumann wrote:

> Now I have a little UI glitch, which might be solved already. If im
> browsing through a lot of commits, I'd like to have a way to advance to
> tne next/previous commit while also showing the diff like in the pictore
> below. Right now I alwasy press 'q' to leave the diff view, select
> commit C and press return to show me the diff. Wouldn't it be nice to
> have a way to advance to the next diff without leaving the diff window?
> 
>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   |  commit A
>   | >commit B
>   |  commit C
>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   | diff --git a/tig.c b/tig.c
>   | index aec50bc..2dd0ef6 100644
>   | --- a/tig.c
>   | +++ b/tig.c

Don't the up and down arrows switch the commit (updating the diff pane
as appropriate), and PgUp/PgDown scroll the diff window (I don't know
the actual function names, but you should be able to even rebind these
in your tigrc if you want).

-Peff
