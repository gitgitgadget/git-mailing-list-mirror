From: "Constantine Plotnikov" <constantine.plotnikov@gmail.com>
Subject: Forcing progerss output for clone
Date: Sat, 4 Oct 2008 00:01:14 +0400
Message-ID: <85647ef50810031301k641c5f24n65fb213c2b481e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 03 22:02:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Klqr6-0002OJ-UA
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 22:02:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752880AbYJCUBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 16:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752722AbYJCUBR
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 16:01:17 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:7277 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbYJCUBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 16:01:16 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1199665fkq.5
        for <git@vger.kernel.org>; Fri, 03 Oct 2008 13:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=M70s/KgxmLOfJO8YKLC05QCgee69Tm49vNA4XoBEDU4=;
        b=K7N/u5d0akO3EQ95m5a81soTcABN+4QOaPSZyTqtDMPI0q/Z/lxgkHDHuY8cyqpL0s
         C4ZoS9nP+XtmmDjcsGfK9eGC0gtiDrSxnbDSglJWGkXCfhW4fp7jZQ/PV0PYX0uvTAVk
         /OGABhY/YZLUetLmdWLjq/F4cq4Yx35r4FugU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=mqCQh7i+oP5fB6a8VMvjVsTYmh3ws+xx7lDQ0GsXCwZ41OxMx66IHKH/Yf4fvkiY6w
         BRuQhfLVIDFdHu5anlIsifXgI3RNQMZzFyDqNdInsLrF4tnVcL6E3yCMvYU7eyIO5b+r
         8L8s0nRpCYUyX1vhSUuzI88v8dz3sQADmiY6c=
Received: by 10.181.34.1 with SMTP id m1mr1234710bkj.85.1223064074620;
        Fri, 03 Oct 2008 13:01:14 -0700 (PDT)
Received: by 10.180.230.10 with HTTP; Fri, 3 Oct 2008 13:01:14 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97448>

Hello!

Is there a way to force a progress output on stderr for git clone
preferably using options or environment variables?

The clone command in the git 1.6.0.2 does not print a progress
information to stderr if stdout and stderr are redirected (even if no
"-q" option is specified).

Such information would have been useful for displaying progress
information when cloning from IDE. IDE run git with streams
redirected, and this progress information could have been displayed to
user to indicate current status of operation.

Best Regards,
Constantine
