From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFH] Finding all commits that touch the same files as a specific
 commit
Date: Mon, 14 Jul 2008 13:13:28 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807141311520.8950@racer>
References: <bd6139dc0807120858vc058451lb10933b5225c8521@mail.gmail.com>  <7viqvavao4.fsf@gitster.siamese.dyndns.org>  <bd6139dc0807130743y178a865amebcf130a68283854@mail.gmail.com>  <alpine.DEB.1.00.0807131929200.8950@racer>
 <bd6139dc0807140417h7c9cd309g7cf911e78e7f78c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailinglist <git@vger.kernel.org>
To: Sverre Rabbelier <alturin@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 14:15:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIMwm-0000aS-Ch
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 14:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbYGNMN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 08:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbYGNMN3
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 08:13:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:49047 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751321AbYGNMN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 08:13:29 -0400
Received: (qmail invoked by alias); 14 Jul 2008 12:13:27 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp020) with SMTP; 14 Jul 2008 14:13:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18XXoMIMhkXlmp2zyEw7Np8d0kzevyxuIz4PaAl5f
	ia4f1316m0Okpv
X-X-Sender: gene099@racer
In-Reply-To: <bd6139dc0807140417h7c9cd309g7cf911e78e7f78c5@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88418>

Hi,

On Mon, 14 Jul 2008, Sverre Rabbelier wrote:

> For the activity metric I think pretending that all files with the same 
> name or renamed versions of those would make sense, which is what 
> appending the new name would do. The downside is that all files with the 
> same name get grouped together, I'm not sure which is the lesser of two 
> evils. Leaving out information, or (possibly) including too much.

IMO following the file renames/code moves precisely is really worth the 
time it takes to calculate.  Otherwise, the statistics will not reflect 
what was going on in the project, right?

Ciao,
Dscho
