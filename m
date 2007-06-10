From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 11/21] Rewrite error messages; fix up line lengths
Date: Sun, 10 Jun 2007 09:38:55 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706100933270.4059@racer.site>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net> <200706090210.36270.johan@herland.net>
 <200706090217.17795.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 10:42:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxJ05-00050K-0z
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 10:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762886AbXFJImK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 04:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762851AbXFJImJ
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 04:42:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:57178 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762881AbXFJImH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 04:42:07 -0400
Received: (qmail invoked by alias); 10 Jun 2007 08:42:06 -0000
Received: from rdcg01.wifihubtelecom.net (EHLO [10.140.3.169]) [213.174.113.122]
  by mail.gmx.net (mp018) with SMTP; 10 Jun 2007 10:42:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX181JMQwVT81EFPLtlUYlU+s9o3t5UXDwKhmtpMo51
	Y4zcLeFtPvt58J
X-X-Sender: gene099@racer.site
In-Reply-To: <200706090217.17795.johan@herland.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49682>

Hi,

On Sat, 9 Jun 2007, Johan Herland wrote:

> Also update selftests to reflect new error messages.

Had you split the patch conceptually, the changes to the tests would have 
been included where appropriate.

I consider a patch _breaking_ a test case, with a follow up patch to the 
test case, a _bug_.

And I consider a change in error messages not good, _unless_ the changes 
have a real value in practice. Which I maintain they do not, in this 
patch-series' case.

Ciao,
Dscho
