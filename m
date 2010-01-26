From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase -p: Preserve fast-forwardable merges
Date: Tue, 26 Jan 2010 12:14:40 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001261214190.4641@intel-tinevez-2-302>
References: <dd10f5481001222329i58e7b709m2c547c74161b6771@mail.gmail.com>  <alpine.DEB.1.00.1001251508400.8733@intel-tinevez-2-302> <dd10f5481001251053x2ac9fa62r57a46f1231e36560@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1793468193-1264504481=:4641"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Alex Scarborough <alex@gameclay.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 12:14:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZjNg-0007cz-Gf
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 12:14:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850Ab0AZLOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 06:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752786Ab0AZLOn
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 06:14:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:60218 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751938Ab0AZLOn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 06:14:43 -0500
Received: (qmail invoked by alias); 26 Jan 2010 11:14:41 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp065) with SMTP; 26 Jan 2010 12:14:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ntZc9tHtn9Qg/w9F4it/V+b5eu7z2mEc6vQgann
	Yji9+GC3P9ucxN
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <dd10f5481001251053x2ac9fa62r57a46f1231e36560@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68000000000000005
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138030>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1793468193-1264504481=:4641
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 25 Jan 2010, Alex Scarborough wrote:

> On Mon, Jan 25, 2010, Johannes Schindelin wrote:
> > On Fri, 22 Jan 2010, Alex Scarborough wrote:
> >
> > > Previously, rebase -p would not preserve a merge commit if the merge 
> > > could be resolved as a fast-forward.  rebase -p now passes --no-ff 
> > > to git merge when recreating a merge commit, which ensures that 
> > > merge commits created with git merge --no-ff are preserved.
> >
> > For my use case (well, it used to be my use case), namely keeping a 
> > number of topic branches on top of an upstream up-to-date, this is not 
> > the desired action.  In my use case, merged topic branches should just 
> > vanish, and not even leave a merge commit.
> 
> I see.  In that use case this patch would be rather irritating :)
> 
> What do you think of adding a --no-ff option to git rebase which, when 
> used with -p, will recreate merge commits even if they could be resolved 
> as a fast-forward?  That would leave your use case unchanged while 
> giving my use case a way out, so to speak.

That would make most sense, I agree.

Thanks,
Dscho
--8323329-1793468193-1264504481=:4641--
