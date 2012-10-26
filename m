From: Francis Moreau <francis.moro@gmail.com>
Subject: How to get submodule information for a specific commit
Date: Fri, 26 Oct 2012 12:05:41 +0200
Message-ID: <CAC9WiBidhir6S8VaiY3wFFo5Gs1mxJKi4cBTq3nQE_Mau9xApA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 26 12:05:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRgnb-00020l-6E
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 12:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753809Ab2JZKFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 06:05:43 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:44841 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010Ab2JZKFm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 06:05:42 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so2468986oag.19
        for <git@vger.kernel.org>; Fri, 26 Oct 2012 03:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=GX3df2XPLfG5Ar4uFsW8nExcyRtbHXaiYD0ik96+PYM=;
        b=VEqY5ii6tzthe8VwUVpMTFnFFtz2j9Bz/X6ocZrnXNIcPnD9zHM0knOsNl2TlJN4yt
         lZMX+LDEO7HrGY+vJCjX8cpaZbbj9yYlL0FKizUgOlLGTN2I08QOxOZCGYC5DRG/Jm2B
         yQwvBmaSV/X9KcA2Ugt05MPGZ05Kef2GLswKtzIhmRuOrvl0hue7n+2QXLqfGZO8m7Sn
         SWv6L0gvmHay27kvSz1Y0VPT1Th1oKpiv1Z2dilvzluJLX3ab5Lhx5mnS5dnAYJsyta5
         l5y8RTzVrEuY31kVa4wc6meSZhgs+4R+35MwXL5cg1n3dtIg3SFmi1uHZ3821bZL9cpe
         JGeA==
Received: by 10.182.17.100 with SMTP id n4mr14283977obd.45.1351245941774; Fri,
 26 Oct 2012 03:05:41 -0700 (PDT)
Received: by 10.60.93.163 with HTTP; Fri, 26 Oct 2012 03:05:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208433>

Hi,

I'd like to get information about the submodule commits used by a
given super project commit.

The information I'm looking for is quite similar than the one you can
get with "git submodule status" but for any revs not only the current
head of the super project.

Someone on #git kindly suggested me to use git-ls-tree, but I'm
wondering if an option or a new command to git-submodule could be
added to achieve that.

Thanks
-- 
Francis
