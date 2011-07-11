From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Do not trust PWD blindly
Date: Mon, 11 Jul 2011 19:18:10 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1107111917330.1534@s15462909.onlinehome-server.info>
References: <CABNJ2GKgzXGDq9FhKcVP380bs=rEKqYdrOaCb+A99_TBm7A4_A@mail.gmail.com> <alpine.DEB.1.00.1107091935210.1985@bonsai2> <4E1A0FCC.7080308@kdbg.org> <alpine.DEB.1.00.1107110057120.3379@bonsai2> <86k4bpporf.fsf@red.stonehenge.com>
 <alpine.DEB.1.00.1107111121390.3379@bonsai2> <7vbox0g3hn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Johannes Sixt <j6t@kdbg.org>, Pat Thoyts <patthoyts@gmail.com>,
	msysGit <msysgit@googlegroups.com>,
	Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 11 19:18:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgK7f-0003Yc-IE
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 19:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758063Ab1GKRSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 13:18:14 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:50064 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758011Ab1GKRSO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 13:18:14 -0400
Received: (qmail invoked by alias); 11 Jul 2011 17:18:11 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp039) with SMTP; 11 Jul 2011 19:18:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19BaPpXjkZB8BUwSEIurihdkRt3+KYYWIYZDMqhcJ
	lzV9EGiynARK5o
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <7vbox0g3hn.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176875>

Hi,

On Mon, 11 Jul 2011, Junio C Hamano wrote:

> "Do not trust st.st_ino/st.st_dev blindly" might be a better title in 
> that sense.

Maybe prefix it with "get_pwd_cwd(): "?

> In any case, thanks for a fix; will queue.

Thanks!
Johannes
