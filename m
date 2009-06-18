From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Re: rebase -i: auto-squash commits
Date: Thu, 18 Jun 2009 10:26:23 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906181025460.4848@intel-tinevez-2-302>
References: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com> <43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com> <7vvdmurfao.fsf@alter.siamese.dyndns.org> <20090618063348.6117@nanako3.lavabit.com> <alpine.DEB.1.00.0906180007370.26154@pacific.mpi-cbg.de>
 <20090618001111.GB12954@vidovic> <7v8wjq2kqc.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0906181003300.4848@intel-tinevez-2-302> <m3r5xigdvn.fsf@localhost.localdomain> <7vfxdyymtd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	John Tapsell <johnflux@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 10:26:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHCx9-00049u-0K
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 10:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbZFRI0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 04:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbZFRI0Y
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 04:26:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:33678 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750978AbZFRI0X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 04:26:23 -0400
Received: (qmail invoked by alias); 18 Jun 2009 08:26:24 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp050) with SMTP; 18 Jun 2009 10:26:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18tE6Jgz0st372cmg+zE5MZAkKjkLYn8YcExhZ6q7
	THYBIwbbBIzm3h
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vfxdyymtd.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121813>

Hi,

On Thu, 18 Jun 2009, Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > A bit off-topic: I wonder if there is an easy way to make rebase run 
> > testsuite for the each commit it rebases, or even simple compile test, 
> > to not introduce untestable commits when rebasing by mistake...
> 
> I used to do that manually, i.e. s/^pick /edit /;

This could be a command

	run-foreach (cd t && make)

Hmm?

Ciao,
Dscho
