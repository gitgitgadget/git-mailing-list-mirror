From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] test suite: correct export var=val usage
Date: Wed, 18 Feb 2009 00:47:25 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902180046290.10279@pacific.mpi-cbg.de>
References: <7vr61w3dug.fsf@gitster.siamese.dyndns.org> <1234911188-36941-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 00:48:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZZfO-0004lY-93
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 00:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753152AbZBQXq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 18:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753128AbZBQXq0
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 18:46:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:51656 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752177AbZBQXq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 18:46:26 -0500
Received: (qmail invoked by alias); 17 Feb 2009 23:46:24 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp069) with SMTP; 18 Feb 2009 00:46:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/rWAxkb9zrAO1t3CwWJXuxtKhonWTWqbQk1sZob1
	Xb3HFF1nbyuqfk
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1234911188-36941-1-git-send-email-jaysoffian@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110478>

Hi,

On Tue, 17 Feb 2009, Jay Soffian wrote:

> +	(MSG=1 GIT_NOTES_REF=refs/heads/bogus
> +	 && export MSG GIT_NOTES_REF &&

Hmm.  Why does the "&&" at the start of a line strike me as odd.  Ah, yes, 
it is because no code around it uses that style.

*grins*

Ciao,
Dscho
