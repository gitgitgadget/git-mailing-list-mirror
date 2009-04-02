From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Broken t9001 tests
Date: Thu, 2 Apr 2009 15:22:33 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904021520200.7464@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 15:24:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpMts-00062n-13
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 15:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133AbZDBNWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 09:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754037AbZDBNWh
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 09:22:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:33669 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751553AbZDBNWg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 09:22:36 -0400
Received: (qmail invoked by alias); 02 Apr 2009 13:22:33 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp064) with SMTP; 02 Apr 2009 15:22:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/EWJxTjIHEbMYOXtFHWRNmeSOQ8BGNXHcnusmSLj
	cdqUH7bNJdak42
X-X-Sender: schindel@intel-tinevez-2-302
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115462>

Hi,

only when I revert both dc1460a(send-email: ask_default should apply to 
all emails, not just the first) and c18f75a(send-email: add tests for 
refactored prompting) does my test suite pass without asking me 
_interactively_ (twice, even) if I want to

	Send this email? ([y]es|[n]o|[q]uit|[a]ll):

Please fix.

Ciao,
Dscho
