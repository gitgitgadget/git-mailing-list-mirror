From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Intoducing the .git file (again)
Date: Sun, 17 Feb 2008 23:27:04 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802172324520.30505@racer.site>
References: <1203286456-26033-1-git-send-email-hjemli@gmail.com>  <alpine.LSU.1.00.0802172219190.30505@racer.site> <8c5c35580802171429m1091492dgd65e13c94de08bd4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 00:27:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQsvG-0006va-0r
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 00:27:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754415AbYBQX1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 18:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754407AbYBQX1P
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 18:27:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:35994 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754295AbYBQX1O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 18:27:14 -0500
Received: (qmail invoked by alias); 17 Feb 2008 23:27:12 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp041) with SMTP; 18 Feb 2008 00:27:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19G120e76RGK36ZtBjBBn0PGZWRmzh/TwR7AN+Co6
	IV6PsBs6NNx37/
X-X-Sender: gene099@racer.site
In-Reply-To: <8c5c35580802171429m1091492dgd65e13c94de08bd4@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74204>

Hi,

On Sun, 17 Feb 2008, Lars Hjemli wrote:

> On Feb 17, 2008 11:20 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > On Sun, 17 Feb 2008, Lars Hjemli wrote:
> >
> > > PPS: If included, the .git file should probably be used by 
> > > git-submodule to clone submodule repositories into something like 
> > > $GIT_DIR/submodules/<name>, as that would make local submodule 
> > > changes more resistant to dataloss due to checkout/reset in the 
> > > containing repository.
> >
> > I don't buy that argument.  For the moment, the submodules are 
> > self-contained repositories.  The superproject does not even have to 
> > have a single object contained in a submodule.  I'd try to keep that 
> > separation.
> 
> They would still be separated and self-contained repositories, but with 
> my suggestion the submodule repository would be moved out of the working 
> tree of the containing repository. Which I believe is a good thing, 
> especially when you switch from one branch in the containing repository 
> which had the submodule in './foo' to another branch where the submodule 
> is located in './lib/foo'.

That is a good argument.

But what about the argument when you stop being interested in the 
superproject, and move the submodule out of it (then deleting the 
superproject)?

However, when a submodule is deleted, wasn't the plan all along to put the 
submodule's .git/ into the superproject's .git/submodules-deleted/ or some 
such?

Ciao,
Dscho
