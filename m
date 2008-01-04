From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git stash: one bug and one feature request
Date: Fri, 4 Jan 2008 16:04:08 -0500
Message-ID: <20080104210408.GA26248@coredump.intra.peff.net>
References: <e5bfff550801040814n82f34b2g17c485a207093440@mail.gmail.com> <Pine.LNX.4.64.0801041030420.31161@torch.nrlssc.navy.mil> <477E6D26.9020809@obry.net> <m3abnlo4xv.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pascal Obry <pascal@obry.net>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 04 22:04:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAtie-000415-TU
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 22:04:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753560AbYADVEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 16:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753551AbYADVEM
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 16:04:12 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3865 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753076AbYADVEL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 16:04:11 -0500
Received: (qmail 19518 invoked by uid 111); 4 Jan 2008 21:04:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 04 Jan 2008 16:04:09 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Jan 2008 16:04:08 -0500
Content-Disposition: inline
In-Reply-To: <m3abnlo4xv.fsf@roke.D-201>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69606>

On Fri, Jan 04, 2008 at 09:51:05AM -0800, Jakub Narebski wrote:

> or "git stash delete"
> 
> This probably would require the command to delete single reflog,
> which was posted some time ago and is in either pu or in offcuts,
> or in next.
> 
> But I guess this is post 1.5.4

There is a "git reflog delete" in next (but not in master). See
552cecc2. Using the same name makes sense, since they are equivalent
actions (and "git stash delete" should be very easy, since it is
implemented in terms of reflogs).

-Peff
