From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Many different remote branch sources
Date: Fri, 2 Mar 2007 11:53:51 +0100
Message-ID: <81b0412b0703020253i3e1478a9pf505c0d95442536c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 02 11:54:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN5Op-0002jB-84
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 11:54:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423004AbXCBKxy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 05:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423010AbXCBKxx
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 05:53:53 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:59667 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423004AbXCBKxx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 05:53:53 -0500
Received: by ug-out-1314.google.com with SMTP id 44so658852uga
        for <git@vger.kernel.org>; Fri, 02 Mar 2007 02:53:52 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Pa486jV577ZC2oFuoLJBdM+0dODYZwvghaJsobo3m+Tg+P5bpMtiSo/wqdV9lVNFMCdbuP+xxEVAxzIXggaquuvBrPZLe94+8XzK6OYJcNzuWWVMRVuRmS2WvhFZ7naEF5zu3nPQmWtx6vGd1rDXIEypQGPs6T9WEi7Zieafho4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=uORxh3FG5dleTRtE22Ck8O1uVnDusN+6qGQMvUL23yHKuuL+V9/AFlGSN3ziYKwFn8zO4ZeXYVOicxSbYhRhtaMzAC/v12oTfKvJr3DIR7MR4bwiEMXSkT3/uSdtGXWr2cwO5NU4V4/+DnX+Rxns1f0k+yjorCbZ+kRPFCi4T74=
Received: by 10.78.97.7 with SMTP id u7mr258872hub.1172832831815;
        Fri, 02 Mar 2007 02:53:51 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Fri, 2 Mar 2007 02:53:51 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41187>

The following does not seem to work:

  [remote "dev1"]
    url = ...
    fetch = ...
  [remote "dev2"]
    url = ...
    fetch = ...

  [branch "integration"]
    remote = dev1
    merge = refs/heads/topic1

  [branch "integration"]
    remote = dev2
    merge = refs/heads/topic2

How can I specify that a branch has more then one
remote branch it can be merged with?
