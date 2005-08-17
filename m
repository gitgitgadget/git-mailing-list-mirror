From: Marco Costalba <mcostalba@yahoo.it>
Subject: git-format-patch + git-applymbox small issue
Date: Wed, 17 Aug 2005 10:18:44 -0700 (PDT)
Message-ID: <20050817171844.57566.qmail@web26301.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Aug 17 19:19:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5RYz-0007oI-6M
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 19:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbVHQRSu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 13:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbVHQRSu
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 13:18:50 -0400
Received: from web26301.mail.ukl.yahoo.com ([217.146.176.12]:55204 "HELO
	web26301.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751177AbVHQRSu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 13:18:50 -0400
Received: (qmail 57568 invoked by uid 60001); 17 Aug 2005 17:18:44 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Bb8FCQMFpxCMuKxiySHf5RUYfhj3CfL+8ZsNgzWfkQWg7JrE1Q79xiuyZg/XUkb0LHhYGgW2+ySHNLh2HX8SgVIrscZ0ReP3FQU/ZrH772EP9UKxr/Xn8EjkntHBMIw52d8dqM+C8uwVxnFXIwPd7ZXwVZ5Cq+rk5PNgX1wUY38=  ;
Received: from [151.42.53.158] by web26301.mail.ukl.yahoo.com via HTTP; Wed, 17 Aug 2005 10:18:44 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, 

the round trip 

1)  git-format-patch --mbox --keep-subject

2)  git-applymbox -k

is not perfect for revisions where there is only the subject.

An example is c35a7b8d806317dc1762e36561cbd31c2530dd9c in git archive

Original text is:

   Skip merges in format-patch.


After round trip:

 Skip merges in format-patch.

   
    git-format-patch-script |    3 ++-
    1 files changed, 2 insertions(+), 1 deletions(-)
   
   c35a7b8d806317dc1762e36561cbd31c2530dd9c



I know I'm a bit annoying ;-)

Marco

P.S: I say 'revision', and 'git archive' but are very common also 'commit' and
'git repository'. This is just a silly example where a common dictionary 
should be useful.


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
