From: "Anatoly Yakovenko" <aeyakovenko@gmail.com>
Subject: wierd error, cant push my changes back
Date: Thu, 6 Mar 2008 00:09:30 -0800
Message-ID: <e26d18e40803060009r6f8dd313qcc7b3472a5d771ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 06 09:10:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXBB5-0000xB-Dw
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 09:10:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683AbYCFIJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 03:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbYCFIJd
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 03:09:33 -0500
Received: from rn-out-0910.google.com ([64.233.170.186]:6808 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683AbYCFIJc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 03:09:32 -0500
Received: by rn-out-0910.google.com with SMTP id v46so810674rnb.15
        for <git@vger.kernel.org>; Thu, 06 Mar 2008 00:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=HJSj4V5nA/lXI8kYoihDo9DpFwjVwhy+jPp6mTmKDFA=;
        b=XcJd6Bwn7TdW1a0hYxnGWlIgGZIwVBDZkSHCYov/N2+93G8NPfn53F9sSl50Wkncbbv150IozyRjedWZCTz+JmvyuEyTothKpxeLsXWPyNcWShDQDccHgio2XWJu+UyTLfClv/CU31qsPhMjv1Ft83N2zaq4XzfduhgBPp25NH0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=m2ScNQgZejTocXshuxoIcmqWsi+UQF5QnlJiF9SeecdKJpR0uOvuL+Ko6Hs97Z2m0Pu1iXlkD9OWa7PGgXMELyD86nURXFJC5EOAytidGAKB5ccAyMcVsGAGw4FuJQrlAz+1fsLxOjqdKrr9G9veJMnW+Ptxv38t1Bg0aj0nLBc=
Received: by 10.114.194.1 with SMTP id r1mr6386781waf.40.1204790970984;
        Thu, 06 Mar 2008 00:09:30 -0800 (PST)
Received: by 10.115.72.20 with HTTP; Thu, 6 Mar 2008 00:09:30 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76354>

$ git-push ssh://aeyakovenko@localhost/var/lib/git/project
Counting objects: 15, done.
Compressing objects: 100% (12/12), done.
Writing objects: 100% (12/12), 3.60 KiB, done.
Total 12 (delta 3), reused 0 (delta 0)
error: unpack failed: unpacker exited with error code
error: unable to write sha1 filename
./objects/81/19095e4e1996e5fde8212f27caf0a8a6d42167: Permission denied

fatal: failed to write object
To ssh://aeyakovenko@localhost/var/lib/git/project
 ! [remote rejected] master -> master (n/a (unpacker error))
error: failed to push to 'ssh://aeyakovenko@localhost/var/lib/git/project
