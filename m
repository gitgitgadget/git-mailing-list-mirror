From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: A test failing with python 2.2 -- ok?
Date: Sat, 3 Jun 2006 16:18:32 +0930
Message-ID: <93c3eada0606022348l3c39f966u781327b14b0bc3d5@mail.gmail.com>
Reply-To: geoff@austrics.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jun 03 08:48:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmPwH-0006W1-NU
	for gcvg-git@gmane.org; Sat, 03 Jun 2006 08:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932573AbWFCGsd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 02:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbWFCGsd
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 02:48:33 -0400
Received: from wx-out-0102.google.com ([66.249.82.193]:48575 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932573AbWFCGsd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jun 2006 02:48:33 -0400
Received: by wx-out-0102.google.com with SMTP id h28so469187wxd
        for <git@vger.kernel.org>; Fri, 02 Jun 2006 23:48:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mVv71KkX+hPpCPJ828IrXw0rRkdD42+BUxQXxV+bMyuPel2vVv/8H0A9vZQVzO0iXuIMtWNkKjt0h86z+ZXm9XNgdfXHEen7JTdJ9KLSeKnDGkRIfFi1HLeogfaBYx8qSw5ENc3CkYfbHnxT+MiS7Xq85JXK39mvSceoxLnJJd8=
Received: by 10.70.62.1 with SMTP id k1mr3460494wxa;
        Fri, 02 Jun 2006 23:48:32 -0700 (PDT)
Received: by 10.70.32.19 with HTTP; Fri, 2 Jun 2006 23:48:32 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21185>

Hi,

I'm not sure how far back you are supporting, but I'm running a python
2.2 machine
and make test fails with a missing python module. Whatever criss-cross merges
are, I don't need them, but figured if you were intending to support older
environments, then you may be interested.

Cheers,
Geoff Russell

$ git --version

    git version 1.3.3.g61ef-dirty

$ make test

*** t6021-merge-criss-cross.sh ***
....

Traceback (most recent call last):
  File "/usr/local/LINUX/GIT/git/t/../git-merge-recursive", line 10, in ?
    from heapq import heappush, heappop
ImportError: No module named heapq
-------------------------------------------------------
