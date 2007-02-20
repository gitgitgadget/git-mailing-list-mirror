From: Jason Riedy <ejr@cs.berkeley.edu>
Subject: Re: [PATCH] Obey NO_C99_FORMAT in fast-import.c.
Date: Tue, 20 Feb 2007 12:17:50 -0800
Message-ID: <19963.1172002670@lotus.CS.Berkeley.EDU>
Cc: git@vger.kernel.org
To: "Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Tue Feb 20 21:25:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJbYN-0006eg-Gf
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 21:25:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030374AbXBTUZZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 15:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030422AbXBTUZZ
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 15:25:25 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:33761 "EHLO
	lotus.CS.Berkeley.EDU" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030374AbXBTUZY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 15:25:24 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id l1KKHpc6020077;
	Tue, 20 Feb 2007 12:17:51 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id l1KKHod4020074;
	Tue, 20 Feb 2007 12:17:51 -0800 (PST)
In-reply-to: 45DAF02C.4020003@fs.ei.tum.de 
X-Mailer: MH-E 8.0.3; nmh 1.1; GNU Emacs 22.0.92
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40261>

And Simon 'corecode' Schubert writes:
> I think this should read something like
> 
> #ifndef PRIuMAX
> #define PRIuMAX		"llu"	/* Assumes unsigned long long exists */
> #endif

You're right, that's much cleaner.  I'll try it and test it.
(Takes many hours to run a test on this poor machine, so the
patch won't be sent until tomorrow.)

Jason
