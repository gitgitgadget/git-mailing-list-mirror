From: Howard Miller <howardsmiller@googlemail.com>
Subject: Commit to wrong branch. How to fix?
Date: Fri, 4 Sep 2009 16:54:55 +0100
Message-ID: <88A0A7C2-7DCB-45A3-B196-BED2A8AC9405@googlemail.com>
Mime-Version: 1.0 (iPhone Mail 7A400)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 04 17:55:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mjb80-0005sv-Ob
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 17:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755003AbZIDPy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 11:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753924AbZIDPy6
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 11:54:58 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:53260 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753631AbZIDPy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 11:54:57 -0400
Received: by fxm17 with SMTP id 17so772534fxm.37
        for <git@vger.kernel.org>; Fri, 04 Sep 2009 08:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:x-mailer:mime-version
         :subject:date;
        bh=tdNmttPtr9yyCXCvKMb2jyFKfcazfzK/PVtpgkELcJQ=;
        b=cujJw2gaHfnUBGEL8f3kgXw2gES88JH6TEdHXg0x/1apESn+siUlL1vECILEHeG+4O
         Cf7+xDfcyChsw8OeE9+CSfU/sGvfiFKm/zkKDyAWMVVumKjH0noU0gceWWqoeP0qioa2
         qPbEpyjDMcHmU9UOlYPg4zfldqaBh8Hta6c48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date;
        b=Txz8mvHB8X4ZsYq7wUTuPMM5o9qKtIg/z+XpWy+70lxq29rqmOh4qGD37fX+j40JwN
         hnTNRnA/6q2upj0s1PhfVy95cF9OpcM1fV2mTauUd3QM7b9nQ9ByPUrq93Zj2imFEJF5
         IXgC27IvFvLE5WGn7cpzt4mkcxyOImtTxss6c=
Received: by 10.204.154.86 with SMTP id n22mr9214076bkw.110.1252079699028;
        Fri, 04 Sep 2009 08:54:59 -0700 (PDT)
Received: from ?10.25.170.137? ([82.132.139.8])
        by mx.google.com with ESMTPS id c28sm1951622fka.49.2009.09.04.08.54.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Sep 2009 08:54:58 -0700 (PDT)
X-Mailer: iPhone Mail (7A400)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127738>

I commited to the wrong branch and I can't figure out what to do. To  
make matters worse I then did 'git reset HEAD^' which has made things  
much worse. It didn't remove the commit and now I can't change  
branches. I'm utterly confused. Any help much appreciated!

Moral - use git status liberally and read it carefully before doing  
anything. A 'git undo" command would be great is someone is feeling  
generous :-) 
