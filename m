From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when
  appropriate to do so
Date: Tue, 6 Oct 2009 12:04:54 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910061151420.4686@intel-tinevez-2-302>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>  <alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de>  <20091005225611.GB29335@coredump.intra.peff.net>  <alpine.DEB.1.00.0910061111410.4985@pacific.mpi-cbg.de>  <vpqiqesna6x.fsf@bauges.imag.fr>
 <237967ef0910060241q671baafav93fe6402a4c510c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	git@vger.kernel.org
To: Mikael Magnusson <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 06 12:11:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mv702-0000Qd-4U
	for gcvg-git-2@lo.gmane.org; Tue, 06 Oct 2009 12:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756883AbZJFKFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2009 06:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756881AbZJFKFo
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Oct 2009 06:05:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:50114 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756876AbZJFKFn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2009 06:05:43 -0400
Received: (qmail invoked by alias); 06 Oct 2009 10:04:55 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp070) with SMTP; 06 Oct 2009 12:04:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+i8c0yEgyiDQpa+slUJBbQprFwJMH0BxNTkOJs0X
	TmeBDSSO3AIsGo
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <237967ef0910060241q671baafav93fe6402a4c510c5@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129619>

Hi,

On Tue, 6 Oct 2009, Mikael Magnusson wrote:

> I can imagine this happening:
> % git clone git://git.git git
> % git checkout next
> do you want to checkout origin/next? y
> # a few days later
> % git fetch
> % git checkout next
> [freenode] /join #git
> [#git] i did git checkout next but my files are still the same?

I imagined more something like this:

$ git clone git://git.git git
$ git checkout next
Automatically checking out local branch 'next' tracking 'origin/next'.
Please update it with 'git pull'.

Ciao,
Dscho
