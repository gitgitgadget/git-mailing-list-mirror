From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Fetch from remote A, push to remote B
Date: Thu, 31 May 2007 17:53:16 +1200
Message-ID: <46a038f90705302253s68b70311h3feac7404fa23933@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 31 07:53:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtdbB-00041L-J8
	for gcvg-git@gmane.org; Thu, 31 May 2007 07:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756797AbXEaFxS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 01:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758077AbXEaFxS
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 01:53:18 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:11075 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756797AbXEaFxR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 01:53:17 -0400
Received: by wx-out-0506.google.com with SMTP id t15so56723wxc
        for <git@vger.kernel.org>; Wed, 30 May 2007 22:53:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Sf004n8fpMh6tPZNaBkCr1fEeczXoNgVo93SzPFww2tHF7Z2MrrRU5IsmNoZUDGkueIXDmaEIl6P3y9PSjcwbJ4R00f1HAAr4sm0KZHcGBSDzPXBJKyH/z/QUiw/EZsSR5bhiT3ucjILID3QafymjZLZc8LRkRaWHFY5AIWotlo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gZLcJjmhCIVi+HnKIsaJ8KAkioDf/Q1r9GCl6zbQf65zQG2cVl/eFP0/JdOk4mvy3MBlSrrZYGZvl0/bR3jVrKGi18N03ojVav0RbNFaIj/bjKi5evD7aWtzWuZIt38/2m3UrUE3V6JwsRl9Q5o2MxN2FGKBhIUS/LzDor+cPvM=
Received: by 10.90.90.16 with SMTP id n16mr92800agb.1180590796346;
        Wed, 30 May 2007 22:53:16 -0700 (PDT)
Received: by 10.90.53.18 with HTTP; Wed, 30 May 2007 22:53:16 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48801>

Is there an easy way to get a "passthrough" repo setup so I can say on a cronjob

  git-fetch remoteA
  git-push ssh+git://host/path/to/repoB.git remotes/remoteA/<all>

The 2 repositories cannot talk to each other directly.

cheers,


martin
