From: Lynn Lin <lynn.xin.lin@gmail.com>
Subject: merge result
Date: Fri, 9 Sep 2011 18:54:21 +0800
Message-ID: <CAPgpnMRrSmVrXD__jxv3uNrek8up+scHp+_Kj8+=HX8tfweWzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 12:54:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1yj7-0005xX-23
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 12:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758746Ab1IIKyW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 06:54:22 -0400
Received: from mail-vw0-f43.google.com ([209.85.212.43]:48133 "EHLO
	mail-vw0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758740Ab1IIKyV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 06:54:21 -0400
Received: by mail-vw0-f43.google.com with SMTP id 10so1237691vws.2
        for <git@vger.kernel.org>; Fri, 09 Sep 2011 03:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=sLvPSPxy5D8VDAoT02UvSHB63+DPSJp3drOdTLq2jt8=;
        b=UW5LN2jfvIcxi4wgcn3QSDnQfh70wWf6uXbrwCMBk3BFCKv5atnG1uBbZku3uzw5i6
         TI8D9eLnc1FWBBAPBjW4OQXMT7mo+d2uVsaYtk696irRVpo3YjNyS8thiG+g2w5KVtX/
         NLAwpQQ89cjw+yw/su4QEnsOmAAU7u6UOFbjU=
Received: by 10.52.76.105 with SMTP id j9mr889233vdw.215.1315565661333; Fri,
 09 Sep 2011 03:54:21 -0700 (PDT)
Received: by 10.52.166.6 with HTTP; Fri, 9 Sep 2011 03:54:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181049>

Hi All,
   When I merge branch A back to master branch,if there are same
commit(developer do double commit) both in master and A branch, there
will be two same commit in master branch.For example


   1->2->3-4>5        Master
       |
       4->6->7          A

When I merge A branch into master,the two same 4 commit will present
in master branch.

Is there any wrong with my operation?

Thanks for your help
Lynn
