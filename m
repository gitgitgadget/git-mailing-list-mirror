From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git config: Don't rely on regexec() returning 1 on
 non-match
Date: Wed, 5 Dec 2007 15:14:11 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712051513570.27959@racer.site>
References: <1196867484-22188-1-git-send-email-B.Steinbrink@gmx.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-517497974-1196867651=:27959"
Cc: gitster@pobox.com, git@vger.kernel.org
To: =?utf-8?q?Bj=C3=B6rn=20Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 05 16:15:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Izvxq-0005a9-0C
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 16:15:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124AbXLEPOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 10:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752104AbXLEPOn
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 10:14:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:57580 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751743AbXLEPOn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 10:14:43 -0500
Received: (qmail invoked by alias); 05 Dec 2007 15:14:40 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp012) with SMTP; 05 Dec 2007 16:14:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Aq9sMv6uAu+k5/J4qyMSURy4eKTWNFKk0AGE+w7
	65/0Dop0XaFlxg
X-X-Sender: gene099@racer.site
In-Reply-To: <1196867484-22188-1-git-send-email-B.Steinbrink@gmx.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67157>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-517497974-1196867651=:27959
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 5 Dec 2007, Björn Steinbrink wrote:

> Some systems don't return 1 from regexec() when the pattern does not
> match (notably HP-UX which returns 20). Fortunately, there's the
> REG_NOMATCH constant, which we can use as the expected return value
> and test for that instead of "1 XOR retval".
> 
> Bug identified by Dscho and H.Merijn Brand.
> 
> Signed-off-by: Björn Steinbrink <B.Steinbrink@gmx.de>
> Tested-by: H.Merijn Brand <h.m.brand@xs4all.nl>
> Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>

ACK

Ciao,
Dscho

---1463811741-517497974-1196867651=:27959--
