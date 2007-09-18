From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-fsck/lost-found's speed vs git-prune's
Date: Tue, 18 Sep 2007 12:13:14 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709181211560.28586@racer.site>
References: <20070918090926.GA8927@glandium.org> <7v4phswcuj.fsf@gitster.siamese.dyndns.org>
 <20070918095049.GA9388@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 13:14:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXb21-0001Nw-34
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 13:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755371AbXIRLOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 07:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753567AbXIRLOH
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 07:14:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:41740 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752622AbXIRLOE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 07:14:04 -0400
Received: (qmail invoked by alias); 18 Sep 2007 11:14:00 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp055) with SMTP; 18 Sep 2007 13:14:00 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18DFWsGN9EDOaAYh+1OEoqB0aioK/U66bD5EPEIZH
	n6EfnVLSg9xTal
X-X-Sender: gene099@racer.site
In-Reply-To: <20070918095049.GA9388@glandium.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58577>

Hi,

On Tue, 18 Sep 2007, Mike Hommey wrote:

> On Tue, Sep 18, 2007 at 02:18:44AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> > Mike Hommey <mh@glandium.org> writes:
> > 
> > > I was wondering if that was to be expected for git-fsck to be
> > > significantly slower than git-prune (by several orders of magnitude) ?
> > 
> > fsck validates objects are correct and sane.  prune only looks
> > at reachability.
> 
> Now, the speed difference makes sense, but I wouldn't expect lost-found
> to actually bother validating objects...

That's why we should get rid of lost-found, and only keep the --lost-found 
option to git-fsck, to make it clear.

And I think that it is too rare that you lost objects and want to find 
them, to warrant a fast version of it.

Ciao,
Dscho
