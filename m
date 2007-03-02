From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git checkout preserve timestamp?
Date: Fri, 2 Mar 2007 16:18:41 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703021618000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <17895.18265.710811.536526@lisa.zopyra.com>
 <20070302091426.GA2605@diana.vm.bytemark.co.uk> <17896.9631.316001.869157@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-847461228-1172848721=:22628"
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 16:18:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN9X0-0000Dc-HD
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 16:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992506AbXCBPSp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 10:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965366AbXCBPSp
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 10:18:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:38378 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965389AbXCBPSp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 10:18:45 -0500
Received: (qmail invoked by alias); 02 Mar 2007 15:18:43 -0000
X-Provags-ID: V01U2FsdGVkX1/9W+Uqjpb9i/qcF6mw2FEMNM0bdSoPvD17wzF0dQ
	c2h5JhwTCsaJL1
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <17896.9631.316001.869157@lisa.zopyra.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41215>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-847461228-1172848721=:22628
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 2 Mar 2007, Bill Lear wrote:

> On Friday, March 2, 2007 at 10:14:26 (+0100) Karl Hasselström writes:
> >                                     .... Of course, the proper fix is
> >to use a make-like tool that uses content hashes as well as timestamps
> >to decide if a file has been updated ...
> 
> I like this idea...

I don't like it at all. The proper fix is to _not_ change the contents of 
the current working directory, if you don't want to change them to begin 
with.

Ciao,
Dscho

---1148973799-847461228-1172848721=:22628--
