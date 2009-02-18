From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 4/5] t3301: use test_must_fail instead of !
Date: Wed, 18 Feb 2009 11:14:10 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902181113210.6274@intel-tinevez-2-302>
References: <200902142056.42198.trast@student.ethz.ch> <8c50889d27e5baec1cbbd9a5775fa80b986c6df6.1234642638.git.trast@student.ethz.ch> <7vvdrcnnl0.fsf@gitster.siamese.dyndns.org> <200902151711.45099.trast@student.ethz.ch> <20090215181818.GA2291@coredump.intra.peff.net>
 <e2b179460902170129s7ae613cehe237619be5e84936@mail.gmail.com> <20090217163413.GB31297@sigill.intra.peff.net> <e2b179460902171000s605675dct1f499a9425c3ebb2@mail.gmail.com> <20090217202731.GA16586@coredump.intra.peff.net>
 <20090218064121.GA16611@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Ralphson <mike.ralphson@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 18 11:15:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZjSw-0002fq-4v
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 11:15:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbZBRKOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 05:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751623AbZBRKOO
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 05:14:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:53578 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751246AbZBRKON (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 05:14:13 -0500
Received: (qmail invoked by alias); 18 Feb 2009 10:14:11 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp061) with SMTP; 18 Feb 2009 11:14:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1947Vc2Lph4xQa1fJTBjXi3CjeoyYDyP3kq7i+6ea
	K164IJcECQogaP
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090218064121.GA16611@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110520>

Hi,

On Wed, 18 Feb 2009, Jeff King wrote:

> I can now get as far as t3404, which seems to have problems due to
> rebase-interactive using parentheses, "-a", and "-o" with "test".

The parentheses will be fixed soon, but "-a" and "-o" really are 
necessary.

Ciao,
Dscho
