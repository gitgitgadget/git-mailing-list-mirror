From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Cast things properly to handle >2G files.
Date: Sun, 14 Jun 2009 22:17:15 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906142215560.26154@pacific.mpi-cbg.de>
References: <E1MFvux-0001ix-I7@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Alfred M. Szmidt" <ams@gnu.org>
X-From: git-owner@vger.kernel.org Sun Jun 14 22:16:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFw7n-00084I-24
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 22:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588AbZFNUQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2009 16:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754305AbZFNUQI
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 16:16:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:49309 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754043AbZFNUQH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2009 16:16:07 -0400
Received: (qmail invoked by alias); 14 Jun 2009 20:16:08 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp054) with SMTP; 14 Jun 2009 22:16:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+hEdl3BwqhgT1uQ4gnGvtTq7e9a6YfclQkxhLWvj
	Rj3PLulCSnUOD8
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <E1MFvux-0001ix-I7@fencepost.gnu.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121561>

Hi,

Disclaimer: if you are offended by constructive criticism, or likely to
answer with insults to the comments I offer, please stop reading this mail
now (and please do not answer my mail, either). :-)

Still with me?  Good.  Nice to meet you.

Just for the record: responding to a patch is my strongest way of saying
that I appreciate your work.

On Sun, 14 Jun 2009, Alfred M. Szmidt wrote:

> This small patch fixes things so that repack, fsck, and other things
> work on >2GiB files.  There are still some other problems (cloning
> over ssh being one), but this makes it atleast possible to handle such
> files.
> 
> (not subscribed, please CC)

This is almost perfect, but please add a Signed-off-by: line.

Oh, and maybe add a test like t/t5705-clone-2gb.sh?

Ciao,
Dscho
