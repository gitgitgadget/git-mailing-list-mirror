From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: git-svnimport usage with different SVN repo layouts
Date: Thu, 15 Dec 2005 17:47:28 +1300
Message-ID: <46a038f90512142047n1cf9c927ye26af2c7f77f9b63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Dec 15 05:49:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eml1g-0005kk-Bq
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 05:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161048AbVLOEr3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 23:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161049AbVLOEr3
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 23:47:29 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:15062 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161048AbVLOEr3 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2005 23:47:29 -0500
Received: by wproxy.gmail.com with SMTP id 57so279882wri
        for <git@vger.kernel.org>; Wed, 14 Dec 2005 20:47:28 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=f8GBqeJ/t5Nd2Caj+NTCKLhDvEdeK1LrONMZq0DxyAKiFtrWFQHE5T3nlV4B5C8B8A7CeE3fv4fx/8r/QR0jan0RVfam1vav4LZPx21HXsjkJbCoaZSGMRr45keBUAQxvJ1EKLF2yWXdkaWMRBRWeihl7BFRiSYTBr04CqzeHMU=
Received: by 10.54.143.10 with SMTP id q10mr661256wrd;
        Wed, 14 Dec 2005 20:47:28 -0800 (PST)
Received: by 10.54.72.15 with HTTP; Wed, 14 Dec 2005 20:47:28 -0800 (PST)
To: Git Mailing List <git@vger.kernel.org>,
	Matthias Urlichs <smurf@smurf.noris.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13676>

git-svnimport doesn't seem to like the repos I point it to -- there is
something I must be missing when crafting the import invocation.

I am not a subversion user -- so I'm surely missing a lot of subtlety
WRT to the 'each tag is a directory, each branch is a directory'
philosophy. In any case, the repos I'm trying to use seem simple
(though may be broken).

(And, btw, what are the -T and -t parameters? The documentation and
the usage message contradict each other.)

Example:

  # this gives me a small repo with 40 commits
  svn co svn://elgg.net/devel

  # but I could not get any of this to go
  git-svnimport svn://elgg.net/devel

  # I seem to be having /some/ luck with
  git-svnimport -T devel -t releases svn://elgg.net/devel

... at least history shows through. But I am not seeing any files.
Gah. Also tried, without success

  git-svnimport -T devel -t releases -b branches svn://elgg.net/devel

and -b branch too.

Another nut I haven't been able to crack has been
http://svn.berlios.de/svnroot/repos/serendipity/

puzzled,



martin
