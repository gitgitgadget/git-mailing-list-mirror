From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git submodule update --merge
Date: Mon, 25 May 2009 21:54:09 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905252149370.4288@intel-tinevez-2-302>
References: <7vab5ci281.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0905191348460.4266@intel-tinevez-2-302>  <200905191526.40471.johan@herland.net> <200905251359.37619.johan@herland.net>  <7vmy91vxqc.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.0905252053070.4288@intel-tinevez-2-302> <32541b130905251204q20b5600fr4486390cc9157f66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1087858519-1243281254=:4288"
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	markus.heidelberg@web.de, Peter Hutterer <peter.hutterer@who-t.net>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 25 21:55:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8gGK-0004kH-Iz
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 21:55:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754409AbZEYTyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 15:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754125AbZEYTyT
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 15:54:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:41846 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751793AbZEYTyS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 15:54:18 -0400
Received: (qmail invoked by alias); 25 May 2009 19:54:14 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp061) with SMTP; 25 May 2009 21:54:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+RKgE8/fqRpv0ImjYPLaxg2e1OxscqvBOe8ZJc0f
	neh0miyIquQb+9
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <32541b130905251204q20b5600fr4486390cc9157f66@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119959>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1087858519-1243281254=:4288
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 25 May 2009, Avery Pennarun wrote:

> On Mon, May 25, 2009 at 2:57 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Because in the project I use submodules most heavily, there is one
> > recurring theme: you cannot push to the submodules.  And by "you" I mean
> > "a regular user".
> >
> > So virtually all you do in these submodules cannot be pushed at all.  It
> > has to be submitted to the respective submodule maintainer.
> >
> > And guess what happens in such a case when you set that tentative "update"
> > variable to "merge"?
> >
> > Exactly.
> >
> > FWIW I consider any scenario where the average users have push access to
> > the submodule a toy scenario.
> 
> I have the same problem.  Out of curiosity, how do you handle the case
> where you really need to make a change to the submodule and let your
> team members see that change, even though the submodule's upstream is
> slow and/or doesn't accept the patch?
> 
> In that situation, we've had to make local shared mirrors of all the
> submodules and point .gitmodules at that.  But that would be your
> "toy" scenario - our local users have push access to the submodule.

Happily enough, our changes were accepted so far.

For a few branches, though, the patches are not ready to be sent upstream 
(or, from a certain viewpoint, sometimes downstream) yet, so we do have 
local forks for those working on that.

Note, however, that even in this case, it is better to use 'rebase' rather 
than 'merge', for exactly the same (I almost wrote "unconvincing") reason 
as before.

Ciao,
Dscho

P.S.: in some cases, the submodules' "upstreams" are maintained by team 
members, but that is very much on purpose.  They are trusted maintainers, 
and there is no reason to let some young and maybe overly energetic 
friends push to such a trusted repository.
--8323329-1087858519-1243281254=:4288--
