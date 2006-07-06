From: "Robin Luckey" <robinluckey@gmail.com>
Subject: git-log output changed from 1.4.0 -> 1.4.1?
Date: Thu, 6 Jul 2006 14:51:23 -0700
Message-ID: <761519800607061451n9473ad4oa9e2781517ca9389@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jul 06 23:51:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fybkv-0003BE-2u
	for gcvg-git@gmane.org; Thu, 06 Jul 2006 23:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWGFVvZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Jul 2006 17:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWGFVvZ
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Jul 2006 17:51:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:41456 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750802AbWGFVvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jul 2006 17:51:25 -0400
Received: by ug-out-1314.google.com with SMTP id a2so2855480ugf
        for <git@vger.kernel.org>; Thu, 06 Jul 2006 14:51:23 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=KlfL7cjg09HGcIB7YCXnwaVwBKKxeBEVMk6x6SkuvPJoEZ/6ngavu1qiCUFVmLjg9iu/UHDF6UewckKUn0AV6nkuaDhq5P/8IhcNwLcfmijl/FIBjC9rp8EdWIEBiOflmtie6cIIR6S3v+EHQS3eI7aiBdbo6ivTtNuLtxjzb0w=
Received: by 10.66.220.17 with SMTP id s17mr1230309ugg;
        Thu, 06 Jul 2006 14:51:23 -0700 (PDT)
Received: by 10.66.220.13 with HTTP; Thu, 6 Jul 2006 14:51:23 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23404>

We use a custom script to generate reports based on the git-log
output. However, it appears that the output of git-log has changed in
1.4.1, and I have been unable to discover a set of flags to recreate
the log format to which I have become accustomed.

In git 1.4.0, the following command...

git log -r --root --abbrev=40 master

...would generate log entries like this...

commit 8db998464a3cc7f41728ac8bb59aee0f62e14aa8
Author: someone <someone>
Date:   Sun Aug 29 09:44:49 2004 +0000

    A comment goes here.

:100755 000000 56f5eb6c914c7ff6706dc3f8736a77d155cad93f
0000000000000000000000000000000000000000 D someapp/file1.c
:100755 000000 d7e0277fe15bfc11f75cbc535ecf1c5ee3d79baf
0000000000000000000000000000000000000000 D someapp/file2.c

Is there a way to generate this same format with git 1.4.1?

Thanks,
Robin
