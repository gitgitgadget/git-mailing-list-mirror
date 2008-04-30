From: Jeff King <peff@peff.net>
Subject: Re: cvsimport and branches with "(" in the name
Date: Tue, 29 Apr 2008 23:31:46 -0400
Message-ID: <20080430033146.GA28373@sigill.intra.peff.net>
References: <320075ff0804290022r56c9f4efx74a13d3502be212@mail.gmail.com> <20080429155238.GA18494@sigill.intra.peff.net> <118833cc0804291745m2da2a3bdl21a9440e961afb6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: GIT Mailing List <git@vger.kernel.org>
To: Morten Welinder <mwelinder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 05:32:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr33d-0008CO-3f
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 05:32:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754307AbYD3Dbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 23:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754283AbYD3Dbt
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 23:31:49 -0400
Received: from peff.net ([208.65.91.99]:2106 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754193AbYD3Dbs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 23:31:48 -0400
Received: (qmail 7433 invoked by uid 111); 30 Apr 2008 03:31:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 29 Apr 2008 23:31:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Apr 2008 23:31:46 -0400
Content-Disposition: inline
In-Reply-To: <118833cc0804291745m2da2a3bdl21a9440e961afb6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80783>

On Tue, Apr 29, 2008 at 08:45:42PM -0400, Morten Welinder wrote:

> >  -       system("git-update-ref $remote/$branch $cid") == 0
> >  +       system('git-update-ref', "$remote/$branch", $cid) == 0
> 
> I hope there are no further such system calls left.  This could run arbitrary
> commands if one was tricked into importing an evil repository.

Yes, even if that doesn't fix his problem, it should still be changed. I
have confirmed that it's the only such one in git-cvsimport.

-Peff
