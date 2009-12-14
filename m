From: Eric Paris <eparis@redhat.com>
Subject: Re: git-reflog 70 minutes at 100% cpu and counting
Date: Mon, 14 Dec 2009 16:20:29 -0500
Message-ID: <1260825629.9379.56.camel@localhost>
References: <1260822484.9379.53.camel@localhost>
	 <20091214211142.GC9364@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 14 22:20:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKILT-0000ve-FH
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 22:20:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755845AbZLNVUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 16:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933025AbZLNVUe
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 16:20:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:8720 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751735AbZLNVUd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 16:20:33 -0500
Received: from int-mx08.intmail.prod.int.phx2.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id nBELKUOL022376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 14 Dec 2009 16:20:31 -0500
Received: from [10.11.9.84] (vpn-9-84.rdu.redhat.com [10.11.9.84])
	by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id nBELKUnU014459;
	Mon, 14 Dec 2009 16:20:30 -0500
In-Reply-To: <20091214211142.GC9364@coredump.intra.peff.net>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.21
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135240>

On Mon, 2009-12-14 at 16:11 -0500, Jeff King wrote:
> On Mon, Dec 14, 2009 at 03:28:04PM -0500, Eric Paris wrote:
> 
> > So I have no idea what is interesting or relevant what I can collect,
> > what you want to know or anything like that, so this is a bit of a dump
> > of info and I'm sorry to whoever tries to pick anything useful out of
> 
> It sounds like you might have found an infinite loop, as reflog should
> never really need a lot of CPU. Is it possible to tar the whole
> repository and make it available publicly for us to look at?

Updated to git-1.6.5.3-1 from Fedora rawhide and still git reflog ran
for >5 minutes at 100% cpu (I killed it, it didn't finish)

I'm pushing a copy of the whole repo (all 1.9G after bzip compression)
to

http://people.redhat.com/~eparis/git-tar/

But it's going to take a couple hours.

-Eric
