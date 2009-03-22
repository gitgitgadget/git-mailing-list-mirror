From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/7] check_ref_format(): tighten refname rules
Date: Sun, 22 Mar 2009 15:41:11 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903221539060.10279@pacific.mpi-cbg.de>
References: <1237673619-12608-1-git-send-email-gitster@pobox.com> <1237673619-12608-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 15:40:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlOqw-0006KV-DE
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 15:40:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753613AbZCVOjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 10:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753497AbZCVOjM
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 10:39:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:33438 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753069AbZCVOjL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 10:39:11 -0400
Received: (qmail invoked by alias); 22 Mar 2009 14:39:08 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp064) with SMTP; 22 Mar 2009 15:39:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Hwn0128uHTrxpASPXa+yal0Wb1ydCZZse9dIVjE
	Y7ku6rn5otumY1
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1237673619-12608-2-git-send-email-gitster@pobox.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114142>

Hi,

On Sat, 21 Mar 2009, Junio C Hamano wrote:

> Yes, I know that tightening rules retroactively is bad, but this changes 
> the rules for refnames to forbid:

Tightening rules retroactively is not only bad (if sometimes necessary), 
but tightening rules without giving the user a chance to recover is really 
bad.

'git branch -m' uses check_ref_format() to check the old name.

OTOH, a _warning_ should be plenty enough in most cases, and _not_ share 
the shortcomings with tightening.

Ciao,
Dscho
