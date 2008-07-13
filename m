From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFH] Finding all commits that touch the same files as a specific
 commit
Date: Sun, 13 Jul 2008 19:30:27 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807131929200.8950@racer>
References: <bd6139dc0807120858vc058451lb10933b5225c8521@mail.gmail.com>  <7viqvavao4.fsf@gitster.siamese.dyndns.org> <bd6139dc0807130743y178a865amebcf130a68283854@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailinglist <git@vger.kernel.org>
To: Sverre Rabbelier <alturin@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 20:31:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI6M4-0007Ur-Je
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 20:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753891AbYGMSa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 14:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753851AbYGMSa3
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 14:30:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:33222 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753799AbYGMSa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 14:30:28 -0400
Received: (qmail invoked by alias); 13 Jul 2008 18:30:26 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp026) with SMTP; 13 Jul 2008 20:30:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19en2xJCcZet7ThE1IuDkclobj2Ut1mfyBskfoTuZ
	tDNwkgZ95rVSBA
X-X-Sender: gene099@racer
In-Reply-To: <bd6139dc0807130743y178a865amebcf130a68283854@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88321>

Hi,

On Sun, 13 Jul 2008, Sverre Rabbelier wrote:

> On Sun, Jul 13, 2008 at 3:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
> 
> <explanation of the git log traversal machinery snipped>
> 
> > In order to follow renames reliably in a merge heavy history, you need to
> > keep track of the pathname the file you are interested in appears as _in
> > each commit_.  As you traverse down the history, you pass down the
> > pathname to the parent you visit, so while you are traversing from 'x' to
> > earlier 'x', you will keep following "git-gui/git-gui.sh", while you
> > traverse down to 'o', you will inspect "git-gui.sh".
> >
> > The data structure the revision traversal machinery uses does not support
> > this "path-per-commit" natively.
> 
> Would it be possible to go for a slightly less complicated approach
> and instead of passing replacing the tracked file, append it?

Maybe I miss something, but do you not have to keep track of the file 
names, in order to keep track of the proper statistics?

If that is the case, appending does not cut it.

Ciao,
Dscho
