From: Eric Paris <eparis@redhat.com>
Subject: Re: git-reflog 70 minutes at 100% cpu and counting
Date: Mon, 14 Dec 2009 16:56:30 -0500
Message-ID: <1260827790.9379.59.camel@localhost>
References: <1260822484.9379.53.camel@localhost>
	 <20091214211142.GC9364@coredump.intra.peff.net>
	 <1260825629.9379.56.camel@localhost>
	 <20091214212343.GA11131@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 14 22:56:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKIuR-0003VB-QW
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 22:56:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758426AbZLNV4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 16:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758419AbZLNV4f
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 16:56:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48798 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758415AbZLNV4e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 16:56:34 -0500
Received: from int-mx08.intmail.prod.int.phx2.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id nBELuWAM007537
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 14 Dec 2009 16:56:32 -0500
Received: from [10.11.9.84] (vpn-9-84.rdu.redhat.com [10.11.9.84])
	by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id nBELuVPd024159;
	Mon, 14 Dec 2009 16:56:31 -0500
In-Reply-To: <20091214212343.GA11131@coredump.intra.peff.net>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.21
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135245>

On Mon, 2009-12-14 at 16:23 -0500, Jeff King wrote:
> On Mon, Dec 14, 2009 at 04:20:29PM -0500, Eric Paris wrote:
> 
> > Updated to git-1.6.5.3-1 from Fedora rawhide and still git reflog ran
> > for >5 minutes at 100% cpu (I killed it, it didn't finish)
> > 
> > I'm pushing a copy of the whole repo (all 1.9G after bzip compression)
> > to
> > 
> > http://people.redhat.com/~eparis/git-tar/
> 
> Wowzers, that's big. Can you send just what's in .git?

So I zipped up just .git   1.2G.  I did a make clean and zipped up the
whole repo  1.3G.

Just started pushing the 1.3G file.

Maybe having a .git directory that large is the problem?
