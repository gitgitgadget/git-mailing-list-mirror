From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] BUG: git push on an empty clone segfaults.
Date: Mon, 20 Apr 2009 16:30:38 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904201629280.6771@intel-tinevez-2-302>
References: <1240220930-24679-1-git-send-email-Matthieu.Moy@imag.fr> <7vfxg3ipib.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0904201252120.6955@intel-tinevez-2-302> <20090420135532.GC8940@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?ISO-8859-15?Q?Nguy=3Fn_Th=E1i_Ng=3Fc_Duy?= <pclouds@gmail.com>,
	git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Apr 20 16:32:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvuXf-0006oZ-5X
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 16:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755557AbZDTOam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 10:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755547AbZDTOal
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 10:30:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:52858 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755524AbZDTOal (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 10:30:41 -0400
Received: (qmail invoked by alias); 20 Apr 2009 14:30:39 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp032) with SMTP; 20 Apr 2009 16:30:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/BcGJ3eqnBEPgBhl7ywOsnBoBVczsn/Mmp33RMVp
	Dw5kNSZfUIbTNl
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090420135532.GC8940@machine.or.cz>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116994>

Hi,

On Mon, 20 Apr 2009, Petr Baudis wrote:

> On Mon, Apr 20, 2009 at 12:55:10PM +0200, Johannes Schindelin wrote:
> > I fetched from repo.or.cz and tested with 'master', and it was broken.  
> > Apparently git://repo.or.cz/git.git is lagging behind by 5 days.  
> > Pasky?
> 
>   yes, I noticed that the mirroring got hanging on some dead repository 
> earlier today and restarted it, but it might take a while until a full 
> mirror cycle refreshes everything.

I always wondered why it should make sense to have a mirror git.git, and 
in addition a repository alt-git.git that Junio pushes to.

Maybe it is time to fix that?

I mean, I am hardly a Git newbie, and even I got burnt.

Ciao,
Dscho
