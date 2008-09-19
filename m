From: Xavier Claessens <xclaesse@gmail.com>
Subject: Branches with git-svn
Date: Fri, 19 Sep 2008 12:15:01 +0200
Message-ID: <1221819302.6784.4.camel@zdra-laptop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 19 12:16:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kgd26-0004rY-Mw
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 12:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757307AbYISKPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 06:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbYISKPI
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 06:15:08 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:48406 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757302AbYISKPG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 06:15:06 -0400
Received: by fg-out-1718.google.com with SMTP id 19so516792fgg.17
        for <git@vger.kernel.org>; Fri, 19 Sep 2008 03:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=MloAcjHomDHVu/J+E9wHGhIoICRN5OuH2TDasvzyB5Y=;
        b=Puf+9XxfzuKL83XW6aqgn6Ft4H3hvjDVqVxmRJ3Z0mvWLtT6pcmoflf07yF0RD/LA/
         Vq7/KbW0krv6MRMZPQpW9dmw3xcQFR2vH10Vzjza6BPU5xogVfDH6RkIgnf1XsSJ6G8o
         IIhGqWi5B1SBozJH15ac0fuA/NbHNjFXdf7LU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=HbqAqSIQA3Gdp+x84fYgJ4HdwPmGCQ8dcQeN3JceN7j0RyPzQdaYjsGTaIW69ReZ5o
         1xNQ+wkFFSsCa692w6pSCa+fURkQ73Jz92CR39eRqsSiLrzhaBfaIa4xrAcyvmCpIduY
         ZPR/uFMrJfUQxY97Jmk4Xu7w4TBxgIPfOmV4k=
Received: by 10.86.76.20 with SMTP id y20mr1736706fga.14.1221819304894;
        Fri, 19 Sep 2008 03:15:04 -0700 (PDT)
Received: from ?192.168.1.13? ( [81.247.142.114])
        by mx.google.com with ESMTPS id d4sm1644953fga.5.2008.09.19.03.15.03
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Sep 2008 03:15:04 -0700 (PDT)
X-Mailer: Evolution 2.23.91 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96274>

Hi,

I created a git repository using "git-svn clone <url>" a long time ago.
But now I realise that I don't get SVN branches into my git repository.
I see that the doc tells to use "git clone -t tags -b branches -T trunk
<url>" to create the repository. If I create a new repository with that
command, I get branches and tags.

However I have lots of contributors having branches based on my git
repository. Is there a way to add SVN branch to my existing git repo?

Thanks!

Xavier Claessens.
