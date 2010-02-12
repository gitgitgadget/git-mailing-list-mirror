From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: strbuf & other stuff dual-licensing, was Re: GSoC 2010
Date: Fri, 12 Feb 2010 11:49:41 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002121147440.20986@pacific.mpi-cbg.de>
References: <fabb9a1e1002101223o6a00f7eavb84567c1119c8ebc@mail.gmail.com> <20100212080620.GA31719@dcvr.yhbt.net> <alpine.DEB.1.00.1002121000290.20986@pacific.mpi-cbg.de> <fabb9a1e1002120103j3f37d417ka5b7b7ca3ae8edd@mail.gmail.com> <20100212091635.GA22942@glandium.org>
 <alpine.DEB.1.00.1002121034320.20986@pacific.mpi-cbg.de> <fabb9a1e1002120132q157d2d4dqd7c81d766bd933f6@mail.gmail.com> <20100212100758.GA23461@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>, Andreas Ericsson <ae@op5.se>,
	Pierre Habouzit <madcoder@madism.org>
X-From: git-owner@vger.kernel.org Fri Feb 12 11:43:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfszX-0004LI-4u
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 11:43:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136Ab0BLKnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 05:43:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:47463 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751161Ab0BLKnM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 05:43:12 -0500
Received: (qmail invoked by alias); 12 Feb 2010 10:43:10 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp005) with SMTP; 12 Feb 2010 11:43:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19x7TlrNSZx3RjnCDbktOuuixhy2Ia6igHySQxxJK
	/RFU1Ki2BmDexq
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20100212100758.GA23461@glandium.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.60999999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139679>

Hi,

[culling the Cc: list to the most-likely interested parties, Cc:ing 
Andreas and Pierre]

On Fri, 12 Feb 2010, Mike Hommey wrote:

> On Fri, Feb 12, 2010 at 10:32:44AM +0100, Sverre Rabbelier wrote:
> 
> > On Fri, Feb 12, 2010 at 10:35, Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > > On Fri, 12 Feb 2010, Mike Hommey wrote:
> > >> It is already mentioned on the wiki that this would probably be a
> > >> problem, license-wise. (the svn library is Apache license, which is
> > >> incompatible with GPLv2)
> > 
> > Yeah, guess who put that there ;).
> > 
> > > So git-remote-svn would have to be under an Apache-compatible license, so
> > > what? It is not as if git-remote-svn was a derivative work of Git, just
> > > because it abides by a very simple command-line interface that happens to
> > > be defined in Git, but would work anywhere else, too.
> > 
> > Excellent point, I think we could safely argue that if we only expose
> > 'import' and 'export' (so adhere to the fast-import/fast-export format
> > that is already widely used), that it is indeed not a derative work.
> 
> It is not so clear when you begin to use facilities such as strbuf, etc.
> Maybe dual-licensing these parts would be enough, though, but that still
> means doing some homework (getting approval from all contributors)

AFAIR Andreas already did most of the chasing down for libgit2.

Ciao,
Dscho
