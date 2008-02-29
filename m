From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add test for git rebase --abort
Date: Fri, 29 Feb 2008 23:39:19 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802292338190.22527@racer.site>
References: <1204322927-22407-1-git-send-email-mh@glandium.org> <7v63w7bb06.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 00:40:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVEqD-0005P5-Eg
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 00:40:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761081AbYB2Xj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 18:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760824AbYB2Xj7
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 18:39:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:55732 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760964AbYB2Xj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 18:39:59 -0500
Received: (qmail invoked by alias); 29 Feb 2008 23:39:57 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp038) with SMTP; 01 Mar 2008 00:39:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19rtnhD0AdrVgwuBnh2gCGXd3f3E7jQiqJEr61mmH
	UA/Prdx/6bUHhV
X-X-Sender: gene099@racer.site
In-Reply-To: <7v63w7bb06.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75592>

Hi,

On Fri, 29 Feb 2008, Junio C Hamano wrote:

>         Side note.  As a test framework extension, we might want
>         to add 4th parameter to test_expect_{success,failure}
>         that specifies a clean-up to be made regardless of the
>         outcome of the test.

I saw something the other night, where the test _I_ introduced, for 
git-daemon, failed (with -i -v), and the daemon was _not_ killed as I 
expected (with trap "<bla>" 0).

Ciao,
Dscho

