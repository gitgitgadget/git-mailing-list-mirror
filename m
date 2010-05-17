From: Debayan Banerjee <debayanin@gmail.com>
Subject: Possible bug with argument parsing in git blame
Date: Mon, 17 May 2010 15:51:18 +0530
Message-ID: <AANLkTikn1-Ua6G7eAc8UD8DJx0vpc-5-BOoxsi2mx2BC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 17 12:21:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODxSD-0002oE-PN
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 12:21:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754890Ab0EQKVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 06:21:39 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53838 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754079Ab0EQKVi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 May 2010 06:21:38 -0400
Received: by pwi5 with SMTP id 5so389455pwi.19
        for <git@vger.kernel.org>; Mon, 17 May 2010 03:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=aYIPlyt6Q9p93hihtY8823Gu3gk6h1odf5j9TcS8QMM=;
        b=P47p/3XKDhV1lMSa3TCr72+1sFWhwpCDoLT9qDzV4J92kkBHF/qpSkOO8FyLapVKAe
         56lIUfHaQTo8FeTgX8UOQkLsCJNZoeSlKWtGwfbsspDGW3a4ZQq5oky1/9DkR21YrwDT
         m+LQkdMP3BlDQkrl/l37i+N4JbqygfOrySpP4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=RxDn9DABfnIqFKLFI1SWJWwnpO0tKIkpJEgjAV2uIoWpmnevELOFrZeUNK46Pf66eF
         LawITqeECVNff6iVkBVzEeBfoLxY1Mlq8NPAp3YqjoMezdnSZOaFJnKri+0YICPWuNC3
         WglJXoUz0kaP7xv+EazEPK4YA79LVvIoXilBk=
Received: by 10.140.251.20 with SMTP id y20mr3486205rvh.206.1274091698328; 
	Mon, 17 May 2010 03:21:38 -0700 (PDT)
Received: by 10.141.34.18 with HTTP; Mon, 17 May 2010 03:21:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147221>

debayan@deep-blur:~/testrepo$ git blame 22621a32..8486802f --
dir/subdir/newsubdir/b

81531975 b                      (debayan 2010-05-13 15:32:17 +0530  1) four
81531975 b                      (debayan 2010-05-13 15:32:17 +0530  2) five
d700ac9c b                      (debayan 2010-05-13 15:33:27 +0530  3) blah
2656ab56 b                      (debayan 2010-05-13 15:33:34 +0530  4) bleh
d0c6e851 b                      (debayan 2010-05-13 15:42:21 +0530  5) foo
7bf5510e b                      (debayan 2010-05-13 15:42:53 +0530  6) yo
c4515289 b                      (debayan 2010-05-13 15:43:10 +0530  7) lala
a257c7e4 b                      (debayan 2010-05-13 16:03:46 +0530  8) yes
ed8e4601 b                      (debayan 2010-05-13 16:03:55 +0530  9) np
e96d14bf dir/subdir/newsubdir/b (debayan 2010-05-13 16:05:05 +0530 10) yo
dace00d1 dir/subdir/newsubdir/b (debayan 2010-05-13 16:05:11 +0530 11) boye
8486802f dir/subdir/newsubdir/b (debayan 2010-05-13 16:07:51 +0530 12) what?

debayan@deep-blur:~/testrepo$ git blame 22621a32..8486802f
dir/subdir/newsubdir/b
fatal: cannot stat path 22621a32..8486802f: No such file or directory

The only difference between the first and the second command is the
"--" separator.  Is this normal behaviour?

-- 
Debayan Banerjee
Software Engineer
