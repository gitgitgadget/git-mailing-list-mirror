From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Move run_hook() from builtin-commit.c into run-command.c
 (libgit)
Date: Fri, 16 Jan 2009 21:58:46 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901162157400.3586@pacific.mpi-cbg.de>
References: <1232031618-5243-1-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0901151637590.3586@pacific.mpi-cbg.de> <20090116172521.GD28177@leksak.fem-net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Paolo Bonzini <bonzini@gnu.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>, gitster@pobox.com
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jan 16 21:59:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNvmf-00030C-Kh
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 21:59:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754401AbZAPU5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 15:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753445AbZAPU5x
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 15:57:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:53184 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752559AbZAPU5w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 15:57:52 -0500
Received: (qmail invoked by alias); 16 Jan 2009 20:57:50 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp061) with SMTP; 16 Jan 2009 21:57:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18+QDNQhYU+EH5I/wjzY7IT/V2fR7Tj1N9Hie8pVu
	My2cH5TYEmMb1C
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090116172521.GD28177@leksak.fem-net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105994>

Hi,

On Fri, 16 Jan 2009, Stephan Beyer wrote:

> Dscho wrote:
>
> > Lots of improvements possible (I agree; _after_ this patch):
> [...]
> 
> > - use an strbuf for the index file
> 
> Is that useful in some way?
> Currently it would only adds code to generate strbufs at the caller
> side. And in the case the caller has a strbuf for the index file, it
> can simply use the .buf member.

Of course I meant the buffer into which "GIT_INDEX_FILE=..." is written, 
which is fixed size ATM.

Ciao,
Dscho
