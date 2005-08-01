From: Tejun Heo <htejun@gmail.com>
Subject: [ANNOUNCE] mtkdiff-20050801 (with patchkdiff, quiltkdiff, gitkdiff
 and modified gitk)
Date: Mon, 01 Aug 2005 22:28:47 +0900
Message-ID: <42EE238F.4050900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Aug 01 15:29:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzaLn-0007uP-5q
	for gcvg-git@gmane.org; Mon, 01 Aug 2005 15:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbVHAN24 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Aug 2005 09:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbVHAN24
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Aug 2005 09:28:56 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:27186 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261803AbVHAN2z (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2005 09:28:55 -0400
Received: by wproxy.gmail.com with SMTP id i34so463439wra
        for <git@vger.kernel.org>; Mon, 01 Aug 2005 06:28:54 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=DxMBmmxA9q8u+lY/BIr2veGSSjVGLkJS/yvON1ZldksAWswdF2GZZx4sN3zm3ycHpWowM/epeCvM5svLJ5c4HHw/Y4nC1WcVaTHwZT2MviMX10HgkN1FgDEuayS9T+9tNZm05fxoqLBlMao3PZkYmFs3ydCEfMgC/rRxIh9A7Rw=
Received: by 10.54.143.10 with SMTP id q10mr2847136wrd;
        Mon, 01 Aug 2005 06:28:54 -0700 (PDT)
Received: from htj.dyndns.org ([222.97.233.53])
        by mx.gmail.com with ESMTP id g5sm2329515wra.2005.08.01.06.28.52;
        Mon, 01 Aug 2005 06:28:54 -0700 (PDT)
Received: from [127.0.0.1] (htj.dyndns.org [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by htj.dyndns.org (Postfix) with ESMTP id 286821846C9;
	Mon,  1 Aug 2005 22:28:48 +0900 (KST)
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: en-us, en
To: git@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
	snemana@yahoo.com, paulus@samba.org, rdunlap@xenotime.net,
	mingo@elte.hu
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello, guys.

New version of mtkdiff package is available.  Changes since last release 
(20050514) are.

* patchkdiff added.  Idea is from patchview of Randy Dunlap (Hi!).
   patchkdiff can show multiple diff files.

* quiltkdiff rewritten in perl.  It's faster and doesn't push/pop quilt
   repository.  Patches are rolled back and applied in a temporary
   working directory.

* gitkdiff rewritten in perl.  It now works with the new git diff
   output format and a bit faster.  Also, this version can show
   multiple commits.  For example, you can do the following.
   $ git-rev-list HEAD ^OLD_HEAD | gitkdiff -c -r

* modified gitk-1.2.

For more information...

http://home-tj.org/mtkdiff

Tarball is available at

http://home-tj.org/mtkdiff/files/mtkdiff-20050801.tar.gz

Thanks.

-- 
tejun
