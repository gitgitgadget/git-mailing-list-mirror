From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: correct git merge behavior or corner case?
Date: Tue, 21 Apr 2009 10:56:27 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904211055160.10279@pacific.mpi-cbg.de>
References: <4ac8254d0904191540j68246cd8qa36a034209d4c800@mail.gmail.com>  <alpine.DEB.1.00.0904201148150.6955@intel-tinevez-2-302> <41354.bFoQE3daRhY=.1240222235.squirrel@webmail.hotelhot.dk>  <20090421024433.GC14479@coredump.intra.peff.net>
 <7vskk2bt3x.fsf@gitster.siamese.dyndns.org> <fabb9a1e0904210148w4c6b869l396122baef1c0ee3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>,
	Tuncer Ayaz <tuncer.ayaz@gmail.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 10:56:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwBmX-0003Cm-G2
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 10:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124AbZDUIyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 04:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751992AbZDUIyy
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 04:54:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:55670 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751083AbZDUIyx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 04:54:53 -0400
Received: (qmail invoked by alias); 21 Apr 2009 08:54:51 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp063) with SMTP; 21 Apr 2009 10:54:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18iNWdItnMiLQ17s09+62zi3vJlrhUBuIPtHKdMVn
	ZtU1Bs0KCHj7ml
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <fabb9a1e0904210148w4c6b869l396122baef1c0ee3@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117107>

Hi,

On Tue, 21 Apr 2009, Sverre Rabbelier wrote:

> On Tue, Apr 21, 2009 at 05:09, Junio C Hamano <gitster@pobox.com> wrote:
> > and sane projects would not have an empty file tracked anyway, so...
> 
> Except python projects that are full of empty __init__.py files.... no?

But they would be a good example why we do _not_ want rename detection 
there.

I actually agree with Junio, though, that we want this special handling of 
empty files only in merge-recursive.

Ciao,
Dscho
