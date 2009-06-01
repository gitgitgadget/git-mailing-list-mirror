From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 03/11 v2] Work around a regression in Windows 7, causing
 erase_in_line() to crash sometimes
Date: Mon, 1 Jun 2009 10:25:48 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906011025080.26154@pacific.mpi-cbg.de>
References: <4A22C674.603@kdbg.org> <1243836256-11958-1-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Jun 01 10:25:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MB2pW-0001kD-FY
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 10:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754027AbZFAIZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 04:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752966AbZFAIZF
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 04:25:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:56139 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752676AbZFAIZE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 04:25:04 -0400
Received: (qmail invoked by alias); 01 Jun 2009 08:25:04 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp052) with SMTP; 01 Jun 2009 10:25:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18PMxgWv7sPryOQc0Xf27fPMrwodqdoLN32B5p4xg
	OOESjKNDUCixje
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1243836256-11958-1-git-send-email-prohaska@zib.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120450>

Hi,

On Mon, 1 Jun 2009, Steffen Prohaska wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The function FillConsoleOutputCharacterA() was pretty content in XP to take a NULL
> pointer if we did not want to store the number of written columns.  In Windows 7,
> it crashes, but only when called from within Git Bash, not from within cmd.exe.
> Go figure.

Did I really have too-long lines in my commit message?

> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Steffen Prohaska <prohaska@zib.de>
> ---
>  compat/winansi.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> I squashed the second chunk of 05/11, as suggested by Hannes.

Makes sense, thank you!
Dscho
