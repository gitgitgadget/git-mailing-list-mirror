From: Tejun Heo <htejun@gmail.com>
Subject: [ANNOUNCE] gitkdiff 0.1
Date: Thu, 28 Apr 2005 14:14:07 +0900
Message-ID: <4270711F.7020501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Apr 28 07:09:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR1Gn-0007fF-NK
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 07:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbVD1FOR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 01:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbVD1FOR
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 01:14:17 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:24612 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261997AbVD1FON (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 01:14:13 -0400
Received: by rproxy.gmail.com with SMTP id a41so298868rng
        for <git@vger.kernel.org>; Wed, 27 Apr 2005 22:14:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=bMvqG5E/XiueAzNNsXRxm9HtUkmxO6U+Em7fz1D5FRICqx/YhQLKQICQ2sonWrRNBnQurEJQcnjIk7pH7kN1gOfYdVzWb6ATYCEl2TKgXVWHi9vPwK4hU38dYw6QP2BptTpCr0LdlXbEK4eHKbI1DHwE+IpC4YiNjS3qQImqBT8=
Received: by 10.38.161.10 with SMTP id j10mr1971930rne;
        Wed, 27 Apr 2005 22:14:13 -0700 (PDT)
Received: from htj.dyndns.org ([222.97.233.99])
        by mx.gmail.com with ESMTP id k22sm865882rnb.2005.04.27.22.14.12;
        Wed, 27 Apr 2005 22:14:13 -0700 (PDT)
Received: from [127.0.0.1] (htj.dyndns.org [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by htj.dyndns.org (Postfix) with ESMTP id 9C151184D04
	for <git@vger.kernel.org>; Thu, 28 Apr 2005 14:14:08 +0900 (KST)
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


 Hello, guys.

 I've hacked tkdiff and made a commit viewing utility.  Just download
the following tarball and unpack it whereever PATH points to.  It
assumes that all base git executables are visible via PATH.

 http://home-tj.org/gitui/files/gitui-200504281405.tar.gz

$ gitkdiff -h
/home/tj/bin/gitkdiff: illegal option -- h
GIT tkdiff - gitkdiff 0.1

Usage: gitkdiff [OPTS...] DIFFSPEC

OPTS are
    -h                      prints this help message and exit

DIFFSPEC can be one of
    [files...]              the current cache vs. working files
    -r R [files...]         files in commit R's parent vs. files in commit R
    -r R0 -r R1 [files...]  files in commit R0 vs. files in commit R1

If no file is specified, all modified files are shown.

-- 
tejun
