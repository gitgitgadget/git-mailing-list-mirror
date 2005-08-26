From: Marco Costalba <mcostalba@yahoo.it>
Subject: Template added to git repository?
Date: Fri, 26 Aug 2005 11:16:42 -0700 (PDT)
Message-ID: <20050826181642.87710.qmail@web26308.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 26 20:16:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8iky-0004QB-5E
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 20:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965166AbVHZSQo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 14:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965165AbVHZSQo
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 14:16:44 -0400
Received: from web26308.mail.ukl.yahoo.com ([217.146.176.19]:52894 "HELO
	web26308.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S965166AbVHZSQn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2005 14:16:43 -0400
Received: (qmail 87712 invoked by uid 60001); 26 Aug 2005 18:16:42 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=PXbcWmQ40WiIhuPA0DLffQlw6gTC9enoL3Ek9COVjcju3LM9LnAOY8fmSUg68a61PqnfAJsOsSMbQHU0POjm6GojIq08t05/RWOo1q85ygHvWvVL/z7BuZ31hYVIMohw48sJvTyNFFWfA9ZMIzqAvUU9L1zWrdc3NW2U/NQyZO8=  ;
Received: from [151.38.111.157] by web26308.mail.ukl.yahoo.com via HTTP; Fri, 26 Aug 2005 11:16:42 PDT
To: junkio@cox.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7819>

Hi,


$ git status
nothing to commit
$ make clean
rm -f *.o mozilla-sha1/*.o ppc/*.o git-update-cache git-diff-files git-init-db git-write-tree
git-read-tree git-commit-tree git-cat-file git-fsck-cache git-checkout-cache git-diff-tree
git-rev-tree git-ls-files git-ls-tree git-merge-base git-merge-cache git-unpack-file git-export

<stripped lines>


$ git status
#
# Changed but not updated:
#   (use git-update-cache to mark for commit)
#
#       deleted:  templates/blt/description
#       deleted:  templates/blt/hooks/applypatch-msg
#       deleted:  templates/blt/hooks/commit-msg
#       deleted:  templates/blt/hooks/post-commit
#       deleted:  templates/blt/hooks/post-update
#       deleted:  templates/blt/hooks/pre-applypatch
#       deleted:  templates/blt/hooks/pre-commit
#       deleted:  templates/blt/hooks/update
#       deleted:  templates/blt/info/exclude
#
nothing to commit
$ make
gcc -o update-cache.o -c -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' update-cache.c
gcc -o read-cache.o -c -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' read-cache.c
gcc -o sha1_file.o -c -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' sha1_file.c

<stripped lines>

$ git status
nothing to commit
$

Perpahs generated template files should not be in git repository?


Marco


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
