From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add the diff option --no-defaults
Date: Thu, 16 Apr 2009 19:36:52 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904161935570.6798@intel-tinevez-2-302>
References: <1237600853-22815-1-git-send-email-keith@cs.ucla.edu> <alpine.DEB.1.00.0903210415110.10279@pacific.mpi-cbg.de> <alpine.GSO.2.00.0904021647120.16242@kiwi.cs.ucla.edu> <alpine.DEB.1.00.0904091030030.10279@pacific.mpi-cbg.de>
 <20090409084903.GA18947@coredump.intra.peff.net> <alpine.DEB.1.00.0904091242430.10279@pacific.mpi-cbg.de> <20090410080155.GB32195@coredump.intra.peff.net> <alpine.DEB.1.00.0904140036341.10279@pacific.mpi-cbg.de> <20090416083443.GA27399@coredump.intra.peff.net>
 <alpine.DEB.1.00.0904161124000.10279@pacific.mpi-cbg.de> <20090416094154.GA30479@coredump.intra.peff.net> <7v4owok0bh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Keith Cascio <keith@CS.UCLA.EDU>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 16 19:39:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuVY0-00013Z-8R
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 19:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756625AbZDPRg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 13:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757040AbZDPRg4
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 13:36:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:43298 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755603AbZDPRg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 13:36:56 -0400
Received: (qmail invoked by alias); 16 Apr 2009 17:36:53 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp071) with SMTP; 16 Apr 2009 19:36:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Z22462O/Zbxzva+IKMQyjlv6cIno5JuLw6XRFcU
	vagGhrbsR7ppHg
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7v4owok0bh.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116715>

Hi,

On Thu, 16 Apr 2009, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Thu, Apr 16, 2009 at 11:25:08AM +0200, Johannes Schindelin wrote:
> >
> >> > This feels very hack-ish to me, but perhaps this is a case of "perfect
> >> > is the enemy of the good".
> >> 
> >> I have a strong feeling that none of our diff/rev options can sanely take 
> >> a parameter looking like "--defaults" or "--no-defaults".
> >> 
> >> But I do not have the time to audit the options.  Maybe you have?
> >
> > Right now, I think we are safe. A few options like "--default" do take a
> > separated string argument, but saying "--default --no-defaults" seems a
> > little crazy to me (besides being confusing because they are talking
> > about two totally unrelated defaults).
> 
> Maybe you guys have already considered and discarded this as too hacky,
> but isn't it the easiest to explain and code to declare --no-defaults is
> acceptable only at the beginning?

That would not work if you use an alias:

	$ git config alias.grmpfl log --stat
	$ git grmpfl --no-defaults

Ciao,
Dscho
