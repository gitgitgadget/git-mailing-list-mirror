From: Alex Riesen <raa.lkml@gmail.com>
Subject: cygwin: t3200-branch.sh fails with "List form of pipe open not implemented at -e line 22."
Date: Fri, 14 Oct 2005 14:46:25 +0200
Message-ID: <81b0412b0510140546ya10bc8fg3dd5eaab429eba6f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Oct 14 14:47:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQOxf-0004D2-2K
	for gcvg-git@gmane.org; Fri, 14 Oct 2005 14:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbVJNMq1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Oct 2005 08:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbVJNMq1
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Oct 2005 08:46:27 -0400
Received: from nproxy.gmail.com ([64.233.182.204]:63980 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750730AbVJNMq0 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2005 08:46:26 -0400
Received: by nproxy.gmail.com with SMTP id n15so245544nfc
        for <git@vger.kernel.org>; Fri, 14 Oct 2005 05:46:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=WCnDN/k2duYFcEPzMC0JfvwsoDE7ja/PsiyUmXods/xrMj87soAj2KWzaWqSIq3m+9UDNFWdrCOTyf5HmdtWlw7pBPxPi8+fq1jfjT7YmlwYmAtoyIjDINPxKHD7WOIPCJTZH1xPB+j6IcNRD/MucC5sW+7f39inKIOlVaZY5D0=
Received: by 10.48.239.11 with SMTP id m11mr26445nfh;
        Fri, 14 Oct 2005 05:46:25 -0700 (PDT)
Received: by 10.48.247.10 with HTTP; Fri, 14 Oct 2005 05:46:25 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10107>

Now, how broken is that:

The message comes from one of the hooks, which are executed even
though they never meant to, because cygwin apparently uses file
content or name to detect executability (on FAT).

I just remove the hooks from repositories atm.
