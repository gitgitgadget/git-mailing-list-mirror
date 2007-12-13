From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach git-gui to split hunks
Date: Thu, 13 Dec 2007 12:49:45 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712131248500.27959@racer.site>
References: <402731c90712110548k67f28b64w5afa93ee908ce73b@mail.gmail.com>
 <31e9dd080712111114t2bbdba60m18b7d6210f3f9174@mail.gmail.com>
 <e5bfff550712111133j66c4b9adx9f57661cc720aa41@mail.gmail.com>
 <402731c90712111254q1cb99c6al47538971d93b4592@mail.gmail.com>
 <31e9dd080712111329j2c8b22ebs38ab727a5fbe85fb@mail.gmail.com>
 <20071212041002.GN14735@spearce.org> <31e9dd080712112113u44b30c62ja012951fba958c5d@mail.gmail.com>
 <20071212052329.GR14735@spearce.org> <31e9dd080712120702k36a959cfh3e2a5c5fb076d922@mail.gmail.com>
 <Pine.LNX.4.64.0712121814260.27959@racer.site>
 <31e9dd080712121050i45981ed5u845b71f0e73aa8e2@mail.gmail.com>
 <Pine.LNX.4.64.0712121931050.27959@racer.site> <7vhcin3rv4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jason Sewall <jasonsewall@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, David <davvid@gmail.com>,
	Marco Costalba <mcostalba@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 13:50:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2nW3-00043p-8a
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 13:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754736AbXLMMtw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 07:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754402AbXLMMtw
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 07:49:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:38853 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752644AbXLMMtv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 07:49:51 -0500
Received: (qmail invoked by alias); 13 Dec 2007 12:49:49 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp010) with SMTP; 13 Dec 2007 13:49:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Y2aRJ8DIYsYVAl5RbvUGgwgJoP5L0qRjL/pxIia
	/O+IjqUbbt/86b
X-X-Sender: gene099@racer.site
In-Reply-To: <7vhcin3rv4.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68143>

Hi,

On Thu, 13 Dec 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > For this to work, apply has to be called with --unidiff-zero, since
> > the new hunks can start or stop with a "-" or "+" line.
> 
> You do not have to do "unidiff zero".  Suppose you have this hunk you
> need to split.
>
> [describes to pick zero or more '-' lines and zero or more '+' lines]

I thought about that, but the UI is not trivial.  The UI for my solution 
is.

Ciao,
Dscho
