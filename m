From: "pradeep singh rautela" <rautelap@gmail.com>
Subject: Why does git track directory listed in .gitignore/".git/info/exclude"?
Date: Wed, 23 Jan 2008 19:24:44 +0530
Message-ID: <6bc632150801230554l3b24e1e4lb4641bf7c16857c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 23 14:55:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHg4T-0006gl-UT
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 14:55:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbYAWNyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 08:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbYAWNyr
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 08:54:47 -0500
Received: from wx-out-0506.google.com ([66.249.82.231]:53099 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbYAWNyq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 08:54:46 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1657926wxd.4
        for <git@vger.kernel.org>; Wed, 23 Jan 2008 05:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=haW1G8ADYpkNDC5dYO4nxemXzKauC66RTOUI/p7u1pY=;
        b=OkheBCffUNwZSa+JUUm58KySmLkg/REkJlCy4XVell463H2uEFTYTHSavRC/eKidAvueeEipBGrbI9mJh07PqD5Wro/29FtJ9fV0JbokOWoCTuc67fqEZxSAIre5x9N20ZjFQXXSTgh0HPyjKRiXUoVkf8NKzBxhVR8+fUuKK9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cBbfaPNcWmbTd+1h4EljS76//BC0Z11+M3byaIgHDcUTf7vaw9z4NrvlO/tuenutGdp0nPkkaXvCJq0oXeKwMTakyh5blTdB7dAUNxoCOm6Z9J1xLEX2GILnEw3Dl7tNqKNTere76AsyjoF2wldAfhO29j7ji/IUhLMJ3RwQuFo=
Received: by 10.142.103.6 with SMTP id a6mr4900139wfc.21.1201096484321;
        Wed, 23 Jan 2008 05:54:44 -0800 (PST)
Received: by 10.142.102.10 with HTTP; Wed, 23 Jan 2008 05:54:44 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71540>

Hi All,

I have an source directory, which in turn has some other directories too.
I do not want to track one of these directories.
So i added the directory name in .gitignore as well as in
.git/info/exclude for my repo.

i.e i have added following line to both of them -
xen-3.1.0-src/

I copied xen-3.1.0-src from archives in the git repo's base directory.

Now when i do a git-status i get
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       xen-3.1.0-src/
nothing added to commit but untracked files present (use "git add" to track)

Why is git seeing xen-3.1.0-src directory at all?
Is this the expected behaviour?

I thought i should not get this message after adding relevant entries
in .gitignore or in info/exclude .

What am i doing wrong here?
Is there a way that this can be done without having to witness this
message everytime i do a git status?

Please CC me as I am not subscribed to the list.

Thanks,
         ~Pradeep
-- 
--
pradeep singh rautela
http://eagain.wordpress.com
http://emptydomain.googlepages.com
