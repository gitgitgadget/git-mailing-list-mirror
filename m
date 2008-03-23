From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/4] Add a function for get the parents of a commit
Date: Sun, 23 Mar 2008 23:33:56 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803232332150.4353@racer.site>
References: <1206308562-31489-1-git-send-email-joerg@alea.gnuu.de> <1206308562-31489-2-git-send-email-joerg@alea.gnuu.de> <1206308562-31489-3-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1715906408-1206311638=:4353"
Cc: git@vger.kernel.org, gitster@pobox.com, B.Steinbrink@gmx.de
To: =?ISO-8859-15?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Sun Mar 23 23:34:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdYlx-0002l5-RE
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 23:34:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755835AbYCWWd4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 18:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755846AbYCWWd4
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 18:33:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:59754 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755744AbYCWWdz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 18:33:55 -0400
Received: (qmail invoked by alias); 23 Mar 2008 22:33:54 -0000
Received: from host86-148-26-43.range86-148.btcentralplus.com (EHLO racer.home) [86.148.26.43]
  by mail.gmx.net (mp018) with SMTP; 23 Mar 2008 23:33:54 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX195SjhGWRZ53gHhir9Ci0cTkqvFEdkj91Vt+lOPl3
	zXfolLDf6uJM6w
X-X-Sender: gene099@racer.site
In-Reply-To: <1206308562-31489-3-git-send-email-joerg@alea.gnuu.de>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77970>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1715906408-1206311638=:4353
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sun, 23 Mar 2008, Jörg Sommer wrote:

> 
> Signed-off-by: Jörg Sommer <joerg@alea.gnuu.de>

"for get"?  You mean "to get".

> +parents_of_commit() {
> +	git rev-list --parents -1 "$1" | cut -d' ' -f2-
> +}

>From the rest of Git's source code, I would have expected this to be 
called "get_parents", and to have a space before the parens.  In general, 
it is always good to imitate the style around the code you are writing.

Ciao,
Dscho
--8323584-1715906408-1206311638=:4353--
