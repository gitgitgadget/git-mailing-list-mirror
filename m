From: Michael Somos <somos@grail.cba.csuohio.edu>
Subject: Re: git-1.4.0 make problems
Date: Sat, 17 Jun 2006 10:46:35 -0400
Message-ID: <200606171446.k5HEkZAx006686@grail.cba.csuohio.edu>
Cc: git@vger.kernel.org, rene.scharfe@lsrfire.ath.cx
X-From: git-owner@vger.kernel.org Sat Jun 17 16:53:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrcAs-0006vy-NX
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 16:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbWFQOxK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 10:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbWFQOxK
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 10:53:10 -0400
Received: from grail.cba.csuohio.edu ([137.148.216.15]:16334 "EHLO
	grail.cba.csuohio.edu") by vger.kernel.org with ESMTP
	id S1751653AbWFQOxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jun 2006 10:53:09 -0400
Received: from grail.cba.csuohio.edu (localhost [127.0.0.1])
	by grail.cba.csuohio.edu (8.12.11/8.12.10) with ESMTP id k5HEkZLl006688;
	Sat, 17 Jun 2006 10:46:35 -0400
Received: (from somos@localhost)
	by grail.cba.csuohio.edu (8.12.11/8.12.11/Submit) id k5HEkZAx006686;
	Sat, 17 Jun 2006 10:46:35 -0400
To: dennis@stosberg.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22018>

Dennis  Stosberg wrote :

> I have seen this test failing on FreeBSD 5.3, too.  FreeBSD comes with a
> version of "diff" which does not add the "\ No newline at end of file"
> remark.  Maybe your "diff" is simply too old.  In that case, it's not a
> serious problem because Git uses its own internal diff implementation.

You are exactly right. My "diff" is a bit too old. It was 2.7 and the
latest stable is 2.8.1 which fixes the newline problem.

> The intention of this test is to test git-apply and not the system's
> "diff", so perhaps it should bring along all its patches and not rely
> on the system's "diff" to generate them...

That seems like a good suggestion if it is as you wrote. Thanks for the
information regarding diff and git. Shalom, Michael
