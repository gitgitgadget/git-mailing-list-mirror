From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 2/2] Teach @{-1} to git merge
Date: Thu, 26 Feb 2009 11:18:57 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902261118140.6258@intel-tinevez-2-302>
References: <7v4oyxzeay.fsf@gitster.siamese.dyndns.org> <76718490902132311j5add87bcpb103c951a8192b05@mail.gmail.com> <7vzlgpxz4g.fsf@gitster.siamese.dyndns.org> <7vskmhuzla.fsf_-_@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0902142332210.10279@pacific.mpi-cbg.de>
 <7vfxigqwsp.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0902151212320.10279@pacific.mpi-cbg.de> <7v1vtzf234.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0902161140160.10279@pacific.mpi-cbg.de> <7v8wnuys44.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 11:20:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcdLz-0007H1-Cn
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 11:20:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426AbZBZKTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 05:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753145AbZBZKTB
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 05:19:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:42817 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752451AbZBZKTA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 05:19:00 -0500
Received: (qmail invoked by alias); 26 Feb 2009 10:18:57 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp048) with SMTP; 26 Feb 2009 11:18:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX182vGAhZGY2dJOYfrBuNf2TXInt1AcZ9b8oqXqkh2
	mmMA/S6OATufNm
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7v8wnuys44.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111548>

Hi,

On Wed, 25 Feb 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Sun, 15 Feb 2009, Junio C Hamano wrote:
> >
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> 
> >> > However, IMO there is a much worse issue lurking: people might want 
> >> > to _know_ what "@{-2}" would expand to, _without_ switching 
> >> > branches.
> >> 
> >> "git branch --history" anyone?
> >
> > For a moment, you had me convinced it already exists, and I only 
> > understood after "git grep history builtin-branch.c" came up empty.
> >
> > ;-)
> 
> $ git rev-parse --symbolic-full-name @{-24}
> 
> seem to work for this purpose ;-)

AFAIR I mentioned that command, together with a reminder that teaching 
regular Git users plumbing commands is harmful.

Ciao,
Dscho
