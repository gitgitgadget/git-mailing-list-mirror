From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Newbie: report of first experience with git-rebase.
Date: Wed, 31 Oct 2007 21:12:06 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0710312111170.4362@racer.site>
References: <87d4uv3wh1.fsf@osv.gnss.ru> <20071031195702.GB24332@atjola.homenet>
 <874pg73u6h.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 22:13:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InKs6-00020F-DS
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 22:13:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755111AbXJaVMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 17:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753891AbXJaVMv
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 17:12:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:47783 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753432AbXJaVMu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 17:12:50 -0400
Received: (qmail invoked by alias); 31 Oct 2007 21:12:48 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp027) with SMTP; 31 Oct 2007 22:12:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+iJ/YF73WiH1JtBD57Z/KOd7r81xEGYCU8eCJ2dj
	ZszSgbC4W8xIcT
X-X-Sender: gene099@racer.site
In-Reply-To: <874pg73u6h.fsf@osv.gnss.ru>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62871>

Hi,

On Wed, 31 Oct 2007, Sergei Organov wrote:

> Yes, and that's the problem. Why 'git --continue' didn't just skip this 
> patch that *already became no-op* after conflict resolution and forced 
> me to explicitly use 'git --skip' instead?

Isn't that obvious?  To prevent you from accidentally losing a commit.

Ciao,
Dscho
