From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Remotes order in "git remote update"
Date: Mon, 10 Mar 2008 12:13:43 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803101212220.3975@racer.site>
References: <2008-03-09-11-22-34+trackit+sam@rfc1149.net> <7vbq5op4gt.fsf@gitster.siamese.dyndns.org> <2008-03-09-12-21-35+trackit+sam@rfc1149.net> <alpine.LSU.1.00.0803092148480.3975@racer.site> <2008-03-10-09-17-33+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Mon Mar 10 12:14:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYfxT-00053L-3O
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 12:14:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbYCJLNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 07:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbYCJLNl
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 07:13:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:42055 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751313AbYCJLNk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 07:13:40 -0400
Received: (qmail invoked by alias); 10 Mar 2008 11:13:38 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp042) with SMTP; 10 Mar 2008 12:13:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Sk+5cqQKSlxhf/3aF/8XkSImTVDsHf+qUN9sjvh
	OpsSrLJ4QKhIga
X-X-Sender: gene099@racer.site
In-Reply-To: <2008-03-10-09-17-33+trackit+sam@rfc1149.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76719>

Hi,

On Mon, 10 Mar 2008, Samuel Tardieu wrote:

> On  9/03, Johannes Schindelin wrote:
> 
> | Well, technically this is a regression.
> | 
> | If you really want to order your remotes, why not add something like
> | 
> | [remotes]
> | 	default = my-first-remote my-second-remote [...]
> | 
> | to the config?  That is what the (recently fixed in builtin-remote) 
> | remote groups are for...
> 
> I could do that, but it means that if I add a new remote, it won't enter 
> the default group by itself since I defined it explicitely. I think 
> respecting the order given in the .git/config file when not using a 
> group doesn't hurt and may help.

Well, since the builtin remote does that, I do not see a reason to change 
it ;-)  However, I do not see a reason to guarantee that, either.

> Or maybe we should add a remotes.reference configuration variable which 
> lists the remote to use first if it belongs to the list of remotes we 
> are going to fetch from. Or at least, make origin the first fetched 
> remote, but I know some projects where origin uses a dumb protocol while 
> other contributors have up-to-date non-dumb public repositories.

I do not like the remotes.reference idea.  Too specific for one particular 
use case.

Ciao,
Dscho
