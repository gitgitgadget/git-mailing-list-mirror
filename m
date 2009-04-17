From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add the diff option --no-defaults
Date: Fri, 17 Apr 2009 15:15:44 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904171514440.6675@intel-tinevez-2-302>
References: <alpine.GSO.2.00.0904021647120.16242@kiwi.cs.ucla.edu> <alpine.DEB.1.00.0904091030030.10279@pacific.mpi-cbg.de> <20090409084903.GA18947@coredump.intra.peff.net> <alpine.DEB.1.00.0904091242430.10279@pacific.mpi-cbg.de> <20090410080155.GB32195@coredump.intra.peff.net>
 <alpine.DEB.1.00.0904140036341.10279@pacific.mpi-cbg.de> <20090416083443.GA27399@coredump.intra.peff.net> <alpine.DEB.1.00.0904161124000.10279@pacific.mpi-cbg.de> <20090416094154.GA30479@coredump.intra.peff.net> <7v4owok0bh.fsf@gitster.siamese.dyndns.org>
 <20090417115414.GA29121@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Keith Cascio <keith@CS.UCLA.EDU>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 17 15:17:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lunwa-00086d-Gw
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 15:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757206AbZDQNPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 09:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755323AbZDQNPs
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 09:15:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:46293 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754298AbZDQNPr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 09:15:47 -0400
Received: (qmail invoked by alias); 17 Apr 2009 13:15:46 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp031) with SMTP; 17 Apr 2009 15:15:46 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18eYZQNSdYepbJnboXZ1pd8cGEGvkYuuScQgWg715
	uksDFbS+kd2jFz
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090417115414.GA29121@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116738>

Hi,

On Fri, 17 Apr 2009, Jeff King wrote:

> But I think all of this is just ending up in the same place that Keith 
> and I arrived at much earlier in the thread: you _are_ choosing a 
> poison, and his patch was meant to avoid that. The question is whether 
> the added code complexity is worth it.

Well, I think I gave my answer in the form of two patches.

Besides, you still will have a poison:

	git config diff.defaultOptions --no-defaults

which is Russel's paradoxon right there.

Ciao,
Dscho
