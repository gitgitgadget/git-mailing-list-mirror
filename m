From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Something like $Id$, $Revision$ or $Date$?
Date: Mon, 10 Nov 2008 13:25:14 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811101319570.30769@pacific.mpi-cbg.de>
References: <87ljvsjuq7.fsf@erwin.mina86.com> <bd6139dc0811091643m31ff6f49o55a4c581be7f38b2@mail.gmail.com> <87hc6gjs7v.fsf@erwin.mina86.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: sverre@rabbelier.nl, git@vger.kernel.org
To: Michal Nazarewicz <mina86@tlen.pl>
X-From: git-owner@vger.kernel.org Mon Nov 10 13:18:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzVjM-0003Ck-Q4
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 13:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754344AbYKJMRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 07:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754430AbYKJMRm
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 07:17:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:46473 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754332AbYKJMRm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 07:17:42 -0500
Received: (qmail invoked by alias); 10 Nov 2008 12:17:40 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp034) with SMTP; 10 Nov 2008 13:17:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18cjDQFk7wc0IFVu2BzBgc2TldSR5ReebSW0tUWhV
	y9pEa0tbSOi8Nh
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <87hc6gjs7v.fsf@erwin.mina86.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100522>

Hi,

On Mon, 10 Nov 2008, Michal Nazarewicz wrote:

> I would like the "$Id$" sequences to be updated automatically after a 
> commit (ie. without the need to check out).  (Besides I would prefer 
> $Date$ more but I can live with $Id$ I guess ;) ).

No, you don't.

At least most likely you do not want that behavior.  Typically, you have 
the $Id$ stuff in released versions to indicate what revision that version 
came from even if the files are no longer in a Git repository.

And you can have that without ever committing anything in-between, by 
using the export-subst attributes with git-archive.  Have a look at 
Documentation/gitattributes.txt (I agree it is underdocumented in 
git-archive.txt).

If that is not your use case, then it may be wise to let us Git people 
know what you _actually_ want (i.e. instead of asking for a specific 
solution, you could tell us what your problem is).

Ciao,
Dscho
