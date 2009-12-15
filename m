From: Eric Paris <eparis@redhat.com>
Subject: Re: git-reflog 70 minutes at 100% cpu and counting
Date: Mon, 14 Dec 2009 23:26:20 -0500
Message-ID: <1260851180.9379.88.camel@localhost>
References: <1260822484.9379.53.camel@localhost>
	 <20091214211142.GC9364@coredump.intra.peff.net>
	 <1260825629.9379.56.camel@localhost>
	 <20091215023918.GA14689@coredump.intra.peff.net>
	 <alpine.LFD.2.00.0912142245240.23173@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Dec 15 05:26:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKOza-0002TG-Ma
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 05:26:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759249AbZLOE0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 23:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759216AbZLOE0Z
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 23:26:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55244 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758828AbZLOE0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 23:26:25 -0500
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id nBF4QMhG028061
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 14 Dec 2009 23:26:22 -0500
Received: from [10.11.9.84] (vpn-9-84.rdu.redhat.com [10.11.9.84])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id nBF4QLgi028353;
	Mon, 14 Dec 2009 23:26:21 -0500
In-Reply-To: <alpine.LFD.2.00.0912142245240.23173@xanadu.home>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135270>

On Mon, 2009-12-14 at 22:50 -0500, Nicolas Pitre wrote:
> On Mon, 14 Dec 2009, Jeff King wrote:
> 
> > On Mon, Dec 14, 2009 at 04:20:29PM -0500, Eric Paris wrote:
> > 
> > > I'm pushing a copy of the whole repo (all 1.9G after bzip compression)
> > > to
> > > 
> > > http://people.redhat.com/~eparis/git-tar/
> > > 
> > > But it's going to take a couple hours.
> > 
> > Holy cow. Almost 150 packs, and that's not even everything. The tarball
> > is missing a bunch of objects, because it points to your kernel-1 as an
> > alternate. So I suspect we would need that, as well, to recreate.
> 
> Hmmm... Rebasing repositories mixed with alternates...  I wonder if the 
> infinite loop might not actually be due to a delta cycle, especially if 
> the alternate is also rebasing.
> 
> So having the alternate, too, would certainly be interesting.

The alternative repo is slowing pushing up to that same location.  That
tar is 855838982, so just a tad bit smaller.

-Eric
