From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Cross-Platform Version Control
Date: Tue, 12 May 2009 18:57:47 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905121856250.4447@intel-tinevez-2-302>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com> <20090512151403.GS30527@spearce.org> <20090512161638.GB29566@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Esko Luontola <esko.luontola@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 12 18:57:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3vIl-0000qZ-Bb
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 18:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917AbZELQ5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 12:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752445AbZELQ5t
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 12:57:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:58492 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750825AbZELQ5t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 12:57:49 -0400
Received: (qmail invoked by alias); 12 May 2009 16:57:48 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp065) with SMTP; 12 May 2009 18:57:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX190D8xF24x0Xw53Lb9+24jX0A41YIBq8RQPXR94PX
	gZfVRCeuSBktrv
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090512161638.GB29566@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118928>

Hi,

On Tue, 12 May 2009, Jeff King wrote:

> On Tue, May 12, 2009 at 08:14:03AM -0700, Shawn O. Pearce wrote:
> 
> > As for file names, no plans, its a sequence of bytes, but I think a 
> > lot of people wind up using some subset of US-ASCII for their file 
> > names, especially if their project is going to be cross platform.
> 
> Or they use a single encoding like utf8 so that there are no surprises. 
> You can still run into normalization problems with filenames on some 
> filesystems, though.  Linus's name_hash code sets up the framework to 
> handle "these two names are actually equivalent", but right now I think 
> there is just code for handling case-sensitivity, not utf8 normalization 
> (but I just skimmed the code, so I might be wrong).

Back then I actually started on a patch to make Git capable of determining 
UTF-8 equivalence, but at the same time somebody started such an annoying 
mail thread that I stopped working on the issue completely.

Ciao,
Dscho
