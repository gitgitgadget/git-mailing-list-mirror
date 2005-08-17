From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: git-format-patch + git-applymbox small issue
Date: Wed, 17 Aug 2005 10:54:51 -0700 (PDT)
Message-ID: <20050817175452.84541.qmail@web26306.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 19:55:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5S7s-0007dv-8g
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 19:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbVHQRyx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 13:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbVHQRyx
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 13:54:53 -0400
Received: from web26306.mail.ukl.yahoo.com ([217.146.176.17]:55153 "HELO
	web26306.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751186AbVHQRyx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 13:54:53 -0400
Received: (qmail 84543 invoked by uid 60001); 17 Aug 2005 17:54:52 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Ez+SIBChSx1eQQeMsvD6YhpzTUPRAX+0lelCHML9Hmvp3d+8ssh7zSI1CWNg20zGhRB6rj48IuRs9f+a5+ddYxg2VKQlEJnZmCTYGaF/K8/TqpOSXFiX2/jJEFCNmzGFCGzeQQeAS5XyCc0V0pqZpgout6M8agkRoJuy70H0JyA=  ;
Received: from [151.42.53.158] by web26306.mail.ukl.yahoo.com via HTTP; Wed, 17 Aug 2005 10:54:51 PDT
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin wrote:

>Hi,
>
>On Wed, 17 Aug 2005, Marco Costalba wrote:
>
>>P.S: I say 'revision', and 'git archive' but are very common also 
>>'commit' and 'git repository'. This is just a silly example where a 
>>common dictionary should be useful.
>
>
>How about the glossary, which I posted a few hours ago?
>
>Ciao,
>Dscho
>
>

Yeah, I missed it.

Sorry for the noise.

By the way, a very good and useful job.

>
>revision::
>	A particular state of files and directories which was stored in
>	the object database. It is referenced by a commit object.
>


>
>commit object::
>	An object which contains the information about a particular
>	revision, such as parents, committer, author, date and the
>	tree object which corresponds to the top directory of the
>	stored revision.
>

So 'revision' is the struct and 'commit object' the pointer ;-)



>
>repository::
>	A collection of refs together with an object database containing
>	all objects, which are reachable from the refs. A repository can
>	share an object database with other repositories.
>

In a lot of git documentation, starting from the tutorial, it is used 'git archive' 
but peraphs 'repository' is more a standard definition for an SCM archive. 
Just archive peraphs is too generic, also a tarball is an archive :-)

Marco


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
