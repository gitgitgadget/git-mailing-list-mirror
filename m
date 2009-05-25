From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git submodule update --merge
Date: Mon, 25 May 2009 20:57:28 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905252053070.4288@intel-tinevez-2-302>
References: <7vab5ci281.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0905191348460.4266@intel-tinevez-2-302> <200905191526.40471.johan@herland.net> <200905251359.37619.johan@herland.net> <7vmy91vxqc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	markus.heidelberg@web.de, Peter Hutterer <peter.hutterer@who-t.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 25 20:57:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8fMt-0004VL-KL
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 20:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523AbZEYS5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 14:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752243AbZEYS5o
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 14:57:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:46562 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751853AbZEYS5n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 14:57:43 -0400
Received: (qmail invoked by alias); 25 May 2009 18:57:37 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp055) with SMTP; 25 May 2009 20:57:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18YfhJ1NO0YojGWR2w490nk/fYX4/Bn3jqc9CjC6m
	RpMnjSywdyJuQZ
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vmy91vxqc.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119949>

Hi,

On Mon, 25 May 2009, Junio C Hamano wrote:

> Johan Herland <johan@herland.net> writes:
> 
> > I haven't received any replies to my attempt to describe the context 
> > in which "git submodule update --merge" is useful. A hint as to 
> > whether my argument is valid, or just crap, would be nice.
> 
> FWIW, I didn't find "rebase makes sense but merge doesn't" argument very
> convincing to begin with.

Well, that is probably because you are not forced by me to use submodules.

Because in the project I use submodules most heavily, there is one 
recurring theme: you cannot push to the submodules.  And by "you" I mean 
"a regular user".

So virtually all you do in these submodules cannot be pushed at all.  It 
has to be submitted to the respective submodule maintainer.

And guess what happens in such a case when you set that tentative "update" 
variable to "merge"?

Exactly.

FWIW I consider any scenario where the average users have push access to 
the submodule a toy scenario.

The rebase workflow is very useful in my project, so if it does not go 
into git.git, I'll just force my users to install a Git compiled from my 
git tree.

Ciao,
Dscho
