From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: pack-e3117bbaf6a59cb53c3f6f0d9b17b9433f0e4135.pack
Date: Fri, 8 Jul 2005 11:49:45 +0400
Message-ID: <200507081149.45344.adobriyan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jul 08 09:43:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqnVt-0006gb-Vj
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 09:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbVGHHnD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 03:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261834AbVGHHnD
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 03:43:03 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:3528 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261476AbVGHHnB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jul 2005 03:43:01 -0400
Received: by wproxy.gmail.com with SMTP id i25so377293wra
        for <git@vger.kernel.org>; Fri, 08 Jul 2005 00:42:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=CdVDSqIUj0zJMyHY198xddDjo2uZptLDjFsZhhuwZyPR4eFtDwD70tGWuSsDbqsU1lLARk30CWm+M6mRA49oZ5nj+no/yq1fdWc9u38u6sf0unTu7qmQuxUnvtBA0S1SWO4QCCoOmUJ6bfByI9nfS0k1AzzihznC8Gl2q9kkJs4=
Received: by 10.54.16.77 with SMTP id 77mr415702wrp;
        Fri, 08 Jul 2005 00:42:59 -0700 (PDT)
Received: from mipter.zuzino.mipt.ru ([217.10.38.130])
        by mx.gmail.com with ESMTP id d75sm2229029wra.2005.07.08.00.42.58;
        Fri, 08 Jul 2005 00:42:59 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.8.1
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Being a happy user of

	$ cat ./rsync-linus
	#!/bin/sh -x

	cd linux-linus
	rsync -avz --progress \
	        rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ \
	        .git/

I'm confused now. This pack file is ~60M in size. Will rsync download
another 60M next time? What command should I use now to a) get latest and
greatest and b) be nice with my traffic?
