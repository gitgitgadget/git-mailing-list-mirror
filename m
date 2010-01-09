From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH (v2) 2/2] rebase -i: teach --onto A...B syntax
Date: Sat, 9 Jan 2010 02:36:19 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001090235520.4985@pacific.mpi-cbg.de>
References: <7vljgei7rs.fsf@alter.siamese.dyndns.org> <7vskal5c11.fsf@alter.siamese.dyndns.org>  <20100106191825.6117@nanako3.lavabit.com> <alpine.DEB.1.00.1001061219180.11013@intel-tinevez-2-302>  <7vocl7yxef.fsf@alter.siamese.dyndns.org>
 <20100107200509.6117@nanako3.lavabit.com>  <7vtyux3bx1.fsf@alter.siamese.dyndns.org> <32541b131001081216p27d7e29bu269755db895128@mail.gmail.com>  <fabb9a1e1001081222q7122872bu72cea4e393f272ac@mail.gmail.com>  <32541b131001081231x1b6ac8c1k30084e4abf8cc896@mail.gmail.com>
 <fabb9a1e1001081237n11fa61b5m63fa46fac2ad8d4a@mail.gmail.com> <4B47BE13.7070509@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 09 02:31:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTQAN-0007hn-Rk
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 02:31:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242Ab0AIBay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 20:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752730Ab0AIBay
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 20:30:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:39516 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752596Ab0AIBax (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 20:30:53 -0500
Received: (qmail invoked by alias); 09 Jan 2010 01:30:52 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp039) with SMTP; 09 Jan 2010 02:30:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+2zwsYm7m2N4a+9e0q8Q7N6jp+o9RocJkOXslcw7
	uI0IuGuEl2Xdas
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4B47BE13.7070509@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136508>

Hi,

On Fri, 8 Jan 2010, A Large Angry SCM wrote:

> Sverre Rabbelier wrote:
> > 
> > On Fri, Jan 8, 2010 at 15:31, Avery Pennarun <apenwarr@gmail.com> 
> > wrote:
> > > Thanks, I didn't know about that one.  But my general point is 
> > > still: we seem to have two implementations when the functionality of 
> > > one is actually a superset of the other.  As far as I can see, 
> > > anyway.  So the obvious way to reduce the duplicated code is to 
> > > simply eliminate the less-featureful implementation.
> > 
> > *cough* git sequencer *cough*
> 
> *cough* not in my ${PATH} *cough*

*cough* because that GSoC project failed in all but writing? *cough*
