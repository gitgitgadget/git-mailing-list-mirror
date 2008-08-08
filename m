From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH 0/3] Enable parallelized tests
Date: Fri, 8 Aug 2008 18:33:41 +0200
Message-ID: <20080808163341.GA20211@leksak.fem-net>
References: <alpine.DEB.1.00.0808080752210.9611@pacific.mpi-cbg.de.mpi-cbg.de> <20080808153624.GA28716@neumann> <20080808160252.GA8541@leksak.fem-net> <alpine.DEB.1.00.0808081829160.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 08 18:34:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRUvP-0007QY-IU
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 18:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763AbYHHQdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 12:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752211AbYHHQdp
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 12:33:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:48780 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751505AbYHHQdp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 12:33:45 -0400
Received: (qmail invoked by alias); 08 Aug 2008 16:33:43 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp027) with SMTP; 08 Aug 2008 18:33:43 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18lW98wss0lt+uavRIjZCIwEE5KNJbltx8m89AQRd
	1dKLWR5gghgMWr
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KRUuL-0005Lo-Fn; Fri, 08 Aug 2008 18:33:41 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0808081829160.24820@pacific.mpi-cbg.de.mpi-cbg.de>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91689>

Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 8 Aug 2008, Stephan Beyer wrote:
> 
> > Hm, another simple(?) solution could be to make the tests that try to 
> > access the same port/directory/whatever depend on each other.
> 
> No.  Because then you cannot run them independently anymore.

Sorry, I meant, "depend on each other _in the Makefile_".

So "./t91xy-git-svn-foo.sh" will work independently, won't it?
What does not work independently is "make t91xy-git-svn-foo.sh"
but is it that bad?

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
