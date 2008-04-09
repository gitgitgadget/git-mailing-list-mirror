From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add --only-merges flag to display only merge commits.
Date: Wed, 9 Apr 2008 17:00:14 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0804091659130.10660@wbgn129.biozentrum.uni-wuerzburg.de>
References: <20080408203648.GS11574@genesis.frugalware.org> <alpine.LSU.1.00.0804091605460.10660@wbgn129.biozentrum.uni-wuerzburg.de> <20080409145108.GY11574@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Apr 09 17:01:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjbnO-00010N-NY
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 17:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752672AbYDIPAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 11:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752641AbYDIPAX
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 11:00:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:38687 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752634AbYDIPAW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 11:00:22 -0400
Received: (qmail invoked by alias); 09 Apr 2008 15:00:19 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp025) with SMTP; 09 Apr 2008 17:00:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19bdHYm/n9bMEJgFyFWCTQ/Po84G4eMy0gNIv3nhu
	3K1uEWabwQAytI
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <20080409145108.GY11574@genesis.frugalware.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79114>

Hi,

On Wed, 9 Apr 2008, Miklos Vajna wrote:

> On Wed, Apr 09, 2008 at 04:06:57PM +0200, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > I just wanted to see the list of merges since the last tag in a repo
> > > where we have 1000+ commits and about 20 merges and found that there is
> > > no easy way to do so.
> > 
> > I usually did something like this:
> > 
> > git log -1 $(git rev-list --parents | sed -n "s/ .* .*//p")
> 
> If you mean:
> 
> git log -1 $(git rev-list --parents HEAD | sed -n "s/ .* .*//p")

Yes, I meant "something like" that...

> then it'll show only the first merge, --only-merges shows each merge. 
> (While of course you can still use -1 or tag.. or so.)

Yep, I wrote "-1", but what I actually meant was "--no-walk".

Sorry,
Dscho
