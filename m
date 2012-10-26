From: Francis Moreau <francis.moro@gmail.com>
Subject: git submodule summary doesn't return an error when passed a wrong commit/rev
Date: Fri, 26 Oct 2012 16:03:26 +0200
Message-ID: <CAC9WiBgdgy1bwh0c16jd017q2rqQAq-suDADn2-vGw9eubBs_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 26 16:03:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRkVf-0002dk-Pa
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 16:03:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933073Ab2JZOD1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 10:03:27 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:60020 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933042Ab2JZOD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 10:03:27 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so2659935oag.19
        for <git@vger.kernel.org>; Fri, 26 Oct 2012 07:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=fokHEA30ZQbKAtI/znDk9Hquao0bAjSzvznhJ2X4faw=;
        b=FG+uvnpYRazai11iXuE4MnqqTTtCKr6IQrLPBBqIN/6OQkK/610hYSUqA0oxPn88al
         0Vve7f9JmHPYx2avDMknfutbiqlTZHD02VNPRRsNtUFbFtmarJg3BgHVaGCv+ZGdheot
         f3uPCE9aKrDBbVQniLE0jkAGWP8Xuqls6pqAPHmLXOdUVHhQ1jVdJ098GDXoDlF6pQ27
         DdQsVE+WOpDRDOEerYqUtQEUdpBaniIprJNyBfQTq0Shuwo+fHyLEMsJWfzbh5BbkIGz
         M1svKqvqhcchdklN/cM/p58OptfMbUUTVrD4O7RIR2YuGafjXjhbto2PdRgJGoCt78b1
         21vA==
Received: by 10.60.172.48 with SMTP id az16mr19203735oec.64.1351260206042;
 Fri, 26 Oct 2012 07:03:26 -0700 (PDT)
Received: by 10.60.93.163 with HTTP; Fri, 26 Oct 2012 07:03:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208449>

Hi,

it seems to me that when passed an unknown rev or a wrong commit/sha1,
git-submodule-summary should at least exit with an error status. Even better
would be a error output.

Test was done with git version 1.7.10.4 from debian wheezy.

Thanks
-- 
Francis
