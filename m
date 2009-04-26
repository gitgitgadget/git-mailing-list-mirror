From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Google Code: Support for Mercurial and Analysis of Git and
 Mercurial
Date: Sun, 26 Apr 2009 18:56:54 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904261854460.10279@pacific.mpi-cbg.de>
References: <200904260703.31243.chriscool@tuxfamily.org> <m363grq13i.fsf@localhost.localdomain> <49F475B8.20903@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 11:47:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ly7gK-0007r1-SM
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 18:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754290AbZDZQ4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2009 12:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754093AbZDZQ4q
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 12:56:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:35634 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753391AbZDZQ4p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 12:56:45 -0400
Received: (qmail invoked by alias); 26 Apr 2009 16:56:42 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp053) with SMTP; 26 Apr 2009 18:56:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19/AhAPMe5/+oMsm3owggnAJl56PLfa/Dlt1CHZME
	RP0FNDbUz9FLcT
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <49F475B8.20903@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117635>

Hi,

On Sun, 26 Apr 2009, A Large Angry SCM wrote:

> Another important criteria was which, both or neither of Git and Hg 
> would actually work and perform well on top of Google Code's underling 
> storage system and except to mention they would be using Bigtable, the 
> report did not discuss this. Git on top of Bigtable will not perform 
> well.

Actually, did we not arrive at the conclusion that it could perform well 
at least with the filesystem layer on top of big table, but even better if 
the big tables stored certain chunks (not really all that different from 
the chunks needed for mirror-sync!)?

Back when I discussed this with a Googler, it was all too obvious that 
they are not interested (and in the meantime I understand why, see my 
other mail).

Ciao,
Dscho
