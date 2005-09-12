From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: cg-push - push to a different head
Date: Mon, 12 Sep 2005 13:56:37 +1200
Message-ID: <46a038f90509111856aa3c23@mail.gmail.com>
Reply-To: martin.langhoff@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Sep 12 03:58:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEdZ5-0008Ni-2f
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 03:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbVILB4k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 21:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbVILB4k
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 21:56:40 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:25213 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751126AbVILB4j convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 21:56:39 -0400
Received: by rproxy.gmail.com with SMTP id i8so295350rne
        for <git@vger.kernel.org>; Sun, 11 Sep 2005 18:56:37 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=U+v67PrtccFzhyGjmik8Nm6lqGCrqJmNHqgzfBw9aP33YQHy5w17tJfKVtPyXQD1dVBiFbA9zPJvY8p6T8Cr8BgtFYKbtDOpUCaAermYhy/Y4niEO7mSLkxYIWE34VUDsNyIAEyrz0H0SfOSgZLQcv+f7VLdfB9tFpFNqTmcMfU=
Received: by 10.38.209.6 with SMTP id h6mr246296rng;
        Sun, 11 Sep 2005 18:56:37 -0700 (PDT)
Received: by 10.38.101.53 with HTTP; Sun, 11 Sep 2005 18:56:37 -0700 (PDT)
To: Petr Baudis <pasky@ucw.cz>, Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8362>

Hi Petr,

good to see you back. Now, before you go on holidays again... ;-)

I'd be happy to work a bit on cg-clone to get this scenario working. 
  
      $ cg-clone somehost.com/somerepo.dir#odd-branch locadir
      ... work ... commit ... work
      $ cg-push
      cg-push: pushing to a different head not supported yet
      ... grrr...
      $ git-push somehost.com/somerepo.dir master:odd-branch
      # this works!
 
I am 100% confuses as to how cg-push is supposed to work. Am I doing
something wrong, or how should I fix cg-push to do the right thing?

cheers,



martin
