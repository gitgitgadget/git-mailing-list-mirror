From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Fri, 13 Jun 2008 11:54:38 -0500
Message-ID: <ZTTd7YVht_gFLPWCKTfGHU9iKdkp9sYEZ4upWUptwV0n-_bvgy23kA@cipher.nrlssc.navy.mil>
References: <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil> <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil> <20080611213648.GA13362@glandium.org> <alpine.DEB.1.00.0806112242370.1783@racer> <20080611230344.GD19474@sigill.intra.peff.net> <alpine.LFD.1.10.0806111918300.23110@xanadu.home> <loom.20080612T042942-698@post.gmane.org> <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com> <4851F6F4.8000503@op5.se> <20080613055800.GA26768@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, Wincent Colaiuta <win@wincent.com>,
	Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 18:56:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7CZ9-0001cp-BQ
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 18:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753986AbYFMQy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 12:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753582AbYFMQy6
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 12:54:58 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:53559 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927AbYFMQy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 12:54:57 -0400
Received: by mail.nrlssc.navy.mil id m5DGsd3s019165; Fri, 13 Jun 2008 11:54:39 -0500
In-Reply-To: <20080613055800.GA26768@sigill.intra.peff.net>
X-OriginalArrivalTime: 13 Jun 2008 16:54:39.0604 (UTC) FILETIME=[2B481B40:01C8CD76]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84899>

Jeff King wrote:
> On Fri, Jun 13, 2008 at 06:26:28AM +0200, Andreas Ericsson wrote:

> Stashes shouldn't expire, because the user told the stash to save
> information. The user considers it a "save" because stashes hold things
> forever. Stashes hold things forever because they shouldn't expire.

Maybe the command name is the problem. We know that 'git stash' is short
for 'git stash save', so we think we are directing git to "save" something.
In the physical world when I "save" something or "stash" it away, even
temporarilly, I don't stick it in a garbage can and put it out by the curb. :)

Sorry, that's just what popped into my head :)

-brandon
