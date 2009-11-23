From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] remote-curl.c: fix rpc_out()
Date: Mon, 23 Nov 2009 11:39:31 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0911231137170.4985@pacific.mpi-cbg.de>
References: <20091123110338.2b230359.rctay89@gmail.com>  <fabb9a1e0911222153n633ade94w179513d4aa42a3d4@mail.gmail.com> <be6fef0d0911230038y13c23e3ek5591ee0dc3eaa47a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 23 11:35:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCWGl-0001fx-S7
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 11:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756893AbZKWKf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 05:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756643AbZKWKf3
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 05:35:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:34593 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756632AbZKWKf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 05:35:28 -0500
Received: (qmail invoked by alias); 23 Nov 2009 10:35:32 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp006) with SMTP; 23 Nov 2009 11:35:32 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+DPe4g4xKD4RQKryIOQ/RIE7bQhWP7Wk1PCM+p2T
	fOQOdLRZamxIcq
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <be6fef0d0911230038y13c23e3ek5591ee0dc3eaa47a@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133496>

Hi,

On Mon, 23 Nov 2009, Tay Ray Chuan wrote:

> On Mon, Nov 23, 2009 at 1:53 PM, Sverre Rabbelier <srabbelier@gmail.com> 
> wrote:
> > Seems like this type of patch would do very well with a test case or 
> > two?
> 
> ah, but to trigger the code involved, a sufficiently large test 
> repository is needed. The git repository would be enough. :)

I guess you meant "not be enough", as an int can hold a pretty large 
number until it turns negative.

So I think in this case it is more harm- than helpful to have a test case.

For future reference: if you need a repository with special featurs 
for testing, it is best to generate it in a test script (see the many test 
cases labeled 'setup' in our test suite for examples).

Ciao,
Dscho
