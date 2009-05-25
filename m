From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Araxis in mergetool, was Re: What's cooking in git.git (May 2009,
 #03; Mon, 25)
Date: Mon, 25 May 2009 10:54:43 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905251050050.4288@intel-tinevez-2-302>
References: <7vd49xy42b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 25 10:54:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8VxO-00041F-Ls
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 10:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753603AbZEYIyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 04:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753169AbZEYIyt
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 04:54:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:53444 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752732AbZEYIys (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 04:54:48 -0400
Received: (qmail invoked by alias); 25 May 2009 08:54:48 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp071) with SMTP; 25 May 2009 10:54:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19O2TRJl2xOvVAWHQ7YesfVVw+XCma1zpyrz6H60/
	KjINElAEGisXI+
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vd49xy42b.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119902>

Hi,

On Mon, 25 May 2009, Junio C Hamano wrote:

> * da/araxis-mergetool (Sun May 24 00:24:41 2009 +0000) 1 commit
>  + mergetool--lib: add support for araxis merge
> 
> I admit that I feel certain distaste in supporting a closed tool, but we
> already make things bearable for people on Windows; Araxis is no worse,
> right?

Well, I think it is the first closed-source tool that we support, and I 
would feel less unhappy if somebody reported back that she tested it and 
it works fine.

For the future, it might be better if mergetool could be configured using 
/etc/gitconfig to call the merge helper properly.  Then we would not need 
to clutter git.git with properietary stuff, but could just have the 
Windows-specific handling in Git for Windows.

Ciao,
Dscho
